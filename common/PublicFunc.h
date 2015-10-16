#pragma once

#include <string>

namespace mc_system_public_function
{
	void		GetCurrentTimeAndConertToString(char* buffer, int len);

	bool		CharConvertToWchar(const char* str, int strLen, wchar_t* wstr, int wstrLen);
	bool		WcharConvertToChar(const wchar_t* wstr, int wstrLen, char* str, int strLen);

	bool		StringToWString(const std::string &str,std::wstring &wstr);
	bool		WStringToString(const std::wstring &wstr,std::string &str);

	void		SetThreadName(unsigned long threadID, const char* name);
};
