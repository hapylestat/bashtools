#!/bin/bash

APPNAME=nginx
APPVER=1.5.10
DEPNAME1=openssl
DEPVER1=1.0.1e
FAKENAME=sangou
FAKEVER=0.1

if [ ! -f $srvDOWNDIR/$APPNAME-$APPVER.tar.gz ]; then
 run "wget http://nginx.org/download/$APPNAME-$APPVER.tar.gz -O $srvDOWNDIR/$APPNAME-$APPVER.tar.gz" "Download source"
else
 echo "Source are exist..."
fi

if [ ! -f $srvDOWNDIR/$DEPNAME1-$DEPVER1.tar.gz ]; then
 run "wget http://www.openssl.org/source/$DEPNAME1-$DEPVER1.tar.gz -O $srvDOWNDIR/$DEPNAME1-$DEPVER1.tar.gz" "Download dependency source"
else
 echo "Dependency are exists..."
fi


switch_dir $srvDOWNDIR
run "tar -xf $srvDOWNDIR/$APPNAME-$APPVER.tar.gz" "Prepare source"
run "tar -xf $srvDOWNDIR/$DEPNAME1-$DEPVER1.tar.gz" "Prepare dependency source"
switch_dir

#workaround for compilation openssl package(on rawhide with latest perl)
rm -f $srvDOWNDIR/$DEPNAME1-$DEPVER1/doc/apps/cms.pod
rm -f $srvDOWNDIR/$DEPNAME1-$DEPVER1/doc/apps/smime.pod
rm -f $srvDOWNDIR/$DEPNAME1-$DEPVER1/doc/crypto/X509_STORE_CTX_get_error.pod
rm -f $srvDOWNDIR/$DEPNAME1-$DEPVER1/doc/ssl/*.pod
echo "=pod" > $srvDOWNDIR/$DEPNAME1-$DEPVER1/doc/ssl/temp.pod
echo "=cut" >> $srvDOWNDIR/$DEPNAME1-$DEPVER1/doc/ssl/temp.pod
#======


run "rm -rf $srvDIR/$APPNAME && rm -rf $srvBINDIR/$APPNAME-$APPVER" "Cleanup...."
run "mkdir $srvBINDIR/$APPNAME-$APPVER && ln -s $srvBINDIR/$APPNAME-$APPVER $srvDIR/$APPNAME" "Make links"

sed -i -e "s/Server: nginx/Server: $FAKENAME/g" $srvDOWNDIR/$APPNAME-$APPVER/src/http/ngx_http_header_filter_module.c
sed -i -e 's/"Server: " NGINX_VER/"Server: '$FAKENAME'\/'$FAKEVER'"/g' $srvDOWNDIR/$APPNAME-$APPVER/src/http/ngx_http_header_filter_module.c


switch_dir $srvDOWNDIR/$APPNAME-$APPVER
run "./configure --prefix=$srvDIR/$APPNAME --with-http_ssl_module --with-http_realip_module --with-http_dav_module --with-http_gzip_static_module --with-http_random_index_module --with-pcre --with-ipv6 --with-http_auth_request_module --error-log-path=$srvLOGDIR/$APPNAME/error.log --conf-path=$srvCONFDIR/$APPNAME/$APPNAME.conf --with-openssl=$srvDOWNDIR/$DEPNAME1-$DEPVER1" "Configure project"
run "make" "Compile project"
run "make install" "Install project"
switch_dir

#echo -e "${COLOR_VALUE}Install $APPANAME service....${COLOR_END}"
#service_install "$APPNAME" "$srvDIR/$APPNAME/sbin/$APPNAME" "forking"

