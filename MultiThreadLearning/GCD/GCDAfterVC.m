//
//  GCDAfterVC.m
//  MultiThreadLearning
//
//  Created by mengxiangjian on 2020/3/26.
//  Copyright © 2020 mengxiangjian. All rights reserved.
//

#import "GCDAfterVC.h"

@interface GCDAfterVC ()

@property (nonatomic, strong) UITextField *textField;
@property (nonatomic, strong) UIButton *button;

@end

@implementation GCDAfterVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"Dispatch After";
    [self.view addSubview:self.textField];
    [self.view addSubview:self.button];
}

- (UITextField *)textField {
    if (!_textField) {
        _textField = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, 300, 30)];
        _textField.center = CGPointMake(CGRectGetMidX(self.view.bounds), 200);
        _textField.borderStyle = UITextBorderStyleRoundedRect;
        _textField.keyboardType = UIKeyboardTypeNumberPad;
        _textField.placeholder = @"the seconds that showing alert after now";
    }
    return _textField;
}

- (UIButton *)button {
    if (!_button) {
        _button = [UIButton buttonWithType:UIButtonTypeSystem];
        _button.frame = CGRectMake(0, 0, 100, 50);
        _button.center = CGPointMake(CGRectGetMidX(self.view.bounds), CGRectGetMaxY(self.textField.frame) + 50);
        [_button setTitle:@"FIRE!" forState:UIControlStateNormal];
        [_button addTarget:self
                    action:@selector(click:)
          forControlEvents:UIControlEventTouchUpInside];
    }
    return _button;
}

- (void)click:(id)sender {
    if (self.textField.text.length <= 0) {
        return;
    }
    self.button.enabled = NO;
    NSInteger s = [self.textField.text integerValue];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(s * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSString *msg = [NSString stringWithFormat:@"Trigger this alert after %ld second(s) when clicking the button", (long)s];
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Delay Action"
                                                                       message:msg
                                                                preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定"
                                                         style:UIAlertActionStyleDefault
                                                       handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        [alert addAction:action];
        [self presentViewController:alert
                           animated:YES
                         completion:^{
            self.button.enabled = YES;
        }];
    });
}

@end
