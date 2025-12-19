--[[pod_format="raw",created="2024-03-24 14:56:58",modified="2024-03-24 14:56:58",revision=0]]


-- iterators need to be in lua to avoid c boundary yielding

function all(c) if (c == nil or #c == 0) then return function() end end
 	local i=1
 	local li=nil
 	return function()
 		if (c[i] == li) then i=i+1 end
 		while(c[i]==nil and i <= #c) do i=i+1 end
 		li=c[i]
 		return li
 	end
end

function foreach(c,_f)
	for i in all(c) do _f(i) end 
end

-- pico-8 style sub // to do: move to c

function sub(str, p0, p1)
	if (type(str) ~= "string") then return end
	if (p1 ~= nil and type(p1) != "number") p1 = p0 -- get character at pos
	return string.sub(str, p0, p1)
end


-- pico-8 compatibility (but as_hex works differently; no fractional part)
-- weird to have 2 slightly different ways to write the same thing, but tostr(foo,1) is too handy for getting hex numbers

local _tostring = tostring
function tostr(val, as_hex)
	if (as_hex) then
		if (type(val) != "number") return -- same as pico-8
		return string.format("0x%x", tonumber(val) or 0)
	else
		return _tostring(val)
	end
end

-- pack, unpack globals at top level

unpack = table.unpack
pack = table.pack


--use a system volume, also ensure pokes are affected by cartridge_volume

local cartridge_volume=fetch("/appdata/system/gaming/settings.pod").volume
cartridge_volume=mid(0,cartridge_volume,255) --max is 255/0xff
cartridge_volume=cartridge_volume/255 --convert to decimal, multiply anything by it to factor in volume!

local _sfx=sfx
sfx=function(a,b,special_case_mix_volume,normal_mix_volume,...)
	if (a==-4) then
		if (special_case_mix_volume) then
			special_case_mix_volume=special_case_mix_volume*cartridge_volume
		end
	else
		if (normal_mix_volume) then
			normal_mix_volume=normal_mix_volume*cartridge_volume
		end
	end
    return _sfx(a,special_case_mix_volume,c,normal_mix_volume,...)
end

local _note=note
note=function(a,b,volume,...)
	if (volume) then
		printh("fed: "..volume)
		volume=volume*cartridge_volume
		printh("volume factor: "..volume)
		printh("new: "..volume)
	end
    return _note(a,b,volume,...)
end

local _poke=poke
poke=function(a,b,...)
	if (a==0x5533a) then
		b*=cartridge_volume
	end
	return _poke(a,b,...)
end