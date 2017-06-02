##CocoaPicker --仿QQ图片选择器


###使用方法
```
platform :ios, '7.0'
pod "CocoaPicker"

```


 ```objective-c
  self.view.window.rootViewController.modalPresentationStyle = UIModalPresentationCurrentContext;//半透明
  CocoaPickerViewController *transparentView = [[CocoaPickerViewController alloc] init];
  transparentView.delegate = self;
  transparentView.modalPresentationStyle = UIModalPresentationOverFullScreen;
  transparentView.view.frame=self.view.frame;
  transparentView.view.superview.backgroundColor = [UIColor clearColor];
  [self presentViewController:transparentView animated:YES completion:nil];
```
      


###CocoaPicker


 <div align='center'>
        <img src="http://t.cn/RyPHLBc" width = "360" height = "640" alt=“图片名称” align=center />  
 </div>

###QQ

 <div align='center'>
        <img src="http://ww4.sinaimg.cn/large/640e3faagw1evgya4vmknj20ku112acv.jpg" width = "360" height = "640" alt=“图片名称” align=center />  
 </div>
 


