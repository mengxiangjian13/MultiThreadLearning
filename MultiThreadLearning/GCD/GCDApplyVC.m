//
//  GCDApplyVC.m
//  MultiThreadLearning
//
//  Created by mengxiangjian on 2020/3/26.
//  Copyright © 2020 mengxiangjian. All rights reserved.
//

#import "GCDApplyVC.h"
#import "UIViewController+Button.h"

@interface GCDApplyVC ()

@end

@implementation GCDApplyVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"Dispatch Apply";
    
    UIButton *syncButton = [self buttonWithFrame:CGRectMake(0, 0, 100, 50)
                                           title:@"串行队列"
                                          action:@selector(syncDispatchApply)];
    syncButton.center = CGPointMake(CGRectGetMidX(self.view.bounds), 200);
    [self.view addSubview:syncButton];
    
    UIButton *asyncButton = [self buttonWithFrame:CGRectMake(0, 0, 100, 50)
                                           title:@"并发队列"
                                          action:@selector(asyncDispatchApply)];
    asyncButton.center = CGPointMake(CGRectGetMidX(self.view.bounds), 400);
    [self.view addSubview:asyncButton];
}

- (void)dispatchApplyWithQueue:(dispatch_queue_t)queue {
    NSLog(@"=========Dispatch Apply Begin============");
    dispatch_apply(10, queue, ^(size_t i) {
        NSLog(@"======block number %ld, current thread: %@", (long)i, [NSThread currentThread]);
        [NSThread sleepForTimeInterval:1];
    });
    NSLog(@"=========Dispatch Apply End============");
}

- (void)syncDispatchApply {
    // 使用main queue会死锁
    dispatch_queue_t queue = dispatch_queue_create("com.mengxiangjian.gcd", DISPATCH_QUEUE_SERIAL);
    [self dispatchApplyWithQueue:queue];
}

- (void)asyncDispatchApply {
    [self dispatchApplyWithQueue:dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)];
}

@end
