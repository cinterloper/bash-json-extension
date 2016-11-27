local JSON = (loadfile "ext/JSON.lua")() -- one-time load of the routines
--https://github.com/torch/xlua/blob/98c11caac263e21f793ab2e6a8ed536b3c7cb135/init.lua#L689-L706
function string.split(str, pat)
   local t = {}  -- NOTE: use {n = 0} in Lua-5.0
   local fpat = "(.-)" .. pat
   local last_end = 1
   local s, e, cap = str:find(fpat, 1)
   while s do
      if s ~= 1 or cap ~= "" then
         table.insert(t,cap)
      end
      last_end = e+1
      s, e, cap = str:find(fpat, last_end)
   end
   if last_end <= #str then
      cap = str:sub(last_end)
      table.insert(t, cap)
   end
   return t
end

function l_decodeJson (decodeVar) 
  local jstring = bash.getVariable(decodeVar)
  local jsont = JSON:decode(jstring)
  local keyset = ''
  for key,value in pairs(jsont) do
    if type(value) == "table" then
      value = JSON:encode(value)
    else
      value = tostring(value)
    end
    if type(key) == "number" then
      key = (decodeVar .. "_" .. tostring(key))
    end
    bash.setVariable(key,value)
    print(key)
    keyset = keyset .. key .. ' '
  end
  bash.setVariable('DECODE_KEYS',keyset)
end

function l_encodeJson ()
  local varstring=bash.getVariable("KEY_SET") 
  local vars=varstring:split(" ")
  local t = {}

  for key,value in pairs(vars) do

      try = pcall(function()
        t[value] = JSON:decode(bash.getVariable(value))
      end) 
      if not try then 
        t[value] = bash.getVariable(value)
      end
        
  end
  local jsons = JSON:encode(t)
  print(jsons)
end


bash.register("l_decodeJson")
bash.register("l_encodeJson")
