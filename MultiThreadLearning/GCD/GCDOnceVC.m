//
//  GCDOnceVC.m
//  MultiThreadLearning
//
//  Created by mengxiangjian on 2020/3/26.
//  Copyright © 2020 mengxiangjian. All rights reserved.
//

#import "GCDOnceVC.h"

static NSInteger someNum = 0;

@interface GCDOnceVC ()

@end

@implementation GCDOnceVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"Dispatch Once";
    
    NSLog(@"======= GCDOnceVC Begin =======");
    NSLog(@"the some number is: %ld at the start!", (long)someNum);
    
    for (int i = 0; i < 10; i ++) {
        [self plusplus];
        NSLog(@"the some number is: %ld at %ld time(s)!", (long)someNum, (long)i+1);
    }
    
    NSLog(@"======= GCDOnceVC End =======");
}

- (void)plusplus {
    static dispatch_once_t token;
    dispatch_once(&token, ^{
        someNum ++;
    });
}

@end
