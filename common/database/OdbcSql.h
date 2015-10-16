#ifndef __ODBC_SQL_H__
#define __ODBC_SQL_H__

//#ifndef WINVER
//#define WINVER          0x0500
//#endif
//
//#ifndef _WIN32_WINNT
//#define _WIN32_WINNT    0x0500
//#endif

#pragma once

#include <windows.h>
#include <string.h>

#include <sql.h>
#include <sqlext.h>
#include <sqltypes.h>
#include <odbcss.h>
#include "assert.h"
#include "IdentifiersDefine.h"
#include "PublicFunc.h"

class cSQLConnection;
class cSQLStatement;
class cSQLEnvironment;

// 1. SQL_SUCCESS_WITH_INFO SQL_ERROR
// 2. Returns SQL_NO_DATA
// 3. Handle Type
//    SQL_HANDLE_ENV
//    SQL_HANDLE_DBC
//    SQL_HANDLE_STMT
//    SQL_HANDLE_DESC
class cSQLDiag
{
friend class cSQLConnection;
friend class cSQLStatement;
friend class cSQLEnvironment;

protected:
	SQLWCHAR      mSqlstate[ SQL_SQLSTATE_SIZE + 1 ];
	SQLINTEGER    mNativeErrorPtr;                        
	SQLWCHAR      mMessageText[ SQL_MAX_MESSAGE_LENGTH ];   

public:
	cSQLDiag(void) {}
	virtual ~cSQLDiag(void) {}

	bool GetDiagRec( SQLSMALLINT handleType,
					 SQLHANDLE   handle,
					 SQLSMALLINT recNumber=1 )
	{
		SQLSMALLINT bufferLength = SQL_MAX_MESSAGE_LENGTH;
		SQLSMALLINT textLength   = 0;
		SQLRETURN   result       = SQLGetDiagRecW( handleType,
												  handle,
												  recNumber,         // [IN ] Status records are numbered from 1.
												  mSqlstate,         // [OUT] SQL Error State string
												  &mNativeErrorPtr,  // [OUT] Native Error code
												  mMessageText,      // [OUT] SQL Error Text string
												  bufferLength,      // [IN ] Length of the *MessageText buffer in characters.
												  &textLength );

		return ( result == SQL_NO_DATA || result == SQL_ERROR ) ? false : true;
	}

	SQLWCHAR*   Sqlstate    ( void ) { return mSqlstate; }
	SQLINTEGER  NativeError ( void ) { return mNativeErrorPtr; }
	SQLWCHAR*   MessageText ( void ) { return mMessageText; }
};

class cSQLEnvironment
{
friend class cSQLConnection;

protected:
	SQLHENV mHenv;

public:
	cSQLEnvironment(void) : mHenv( SQL_NULL_HENV ) { }
	virtual ~cSQLEnvironment(void) { FreeEnv( ); }

	SQLHENV GetSqlEnv   ( void ) { return mHenv; }

	bool    AllocEnv    ( void )
	{
		// SQLAllocHandle( SQL_HANDLE_ENV, SQL_NULL_HANDLE, &mHenv )
		return (SQLAllocEnv( &mHenv ) == SQL_SUCCESS) ? true : false;
	}

	void    FreeEnv     ( void )
	{
		if ( mHenv != SQL_NULL_HENV )
		{
			// SQLFreeHandle( SQL_HANDLE_ENV, mHenv );
			SQLFreeEnv( mHenv );
			mHenv = SQL_NULL_HENV;
		}
	}

	bool    SetEnvAttr  ( SQLINTEGER Attribute    = SQL_ATTR_ODBC_VERSION,
						  SQLPOINTER ValuePtr     = (SQLPOINTER)SQL_OV_ODBC3,
						  SQLINTEGER StringLength = SQL_IS_INTEGER )
	{
		return (SQLSetEnvAttr( mHenv, Attribute, ValuePtr, StringLength ) == SQL_SUCCESS) ? true : false;
	}

