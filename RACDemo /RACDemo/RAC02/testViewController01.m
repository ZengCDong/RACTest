//
//  testViewController01.m
//  RACDemo
//
//  Created by ZCD on 2017/7/19.
//  Copyright © 2017年 ZCD. All rights reserved.
//

#import "testViewController01.h"
#import "RACableViewCell.h"
#import "RequestViewModel.h"
@interface testViewController01 ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *tableView;
@property (nonatomic, strong) RequestViewModel *requesViewModel;
@end

@implementation testViewController01
-(UITableView *)tableView{
    if (!_tableView) {
        self.tableView = [[UITableView alloc]initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStylePlain];
        [self.view addSubview:self.tableView];
    }
    return _tableView;
}
//懒加载
-(RequestViewModel *)requesViewModel
{
    if (_requesViewModel == nil) {
        _requesViewModel = [[RequestViewModel alloc] init];
    }
    return _requesViewModel;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerNib:[UINib nibWithNibName:@"RACableViewCell" bundle:nil] forCellReuseIdentifier:@"RACableViewCell"];

//    [[self.requesViewModel initialBind1]subscribeNext:^(NSDictionary *x) {
//        NSLog(@"%@",x);
//    }];
    [self.requesViewModel.reuqesCommand.executionSignals.switchToLatest subscribeNext:^(NSDictionary *dict) {
        
        NSLog(@"%@",dict);
    }];
    // 4.监听命令是否执行完毕,默认会来一次，可以直接跳过，skip表示跳过第一次信号。
    [[self.requesViewModel.reuqesCommand.executing skip:1] subscribeNext:^(id x) {
        
        if ([x boolValue] == YES) {
            // 正在执行
            NSLog(@"正在执行");
            
        }else{
            // 执行完成
            NSLog(@"执行完成");
        }
        
    }];
    // 5.执行命令
    [self.requesViewModel.reuqesCommand execute:@1];

}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    RACableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RACableViewCell" forIndexPath:indexPath];
    return cell;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
