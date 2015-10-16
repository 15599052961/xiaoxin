#include "stdafx.h"
#include <winsock2.h>
#include "sqlpool.h"
#include "CriticalSectionLock.h"

// Local definitions
#pragma warning( disable: 4127 )

// memory
#define SafeDelete(P) if (P!=NULL) { delete(P); (P)=NULL; }

// Global data

// cSQLPool Constructor.
cSQLPool::cSQLPool(void)
{
	// Critical Section
	InitializeCriticalSectionAndSpinCount( &mCs, 1024 );

	// SQLEnvironment
	mSqlEnv                 = NULL;

	// SQLConnection
	mPagedPoolUsage         = NULL;
	mNonPagedPoolUsage      = NULL;

	mQuotaPagedPoolUsage    = 0;
	mQuotaNonPagedPoolUsage = 0;
	mWorkingSetSize         = 0;
	mPeakWorkingSetSize     = 0;

	memset( mDsn, 0, sizeof(mDsn) );
	memset( mUid, 0, sizeof(mUid) );
	memset( mPwd, 0, sizeof(mPwd) );
}

// ~cSQLPool Destructor.
cSQLPool::~cSQLPool(void)
{
	// cSQLPool ThreadPool
	Shutdown( );

	// Critical Section
	DeleteCriticalSection( &mCs );
}

// GetProcessMemoryInfo Method.
void cSQLPool::GetProcessMemoryInfo(SIZE_T& quotaPagedPoolUsage, SIZE_T& quotaNonPagedPoolUsage, SIZE_T& workingSetSize)
{
	cCSLock lock( &mCs );
	quotaPagedPoolUsage    = mQuotaPagedPoolUsage;
	quotaNonPagedPoolUsage = mQuotaNonPagedPoolUsage;
	workingSetSize         = mWorkingSetSize;
}

// Initialize Method - ThreadPool::Initialize 
bool cSQLPool::Initialize(wchar_t* dsn, wchar_t* uid, wchar_t* pwd, int numWorkerThreads)
{
	// SQLServer 
	mSqlEnv  = new cSQLEnvironment( );

	try{
		// Audit 
		wcscpy_s( mDsn, dsn );
		wcscpy_s( mUid, uid );
		wcscpy_s( mPwd, pwd );

		// ODBC, SQL 
		if ( mSqlEnv->AllocEnv( ) == false )
			return false;

		// SQL_ATTR_ODBC_VERSION  SQL_OV_ODBC3 
		if ( mSqlEnv->SetEnvAttr( ) == false )
			return false;

		// ThreadPool Class
		return cThreadPool::Initialize( numWorkerThreads );
	}
	catch(...){
		if(mSqlEnv != NULL){
			delete mSqlEnv;
			mSqlEnv = NULL;
		}

		return false;
	}
	
	return false;
}

// Shutdown Method - ThreadPool::Shutdown!
void cSQLPool::Shutdown(void)
{
	cCSLock lock( &mCs );
	PerSQLConnection* temp;

	while ( mPagedPoolUsage != NULL )
	{
		temp               = mPagedPoolUsage;
		mPagedPoolUsage    = mPagedPoolUsage->next;
		FreeSQLConnection( &temp );
	}
	while ( mNonPagedPoolUsage != NULL )
	{
		temp               = mNonPagedPoolUsage;
		mNonPagedPoolUsage = mNonPagedPoolUsage->next;
		FreeSQLConnection( &temp );
	}

	// ODBC, SQL .
	if ( mSqlEnv != NULL )
	{
		mSqlEnv->FreeEnv( );
	}

	// ODBC, SQL .
	SafeDelete( mSqlEnv );

	memset(mDsn, 0, MAX_PATH);
	memset(mUid, 0, MAX_PATH);
	memset(mPwd, 0, MAX_PATH);
}

// AllocSQLConnection Method
PerSQLConnection* cSQLPool::AllocSQLConnection(void)
{
	PerSQLConnection* perSQLConnection = (PerSQLConnection*)GlobalAlloc( GPTR, sizeof(PerSQLConnection) );

	if ( perSQLConnection != NULL )
	{
		// PerSQLConnection 
		perSQLConnection->sqlConnection = new cSQLConnection( );  // 1. SQLConnection .
		perSQLConnection->sqlStatement  = new cSQLStatement( );   // 2. SQLStatement  .
		perSQLConnection->prev          = NULL;                   
		perSQLConnection->next          = NULL;                  

		if ( perSQLConnection->sqlConnection != NULL && perSQLConnection->sqlStatement != NULL )
		{
			// SQLEnvironment 
			if ( perSQLConnection->sqlConnection->AllocDbc( mSqlEnv ) == true )
			{
				// DBC
				if ( perSQLConnection->sqlConnection->Connect( mDsn, mUid, mPwd ) == true )
				{
					// SQLConnection
					if ( perSQLConnection->sqlStatement->AllocStmt( perSQLConnection->sqlConnection ) == true )
					{
						// mWorkingSetSize
						mWorkingSetSize++;
						return perSQLConnection;
					}
				}
			}
		}
	}

	FreeSQLConnection( &perSQLConnection );
	return perSQLConnection;
}

