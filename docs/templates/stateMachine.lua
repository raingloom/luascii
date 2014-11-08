--[[
return coroutine.wrap(function (myRegistry,thisCoroutine,...)
	--check if registry and [optional] self reference are intact
	coroutine.yield(OK)
	--do some other stuff
	while ALIVE do
		coroutine.yield()
	end
end)
--]]
