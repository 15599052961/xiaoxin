#pragma once

#include <windows.h>
#include "IdentifiersDefine.h"
#include "boost/thread/recursive_mutex.hpp"

namespace mc_system{
#if defined(_CONSOLE) && (defined(_WIN32) || defined(_WIN64))

	enum eErrorPrintColorValue
	{
		eEPCV_none		= FOREGROUND_RED|FOREGROUND_BLUE|FOREGROUND_GREEN|FOREGROUND_INTENSITY,

		eEPCV_white		= eEPCV_none,
		eEPCV_red		= FOREGROUND_RED,
		eEPCV_green		= FOREGROUND_GREEN,
		eEPCV_yellow	= 0x06,
		eEPCV_gray		= 0x08,
	};


	class ErrorPrint
	{
	public:
		ErrorPrint(){
			_console = GetStdHandle(STD_OUTPUT_HANDLE);
		}

		ErrorPrint(eErrorPrintColorValue value){
			_console = GetStdHandle(STD_OUTPUT_HANDLE);
			SetConsoleTextAttribute(_console, value);
		}

		~ErrorPrint(){
			SetConsoleTextAttribute(_console, eEPCV_gray);
			//CloseHandle(_console);
		}

		void operator ()(mc_system::eErrorPrintColorValue value, char* description);
		void operator ()(mc_system::eErrorPrintColorValue value, const char* description);
		void operator ()(mc_system::eErrorPrintColorValue value, wchar_t* description);

	private:
		HANDLE _console;
		static boost::recursive_mutex _mutex;
	};
#endif
};

inline
	void mc_system::ErrorPrint::operator()( mc_system::eErrorPrintColorValue value, const char* description )
{
	(*this)(value, (char*)description);
}

