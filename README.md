# HZSHookVCBack

[![CI Status](https://img.shields.io/travis/1498522607@qq.com/HZSHookVCBack.svg?style=flat)](https://travis-ci.org/1498522607@qq.com/HZSHookVCBack)
[![Version](https://img.shields.io/cocoapods/v/HZSHookVCBack.svg?style=flat)](https://cocoapods.org/pods/HZSHookVCBack)
[![License](https://img.shields.io/cocoapods/l/HZSHookVCBack.svg?style=flat)](https://cocoapods.org/pods/HZSHookVCBack)
[![Platform](https://img.shields.io/cocoapods/p/HZSHookVCBack.svg?style=flat)](https://cocoapods.org/pods/HZSHookVCBack)

## Example

导入头文件HZSHookVCBack.h
然后实现UINavigationControllerHookBackDelegate里面的方法即可实现拦截
```ruby
- (BOOL)hzs_backGestureAction {
    
    [self showAlert];
    return NO;
}

- (BOOL)hzs_backBarButtonItemDidClickAction {
    
    [self showAlert];
    return NO;
}

- (void)showAlert {
    UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"是否要退出页面" preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定退出" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self.navigationController popViewControllerAnimated:YES];
    }]];
    
    [self presentViewController:alert animated:YES completion:nil];
}
```

## Requirements

## Installation

HZSHookVCBack is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'HZSHookVCBack'
```

## Author

黄祖树, 1498522607@qq.com

## License

HZSHookVCBack is available under the MIT license. See the LICENSE file for more info.