// FreeSQLConnection Method
void cSQLPool::FreeSQLConnection(PerSQLConnection** perSQLConnection)
{
	if ( perSQLConnection != NULL )
	{
		SafeDelete( (*perSQLConnection)->sqlStatement );  // 1. SQLStatement  
		SafeDelete( (*perSQLConnection)->sqlConnection ); // 2. SQLConnection 

		GlobalFree( (*perSQLConnection) );
		(*perSQLConnection) = NULL;

		// mWorkingSetSize
		mWorkingSetSize--;
	}
}

// AttachPool Method - POOL 
void cSQLPool::AttachPool(PerSQLConnection** pool, PerSQLConnection* perSQLConnection)
{
	if ( (*pool) != NULL )
	{
		(*pool)->prev = perSQLConnection;

		perSQLConnection->prev = NULL;
		perSQLConnection->next = (*pool);
	}
	(*pool) = perSQLConnection;
}

// DetachPool Method - POOL 
void cSQLPool::DetachPool(PerSQLConnection** pool, PerSQLConnection* perSQLConnection)
{
	PerSQLConnection* prev = perSQLConnection->prev;
	PerSQLConnection* next = perSQLConnection->next;

	if ( prev == NULL && next == NULL )
	{
		(*pool) = NULL;
	}
	else if ( prev == NULL && next != NULL )
	{
		next->prev = NULL;
		(*pool) = next;
	}
	else if ( prev != NULL && next == NULL )
	{
		prev->next = NULL;
	}
	else if ( prev != NULL && next != NULL )
	{
		prev->next = next;
		next->prev = prev;
	}

	perSQLConnection->prev = NULL;
	perSQLConnection->next = NULL;
}

// GetPool Method
// ReleasePool Context Switching
PerSQLConnection* cSQLPool::GetPool(void)
{
	cCSLock           lock( &mCs );
	PerSQLConnection* perSQLConnection = mNonPagedPoolUsage;

	if ( perSQLConnection != NULL )
	{
		DetachPool( &mNonPagedPoolUsage, perSQLConnection );
		mQuotaNonPagedPoolUsage--;

		if ( perSQLConnection->sqlConnection->ConnectionDead( ) )
		{
			FreeSQLConnection( &perSQLConnection );
		}
	}

	if ( perSQLConnection == NULL )
	{
		perSQLConnection = AllocSQLConnection( );
	}

	if ( perSQLConnection != NULL )
	{
		AttachPool( &mPagedPoolUsage, perSQLConnection );
		mQuotaPagedPoolUsage++;
	}

	return perSQLConnection;
}

// ReleasePool Method
void cSQLPool::ReleasePool(PerSQLConnection* perSQLConnection, bool isDelete)
{
	cCSLock lock( &mCs );

	DetachPool( &mPagedPoolUsage, perSQLConnection );
	mQuotaPagedPoolUsage--;

	if ( isDelete != true )
	{
		AttachPool( &mNonPagedPoolUsage, perSQLConnection );
		mQuotaNonPagedPoolUsage++;
	}
	else
	{
		FreeSQLConnection( &perSQLConnection );
	}
}

// WorkerThread Method
unsigned int cSQLPool::WorkerThread(void)
{
	PerSQLConnection* perSQLConnection = NULL;

	while ( !_is_exit )
	{
		_condition.wait(_mutex);

		mc_system_db::PPerhandleDataDB tmpData = GetData();

		// SQLConnection.
		perSQLConnection = GetPool( );

		// SQLConnection.
		if ( perSQLConnection == NULL )
		{
			// 10/1000(s) - CPU 
			Sleep( 10 );

			QueueRequest( tmpData );
			continue;
		}

		// SQLConnection.
		ReleasePool( perSQLConnection );
	}
	return 0L;
}

void cSQLPool::NotifyAllAndClose( bool isCLose /*= true */ )
{
	_is_exit = true;
	_condition.notify_all();
}
