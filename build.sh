#!/bin/bash
cd ./server/scripts
if [[ $? -ne 0 ]]; then
    exit 1
fi

./build-wrapper.sh .. my_server.jar debug

if [[ $? -ne 0 ]]; then
    exit 1
fi

cd ../..

echo "server: $1"
build_dir="build"
echo "sudo rm -rf $build_dir"
sudo rm -rf $build_dir \
&& \
mkdir -p $build_dir \
&& \
meson $build_dir --buildtype release --strip -Db_lto=true -Dbuild_app=true -Dprebuilt_server=./server/scripts/my_server.jar \
&& \
cd $build_dir \
&& \
sudo ninja install
