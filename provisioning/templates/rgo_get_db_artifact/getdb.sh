#!/bin/bash

function usage_mode() {
    echo "Correct usage: getdb <type> <schema> <object>"    
    echo "  type must be: "
    echo "      -p: procedure, -f: function, -v: view, -t: table"    
    echo "  example: getdb -p MOSY EXO_ACRISS_GET"
}

type=$1
schema=$2
object=$3

if [[ $# -ne 3 ]];
then
    usage_mode
    exit -1
fi

if [[ -z $type ]];
then
  echo "Type not specified"
  usage_mode
  exit -1
fi

if [[ -z $schema ]];
then
  echo "schema not specified"
  usage_mode
  exit -1
fi

if [[ -z $object ]];
then
  echo "Object not specified"
  usage_mode
  exit -1
fi

case $type in
  -p)
    type="PROCEDURES"
  ;;
  -f)
    type="FUNCTIONS"
  ;;  
  -v)
    type="VIEWS"
  ;; 
  -t)
    type="TABLES"
  ;;   
   *)   
    echo "Type $type not supported"
    usage_mode
    exit -1
  ;;
esac

mkdir -p "./db/$schema/$type/$object"

echo "Downloading $type: $schema.$object in ./db/$schema/$type/$object"

ansible-playbook "$HOME/repos/recordgo/rgo_get_db_artifact/rgogetdbartifact-playbook.yml" --extra-vars="current_path=$(pwd) type=$type schema=$schema object=$object"

if [[ $? -ne 0 ]];
then
  echo "Ups... There was some errors downloading $schema.$object"
  exit -1
fi

dos2unix $(find ./db/$schema/$type/$object/ -type f -exec grep -Iq . {} \; -print)

echo "$schema.$object downloaded"