#!/bin/bash

# 2333
git clone https://github.com/xiaorouji/openwrt-passwall passwall
git clone https://github.com/fw876/helloworld
svn co https://github.com/coolsnowwolf/lede/trunk/package/lean/pdnsd-alt
svn co https://github.com/coolsnowwolf/lede/trunk/package/lean/microsocks
svn co https://github.com/coolsnowwolf/lede/trunk/package/lean/dns2socks
svn co https://github.com/coolsnowwolf/lede/trunk/package/lean/simple-obfs
svn co https://github.com/coolsnowwolf/lede/trunk/package/lean/redsocks2
svn co https://github.com/coolsnowwolf/lede/trunk/package/lean/kcptun
svn co https://github.com/coolsnowwolf/lede/trunk/package/lean/shadowsocksr-libev
svn co https://github.com/coolsnowwolf/lede/trunk/package/lean/ipt2socks
git clone https://github.com/vernesong/OpenClash.git
mv -f OpenClash/luci-app-openclash ./luci-app-openclash
rm -rf OpenClash

# 主题
git clone https://github.com/garypang13/luci-theme-edge -b 18.06
svn co https://github.com/kenzok8/openwrt-packages/trunk/luci-theme-atmaterial
svn co https://github.com/Lienol/openwrt-luci/trunk/themes/luci-theme-material
git clone https://github.com/jerrykuku/luci-theme-argon -b 18.06
git clone https://github.com/jerrykuku/luci-app-argon-config
svn co https://github.com/sirpdboy/sirpdboy-package/trunk/luci-theme-opentomcat
git clone https://github.com/sirpdboy/luci-theme-opentopd
git clone https://github.com/xiaoqingfengATGH/luci-theme-infinityfreedom
git clone https://github.com/rosywrt/luci-theme-rosy

#依赖
git clone https://github.com/jerrykuku/node-request
svn co https://github.com/coolsnowwolf/packages/trunk/libs/libcap
svn co https://github.com/coolsnowwolf/lede/trunk/package/lean/redsocks2

# 插件
# svn co https://github.com/sirpdboy/sirpdboy-package/trunk/luci-app-netdata
# svn co https://github.com/sirpdboy/sirpdboy-package/trunk/netdata
svn co https://github.com/openwrt/luci/trunk/collections/luci-ssl-openssl
svn co https://github.com/sirpdboy/sirpdboy-package/trunk/luci-app-koolddns
svn co https://github.com/kenzok8/openwrt-packages/trunk/luci-app-aliddns
svn co https://github.com/sirpdboy/sirpdboy-package/trunk/cpulimit
svn co https://github.com/sirpdboy/sirpdboy-package/trunk/luci-app-cpulimit
svn co https://github.com/firker/diy-ziyong/trunk/luci-app-wrtbwmon-zhcn luci-app-wrtbwmon-zh
svn co https://github.com/firker/diy-ziyong/trunk/wrtbwmon
svn co https://github.com/siropboy/mypackages/trunk/luci-app-advanced
svn co https://github.com/siropboy/mypackages/trunk/luci-app-autopoweroff
svn co https://github.com/siropboy/mypackages/trunk/luci-app-koolproxyR
git clone https://github.com/tty228/luci-app-serverchan
git clone https://github.com/esirplayground/luci-app-poweroff
git clone https://github.com/littletao08/luci-app-eqos
git clone https://github.com/iamaluckyguy/luci-app-smartinfo
git clone https://github.com/jerrykuku/luci-app-jd-dailybonus
svn co https://github.com/Lienol/openwrt-package/trunk/luci-app-fileassistant
svn co https://github.com/Lienol/openwrt-package/trunk/luci-app-filebrowser

sed -i 's/"Argon 主题设置"/"Argon设置"/g' luci-app-argon-config/po/zh-cn/argon-config.po
sed -i 's@e5effd@f8fbfe@g' luci-theme-edge/htdocs/luci-static/edge/cascade.css #luci-theme-edge主题颜色微调
sed -i 's#223, 56, 18, 0.04#223, 56, 18, 0.02#g' luci-theme-edge/htdocs/luci-static/edge/cascade.css #luci-theme-edge主题颜色微调


# 生成完整目录清单
cat >> Update.md <<EOF
helloworld
pdnsd-alt
microsocks
dns2socks
simple-obfs
redsocks2
kcptun
luci-app-openclash
luci-theme-edge
luci-theme-atmaterial
luci-theme-material
luci-theme-argon
luci-app-argon-config
luci-theme-opentomcat
luci-theme-opentopd
luci-theme-infinityfreedom
luci-theme-rosy
luci-app-koolddns
luci-app-aliddns
cpulimit
luci-app-cpulimit
luci-app-wrtbwmon-zh
wrtbwmon
luci-app-advanced
luci-app-autopoweroff
luci-app-koolproxyR
luci-app-serverchan
luci-app-poweroff
luci-app-eqos
luci-app-smartinfo
luci-app-jd-dailybonus
node-request
libcap
redsocks2
EOF

# luci-app-netdata
# netdata

# 获取所有更新目录并显示
ls | grep -v 'Update.md' | grep -v 'UpdateList.md' | grep -v '18.06.sh' >> UpdateList.md

# 对比Update.md文件里没有的内容，并生成变量
echo 缺失包列表
FOLDERS=`grep -Fxvf UpdateList.md Update.md`
FOLDERSX=`echo $FOLDERS | sed 's/ /、/g'`;echo $FOLDERSX

# 判断变量值，如果有效发送微信通知
if [ -n "$FOLDERS" ]; then  curl https://sctapi.ftqq.com/$SCKEY.send?text=插件同步失败-19.07-$FOLDERSX; else touch 同步完成; fi
# 删除对比更新目录列表
rm -rf Update.md
rm -rf UpdateList.md

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
