---@module vector
local class={}
local sqrt=math.sqrt


function class.new (y,x)
	return setmetatable({y,x},class)
end



function class:__index (i)
	if i=="y" then
		return self[1]
	elseif i=="x" then
		return self[2]
	else
		return class[i]
	end
end



function class:__add (b)
	if type(b)=="table" then
		return setmetatable({self[1]+b[1],self[2]+b[2]},class)
	else
		return setmetatable({self[1]+b,self[2]+b},class)
	end
end



function class:__sub (b)
	if type(b)=="table" then
		return setmetatable({self[1]-b[1],self[2]-b[2]},class)
	else
		return setmetatable({self[1]-b,self[2]-b},class)
	end
end



function class:__mul (b)
	return setmetatable({self.y*b,self.x*b},class)
end



function class:__len ()
	local y,x=self[1],self[2]
	return sqrt(y*y+x*x)
end



function class:__eq (b)
	return self[1]==b[1] and self[2]==b[2]
end



function class:__le (b)
	return self:__len() < b:__len()
end



function class:__le (b)
	return self:__len() <= b:__len()
end
