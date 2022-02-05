**本仓库采用GITHUB的Actions功能进行OpenWRT固件编译**

仓库使用说明如下：

**自定义固件补丁及其他补充**

具体例子可参考 XIAOMI_4A-GIGABit 目录下的脚本及文件

 files目录 在编译的时候，会把files文件夹里的文件编译到固件的根目录（具体自行上网搜索其作用）
 
 .config 文件自行提供
 
 feeds.conf.default 软件源文件 如果使用原文件(openwrt源码自带)可以不上传或者Actions编译时选择false则不会替换
 
 openwrt_patch.sh 此脚本将会在clone源代码后执行
 
 make_befor.sh 此脚本将会在执行编译固件(make)前执行
 
 make_after.sh 此脚本会在编译固件完成后执行
 
**编译OpenWRT**

点击仓库上方的 **Actions** 按钮进行openwrt源仓库选择或者选择自定义仓库及分支 并选择脚本执行开关进行编译
![image](https://user-images.githubusercontent.com/35430449/152649957-836b4ff6-81e8-49d8-9a39-61ecf37e3dde.png)

**仓库功能**

仓库设置(Settings->Secrets->Actions)添加3个仓库变量 GIT_TOKEN , GIT_UNAME , GITUMAIL
![image](https://user-images.githubusercontent.com/35430449/152649432-c7f627f0-8c27-4056-a34f-7c1f4db499d0.png)

**GIT_TOKEN:**
![image](https://user-images.githubusercontent.com/35430449/152649583-09760b68-3ce4-4271-a70a-8e26b91afef0.png)

**GIT_UNAME:**
![image](https://user-images.githubusercontent.com/35430449/152649623-a1e8588a-8581-4d20-85b7-d6d5178b0ab7.png)

**GIT_UMAIL：**GITHUB 注册邮箱


每天凌晨0点将会对.github/workflows/下的 yml文件 进行自动更新（自动更新本地固件脚本目录列表及openwrt固件源分支列表）

也可以手动更新

**更新脚本为主目录下的 UpdateActionData.sh 请自行查阅**

更多具体功能请自行探索，本人不太会描述，所以有人写了更好的readme.md请告知一声，让我抄一下作业。

