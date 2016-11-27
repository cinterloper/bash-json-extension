local JSON = (loadfile "ext/JSON.lua")() -- one-time load of the routines
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
