--credits:
--https://github.com/torch/xlua/blob/98c11caac263e21f793ab2e6a8ed536b3c7cb135/init.lua#L689-L706
--https://github.com/james2doyle/lit-merge/blob/master/init.lua
--Author: Grant Haywood, 2016
--License: BSD, no warrenty

package.path = package.path .. ';./ext/LuLPeg/?.lua;./ext/?.lua'
local JSON = (loadfile "ext/JSON.lua")() -- one-time load of the routines
local jp = require "jsonpath"


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

function hasValue (tab, val)
    for index, value in ipairs (tab) do
        if value == val then
            return true
        end
    end

    return false
end

local _BANNED={}
local _ALLOWED={}
local whitelist = {}
_BANNED["DECODE_KEYS"] = (bash.getVariable("BANNED_DECODE_KEYS") or ""):split(" ")
_BANNED["ENCODE_KEYS"] = (bash.getVariable("BANNED_ENCODE_KEYS") or ""):split(" ")
_ALLOWED["DECODE_KEYS"] = (bash.getVariable("ALLOWED_DECODE_KEYS") or ""):split(" ")
_ALLOWED["ENCODE_KEYS"] = (bash.getVariable("ALLOWED_ENCODE_KEYS") or ""):split(" ")
whitelist["DECODE_KEYS"] = false
whitelist["ENCODE_KEYS"] = false


local function isempty(s)
  return s == nil or s == ''
end

function bashGetVar(var)
  local ok = not whitelist["ENCODE_KEYS"]
  if hasValue(_ALLOWED["ENCODE_KEYS"],var) then
    ok = true
  end
  if hasValue(_BANNED["ENCODE_KEYS"],var) then
    ok = false
  end
  if ok == true then
    return bash.getVariable(var)
  end
end

function bashSetVar(var,data)
  local ok = not whitelist["DECODE_KEYS"]
  if hasValue(_ALLOWED["DECODE_KEYS"],var) then
    ok = true
  end
  if hasValue(_BANNED["DECODE_KEYS"],var) then
    ok = false
  end
  if ok then
    return bash.setVariable(var,data)
  end
end


function encodeJson(data,pretty)
  local pretty = bashGetVar("JSON_PRETTY")
  if isempty(pretty) then
    return JSON:encode(data)
  else
    return JSON:encode_pretty(data)
  end
end


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
  local J_VAR=bashGetVar("JSON_VAR")
  local jstring = bashGetVar(J_VAR)
  local jsont = JSON:decode(jstring)
  local lookup=jp.value(jsont,valuePath)
  if type(lookup) == "table" then
    print( encodeJson(lookup) )
  else
    print(lookup)
  end
end


function l_mergeJson () 
  local varstring=bashGetVar("KEY_SET") 
  local vars=varstring:split(" ")
  mTable = {}

  for key,value in pairs(vars) do
    local newData = JSON:decode(bashGetVar(value))
    local nuTable = merge(mTable,newData)  
    mTable = nuTable
  end

  print(encodeJson(mTable))
end

function l_decodeJson (decodeVar) 
  local jstring = bashGetVar(decodeVar)
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
  local varstring=bashGetVar("KEY_SET") 
  local vars=varstring:split(" ")
  local t = {}

  for key,value in pairs(vars) do

      try = pcall(function()
        t[value] = JSON:decode(bashGetVar(value))
      end) 
      if not try then 
        t[value] = bashGetVar(value)
      end
        
  end
  local jsons = encodeJson(t)
  print(jsons)
end

function l_encodeJsonArray ()
  local l = {}
  for line in io.lines() do
      try = pcall(function()
        local nxt = JSON:decode(line)
        table.insert(l,nxt)
      end) 
      if not try then 
        table.insert(l,line)
      end
  end
  print(encodeJson(l))
end


bash.register("l_decodeJson")
bash.register("l_encodeJson")
bash.register("l_encodeJsonArray")
bash.register("l_mergeJson")
bash.register("l_getJsonValue")
