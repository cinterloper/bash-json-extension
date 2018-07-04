-- Stack Table
-- Uses a table as stack, use <table>:push(value) and <table>:pop()
-- Lua 5.1 compatible

-- GLOBAL
Stack = {}
Stacks = {}
-- Create a Table with stack functions
function Stack:Create()

  -- stack table
  local t = {}
  -- entry table
  t._et = {}

  -- push a value on to the stack
  function t:push(...)
    if ... then
      local targs = {...}
      -- add values
      for _,v in ipairs(targs) do
        table.insert(self._et, v)
      end
    end
  end

  -- pop a value from the stack
  function t:pop(num)

    -- get num values from stack
    local num = num or 1

    -- return table
    local entries = {}

    -- get values into entries
    for i = 1, num do
      -- get last entry
      if #self._et ~= 0 then
        table.insert(entries, self._et[#self._et])
        -- remove last value
        table.remove(self._et)
      else
        break
      end
    end
    -- return unpacked entries
    return unpack(entries)
  end

  -- get entries
  function t:getn()
    return #self._et
  end

  -- list values
  function t:list()
    for i,v in pairs(self._et) do
      print(i, v)
    end
  end
  return t
end

-- CHILLCODE™


function l_createStack (name)
  Stacks[name]=Stack:Create()
end
function l_pushStack (name,value)
  Stacks[name]:push(value)
end
function l_popStack(name,count)
--  for i,v in pairs(Stacks[name]:pop(count)) do
--   print(v)
--  end
  print(Stacks[name]:pop(count))
end
function l_getStackDepth(name,indx)
  print(Stacks[name]:getn())
end
function l_delStack(name)
  Stacks[name]=nil
end
bash.register("l_createStack")
bash.register("l_pushStack")
bash.register("l_popStack")
bash.register("l_getStackDepth")