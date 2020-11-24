//
//  UINavigationController+HZSHookVCBack.h
//  Pods
//
//  Created by 古德猫宁 on 2020/11/15.
//

#import <UIKit/UIKit.h>

@interface UINavigationController (HZSHookVCBack)<UIGestureRecognizerDelegate, UINavigationBarDelegate>
//系统的手势已经被禁用，由这个响应
@property (nonatomic, strong, readonly) UIPanGestureRecognizer * hzs_backGestureRecognizer;
@end
