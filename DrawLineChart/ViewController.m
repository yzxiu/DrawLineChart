//
//  ViewController.m
//  DrawLineChart
//
//  Created by yuyu on 16/4/20.
//  Copyright © 2016年 yuyu. All rights reserved.
//

#import "ViewController.h"
#import "LineChartView.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    LineChartView *view = [[LineChartView alloc] initWithFrame:self.view.bounds];
    view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:view];
}



@end
