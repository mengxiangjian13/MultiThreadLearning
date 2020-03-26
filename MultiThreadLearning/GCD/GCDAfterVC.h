//
//  GCDAfterVC.h
//  MultiThreadLearning
//
//  Created by mengxiangjian on 2020/3/26.
//  Copyright © 2020 mengxiangjian. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/// dispatch_after 可以实现，延迟一定时间，将可执行block分发到指定的queue中。值得注意的是，
/// 这个延迟时间是延迟分发的时间，不是可执行block开始执行的时间。开始执行需要队列调度。
@interface GCDAfterVC : UIViewController

@end

NS_ASSUME_NONNULL_END
