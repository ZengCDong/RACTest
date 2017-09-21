//
//  RequestViewModel.h
//  RACDemo
//
//  Created by ZCD on 2017/7/19.
//  Copyright © 2017年 ZCD. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ReactiveCocoa.h"
@interface RequestViewModel : NSObject
// 请求命令
@property (nonatomic, strong, readonly) RACCommand *reuqesCommand;

//模型数组
@property (nonatomic, strong, readonly) NSArray *models;

// 控制器中的view
@property (nonatomic, weak) UITableView *tableView;
-(RACSignal *)initialBind1;
@end
