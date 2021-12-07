# JKAlertX

[![License MIT](https://img.shields.io/badge/license-MIT-green.svg?style=flat)](https://raw.githubusercontent.com/Dilrvvr/JKAlertX/master/LICENSE) &nbsp;
[![CocoaPods](http://img.shields.io/cocoapods/v/JKAlertX.svg?style=flat)](https://cocoapods.org/pods/JKAlertX) &nbsp;
[![CocoaPods](http://img.shields.io/cocoapods/p/JKAlertX.svg?style=flat)](https://cocoapods.org/pods/JKAlertX) &nbsp;
[![Support](https://img.shields.io/badge/support-iOS8+-blue.svg?style=flat)](https://www.apple.com/nl/ios/) &nbsp;


JKAlertX is an alert view for iOS with supporting user customization perfectly.

iOS弹框，包含alert/actionSheet/collectionSheet(类似分享面板)/HUD四种样式。  

自动适配横屏，完美支持自定义。  

支持链式语法，简洁方便！


版本说明
==============

### JKAlertX已重构并更新至2.X版本，基本兼容低版本

1. 如更新后提示方法找不到报错，有可能是1.X中的拼写错误已改正。

2. 将各种样式的弹框分离为单独的控件，方便代码维护及添加新的样式。

3. 更新了默认的界面样式，模糊透明效果改为纯色(HUD样式保留)，sheet样式默认添加圆角等。

4. 支持手动调整深色/浅色模式，目前仅支持全局调整。


基本用法
==============

#### 正常写法（基础弹框）
```objc
JKAlertView *alertView = [JKAlertView alertViewWithTitle:@"标题" message:@"内容" style:(JKAlertStyleAlert)];

[alertView addAction:[JKAlertAction actionWithTitle:@"取消" style:JKAlertActionStyleCancel handler:^(JKAlertAction *action) {

}]];

[alertView addAction:[JKAlertAction actionWithTitle:@"确定" style:JKAlertActionStyleDefaultBlue handler:^(JKAlertAction *action) {

}]];

[alertView show];
```
#### 链式写法（基础弹框）
```objc
JKAlertView.alertView(@"标题", @"内容", JKAlertStyleAlert)
.addAction(JKAlertAction.action(@"取消", JKAlertActionStyleCancel, ^(JKAlertAction *action) {
    
}))
.addAction(JKAlertAction.action(@"确定", JKAlertActionStyleDefaultBlue, ^(JKAlertAction *action) {
    
}))
.show();
```

演示项目
==============
查看并运行 `Example/JKAlertX.xcodeproj`  

### plain带textField样式  
<div align="center">    
<img src="https://raw.githubusercontent.com/Dilrvvr/JKAlertX/master/Snapshots/plain.PNG" width="375">
<img src="https://raw.githubusercontent.com/Dilrvvr/JKAlertX/master/Snapshots/plain_dark.PNG" width="375">
</div>
<br/>

### actionSheet样式  
<div align="center">    
<img src="https://raw.githubusercontent.com/Dilrvvr/JKAlertX/master/Snapshots/actionSheet.PNG" width="375">
<img src="https://raw.githubusercontent.com/Dilrvvr/JKAlertX/master/Snapshots/actionSheet_dark.PNG" width="375">
</div>
<br/>

### collectionSheet & HUD样式
<div align="center">    
<img src="https://raw.githubusercontent.com/Dilrvvr/JKAlertX/master/Snapshots/collectionSheet.PNG" width="375">
<img src="https://raw.githubusercontent.com/Dilrvvr/JKAlertX/master/Snapshots/HUD.PNG" width="375"><br/>
</div>
<br/>

### actionSheet样式横屏  
<div align="center">    
<img src="https://raw.githubusercontent.com/Dilrvvr/JKAlertX/master/Snapshots/actionSheet_landscape.PNG" width="812"><br/>
</div>
<br/>

### collectionSheet样式横屏  
<div align="center">    
<img src="https://raw.githubusercontent.com/Dilrvvr/JKAlertX/master/Snapshots/collectionSheet_landscape.PNG" width="812"><br/>
</div>
<br/>

安装
==============

### CocoaPods

1. 在 Podfile 中添加  `pod 'JKAlertX'`。
2. 执行 `pod install` 或 `pod update`。
3. 导入 `<JKAlertX/JKAlertX.h>`。

### 手动安装

1. 下载 JKAlertX 文件夹内的所有内容。
2. 将 JKAlertX 内的源文件添加(拖放)到你的工程。
4. 链接以下 frameworks:
    * UIKit
6. 导入 `JKAlertX.h`。

系统要求
==============
该项目最低支持 `iOS 8.0` 。


许可证
==============
JKAlertX 使用 MIT 许可证，详情见 LICENSE 文件。


联系方式
==============
使用中有任何问题，欢迎添加微信  

<div>    
<img src="https://raw.githubusercontent.com/Dilrvvr/JKAlertX/master/Snapshots/wechat.JPG" width="337"><br/>
</div>
<br/>
