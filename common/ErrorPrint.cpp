#include "stdafx.h"
#include "ErrorPrint.h"
#include <iostream>

#if defined(_CONSOLE) && (defined(_WIN32) || defined(_WIN64))

boost::recursive_mutex mc_system::ErrorPrint::_mutex;

void mc_system::ErrorPrint::operator()( mc_system::eErrorPrintColorValue value, char* description )
{
	if(description == NULL || _console == INVALID_HANDLE_VALUE){
		return;
	}

	if(_mutex.try_lock()){
		SetConsoleTextAttribute(_console, value);

		std::cout << "--------------------------------\n";
		std::cout << description << std::endl;
		std::cout << "--------------------------------\n";

		_mutex.unlock();
	}
}

void mc_system::ErrorPrint::operator()( mc_system::eErrorPrintColorValue value, wchar_t* description )
{
	if(description == NULL || _console == INVALID_HANDLE_VALUE){
		return;
	}

	SetConsoleTextAttribute(_console, value);

	std::cout << "--------------------------------\n";
	std::cout << description << std::endl;
	std::cout << "--------------------------------\n";
}

#endif