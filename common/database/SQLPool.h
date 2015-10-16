#pragma once

#include "odbcsql.h"
#include "threadpool.h"


#ifndef PER_SQL_CONNECTION
#define PER_SQL_CONNECTION

struct PerSQLConnection
{
	cSQLConnection*          sqlConnection;     // SQL Connection
	cSQLStatement*           sqlStatement;      // SQL Statement
	struct PerSQLConnection* next;              // Dual Linked List 
	struct PerSQLConnection* prev;              // Dual Linked List 
};

#endif // PER_SQL_CONNECTION


class cSQLPool : public cThreadPool
{
public:
	cSQLPool(void);
	virtual ~cSQLPool(void);

	virtual void              GetProcessMemoryInfo ( SIZE_T& quotaPagedPoolUsage, SIZE_T& quotaNonPagedPoolUsage, SIZE_T& workingSetSize );

	virtual bool              Initialize           ( wchar_t* dsn, wchar_t* uid, wchar_t* pwd, int numWorkerThreads=2 );
	virtual void              Shutdown             ( void );
	void					  NotifyAllAndClose	   ( bool isCLose = true );

	virtual unsigned int      WorkerThread         ( void );

protected:
	virtual PerSQLConnection* AllocSQLConnection   ( void );
	virtual void              FreeSQLConnection    ( PerSQLConnection** perSQLConnection );

	void                      AttachPool           ( PerSQLConnection** pool, PerSQLConnection* perSQLConnection );
	void                      DetachPool           ( PerSQLConnection** pool, PerSQLConnection* perSQLConnection );

	PerSQLConnection*         GetPool              ( void );
	void                      ReleasePool          ( PerSQLConnection* perSQLConnection, bool isDelete=false );

protected:
	CRITICAL_SECTION          mCs;
	cSQLEnvironment*          mSqlEnv;

	PerSQLConnection*         mPagedPoolUsage;         
	PerSQLConnection*         mNonPagedPoolUsage;      
	SIZE_T                    mQuotaPagedPoolUsage;    
	SIZE_T                    mQuotaNonPagedPoolUsage; 
	SIZE_T                    mWorkingSetSize;         
	SIZE_T                    mPeakWorkingSetSize;     

	wchar_t                   mDsn[MAX_PATH];          // DataSource
	wchar_t                   mUid[MAX_PATH];          // UserID
	wchar_t                   mPwd[MAX_PATH];          // Password
};

