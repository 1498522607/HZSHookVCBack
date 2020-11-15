//
//  UINavigationControllerHookBackDelegate.h
//  Pods
//
//  Created by 黄祖树 on 2020/11/15.
//

#import <Foundation/Foundation.h>

@protocol UINavigationControllerHookBackDelegate <NSObject>
@optional
/**
 如果需要拦截返回按钮的点击事件，请实现这个
 @return NO要自己管理
 iOS14模拟器有点奇怪直接跑起来模拟器并没有回调这个，但是编译完成后，再从模拟器里打开是没问题的，真机也没问题
 */
- (BOOL)hzs_backBarButtonItemDidClickAction;
/**
 如果需要拦截手势返回，请实现这个方法
 @return NO要自己管理
 */
- (BOOL)hzs_backGestureAction;
@end
