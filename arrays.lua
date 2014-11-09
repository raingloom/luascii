--[[--efficient 2D arrays
	@module array2DFast
]]
local class={}
local serialize=require"pl.pretty".write
local getter

--[[--Initializer
	@param y Y size
	@param x X size
	@param v value to initialize to or a generator function, called as: v(iteration,currentx,currenty)
]]
function class.new(y,x,v)
	local ret={ly=y,lx=x}
	local a={}
	if type(v)=="function" then
		for i=1,y*x do a[i]=v(i,math.floor(i/x),i%x) end
	else
		for i=1,y*x do a[i]=v end
	end
	ret.a=a
	return setmetatable(ret,class)
end

--Special chained indexer for general purpose array indexing notation
function class:__index(i)
	--print(i,debug.traceback())
	local ty=type(i)
	local ly,lx,rawget,format,error=self.ly,self.lx,rawget,string.format,error
	if ty=="number" then
		local y=rawget(self,"y")--avoids an extra indexer call
		local e="%s=%d is out of bounds=[1;%d]"
		if y then
			self.y=nil
			if i>=1 and i<=lx then
				return rawget(self.a,(y-1)*lx+i)
			else
				error(format(e,"x",i,lx))
			end
		else
			if i>=1 and i<=ly then
				self.y=i
				return self
			else
				error(format(e,"y",i,ly))
			end
		end
	else
		if ty=="table" then
			local ok,v=pcall(getter,self,i[1],i[2])
			if ok then return v end
		end
		return class[i]
	end
end



--[[--

]]
function class:get (y,x)
	if type(y)=="table" then y,x=y[1],y[2] end
	local lx=self.lx
	if x>=1 and x<=lx and y>=1 and y<=self.ly then
		return self.a[(y-1)*lx+x]
	else
		error(("y=%d,x=%d out of bounds:[1,%d],[1,%d]]"):format(y,x,self.ly,lx))
	end
end
getter=class.get



--[[--Iterator
	iterates over all fields in array
	@return x current x
	@return y current y
	@return v value at [y][x]
]]
function class:fields()
	return coroutine.wrap(function()
		local ly,lx,a=self.ly,self.lx,self.a
		for iy=1,ly do
			for ix=1,lx do
				coroutine.yield(iy,ix,a[(iy-1)*lx+ix])
			end
		end
	end)
end



--[[--Dump object into string
	@return string PenLight generated, loadable table
	@warning this will only work with pl.pretty.write compatible types
]]
function class:dump ()
	return serialize(self)
end



--[[--Load object from file or string
	@param f A _valid_ array dump.
	@treturn array2DFast
	@return an array object
]]
function class:load (f)
	if io.type(f)=="file" then
		local buf=f:seek("end")
		f:seek("set")
		buf=f:read(buf)
		return setmetatable(loadstring("return "..buf)(),class)
	end
end

function class:bounds() return self.ly, self.lx end
function class:len() return self.ly*self.lx end
if _VERSION=="Lua 5.2" then--set up optional __len metamethod
	class.__len=class.len
end
--End of declaration and init


--tests
local object=class.new(5,6,0)

for v in require"directions".iNeighbourOffsets() do
	print(unpack(v))
end

return class
