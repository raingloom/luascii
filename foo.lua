function inner ()
	local a="a"
	return function ()
		return a
	end
end
a="b"
print(inner()())
