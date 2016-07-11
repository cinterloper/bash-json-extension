local turbo = require("turbo")


function catch(what)
   return what[1]
end

function try(what)
   status, result = pcall(what[1])
   if not status then
      what[2](result)
   end
   return result
end


	

function l_decodeJson (decodeVar) 
  local jstring = bash.getVariable(decodeVar)
  local jsont = turbo.escape.json_decode(jstring)
  for key,value in pairs(jsont) do
    if type(value) == "table" then
      value = turbo.escape.json_encode(value)
    else
      value = tostring(value)
    end
    if type(key) == "number" then
      key = (decodeVar .. "_" .. tostring(key))
    end
    bash.setVariable(key,value)
    print(key)
  end
end

function l_encodeJson ()
  local varstring=bash.getVariable("KEY_SET") 
  local vars=varstring:split(" ")
  t = {}
  local tempt
  local decode = true
  for key,value in pairs(vars) do
    t[value] = bash.getVariable(value)
    try {
      function()
        tempt = turbo.escape.json_decode(t[value])
      end,
      catch {
       function()
         decode = false
       end
      }
    }
    if type(tempt) == "number" then
      decode = false
    end
    if decode then
      t[value] = tempt
    end
  end
  local jsons = turbo.escape.json_encode(t)
  print(jsons)
end


bash.register("l_decodeJson")
bash.register("l_encodeJson")
