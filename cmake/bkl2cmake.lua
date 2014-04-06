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
text = ReadFile("files.bkl")

--~ text = string.gsub(text, "%$%((.-)%)", "${%1}")
--~ 	:gsub("</set>",")")
--~ 	:gsub("<set var=\"","set( ")
--~ 	:gsub("\" hints=\"files\">","")
--~ 	:gsub("</makefile>","")
--~ 	:gsub("<makefile>","")
--~ 	:gsub("\" make_var=\"1","")
--~ 	:gsub("<%?xml version=\"1.0\" %?>","")
--~ 	:gsub("<!--(.-)-->","")
--~ 	:gsub("\n(\n+)","\n")

local out = {}

for var,_,files in string.gfind(text, "<set var=\"(.-)\"(.-)>(.-)</set>") do
	_var = string.gsub(var, "^([%u_]-)\"","%1")

	local IF = string.find(files, "<if cond=")

	if IF then
		for cond,body in string.gfind(files, "<if cond=\"(.-)\">(.-)</if>") do

			local _,_,toolkit  = string.find(cond, "' and TOOLKIT_VERSION=='(.-)'")

			local _,_, cond, cond2 = string.find(cond, "(.-)=='(.-)'")

			local c = nil
			if tonumber(cond2) == 0 then
				c = "NOT " .. cond
			elseif tonumber(cond2) == 1 then
				c = cond
			else
				c = "${".. cond .. '} MATCHES "'.. cond2 .. '"'
			end

			if toolkit then
				toolkit = tonumber(toolkit) or 1 -- fix: for GTK1 toolkit is empty
				local toolkit_cond = " AND ${TOOLKIT_VERSION} MATCHES \"".. toolkit .. "\""
				c = c .. toolkit_cond
			end


			local xx =  "if( " .. c .. " )\n" ..
			"\tset( " .. _var .. "\t".. body .. ")\n"
			.. "endif()\n"

			xx = string.gsub(xx,"%$%((.-)%)", "${%1}"):gsub("<!--(.-)-->","")
			table.insert(out,xx)
		end
	else
		local xx = "set( " .. _var .." "..files .. ")\n"

		xx = string.gsub(xx,"%$%((.-)%)", "${%1}"):gsub("<!--(.-)-->","")
		table.insert(out,xx)
	end

end


text = table.concat(out,"\n")

WriteFile("files.cmake", text)
