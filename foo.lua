--testing randomness goes here
require"lfs"
xplore=require"xplore"
for f in lfs.dir(lfs.currentdir()) do
	print(("-"):rep(6*4))
	xplore(lfs.attributes(f))
end
