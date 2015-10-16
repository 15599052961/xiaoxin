#ifndef __CRITICAL_SECTION_LOCK__
#define __CRITICAL_SECTION_LOCK__

//#ifndef WINVER
//#define WINVER          0x0500
//#endif
//
//#ifndef _WIN32_WINNT
//#define _WIN32_WINNT    0x0500
//#endif

#pragma once

#include <windows.h>

class cCriticalSection
{
private:
	CRITICAL_SECTION* mCs;

public:
	cCriticalSection(CRITICAL_SECTION* cs) : mCs(cs)
	{
	}

	void Lock(void) 
	{
		EnterCriticalSection(mCs);
	}
	void Unlock(void) 
	{
		LeaveCriticalSection(mCs);
	}

public:
	virtual ~cCriticalSection(void)
	{
	}
};

class cCSLock
{
private:
	CRITICAL_SECTION* mCs;

public:
	cCSLock(CRITICAL_SECTION* cs) : mCs(cs)
	{
		EnterCriticalSection(mCs);
	}

public:
	virtual ~cCSLock()
	{
		LeaveCriticalSection(mCs);
	}
};

#endif // __CRITICAL_SECTION_LOCK__