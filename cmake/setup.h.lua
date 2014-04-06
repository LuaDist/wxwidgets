#! /usr/bin/lua

--%	The ReadFile function.
---	Read the whole contents of a file in _sText mode.
--@	_sFileName	(string)	name of the file with path
--:	sData_	(string)	file contents
function ReadFile(_sFileName)
	local f = io.input(_sFileName)
	local sData_ = f:read("*a")
	f:close()
	return sData_
end

--%	The WriteFile function.
---	Writes _sText to a file.
--@	_sFileName	(string)	name with path to write to
--@	_sText	(string)	the _sText to write
function WriteFile(_sFileName,_sText)
	local f = io.output(_sFileName)
	f:write(_sText)
	f:flush ()
	f:close()
end

--------------------------------------------------------------------------------------------------------------------------------------------
text = ReadFile("setup.h.in")

text = string.gsub(text, "#define (.-) 0\n", "#cmakedefine01 %1\n")
 	:gsub("#undef","#cmakedefine")

WriteFile("setup.h.cmake.wip", text)