	// SQL_FETCH_FIRST, SQL_FETCH_NEXT ...
	bool    DataSources ( SQLUSMALLINT direction,
						  SQLWCHAR*    dns,
						  SQLSMALLINT  cbDnsMax,
						  SQLSMALLINT* cbDns,
						  SQLWCHAR*    description,
						  SQLSMALLINT  cbDescriptionMax,
						  SQLSMALLINT* cbDescription )
	{
		SQLRETURN result = SQLDataSourcesW( mHenv,
										   direction,
										   dns,
										   cbDnsMax,
										   cbDns,
										   description,
										   cbDescriptionMax,
										   cbDescription );

		if ( result == SQL_NO_DATA || result == SQL_ERROR )
			return false;
		return true;
	}
};

class cSQLConnection
{
friend class cSQLStatement;

protected:
	SQLHDBC mHdbc;

public:
	cSQLConnection(void) : mHdbc( SQL_NULL_HDBC ) { }

	SQLHDBC GetSqlDbc ( void ) { return mHdbc; }

	virtual bool AllocDbc ( cSQLEnvironment* sqlEnvironment )
	{
		// SQLAllocHandle( SQL_HANDLE_DBC, sqlEnvironment->mHenv, &mHdbc )
		return (SQLAllocConnect( sqlEnvironment->mHenv, &mHdbc ) == SQL_SUCCESS) ? true : false;
	}

	virtual bool AllocDbc ( SQLHENV henv ) 
	{
		// SQLAllocHandle( SQL_HANDLE_DBC, henv, &mHdbc )
		return (SQLAllocConnect( henv, &mHdbc ) == SQL_SUCCESS) ? true : false;
	}

	virtual void FreeDbc ( void )
	{
		if ( mHdbc != SQL_NULL_HDBC )
		{
			// SQLFreeHandle( SQL_HANDLE_DBC, mHdbc )
			SQLFreeConnect( mHdbc );
			mHdbc = SQL_NULL_HDBC;
		}
	}

	virtual bool Connect ( SQLWCHAR* dns, SQLWCHAR* uid, SQLWCHAR* pwd )
	{
#if defined(_DEBUG)
		if(wcslen(dns) == 0 || wcslen(uid) == 0){
			assert(false);
			throw;
		}

		if(wcslen(dns) > MAX_PATH || wcslen(uid) > MAX_PATH){
			assert(false);
			throw;
		}
#endif

		//////////////////////////////////////////////////////////////////////////
		SQLRETURN retcode;
		retcode = SQLConnectW( mHdbc, dns, SQL_NTS, uid, SQL_NTS, pwd, SQL_NTS );

		// if failed to connect, free the allocated mHdbc before return
		if ( retcode != SQL_SUCCESS && retcode != SQL_SUCCESS_WITH_INFO )
		{
			cSQLDiag tmp_sqldiag;
			tmp_sqldiag.GetDiagRec( SQL_HANDLE_DBC, mHdbc );

#ifdef _DEBUG
#ifdef SIC
			std::wstring tmpWStrDes(tmp_sqldiag.MessageText());
			std::wstring tmpWStrErrCode(tmp_sqldiag.Sqlstate());
			std::string tmpStrDes(tmpWStrDes.length(), '\0');
			std::string tmpStrErrCode(tmpWStrErrCode.length(), '\0');

			if(mc_system_public_function::WStringToString(tmpWStrDes, tmpStrDes) && 
				mc_system_public_function::WStringToString(tmpWStrErrCode, tmpStrErrCode)){
				printf("Database connect error[%s]:%s.\n", tmpStrErrCode.c_str(), tmpStrDes.c_str());
			}
			else{
				wprintf(L"Database connect error[%s]:%s.\n", tmp_sqldiag.Sqlstate(), tmp_sqldiag.MessageText());
			}

			PRINT_FFL;
#endif //SIC
#endif //_DEBUG

			if(/*tmpWStrErrCode == L"IM002"*/wcscmp(tmp_sqldiag.Sqlstate(), L"IM002") == 0){
				//[Microsoft][ODBC 驱动程序管理器] 未发现数据源名称并且未指定默认驱动程序
				//这个错误表示，数据库有问题，可能是：
				//1、数据库服务器没有开启
				//2、数据库没有建立
				//3、没有建立数据源ODBC，（打开命令行-输入odbcad32.exe-添加数据源）
				throw;
			}

			Disconnect( );
			
			//assert(false && "Database connect error");
			return false;
		}

		/*--
		retcode = SQLSetConnectAttr( mHdbc, SQL_ATTR_CONNECTION_TIMEOUT, (void*)5, 0 );
		if ( retcode != SQL_SUCCESS && retcode != SQL_SUCCESS_WITH_INFO )
		{
			//GetDiagRec( SQL_HANDLE_DBC, mHdbc );
			Disconnect( );
			return false;
		}
		*/

		// display any connection information if driver returns SQL_SUCCESS_WITH_INFO
		// if ( retcode == SQL_SUCCESS_WITH_INFO )
		//	GetDiagRec( SQL_HANDLE_DBC, mHdbc );		
		return true;
	}

