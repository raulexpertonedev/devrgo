#DEBES GESTIONAR LA AUTENTICACIÓN EN EL XS ENGINE!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!:
#!/bin/bash

if [[ $@ -ne 2 ]];
then 
  echo "Wrong parametes number..."
  echo "  Coorect usage: getxs <xs_package_name> <xs_file_name>"
  exit -1
fi

xsbaseurl="http://192.168.142.102:8000/"   #url en xper-hanades02
xsjs_user="B1DEVUSER"                                          
xsjs_password="12629iYk"
authHeader="Authorization:Basic QjFERVZVU0VSOjEyNjI5aVlr"       
xspackage=$1
xsfile=$2


if [[ -z $xsimportpath ]]; then
  xsimportpath="/mnt/hgfs/SCRATCH/"
fi

xsgetfilesuffix="sap/hana/xs/dt/base/file/"

mkdir -p ./xs/${xspackage}

curl -o ./xs/${xspackage}/${xsfile} --location "${xsbaseurl}${xsgetfilesuffix}${xspackage}/${xsfile}" \
     --header "$authHeader" \
     --header "Cookie:$cookies_value"

dos2unix ./xs/${xspackage}/${xsfile}