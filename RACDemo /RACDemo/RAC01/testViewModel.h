//
//  testViewModel.h
//  RACDemo
//
//  Created by ZCD on 2017/7/18.
//  Copyright © 2017年 ZCD. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ReactiveCocoa.h"
@interface testViewModel : NSObject
@property (nonatomic ,  copy) NSString   *userName;
@property (nonatomic ,  copy) NSString   *password;
@property (nonatomic ,strong) RACSubject *sucessObject;
@property (nonatomic ,strong) RACSubject *failureObject;
@property (nonatomic ,strong) RACSubject *errorObject;
-(id)buttonIsVaild;
-(void)login; 
@end