	// Driver 
	virtual bool SQLConnect4XLS ( SQLWCHAR* connStrIn, SQLSMALLINT connStrLen, SQLWCHAR* connStrOut, SQLSMALLINT connStrOutMax, SQLSMALLINT* connStrOutLen )
	{
		// DRIVER={Microsoft Excel Driver (*.xls)}; FIRSTROWHASNAMES=1; READONLY=0; CREATE_DB=\"test.xls\"; DBQ=test.xls;
		SQLRETURN retcode;
		retcode = SQLDriverConnectW( mHdbc
								   ,NULL
								   ,connStrIn
								   ,connStrLen
								   ,connStrOut
								   ,connStrOutMax
								   ,connStrOutLen
								   ,SQL_DRIVER_NOPROMPT );

		// if failed to connect, free the allocated mHdbc before return
		if ( retcode != SQL_SUCCESS && retcode != SQL_SUCCESS_WITH_INFO )
		{
			//GetDiagRec( SQL_HANDLE_DBC, mHdbc );
			Disconnect( );
			return false;
		}

		return true;
	}

	// SQL_AUTOCOMMIT_OFF = The driver uses manual-commit mode,
	//						and the application must explicitly commit or roll back transactions with SQLEndTran.
	SQLRETURN AutocommitOff ( void )
	{
		return SQLSetConnectAttr( mHdbc, SQL_ATTR_AUTOCOMMIT, (void*)SQL_AUTOCOMMIT_OFF, 0 );
	}
	// SQL_AUTOCOMMIT_ON = The driver uses autocommit mode.
	//	Each statement is committed immediately after it is executed.
	//	This is the default.
	//	Any open transactions on the connection are committed
	//	when SQL_ATTR_AUTOCOMMIT is set to SQL_AUTOCOMMIT_ON to change from manual-commit mode to autocommit mode
	SQLRETURN AutocommitOn ( void )
	{
		return SQLSetConnectAttr( mHdbc, SQL_ATTR_AUTOCOMMIT, (void*)SQL_AUTOCOMMIT_ON, 0 );
	}
	// Completion Type SQL_COMMIT, SQL_ROLLBACK.
	SQLRETURN EndTran ( SQLSMALLINT completionType )
	{
		return SQLEndTran( SQL_HANDLE_DBC, mHdbc, completionType ); 
	}

	// SQL_COPT_SS_CONNECTION_DEAD reports the alive or dead state of a connection to a server.
	// The driver queries the Net-Library for the current state of the connection.

