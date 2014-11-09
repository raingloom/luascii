---Easy to read table exploration for testing and API learning
--@param t any table or anythng else iterable by 'pairs' (deep xplore only works on tables, though)
local function xplore (t,maxd,d,dont)
	maxd=maxd or 1
	d=d or 1
	dont=dont or {[t]=true}
	local types,pairs,ind,ty={},pairs,("\t"):rep(d)
	io.write(("\t"):rep(d-1)..tostring(t).."\n")
	for k,v in pairs(t) do
		ty=type(v)
		if not types[ty] then
			types[ty]={}
		end
		types[ty][k]=v
	end
	for ty,ta in pairs(types) do
		io.write(ind..ty..'\n')
		for k,v in pairs(ta) do
			if ty=="table" and d<maxd and not dont[v] then
				xplore(v,maxd,d+2,dont)
			else
				print(ind,k,v)
			end
		end
	end
end

xplore(_G,2)

return xplore
