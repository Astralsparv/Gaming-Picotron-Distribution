--[[pod_format="raw",created="2025-12-20 06:21:03",modified="2025-12-20 06:21:03",revision=0]]
--[[
	cp src dest

	resulting file should be idential to src (can't just fetch and then store)

	to do:
		-r recursive // rm() is currently recursive by default though
		how to do interactive copying? (prompt for overwrite)
]]

cd(env().path)
local argv = env().argv

if (#argv < 1) then
	print("usage: rm filename")
	exit(1)
end

local filename = fullpath(argv[1])
if (not filename) then
	print("could not resolve path")
	exit(0)
end


local attribs, size, origin = fstat(filename)

if (attribs) then

	-- exists. to do: directories need to be empty?

	local res = rm(filename)
	if (res) then
		print(res)
	else
		print("deleting "..filename)
	end
else

	print("not found")

end






