//
//  UIViewController+Button.m
//  MultiThreadLearning
//
//  Created by mengxiangjian on 2020/3/28.
//  Copyright © 2020 mengxiangjian. All rights reserved.
//

#import "UIViewController+Button.h"

@implementation UIViewController (Button)

- (UIButton *)buttonWithFrame:(CGRect)frame
                        title:(NSString *)title
                       action:(SEL)action {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    button.frame = frame;
    [button setTitle:title forState:UIControlStateNormal];
    [button addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    return button;
}

@end
