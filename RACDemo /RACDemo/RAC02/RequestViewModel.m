//
//  RequestViewModel.m
//  RACDemo
//
//  Created by ZCD on 2017/7/19.
//  Copyright © 2017年 ZCD. All rights reserved.
//

#import "RequestViewModel.h"
#import "AFHTTPSessionManager.h"
@implementation RequestViewModel
-(instancetype)init
{
    if (self = [super init]) {
        
        [self initialBind2];
    }
    return self;
}
//方法二：
-(void)initialBind2{
    _reuqesCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal *(id input) {
        RACSignal *requestSignal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
            parameters[@"q"] = @"基础";
            [[AFHTTPSessionManager manager]GET:@"https://api.douban.com/v2/book/search" parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
                
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                
                //                NSLog(@"%@",responseObject);
                //将信号传递出去
                [subscriber sendNext:responseObject];
                [subscriber sendCompleted];
                
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                [subscriber sendError:error];
            }];
            return nil;
            
        }];
        return requestSignal;
//        // 在返回数据信号时，把数据中的字典映射成模型信号，传递出去
//        return [requestSignal map:^id(NSDictionary *value) {
//            NSMutableArray *dictArr = value[@"books"];
//            
//            // 字典转模型，遍历字典中的所有元素，全部映射成模型，并且生成数组
//            NSArray *modelArr = [[dictArr.rac_sequence map:^id(id value) {
//                NSLog(@"%@",value);
//                return nil;
//            }] array];
//            return modelArr;
//        }];
    }];
    
}
//方法一：
-(RACSignal *)initialBind1{
    //    _reuqesCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal *(id input) {
    RACSignal *requestSignal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
        parameters[@"q"] = @"基础";
        [[AFHTTPSessionManager manager]GET:@"https://api.douban.com/v2/book/search" parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            //                NSLog(@"%@",responseObject);
            //将信号传递出去
            [subscriber sendNext:responseObject];
            [subscriber sendCompleted];
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            [subscriber sendError:error];
        }];
        return nil;
        
    }];
    
    //        // 在返回数据信号时，把数据中的字典映射成模型信号，传递出去
    //        return [requestSignal map:^id(NSDictionary *value) {
    //            NSMutableArray *dictArr = value[@"books"];
    //
    //            // 字典转模型，遍历字典中的所有元素，全部映射成模型，并且生成数组
    //            NSArray *modelArr = [[dictArr.rac_sequence map:^id(id value) {
    //                NSLog(@"%@",value);
    //                return nil;
    //            }] array];
    //
    return requestSignal;
    //        }];
    //    }];
    
}
@end
