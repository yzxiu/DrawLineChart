//
//  ViewController.m
//  DrawLineChart
//
//  Created by yuyu on 16/4/20.
//  Copyright © 2016年 yuyu. All rights reserved.
//

#import "ViewController.h"
#import "LineChartView.h"
#import "PointModel.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    /**
     *  定义点数组. 注:这里不能使用oc数组(nsarray),只能使用c的结构体数组
     *  这里的坐标采用表格里的自定义坐标系
     *  X坐标, 为整数1,2,3,4,5 分别代表2月 ~ 6月
     *  Y坐标, 范围:0~25
     *  @param pointDiameter  点的直径
     */
    
    CGPoint greenPoint[] =
    {
        CGPointMake(1, 3),
        CGPointMake(2, 10),
        CGPointMake(3, 8),
        CGPointMake(4, 7),
        CGPointMake(5, 13),
    };
    
    CGPoint redPoint[] =
    {
        CGPointMake(1, 8),
        CGPointMake(2, 3),
        CGPointMake(3, 5),
        CGPointMake(4, 17),
        CGPointMake(5, 16),
    };
    
    //构建oc点数组
    NSInteger greenCount = sizeof(greenPoint)/sizeof(greenPoint[0]);
    NSArray *greenPoints = [self transformPointArray:greenPoint count:greenCount];
    NSInteger redCount = sizeof(redPoint)/sizeof(redPoint[0]);
    NSArray *redPoints = [self transformPointArray:redPoint count:redCount];
    
    
    
    LineChartView *view = [[LineChartView alloc] initWithFrame:self.view.bounds];
    view.backgroundColor = [UIColor whiteColor];
    view.greenPoints = greenPoints;
    view.redPoints = redPoints;
    view.verticalH = 30.0;
    [self.view addSubview:view];
    [view setNeedsDisplay];
}

-(NSArray *)transformPointArray:(CGPoint *)points count:(NSInteger)count{
    
    NSMutableArray *pointArray = [NSMutableArray array];
    for (NSInteger i = 0; i<count; i++) {
        PointModel *pointmodel = [[PointModel alloc] init];
        pointmodel.x = points[i].x;
        pointmodel.y = points[i].y;
        [pointArray addObject:pointmodel];
    }
    return pointArray;
}




@end
