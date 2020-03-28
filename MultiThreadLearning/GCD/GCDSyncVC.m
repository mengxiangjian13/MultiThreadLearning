//
//  GCDSyncVC.m
//  MultiThreadLearning
//
//  Created by mengxiangjian on 2020/3/28.
//  Copyright © 2020 mengxiangjian. All rights reserved.
//

#import "GCDSyncVC.h"

@interface GCDSyncVC ()

@end

@implementation GCDSyncVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"Sync/Async";
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *syncSerialButton = [self buttonWithFrame:CGRectMake(20, 200, 100, 50)
                                                 title:@"sync/serial"
                                                action:@selector(syncSerial:)];
    [self.view addSubview:syncSerialButton];
    
    UIButton *syncConcurrentButton = [self buttonWithFrame:CGRectMake(140, 200, 150, 50)
                                                 title:@"sync/concurrent"
                                                action:@selector(synConcurrent:)];
    [self.view addSubview:syncConcurrentButton];
    
    UIButton *asyncSerialButton = [self buttonWithFrame:CGRectMake(20, 300, 100, 50)
                                                 title:@"async/serial"
                                                action:@selector(asyncSerial:)];
    [self.view addSubview:asyncSerialButton];
    
    UIButton *asyncConcurrentButton = [self buttonWithFrame:CGRectMake(140, 300, 150, 50)
                                                      title:@"async/concurrent"
                                                     action:@selector(asyncConcurrent:)];
    [self.view addSubview:asyncConcurrentButton];
    
    UIButton *syncMainButton = [self buttonWithFrame:CGRectMake(20, 400, 100, 50)
                                                 title:@"sync/main"
                                                action:@selector(syncMain:)];
    [self.view addSubview:syncMainButton];
    
    UIButton *asyncMainButton = [self buttonWithFrame:CGRectMake(140, 400, 100, 50)
                                                 title:@"async/main"
                                                action:@selector(asyncMain:)];
    [self.view addSubview:asyncMainButton];
    
}

