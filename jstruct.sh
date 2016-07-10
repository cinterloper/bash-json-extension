#!/bin/bash
# this is an example of a semi-native json encoder and decoder for bash
# to encode json, set KEY_SET to a list of env var keys
# to decode json, set JSON_STRING to the payload, then call decodeJson. the keys in the string will become the keys in the enviornment


#require luabash
luabash load ./jstruct.lua
#defaults to JSON_STRING, but you can pass the name of a custom var to decode
decodeJson() {
  JSON_VAR=$1
  if [ "$JSON_VAR" == "" ]
  then
    JSON_VAR="JSON_STRING"
  fi
  if [ "$DECODE_SILENT" != "" ]
  then
    l_decodeJson $JSON_VAR > /dev/null
  else
    l_decodeJson $JSON_VAR
  fi
}
#you can pipe to this, or set KEY_SET
encodeJson() {
  if [ "$KEY_SET" == "" ]
  then
    while read KEY; do
      KEY_SET="$KEY "
      l_encodeJson
    done
  else
    l_encodeJson
  fi
}
