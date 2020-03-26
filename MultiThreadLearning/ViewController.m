//
//  ViewController.m
//  MultiThreadLearning
//
//  Created by mengxiangjian on 2020/3/26.
//  Copyright © 2020 mengxiangjian. All rights reserved.
//

#import "ViewController.h"
#import "GCDBaseVC.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"MultiThread";
    
//    [self.tableView registerClass:[UITableViewCell class]
//           forCellReuseIdentifier:@"cell"];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"
                                                            forIndexPath:indexPath];
    switch (indexPath.row) {
        case 0:
        {
            cell.textLabel.text = @"GCD";
        }
            break;
        case 1:
        {
            cell.textLabel.text = @"NSOperationQueue";
        }
            break;
        default:
            cell.textLabel.text = @"";
            break;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        GCDBaseVC *vc = [[GCDBaseVC alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

@end
