package.path = package.path .. ';./ext/LuLPeg/?.lua;./ext/?.lua'
local JSON = (loadfile "ext/JSON.lua")() -- one-time load of the routines
local jp = require "jsonpath"
--https://github.com/torch/xlua/blob/98c11caac263e21f793ab2e6a8ed536b3c7cb135/init.lua#L689-L706

local function isempty(s)
  return s == nil or s == ''
end

function encodeJson(data,pretty)
  local pretty = bash.getVariable("JSON_PRETTY")
  if isempty(pretty) then
    return JSON:encode(data)
  else
    return JSON:encode_pretty(data)
  end
end

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

--https://github.com/james2doyle/lit-merge/blob/master/init.lua
local function merge(t1, t2)
    for k,v in pairs(t2) do
      if type(v) == "table" then
        if type(t1[k] or false) == "table" then
          merge(t1[k] or {}, t2[k] or {})
        else
          t1[k] = v
        end
      else
        t1[k] = v
      end
    end
    return t1
end


function l_getJsonValue (valuePath)
  local J_VAR=bash.getVariable("JSON_VAR")
  local jstring = bash.getVariable(J_VAR)
  local jsont = JSON:decode(jstring)
  local lookup=jp.value(jsont,valuePath)
  if type(lookup) == "table" then
    print( encodeJson(lookup) )
  else
    print(lookup)
  end
end


function l_mergeJson () 
  local varstring=bash.getVariable("KEY_SET") 
  local vars=varstring:split(" ")
  mTable = {}

  for key,value in pairs(vars) do
    local newData = JSON:decode(bash.getVariable(value))
    local nuTable = merge(mTable,newData)  
    mTable = nuTable
  end

  print(encodeJson(mTable))
end

function l_decodeJson (decodeVar) 
  local jstring = bash.getVariable(decodeVar)
  local jsont = JSON:decode(jstring)
  local keyset = ''
  for key,value in pairs(jsont) do
    if type(value) == "table" then
      value = encodeJson(value)
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
  local jsons = encodeJson(t)
  print(jsons)
end

function l_encodeJsonArray ()
  local l = {}
  for line in io.lines() do
    table.insert(l,line)        
  end
  print(encodeJson(l))
end


bash.register("l_decodeJson")
bash.register("l_encodeJson")
bash.register("l_encodeJsonArray")
bash.register("l_mergeJson")
bash.register("l_getJsonValue")