	// SQL_COPT_SS_CONNECTION_DEAD
	// "Net-Library"
	virtual bool ConnectionDead ( void )
	{
		SQLINTEGER ValuePtr;
		SQLINTEGER StringLengthPtr;
		// SQL_CD_TRUE:  The connection to the server has been lost.
		// SQL_CD_FALSE: The connection is open and available for statement processing.

		// SQL_CD_TRUE:  
		// SQL_CD_FALSE:
		SQLGetConnectAttr( mHdbc, SQL_COPT_SS_CONNECTION_DEAD, &ValuePtr, SQL_IS_INTEGER, &StringLengthPtr );
		return (ValuePtr == SQL_CD_TRUE) ? true : false;
	}

	virtual void Disconnect ( void )
	{
		if ( mHdbc != SQL_NULL_HDBC )
		{
			SQLDisconnect( mHdbc );
		}
	}

public:
	virtual ~cSQLConnection(void)
	{
		Disconnect( );
		FreeDbc( );
	}
};

class cSQLStatement
{
protected:
	SQLHSTMT mHstmt;

public:
	cSQLStatement(void) : mHstmt( SQL_NULL_HSTMT ) { }

	SQLHSTMT GetSqlStmt ( void ) { return mHstmt; }

	virtual bool AllocStmt ( cSQLConnection* sqlConnection )
	{
		// SQLAllocHandle( SQL_HANDLE_STMT, sqlConnection->mHdbc, &mHstmt )
		return (SQLAllocStmt( sqlConnection->mHdbc, &mHstmt ) == SQL_SUCCESS) ? true : false;
	}

	virtual bool AllocStmt ( SQLHDBC hdbc )
	{
		// SQLAllocHandle( SQL_HANDLE_STMT, hdbc, &mHstmt )
		return (SQLAllocStmt( hdbc, &mHstmt ) == SQL_SUCCESS) ? true : false;
	}

	virtual void FreeStmt ( void )
	{
		if ( mHstmt != SQL_NULL_HSTMT )
		{
			// SQLFreeHandle( SQL_HANDLE_STMT, mHstmt )
			SQLFreeStmt( mHstmt, SQL_DROP );
			mHstmt = SQL_NULL_HSTMT;
		}
	}

	virtual bool Sequence ( void )
	{
		SQLWCHAR    sqlstate[ SQL_SQLSTATE_SIZE + 1 ];
		SQLINTEGER  nativeErrorPtr;
		SQLWCHAR    messageText[ SQL_MAX_MESSAGE_LENGTH ];   
		SQLSMALLINT bufferLength = SQL_MAX_MESSAGE_LENGTH;
		SQLSMALLINT textLength   = 0;

		SQLGetDiagRecW( SQL_HANDLE_STMT, mHstmt, 1, sqlstate, &nativeErrorPtr, messageText, bufferLength, &textLength );

		return (strcmp( (char*)sqlstate, "HY010" ) == 0) ? true : false;
	}

	virtual SQLRETURN Test ( char* message )
	{
		SQLWCHAR*  statement = (SQLWCHAR*)L"SELECT ?";
		SQLINTEGER strLenOrInd;
		SQLRETURN  retcode;

		long       messageLen = (long)strlen( message );
		long       cbMessage  = SQL_NTS;

		SQLCHAR    buffer[MAX_PATH];
		long       bufferLen = sizeof(buffer);

		retcode = SQLBindParameter( mHstmt, 0x1, SQL_PARAM_INPUT, SQL_C_CHAR, SQL_VARCHAR, messageLen, 0, message, 0, &cbMessage );
		retcode = SQLExecDirectW( mHstmt, statement, SQL_NTS );
		if ( retcode == SQL_SUCCESS || retcode == SQL_SUCCESS_WITH_INFO )
		{
			if ( SQLFetch( mHstmt ) == SQL_SUCCESS )
			{
				SQLGetData( mHstmt, 0x01, SQL_C_CHAR, buffer, bufferLen, &(strLenOrInd=0) );
			}

			while ( SQLMoreResults( mHstmt ) == SQL_SUCCESS );

			// (Close the open result set.)
			SQLCloseCursor( mHstmt );
		}
		return retcode;
	}

public:
	virtual ~cSQLStatement(void)
	{
		FreeStmt( );
	}
};

#endif // __ODBC_SQL_H__