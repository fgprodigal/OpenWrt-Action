#!/bin/bash

cp -r ../lede/tools/upx tools/upx
cp -r ../lede/tools/ucl tools/ucl

sed -i '/# builddir dependencies/i \
tools-y += ucl upx
' tools/Makefile

sed -i '/# builddir dependencies/a \
$(curdir)\/upx\/compile := $(curdir)\/ucl\/compile
' tools/Makefile