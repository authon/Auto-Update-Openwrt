#!/bin/bash

git clone https://github.com/Lienol/openwrt
git clone https://github.com/Lienol/openwrt-packages packages -b 19.07
git clone https://github.com/Lienol/openwrt-luci luci -b 18.06
git clone https://github.com/xiaorouji/openwrt-passwall passwall

# 检测同步是否完成
folder1=openwrt
folder2=packages
folder3=luci
folder4=passwall

if [ -d "$folder1" ];then  echo "$folder1 成功";  else  echo "$folder1 失败"; fi | tee -a FOLDERS.md
if [ -d "$folder2" ];then  echo "$folder2 成功";  else  echo "$folder2 失败"; fi | tee -a FOLDERS.md
if [ -d "$folder3" ];then  echo "$folder3 成功";  else  echo "$folder3 失败"; fi | tee -a FOLDERS.md
if [ -d "$folder4" ];then  echo "$folder4 成功";  else  echo "$folder4 失败"; fi | tee -a FOLDERS.md

echo 缺失包列表
FOLDERS=`grep 失败 FOLDERS.md`
FOLDERSX=`echo $FOLDERS | sed 's/ /、/g'`;echo $FOLDERSX

# 判断变量值，如果有效发送微信通知
if [ -n "$FOLDERS" ]; then  curl https://sctapi.ftqq.com/$SCKEY.send?text=插件同步失败-lean-$FOLDERSX; else touch 同步完成; fi
rm -rf FOLDERS.md


rm -rf .svn
rm -rf ./*/.git
rm -rf ./*/.svn
rm -rf ./*/*/.svn
rm -rf ./*/*/.git
rm -rf ./*/LICENSE
rm -rf ./*/readme.txt
rm -f .gitattributes .gitignore
# rm -rf ./*/README.md
exit 0
