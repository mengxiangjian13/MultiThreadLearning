//
//  GCDGroupVC.m
//  MultiThreadLearning
//
//  Created by mengxiangjian on 2020/3/27.
//  Copyright © 2020 mengxiangjian. All rights reserved.
//

#import "GCDGroupVC.h"
#import "UIViewController+Button.h"

@interface GCDGroupVC ()

@end

@implementation GCDGroupVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"CGD Group";
    self.view.backgroundColor = [UIColor whiteColor];
    UIButton *notifyButton = [self buttonWithFrame:CGRectMake(0, 0, 200, 50)
                                             title:@"dispatch_group_notify"
                                            action:@selector(notify:)];
    notifyButton.center = CGPointMake(CGRectGetMidX(self.view.bounds), 200);
    [self.view addSubview:notifyButton];
    
    UIButton *waitButton = [self buttonWithFrame:CGRectMake(0, 0, 200, 50)
                                           title:@"dispatch_group_wait"
                                          action:@selector(wait:)];
    waitButton.center = CGPointMake(CGRectGetMidX(self.view.bounds), 300);
    [self.view addSubview:waitButton];
}

- (void)notify:(id)sender {
    NSLog(@"========dispatch notify begin=============");
    dispatch_group_t group = dispatch_group_create();
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_group_async(group, queue, ^{
        NSLog(@"1------block, thread: %@", [NSThread currentThread]);
        [NSThread sleepForTimeInterval:2];
    });
    dispatch_group_async(group, queue, ^{
        NSLog(@"2------block, thread: %@", [NSThread currentThread]);
        [NSThread sleepForTimeInterval:2];
    });
    dispatch_group_async(group, queue, ^{
        NSLog(@"3------block, thread: %@", [NSThread currentThread]);
        [NSThread sleepForTimeInterval:2];
    });
    dispatch_group_async(group, queue, ^{
        NSLog(@"4------block, thread: %@", [NSThread currentThread]);
        [NSThread sleepForTimeInterval:2];
    });
    // 不卡当前线程，等待完成通知
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        NSLog(@"========dispatch group be notified in main queue=============");
    });
    NSLog(@"========dispatch notify end=============");
}

- (void)wait:(id)sender {
    NSLog(@"========dispatch wait begin=============");
    dispatch_group_t group = dispatch_group_create();
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_group_async(group, queue, ^{
        [NSThread sleepForTimeInterval:1];
        NSLog(@"1------block, thread: %@", [NSThread currentThread]);
    });
    dispatch_group_async(group, queue, ^{
        [NSThread sleepForTimeInterval:2];
        NSLog(@"2------block, thread: %@", [NSThread currentThread]);
        
    });
    dispatch_group_async(group, queue, ^{
        [NSThread sleepForTimeInterval:1];
        NSLog(@"3------block, thread: %@", [NSThread currentThread]);
    });
    dispatch_group_async(group, queue, ^{
        [NSThread sleepForTimeInterval:2];
        NSLog(@"4------block, thread: %@", [NSThread currentThread]);
    });
    
    // 卡住当前线程，等待
    dispatch_group_wait(group, DISPATCH_TIME_FOREVER);
//    // 等待1s就退出
//    dispatch_group_wait(group, dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)));
    NSLog(@"========dispatch wait end=============");
}

@end
