//
//  UIViewController+HideLine.m
//  ams
//
//  Created by 趙乐樂 on 2017/1/17.
//  Copyright © 2017年 趙乐樂. All rights reserved.
//

#import "UIViewController+HideLine.h"


@implementation UIViewController (HideLine)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class class = [self class];
        
        SEL originalSelector1 = @selector(viewDidLoad);
        SEL swizzledSelector1 = @selector(mc_viewDidLoad);
        
        Method originalMethod1 = class_getInstanceMethod(class, originalSelector1);
        Method swizzledMethod1 = class_getInstanceMethod(class, swizzledSelector1);
        
        BOOL didAddMethod =
        class_addMethod(class,
                        originalSelector1,
                        method_getImplementation(swizzledMethod1),
                        method_getTypeEncoding(swizzledMethod1));
        
        if (didAddMethod) {
            class_replaceMethod(class,
                                swizzledSelector1,
                                method_getImplementation(originalMethod1),
                                method_getTypeEncoding(originalMethod1));
            
        } else {
            method_exchangeImplementations(originalMethod1, swizzledMethod1);
        }
        
    });
}

- (void)mc_viewDidLoad {
    [self mc_viewDidLoad];
    
    if (self.navigationController) {
        [self hideBottomLine];
    }
    
}

- (void)hideBottomLine {
    //MCTeachingHomeViewController
    Class class = NSClassFromString(@"MainViewController");
    if (self.class == class) {
        return;
    }
    
    if ([UIDevice currentDevice].systemVersion.floatValue >= 10.0) {
        if ([self.navigationController.navigationBar respondsToSelector:@selector(setBackgroundImage:forBarMetrics:)]) {
            NSArray *list=self.navigationController.navigationBar.subviews;
            for (id obj in list) {
                //10.0的系统字段不一样
                UIView *view =   (UIView*)obj;
                for (id obj2 in view.subviews) {
                    if ([obj2 isKindOfClass:[UIImageView class]]) {
                        UIImageView *image =  (UIImageView*)obj2;
                        if (image.frame.size.height <= 1) {
                            image.hidden = YES;
                        }
                    }
                    
                    if ([obj2 isKindOfClass:[UIView class]]) {
                        UIView *view2 = (UIView *)obj2;
                        if (view2.frame.size.height <= 1) {
                            view2.hidden = YES;
                        }
                    }
                }
            }
            
        }
        
        return;
    }
    
    
    if ([self.navigationController.navigationBar respondsToSelector:@selector(setBackgroundImage:forBarMetrics:)]){
        NSArray *list = self.navigationController.navigationBar.subviews;
        for (id obj in list) {
            if ([obj isKindOfClass:[UIImageView class]]) {
                UIImageView *imageView = (UIImageView *)obj;
                NSArray *list2 = imageView.subviews;
                for (id obj2 in list2) {
                    if ([obj2 isKindOfClass:[UIImageView class]]) {
                        UIImageView *imageView2 = (UIImageView *)obj2;
                        if (imageView2.frame.size.height <= 1) {
                            imageView2.hidden = YES;
                        }
                    }
                    
                    if ([obj2 isKindOfClass:[UIView class]]) {
                        UIView *view2 = (UIView *)obj2;
                        if (view2.frame.size.height <= 1) {
                            view2.hidden = YES;
                        }
                    }
                }
            }
        }
    }
}

@end
