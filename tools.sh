#!/bin/bash

cp -r ../lede/tools/upx tools/upx

sed -i '/# builddir dependencies/i \
tools-y += upx
' tools/Makefile

sed -i '/# builddir dependencies/a \
$(curdir)\/upx\/compile := $(curdir)\/ucl\/compile
' tools/Makefile