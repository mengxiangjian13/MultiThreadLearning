//
//  GCDSemaphoreVC.h
//  MultiThreadLearning
//
//  Created by mengxiangjian on 2020/3/28.
//  Copyright © 2020 mengxiangjian. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/// 1. dispatch_semaphore: 信号量。大致意思是，信号>=0，不阻塞线程；信号量<0阻塞线程。用于做到线程之间同步。
/// 1. dispatch_semaphore_create(1): 生成信号量对象
/// 2. dispatch_semaphore_signal(): 发送一个信号，信号量+1
/// 3. dispatch_semaphore_wait(): 减少一个信号，可以设置超时时间（和dispatch_group_wait中的超时时间差不多）。
@interface GCDSemaphoreVC : UIViewController

@end

NS_ASSUME_NONNULL_END
