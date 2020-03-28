//
//  UIViewController+Button.h
//  MultiThreadLearning
//
//  Created by mengxiangjian on 2020/3/28.
//  Copyright © 2020 mengxiangjian. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (Button)

- (UIButton *)buttonWithFrame:(CGRect)frame
                        title:(NSString *)title
                       action:(SEL)action;

@end

NS_ASSUME_NONNULL_END
