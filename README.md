##CocoaPicker --仿QQ图片选择器


###如何使用

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


![Image](http://ww3.sinaimg.cn/large/640e3faagw1evgy8z326qg209m0gtqv9.gif) 

###QQ
![Image](http://ww4.sinaimg.cn/large/640e3faagw1evgya4vmknj20ku112acv.jpg) 




