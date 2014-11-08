--loading functions
local ns={}

---
--@param file file handler
function ns.loadASCIImap(file)

end

---Lua preprocessor from lua-users.org
function ns.prep0 (file)
  local chunk = {n=0}
  for line in file:lines() do
     if string.find(line, "^#") then
      table.insert(chunk, string.sub(line, 2) .. "\n")
     else
      local last = 1
      for text, expr, index in string.gmatch(line, "(.-)$(%b())()") do
        last = index
        if text ~= "" then
          table.insert(chunk, string.format('io.write %q ', text))
        end
        table.insert(chunk, string.format('io.write%s ', expr))
      end
      table.insert(chunk, string.format('io.write %q\n',
                                         string.sub(line, last).."\n"))
    end
  end
  return loadstring(table.concat(chunk))()
end
