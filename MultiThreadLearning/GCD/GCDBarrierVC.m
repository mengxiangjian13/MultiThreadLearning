//
//  GCDBarrierVC.m
//  MultiThreadLearning
//
//  Created by mengxiangjian on 2020/3/27.
//  Copyright © 2020 mengxiangjian. All rights reserved.
//

#import "GCDBarrierVC.h"

@interface GCDBarrierVC ()

@end

@implementation GCDBarrierVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"Barrier Async";
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    button.frame = CGRectMake(0, 0, 200, 50);
    button.center = self.view.center;
    [button setTitle:@"dispatch_barrier_async" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(click:)
     forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}

- (void)click:(id)sender {
    NSLog(@"===========dispatch_barrier_async begin=============");
    // 这里有一个坑。dispatch_barrier_async 并不是在所有的并发队列里都可以做“栅栏”，在global queue中就不能做“栅栏”。
    // 只有在自己创建的 DISPATCH_QUEUE_CONCURRENT 队列中，才达到栅栏的作用。在global queue中，等同于dispatch_async
//    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_queue_t queue = dispatch_queue_create("com.mengxiangjian.barrier", DISPATCH_QUEUE_CONCURRENT);
    dispatch_async(queue, ^{
        [NSThread sleepForTimeInterval:2];
        NSLog(@"1-------block, thread: %@", [NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        [NSThread sleepForTimeInterval:2];
        NSLog(@"2-------block, thread: %@", [NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        [NSThread sleepForTimeInterval:2];
        NSLog(@"3-------block, thread: %@", [NSThread currentThread]);
    });
    
    dispatch_barrier_async(queue, ^{
        [NSThread sleepForTimeInterval:2];
        NSLog(@"barrier-------block, thread: %@", [NSThread currentThread]);
    });
    
    dispatch_async(queue, ^{
        [NSThread sleepForTimeInterval:2];
        NSLog(@"4-------block, thread: %@", [NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        [NSThread sleepForTimeInterval:2];
        NSLog(@"5-------block, thread: %@", [NSThread currentThread]);
    });
    NSLog(@"===========dispatch_barrier_async end=============");
}

@end
