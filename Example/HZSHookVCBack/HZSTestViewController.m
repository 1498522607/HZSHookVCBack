//
//  HZSTestViewController.m
//  HZSHookVCBack_Example
//
//  Created by hzsMac on 2020/11/15.
//  Copyright © 2020 1498522607@qq.com. All rights reserved.
//

#import "HZSTestViewController.h"



@interface HZSTestViewController ()

@end

@implementation HZSTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor redColor];
}

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


@end
