//
//  GCDBaseVC.m
//  MultiThreadLearning
//
//  Created by mengxiangjian on 2020/3/26.
//  Copyright © 2020 mengxiangjian. All rights reserved.
//

#import "GCDBaseVC.h"
#import "GCDOnceVC.h"
#import "GCDAfterVC.h"
#import "GCDApplyVC.h"
#import "GCDGroupVC.h"
#import "GCDBarrierVC.h"

@interface GCDBaseVC ()

@property (nonatomic, strong) NSArray *titleArray;

@end

@implementation GCDBaseVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"GCD";
    
    self.titleArray = @[@"sync/async", @"dispatch_barrier_async", @"dispatch_after",
                        @"dispatch_group_async", @"dispatch_apply", @"dispatch_once",
                        @"dispatch_semaphore"];
    
    [self.tableView registerClass:[UITableViewCell class]
           forCellReuseIdentifier:@"cell"];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.titleArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"
                                                            forIndexPath:indexPath];
    cell.textLabel.text = self.titleArray[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 5) {
        GCDOnceVC *vc = [[GCDOnceVC alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    } else if (indexPath.row == 2) {
        GCDAfterVC *vc = [[GCDAfterVC alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    } else if (indexPath.row == 4) {
        GCDApplyVC *vc = [[GCDApplyVC alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    } else if (indexPath.row == 3) {
        GCDGroupVC *vc = [[GCDGroupVC alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    } else if (indexPath.row == 1) {
        GCDBarrierVC *vc = [[GCDBarrierVC alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

@end
