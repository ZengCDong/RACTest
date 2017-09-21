//
//  testViewModel.m
//  RACDemo
//
//  Created by ZCD on 2017/7/18.
//  Copyright © 2017年 ZCD. All rights reserved.
//

#import "testViewModel.h"

@interface testViewModel ()
@property (nonatomic,strong)RACSubject *userNameSignal;
@property (nonatomic,strong)RACSubject *passWordSignal;
@property (nonatomic,strong)NSArray *dataArr;
@end


@implementation testViewModel
-(instancetype)init{
    self = [super init];
    if (self) {
        [self initialize];
    }
    return self;
}
-(void)initialize{
    _userNameSignal = RACObserve(self, userName);
    _passWordSignal = RACObserve(self, password);
    _sucessObject = [RACSubject subject];
    _failureObject = [RACSubject subject];
    _errorObject = [RACSubject subject];
}

-(id)buttonIsVaild{
    RACSignal *isVaild = [RACSignal combineLatest:@[_userNameSignal,_passWordSignal] reduce:^id{
        return @(_userName.length >= 3 && _password.length >=3);
    }];
    return isVaild;
}
//模拟网络发送请求，并发出网络请求成功的信号
-(void)login{
    //网络请求进行登录
    _dataArr = @[_userName,_password];
    //成功发送成功的信号
    [_sucessObject sendNext:_dataArr];
    //业务逻辑失败和网络请求失败，则发送fail或者error信号并传参
}





@end
