--[[pod_format="raw",created="2025-12-20 06:21:03",modified="2025-12-20 06:21:03",revision=0]]

cd(env().path)

if (not env().argv[1]) then
	print("usage: mkdir path")
	exit(1)
end
local path = env().argv[1]

if (fstat(path) == "folder") then
	print("directory already exists")
	exit(1)
end

if (fstat(path) == "file") then
	print("file already exists")
	exit(1)
end

err = mkdir(path)

if (err) then
	print(err)
end
