//
//  UIViewController+HZSHookVCBack.m
//  Pods
//
//  Created by 古德猫宁 on 2020/11/15.
//

#import "UIViewController+HZSHookVCBack.h"
#import <objc/runtime.h>


@implementation UIViewController (HZSHookVCBack)

static char key1;
- (void)setHzs_interactivePopDisabled:(BOOL)hzs_interactivePopDisabled {
    NSNumber *number = [NSNumber numberWithBool:hzs_interactivePopDisabled];
    objc_setAssociatedObject(self, &key1, number, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)hzs_interactivePopDisabled {
    NSNumber *number = objc_getAssociatedObject(self, &key1);
    return [number boolValue];
}


static char key2;
- (void)setHzs_interactiveDistanceToLeftEdge:(CGFloat)hzs_interactiveDistanceToLeftEdge {
    NSNumber *number = [NSNumber numberWithFloat:hzs_interactiveDistanceToLeftEdge];
    objc_setAssociatedObject(self, &key2, number, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(CGFloat)hzs_interactiveDistanceToLeftEdge {
    NSNumber *number = objc_getAssociatedObject(self, &key2);
    return [number floatValue];
}


@end
