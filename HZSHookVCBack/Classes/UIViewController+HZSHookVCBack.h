//
//  UIViewController+HZSHookVCBack.h
//  Pods
//
//  Created by 古德猫宁 on 2020/11/15.
//

#import <UIKit/UIKit.h>
#import "UINavigationControllerHookBackDelegate.h"


@interface UIViewController (HZSHookVCBack)<UINavigationControllerHookBackDelegate>
//是否禁用手势
@property (nonatomic, assign) BOOL hzs_interactivePopDisabled;
//手势返回的最大交互距离，默认全屏
@property (nonatomic, assign) CGFloat hzs_interactiveDistanceToLeftEdge;
@end


