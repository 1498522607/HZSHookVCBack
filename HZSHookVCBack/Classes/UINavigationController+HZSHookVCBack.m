//
//  UINavigationController+HZSHookVCBack.m
//  Pods
//
//  Created by 黄祖树 on 2020/11/15.
//

#import "UINavigationController+HZSHookVCBack.h"
#import "UIViewController+HZSHookVCBack.h"
#import <objc/runtime.h>


@implementation UINavigationController (HZSHookVCBack)
+(void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class class = [self class];
        SEL originalSelector = @selector(pushViewController:animated:);
        SEL swizzledSelector = @selector(hzs_pushViewController:animated:);
        Method originalMethod = class_getInstanceMethod(class, originalSelector);
        Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
        BOOL success = class_addMethod(class, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));
        if (success) {
            class_replaceMethod(class, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
        } else {
            method_exchangeImplementations(originalMethod, swizzledMethod);
        }
    });
}

- (void)hzs_pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (![self.interactivePopGestureRecognizer.view.gestureRecognizers containsObject:self.hzs_backGestureRecognizer])
    {
        /*
         这里逻辑是禁用原来的手势返回，并运用kvc取出target 和action交给自定义的手势响应
         */
        [self.interactivePopGestureRecognizer.view addGestureRecognizer:self.hzs_backGestureRecognizer];
        NSArray *internalTargets = [self.interactivePopGestureRecognizer valueForKey:@"targets"];
        id internalTarget = [internalTargets.firstObject valueForKey:@"target"];
        SEL internalAction = NSSelectorFromString(@"handleNavigationTransition:");
        self.hzs_backGestureRecognizer.delegate = self;
        [self.hzs_backGestureRecognizer addTarget:internalTarget action:internalAction];
        self.interactivePopGestureRecognizer.enabled = NO;
    }
    if (![self.viewControllers containsObject:viewController]) {
        [self hzs_pushViewController:viewController animated:animated];
    }
}




#pragma mark ---> UIGestureRecognizerDelegate代理方法
- (BOOL)gestureRecognizerShouldBegin:(UIPanGestureRecognizer *)gestureRecognizer
{
    //手势返回的时候会调用这个方法
    
    // 当为根控制器时，手势不执行。
    if (self.viewControllers.count <= 1) {
        return NO;
    }
    // 设置一个页面是否显示此手势，默认为NO 显示。
    UIViewController *topViewController = self.viewControllers.lastObject;
    if (topViewController.hzs_interactivePopDisabled) {
        return NO;
    }
    //  手势滑动距左边框的距离超过maxAllowedInitialDistance 手势不执行。
    CGPoint beginningLocation = [gestureRecognizer locationInView:gestureRecognizer.view];
    CGFloat maxAllowedInitialDistance = topViewController.hzs_interactiveDistanceToLeftEdge;
    if (maxAllowedInitialDistance > 0 && beginningLocation.x > maxAllowedInitialDistance) {
        return NO;
    }
    // 当push、pop动画正在执行时，手势不执行。
    if ([[self valueForKey:@"_isTransitioning"] boolValue]) {
        return NO;
    }
    //  向左边(反方向)拖动，手势不执行。
    CGPoint translation = [gestureRecognizer translationInView:gestureRecognizer.view];
    if (translation.x <= 0) {
        return NO;
    }
    if ([self.topViewController respondsToSelector:@selector(hzs_backGestureAction)]) {
        return [self.topViewController hzs_backGestureAction];
    }
    return YES;
}

- (BOOL)navigationBar:(UINavigationBar *)navigationBar shouldPopItem:(UINavigationItem *)item {
    /*
     这个分类是UINavigationController的分类，而不是子类的分类。
     优先级 ： 子类分类 > 子类 > 父类分类 > 父类
    */
    if ([self.topViewController respondsToSelector:@selector(hzs_backBarButtonItemDidClickAction)]) {
        BOOL back = [self.topViewController hzs_backBarButtonItemDidClickAction];
        if (back) {
            return [self originalNavigationBar:navigationBar shouldPopItem:item];
        } else {
            return back;
        }
    }
    return [self originalNavigationBar:navigationBar shouldPopItem:item];
}

/*
 分类重写方法优先级高于原类。
 */
- (BOOL)originalNavigationBar:(UINavigationBar *)navigationBar shouldPopItem:(UINavigationItem *)item {
    int index = -1;
    unsigned int outCount = 0;
    BOOL res = NO;
    
    Class tempclass = [UINavigationController class];
    Method *methods = class_copyMethodList(tempclass, &outCount);
    for (int i = outCount; i > 0; i--) {
        //降序查找
        Method method = methods[i];
        SEL methodName = method_getName(method);
        NSString * str = NSStringFromSelector(methodName);
        if ([str isEqualToString:@"navigationBar:shouldPopItem:"]) {
            index = i;
            break;
        }
    }
    if (index >= 0) {
        SEL sel = method_getName(methods[index]);
        IMP imp = method_getImplementation(methods[index]);
        res = ((BOOL (*)(id, SEL, UINavigationBar*, UINavigationItem*))imp)(self, sel, navigationBar, item);
        free(methods); //记得释放
        return res;
    }
    free(methods); //记得释放
    return res;
}

- (UIPanGestureRecognizer *)hzs_backGestureRecognizer {
    UIPanGestureRecognizer *panGestureRecognizer = objc_getAssociatedObject(self, _cmd);
    if (!panGestureRecognizer) {
        panGestureRecognizer = [[UIPanGestureRecognizer alloc] init];
        panGestureRecognizer.maximumNumberOfTouches = 1;
        objc_setAssociatedObject(self, _cmd, panGestureRecognizer, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return panGestureRecognizer;
}


@end
