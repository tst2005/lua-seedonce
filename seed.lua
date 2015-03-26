
-- the goal of this module is to use a stored random value as seed instead of time
-- because unixtime with only second precision is predictable!

-- the LUASEEDFILE is used if defined
-- else the $HOME/.luaseed was used

-- attention: the math.randomseed() seems have strange effect in case of float number

-- the current code is little ugly ...


local reseed = assert( require("math").randomseed )
local random = assert( require("math").random )

local getenv = assert( require("os").getenv )
local openfile = assert( require("io").open )

local seedfile = getenv("LUASEEDFILE") or ((getenv("HOME") or ".") .. "/.luaseed")

local function seedformat(seed)
	return ("%32.0f"):format(seed * 10^32)
end

local function reseed_with_check(seed)
	reseed(seed)
	local r1 = random()
	
	reseed(seed)
	local r2 = random()
	--print("r1", r1);print("r2", r2)
	return r1 == r2
end

local seed
local fd = openfile( seedfile, "r")
if not fd then
	seed = seedformat( require("os").time() * random(10^10) * random(10^10) )
else
	--print("read from file")
	seed = fd:read("*a")
	seed = seedformat( seed and tonumber( seed ) or 1 )
	fd:close()
end
--print("seed value : ", seed)
assert( reseed_with_check(seed), "reseed failed")

local fd = openfile( seedfile, "w+")
local nextseed = seedformat( math.random() )

--print("next seed:", nextseed)
fd:write(nextseed.."\n")
fd:close()

--math.randomseed = function() end

return {}
