//
//  RACViewController.m
//  RACDemo
//
//  Created by ZCD on 2017/7/17.
//  Copyright © 2017年 ZCD. All rights reserved.
//

#import "RACViewController.h"
#import "testViewModel.h"
#import "testViewController01.h"
@interface RACViewController ()
@property(nonatomic,strong)testViewModel *testVM;
@end

@implementation RACViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    self.view.backgroundColor = [UIColor redColor];
//    [self bindModel];
    [self SchedulerSigner];
}

//关于RAC线程
-(void)schedulerInfo{
    //主线程
    RACScheduler *mainScheduler = [RACScheduler mainThreadScheduler];
    
    //子线程的两个Scheduler  注意[RACScheduler scheduler]是返回一个新的
    RACScheduler *scheduler1 = [RACScheduler  scheduler];
    RACScheduler *scheduler2 = [RACScheduler scheduler];
    
    //返回当前的Scheduler，自定义的线程会返回nil
    
    RACScheduler *currScheduler = [RACScheduler currentScheduler];
    
    // 创建某优先级的Scheduler，不建议除非你知道你在干什么
    RACScheduler *scheduler3 = [RACScheduler schedulerWithPriority:DISPATCH_QUEUE_PRIORITY_HIGH];
    RACScheduler *scheduler4 = [RACScheduler schedulerWithPriority:DISPATCH_QUEUE_PRIORITY_HIGH name:@"name"];
    
    //马上创建Scheduler，不建议除非你知道你在干什么
    RACScheduler *scheduler6 = [RACScheduler immediateScheduler];

    
}
//异步订阅
-(void)SchedulerSigner{
    RACSignal *singer = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        NSLog(@"******%@",[NSThread currentThread]);
        [subscriber sendNext:@"2"];
        [subscriber sendNext:@"5"];
        [subscriber sendCompleted];
        return nil;
    }];
    [[RACScheduler scheduler]schedule:^{
        NSLog(@"创建一个子线程");
        [singer subscribeNext:^(id x) {
            NSLog(@"%@,值：%@",[NSThread currentThread],x);
        }];
    }];
}

/**1
 * @berif :关联相应的viewModel
 **/
-(void)bindModel{
    _testVM = [[testViewModel alloc]init];
    RAC(self.testVM, userName) = self.userName.rac_textSignal;
    RAC(self.testVM,password)  = self.passWord.rac_textSignal;
    RAC(_loginBtn ,enabled) = [_testVM buttonIsVaild];
    @weakify(self);
    //登录成功处理方法
    [self.testVM.sucessObject subscribeNext:^(id x) {
        @strongify(self);
        NSLog(@"%@",x);
        testViewController01 *testCtr = [[testViewController01 alloc]init];
        [self.navigationController pushViewController:testCtr animated:YES ];
    }];
}
- (IBAction)loginAction:(id)sender {
    [[self.loginBtn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
        NSLog(@"按钮点击事件-------%@",x);
    }];
    [_testVM login];
    
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
