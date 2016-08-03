//
//  ViewController.m
//  DemoRAC
//
//  Created by 韩元旭 on 16/7/22.
//  Copyright © 2016年 韩元旭. All rights reserved.
//

#import "ViewController.h"
#import "ViewModel.h"

@interface ViewController ()

@property (nonatomic, weak) IBOutlet UIButton *loginButton;
@property (nonatomic, weak) IBOutlet UITextField *userNameTextField;
@property (nonatomic, weak) IBOutlet UITextField *passwordTextField;
@property (nonatomic, strong) ViewModel *vm;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self bindViewModel];
    
    [self btnClick];
}

/**
 *  关联ViewModel
 */
- (void)bindViewModel {
    _vm = [[ViewModel alloc] init];
    
    [self.userNameTextField.rac_textSignal subscribeNext:^(id x) {
        NSLog(@"用户名文本框内容改变---:%@", x);
    }];
    
    RAC(self.vm, userName) = self.userNameTextField.rac_textSignal;
    RAC(self.vm, password) = self.passwordTextField.rac_textSignal;
    RAC(self.loginButton, enabled) = [self.vm buttonIsValid];
    
//    [self.userNameTextField.rac_textSignal subscribeNext:^(id x) {
//        self.vm.userName = x;
//    }];
//    [self.passwordTextField.rac_textSignal subscribeNext:^(id x) {
//        self.vm.password = x;
//    }];
//    [[self.vm buttonIsValid] subscribeNext:^(id x) {
//        self.loginButton.enabled = [x boolValue];
//    }];

    
    [self.vm.successObject subscribeNext:^(NSArray * x) {
        NSLog(@"successObject--:%@", x);
    }];
    
    [self.vm.failureObject subscribeNext:^(id x) {
        NSLog(@"failureObject--:%@", x);
    }];
    
    [self.vm.errorObject subscribeNext:^(id x) {
        NSLog(@"errorObject--:%@", x);
    }];
}

/**
 *  按钮点击
 */
- (void)btnClick {
    [[self.loginButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        self.loginButton.enabled = NO;
        [self.vm doLogin];
    }];
}

@end