- (UIButton *)buttonWithFrame:(CGRect)frame
                        title:(NSString *)title
                       action:(SEL)action {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    button.frame = frame;
    [button setTitle:title forState:UIControlStateNormal];
    [button addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    return button;
}

#pragma mark -

- (void)syncSerial:(id)sender {
    /**
     因为是sync同步，所以不具备创建新线程的条件。因为在主线程触发，又是串行队列，所以block在主线程
     按顺序依次执行。
     */
    NSLog(@"===========sync serial begin==============");
    dispatch_queue_t queue = dispatch_queue_create("com.mengxiangjian.syncserial", DISPATCH_QUEUE_SERIAL);
    dispatch_sync(queue, ^{
        [NSThread sleepForTimeInterval:2.f];
        NSLog(@"1------block, thread: %@", [NSThread currentThread]);
    });
    dispatch_sync(queue, ^{
        [NSThread sleepForTimeInterval:2.f];
        NSLog(@"2------block, thread: %@", [NSThread currentThread]);
    });
    dispatch_sync(queue, ^{
        [NSThread sleepForTimeInterval:2.f];
        NSLog(@"3------block, thread: %@", [NSThread currentThread]);
    });
    dispatch_sync(queue, ^{
        [NSThread sleepForTimeInterval:2.f];
        NSLog(@"4------block, thread: %@", [NSThread currentThread]);
    });
    dispatch_sync(queue, ^{
        [NSThread sleepForTimeInterval:2.f];
        NSLog(@"5------block, thread: %@", [NSThread currentThread]);
    });
    NSLog(@"===========sync serial end==============");
}

- (void)synConcurrent:(id)sender {
    /**
     因为是sync同步，所以不具备创建新线程的条件，所以block肯定是在主线程执行。
     因为sync会阻塞线程，所以block就不能同时加入到队列，只能一个block完成才能再加入一个block，
     所以并发队列就失去了意义，表现上看和串行队列一样。
     */
    NSLog(@"===========sync concurrent begin==============");
    dispatch_queue_t queue = dispatch_queue_create("com.mengxiangjian.synconcurrent", DISPATCH_QUEUE_CONCURRENT);
    dispatch_sync(queue, ^{
        [NSThread sleepForTimeInterval:2.f];
        NSLog(@"1------block, thread: %@", [NSThread currentThread]);
    });
    dispatch_sync(queue, ^{
        [NSThread sleepForTimeInterval:2.f];
        NSLog(@"2------block, thread: %@", [NSThread currentThread]);
    });
    dispatch_sync(queue, ^{
        [NSThread sleepForTimeInterval:2.f];
        NSLog(@"3------block, thread: %@", [NSThread currentThread]);
    });
    dispatch_sync(queue, ^{
        [NSThread sleepForTimeInterval:2.f];
        NSLog(@"4------block, thread: %@", [NSThread currentThread]);
    });
    dispatch_sync(queue, ^{
        [NSThread sleepForTimeInterval:2.f];
        NSLog(@"5------block, thread: %@", [NSThread currentThread]);
    });
    NSLog(@"===========sync concurrent end==============");
}

- (void)asyncSerial:(id)sender {
    /**
     因为是async异步，所以具备创建新线程的条件。因为异步，所以block几乎被同时加入到队列。
     队列是串行的，所以需要一个一个顺序执行，在非主线程上。
     */
    NSLog(@"===========async serial begin==============");
    dispatch_queue_t queue = dispatch_queue_create("com.mengxiangjian.syncserial", DISPATCH_QUEUE_SERIAL);
    dispatch_async(queue, ^{
        [NSThread sleepForTimeInterval:2.f];
        NSLog(@"1------block, thread: %@", [NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        [NSThread sleepForTimeInterval:2.f];
        NSLog(@"2------block, thread: %@", [NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        [NSThread sleepForTimeInterval:2.f];
        NSLog(@"3------block, thread: %@", [NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        [NSThread sleepForTimeInterval:2.f];
        NSLog(@"4------block, thread: %@", [NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        [NSThread sleepForTimeInterval:2.f];
        NSLog(@"5------block, thread: %@", [NSThread currentThread]);
    });
    NSLog(@"===========async serial end==============");
}

- (void)asyncConcurrent:(id)sender {
    /**
     异步具备开启新线程的能力，将任务一并放入队列。队列为并发队列，所以可以并发执行多个任务。
     */
    NSLog(@"===========async concurrent begin==============");
    dispatch_queue_t queue = dispatch_queue_create("com.mengxiangjian.synconcurrent", DISPATCH_QUEUE_CONCURRENT);
    dispatch_async(queue, ^{
        [NSThread sleepForTimeInterval:2.f];
        NSLog(@"1------block, thread: %@", [NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        [NSThread sleepForTimeInterval:2.f];
        NSLog(@"2------block, thread: %@", [NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        [NSThread sleepForTimeInterval:2.f];
        NSLog(@"3------block, thread: %@", [NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        [NSThread sleepForTimeInterval:2.f];
        NSLog(@"4------block, thread: %@", [NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        [NSThread sleepForTimeInterval:2.f];
        NSLog(@"5------block, thread: %@", [NSThread currentThread]);
    });
    NSLog(@"===========async concurrent end==============");
}

- (void)syncMain:(id)sender {
    /**
     MainQueue是特殊的队列，就是因为，所有在主线程执行的代码，都被默认加入到了MainQueue，
     所以就容易出现死锁问题。由于sync又是同步，所以在主线程同步到MainQueue，会造成死锁。
     */
    NSLog(@"===========sync main begin==============");
    dispatch_queue_t queue = dispatch_get_main_queue();
    dispatch_sync(queue, ^{
        [NSThread sleepForTimeInterval:2.f];
        NSLog(@"1------block, thread: %@", [NSThread currentThread]);
    });
    NSLog(@"===========sync main end==============");
}

- (void)asyncMain:(id)sender {
    /**
     MainQueue有个特点，就是MainQueue的block一定在主线程执行。所以异步到主线程，不管原来是哪个线程，
     都要换到主线程上来执行block。因为MainQueue是串行队列，所以block按顺序依次执行。
     */
    NSLog(@"===========async main begin==============");
    dispatch_queue_t queue = dispatch_get_main_queue();
    dispatch_async(queue, ^{
        [NSThread sleepForTimeInterval:2.f];
        NSLog(@"1------block, thread: %@", [NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        [NSThread sleepForTimeInterval:2.f];
        NSLog(@"2------block, thread: %@", [NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        [NSThread sleepForTimeInterval:2.f];
        NSLog(@"3------block, thread: %@", [NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        [NSThread sleepForTimeInterval:2.f];
        NSLog(@"4------block, thread: %@", [NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        [NSThread sleepForTimeInterval:2.f];
        NSLog(@"5------block, thread: %@", [NSThread currentThread]);
    });
    NSLog(@"===========async main end==============");
}

@end
