//
//  LineChartView.h
//  DrawLineChart
//
//  Created by yuyu on 16/4/20.
//  Copyright © 2016年 yuyu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LineChartView : UIView

@property(nonatomic,strong)NSArray *greenPoints; //绿点坐标数组
@property(nonatomic,strong)NSArray *redPoints;

@property(nonatomic,assign)CGFloat verticalH; //纵向单元格高度(像素单位)

@end
