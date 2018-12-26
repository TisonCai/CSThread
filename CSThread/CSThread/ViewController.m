//
//  ViewController.m
//  CSThread
//
//  Created by ccs on 2018/12/26.
//  Copyright © 2018年 ccs. All rights reserved.
//

#import "ViewController.h"
#import "CSThread.h"

@interface ViewController ()
@property (nonatomic, strong) CSThread *thread;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIStackView *stack = [[UIStackView alloc] initWithFrame:CGRectMake(0, 100, self.view.bounds.size.width, 44)];
    
    for (NSString *title in @[@"start",@"perform",@"stop"]) {
        UIButton *btn = [self renderButton:title];
        [stack addArrangedSubview:btn];
    }
    stack.alignment = UIStackViewAlignmentFill;
    stack.axis = UILayoutConstraintAxisHorizontal;
    stack.distribution = UIStackViewDistributionFillEqually;
    
    
    [self.view addSubview:stack];

}
- (UIButton *)renderButton:(NSString *)title {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(didClickBtn:) forControlEvents:UIControlEventTouchUpInside];
    return btn;
}
- (void)didClickBtn:(UIButton *)btn {
    NSString *title = [btn currentTitle];
    if ([title isEqualToString:@"start"]) {
        [self.thread start];
    } else if ([title isEqualToString:@"perform"]) {
        [self.thread asyncPerformBlock:^{
            NSThread *thread = [NSThread currentThread];
            NSLog(@"thread:%@\nthreadName:%@",thread,thread.name);
        }];
    } else if ([title isEqualToString:@"stop"]) {
        [self.thread stop];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - getter
- (CSThread *)thread {
    if (_thread == nil) {
        _thread = [[CSThread alloc] initWithName:@"httpThread"];
    }
    return _thread;
}

@end
