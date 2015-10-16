#include "stdafx.h"
#include "PublicFunc.h"
#include <wtypesbase.h>
#include <sysinfoapi.h>
#include <stringapiset.h>


namespace mc_system_public_function
{
	/// <summary>
	/// 获取当前的系统时间并且把时间转换为字符串
	/// </summary>
	/// <param name="buffer">The buffer.</param>
	/// <param name="len">The length.</param>
	void GetCurrentTimeAndConertToString( char* buffer, int len )
	{
		SYSTEMTIME tmpSt;

		::GetLocalTime(&tmpSt);

		sprintf_s(buffer, len, "%d-%d-%d %d:%d:%d", tmpSt.wYear, tmpSt.wMonth, tmpSt.wDay, tmpSt.wHour, tmpSt.wMinute, tmpSt.wSecond);
	}

	bool CharConvertToWchar(const char* str, int strLen, wchar_t* wstr, int wstrLen)
	{
		int len=MultiByteToWideChar(CP_ACP,0,str, -1, NULL,0);
		memset(wstr,0, wstrLen);
		return MultiByteToWideChar(CP_ACP, 0, str,-1,wstr, len) > 0;
	}

	bool WcharConvertToChar(const wchar_t* wstr, int wstrLen, char* str, int strLen)
	{
		int lengthOfMbs = WideCharToMultiByte( CP_ACP, 0, wstr, -1, NULL, 0, NULL, NULL);
		memset(str,0,strLen);
		return WideCharToMultiByte( CP_ACP, 0, wstr, -1, str, lengthOfMbs, NULL, NULL) > 0;
	}

	bool StringToWString(const std::string &str, std::wstring &wstr)
	{
		return CharConvertToWchar((LPCSTR)str.c_str(), str.length(), (LPWSTR)wstr.c_str(), str.length());
	}

	bool WStringToString(const std::wstring &wstr, std::string &str)
	{
		str.resize(wstr.length()*2);
		return WcharConvertToChar((LPCWSTR)wstr.c_str(), wstr.length(), (LPSTR)str.c_str(), str.length());
	}

#pragma region set thread name
	typedef struct tagTHREADNAME_INFO {
		DWORD dwType;		// Must be 0x1000.
		LPCSTR szName;		// Pointer to name (in user addr space).
		DWORD dwThreadID;   // Thread ID (-1=caller thread).
		DWORD dwFlags;		// Reserved for future use, must be zero.
	} THREADNAME_INFO;

	const DWORD kVCThreadNameException = 0x406D1388;

	void SetThreadName(unsigned long threadID, const char* name)
	{
		//只在调试的时候生效 
		if (!::IsDebuggerPresent()) 
			return;

		THREADNAME_INFO info;
		info.dwType = 0x1000;
		info.szName = name;
		info.dwThreadID = threadID;
		info.dwFlags = 0;

		__try
		{
			RaiseException(kVCThreadNameException, 0, sizeof(info)/sizeof(DWORD), reinterpret_cast<DWORD_PTR*>(&info));
		}
		__except(EXCEPTION_CONTINUE_EXECUTION) 
		{
		}
	}
#pragma endregion set thread name
}