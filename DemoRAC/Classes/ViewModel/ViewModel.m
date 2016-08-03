//
//  ViewModel.m
//  DemoRAC
//
//  Created by 韩元旭 on 16/7/25.
//  Copyright © 2016年 韩元旭. All rights reserved.
//

#import "ViewModel.h"

@interface ViewModel ()

@property (nonatomic, strong) RACSignal *userNameSignal;
@property (nonatomic, strong) RACSignal *passwordSignal;

@end


@implementation ViewModel

/**
 *  初始化
 */
- (instancetype)init {
    self = [super init];
    if (self) {
        _userNameSignal = RACObserve(self, userName);
        _passwordSignal = RACObserve(self, password);
        _successObject = [RACSubject subject];
        _failureObject = [RACSubject subject];
        _errorObject = [RACSubject subject];
    }
    return self;
}


- (RACSignal *)buttonIsValid {
    
    RACSignal *isValid = [RACSignal
                          combineLatest:@[self.userNameSignal, self.passwordSignal]
                                 reduce:^id(NSString *userName, NSString *password) {
                                     NSLog(@"reduce--");
                                     return @(userName.length >= 6 && password.length >= 6);
                                 }];
    
    return isValid;
}

- (void)doLogin {
    //网络请求
    [self.successObject sendNext:@[self.userName, self.password]];
}

@end
