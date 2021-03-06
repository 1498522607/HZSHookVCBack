//
//  UINavigationControllerHookBackDelegate.h
//  Pods
//
//  Created by 古德猫宁 on 2020/11/15.
//

#import <Foundation/Foundation.h>

@protocol UINavigationControllerHookBackDelegate <NSObject>
@optional
/**
 如果需要拦截返回按钮的点击事件，请实现这个
 @return NO要自己管理
 */
- (BOOL)hzs_backBarButtonItemDidClickAction;
/**
 如果需要拦截手势返回，请实现这个方法
 @return NO要自己管理
 */
- (BOOL)hzs_backGestureAction;
@end
