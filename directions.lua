---@module directions
local ns={}

local neighbourOffsets={
	{1,0},--N
	{1,1},--NE
	{0,1},--E
	{-1,1},--SE
	{-1,0},--S
	{-1,-1},--SW
	{0,-1},--W
	{1,-1}--NW
}

neighbourOffsets.N=neighbourOffsets[1]
neighbourOffsets.NE=neighbourOffsets[2]
neighbourOffsets.E=neighbourOffsets[3]
neighbourOffsets.SE=neighbourOffsets[4]
neighbourOffsets.S=neighbourOffsets[5]
neighbourOffsets.SW=neighbourOffsets[6]
neighbourOffsets.W=neighbourOffsets[7]
neighbourOffsets.NW=neighbourOffsets[8]

ns.neighbourOffsets=neighbourOffsets

function ns.iNeighbourOffsets(diagonal)
	return coroutine.wrap(function()
		local d=neighbourOffsets
		for i=1,8,diagonal and 1 or 2 do
			coroutine.yield(d[i])
		end
	end)
end

return ns
