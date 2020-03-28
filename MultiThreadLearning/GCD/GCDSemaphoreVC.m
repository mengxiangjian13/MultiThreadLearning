//
//  GCDSemaphoreVC.m
//  MultiThreadLearning
//
//  Created by mengxiangjian on 2020/3/28.
//  Copyright © 2020 mengxiangjian. All rights reserved.
//

#import "GCDSemaphoreVC.h"
#import "UIViewController+Button.h"

@interface GCDSemaphoreVC ()

@property (nonatomic, assign) NSInteger someNumer;

@end

@implementation GCDSemaphoreVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"Semaphore";
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *syncDataButton = [self buttonWithFrame:CGRectMake(0, 0, 100, 50)
                                               title:@"线程同步"
                                              action:@selector(syncData:)];
    syncDataButton.center = CGPointMake(CGRectGetMidX(self.view.bounds), 200);
    [self.view addSubview:syncDataButton];
    
    UIButton *syncLockButton = [self buttonWithFrame:CGRectMake(0, 0, 100, 50)
                                               title:@"同步锁"
                                              action:@selector(syncLock:)];
    syncLockButton.center = CGPointMake(CGRectGetMidX(self.view.bounds), 300);
    [self.view addSubview:syncLockButton];
}

- (void)syncData:(id)sender {
    /**
     信号量用法1，可以用来做线程同步。一个线程需要一个得到某个数据，但这个数据需要去异步获得
     所以同步等待回调。
     */
    
    NSLog(@"============semaphore begin============");
    __block int i = 0;
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [NSThread sleepForTimeInterval:2];
        i = 100;
        dispatch_semaphore_signal(semaphore);
    });
    
    dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
    NSLog(@"get the i value: %ld", (long)i);
    NSLog(@"============semaphore end============");
}

- (void)syncLock:(id)sender {
    /**
     信号量第2个用法：做线程锁。
     下面的例子是，两个线程同时去调用一个方法，减小某个数字，直至数字到0。
     */
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(1);
    self.someNumer = 50;
    dispatch_queue_t queue1 = dispatch_queue_create("com.mengxiangjian.semaphore1", DISPATCH_QUEUE_SERIAL);
    dispatch_queue_t queue2 = dispatch_queue_create("com.mengxiangjian.semaphore2", DISPATCH_QUEUE_SERIAL);
    
    __weak typeof(self) weakSelf = self;
    dispatch_async(queue1, ^{
        [weakSelf minus:semaphore];
    });
    
    dispatch_async(queue2, ^{
        [weakSelf minus:semaphore];
    });
}

- (void)minus:(dispatch_semaphore_t)semaphore {
    while (1) {
        // 相当于加上锁
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
        if (self.someNumer > 0) {
            [NSThread sleepForTimeInterval:0.2];
            NSLog(@"--------some number: %ld, thread:%@", self.someNumer, [NSThread currentThread]);
            self.someNumer --;
        } else {
            NSLog(@"--------some number is 0, break");
            dispatch_semaphore_signal(semaphore);
            break;
        }
        dispatch_semaphore_signal(semaphore);
    }
}

@end
