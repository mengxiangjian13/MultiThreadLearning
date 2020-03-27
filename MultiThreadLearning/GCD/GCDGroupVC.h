//
//  GCDGroupVC.h
//  MultiThreadLearning
//
//  Created by mengxiangjian on 2020/3/27.
//  Copyright © 2020 mengxiangjian. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


/// 1. dispatch_group_async 将任务加入group中，这样可以在并发执行多个任务时候，将多个任务加入到group中，group中的所有任务执行完毕的时候，会得到通知。
/// 1. dispatch_group_wait 等待group执行完毕，阻塞。timeout参数，可以指定超时时间，到时不管是否执行完都不再阻塞。如果将timeout参数赋值DISPATCH_TIME_FOREVER，则直到执行完毕再通过，否则永久阻塞。
/// 2. 用dispatch_group_notify 来替代wait，这样不会阻塞，在group任务执行完毕的时候，执行notify的block。同时，还可以指定notify的queue，指定notify的block在指定的queue中执行。
/// 3. 可以将在不同queue中执行的任务加入到同一个group中。
/// 4. dispatch_group 适用与并发队列，如果是串行队列就没必要了。
@interface GCDGroupVC : UIViewController

@end

NS_ASSUME_NONNULL_END
