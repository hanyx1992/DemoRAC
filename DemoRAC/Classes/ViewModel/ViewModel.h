//
//  ViewModel.h
//  DemoRAC
//
//  Created by 韩元旭 on 16/7/25.
//  Copyright © 2016年 韩元旭. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ViewModel : NSObject

@property (nonatomic, strong) NSString *userName;
@property (nonatomic, strong) NSString *password;
@property (nonatomic, strong) RACSubject *successObject;
@property (nonatomic, strong) RACSubject *failureObject;
@property (nonatomic, strong) RACSubject *errorObject;

- (RACSignal *)buttonIsValid;
- (void)doLogin;

@end
