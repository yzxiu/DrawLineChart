//
//  LineChartView.m
//  DrawLineChart
//
//  Created by yuyu on 16/4/20.
//  Copyright © 2016年 yuyu. All rights reserved.
//

#import "LineChartView.h"

#define SCREENHEIGHT  [UIScreen mainScreen].bounds.size.height
#define SCREENWIDTH  [UIScreen mainScreen].bounds.size.width

@implementation LineChartView{
    CGFloat originX;
    CGFloat originY;
    //虚线纵向间隔
    CGFloat dashlineH;
    //虚线横向间隔
    CGFloat dashWidth;
}


- (void)drawRect:(CGRect)rect {
    // Drawing code
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetRGBStrokeColor(context, 0.3, 0.3, 0.3, 1.0);
    CGContextSetLineWidth(context, 0.5);
    
    //坐标系
    //左下角起点
    originX = 20.0;
    originY = SCREENHEIGHT-originX;
    //虚线纵向间隔
    dashlineH = 20.0;
    //虚线横向间隔
    dashWidth = (SCREENWIDTH-50.0-20)/4;
    
    [self drawBaseWithContext:context];
    [self drawDashLine:context];
    
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
        CGPointMake(2, 16),
        CGPointMake(3, 15),
        CGPointMake(4, 17),
        CGPointMake(5, 16),
    };
    
    //画红点
    for (NSInteger i = 0; i<5; i++) {
        [self drawPointWithContext:context color:[UIColor redColor] point:redPoint[i] pointDiameter:2.0];
    }
    
    //绿点连线
    [self connectLineWithContext:context points:greenPoint colorR:0.0 colorG:1.0 colorB:0.0];
    
    //红点连线
    [self connectLineWithContext:context points:redPoint colorR:1.0 colorG:0.0 colorB:0.0];
    
    
    
    //
    CGContextMoveToPoint(context, originX, SCREENHEIGHT-originX);
    CGContextAddLineToPoint(context, [self transformPoint:greenPoint[0]].x, [self transformPoint:greenPoint[0]].y);
    CGContextAddLineToPoint(context, [self transformPoint:greenPoint[1]].x, [self transformPoint:greenPoint[1]].y);
    CGContextAddLineToPoint(context, [self transformPoint:greenPoint[2]].x, [self transformPoint:greenPoint[2]].y);
    CGContextAddLineToPoint(context, [self transformPoint:greenPoint[3]].x, [self transformPoint:greenPoint[3]].y);
    CGContextAddLineToPoint(context, [self transformPoint:greenPoint[4]].x, [self transformPoint:greenPoint[4]].y);
    CGContextAddLineToPoint(context, [self transformPoint:greenPoint[4]].x, SCREENHEIGHT-originX);
    CGContextAddLineToPoint(context, originX, SCREENHEIGHT-originX);
    CGContextClosePath(context);
    [[UIColor colorWithRed:0.0 green:0.7 blue:0.0 alpha:0.15] set];
    //3.渲染
    CGContextDrawPath(context, kCGPathFillStroke);
    

    //起点
    CGContextMoveToPoint(context, [self transformPoint:redPoint[0]].x, [self transformPoint:redPoint[0]].y);
    
    CGContextAddLineToPoint(context, [self transformPoint:redPoint[1]].x, [self transformPoint:redPoint[1]].y);
    CGContextAddLineToPoint(context, [self transformPoint:redPoint[2]].x, [self transformPoint:redPoint[2]].y);
    CGContextAddLineToPoint(context, [self transformPoint:redPoint[3]].x, [self transformPoint:redPoint[3]].y);
    CGContextAddLineToPoint(context, [self transformPoint:redPoint[4]].x, [self transformPoint:redPoint[4]].y);
    
    CGContextAddLineToPoint(context, [self transformPoint:greenPoint[4]].x, [self transformPoint:greenPoint[4]].y);
    CGContextAddLineToPoint(context, [self transformPoint:greenPoint[3]].x, [self transformPoint:greenPoint[3]].y);
    CGContextAddLineToPoint(context, [self transformPoint:greenPoint[2]].x, [self transformPoint:greenPoint[2]].y);
    CGContextAddLineToPoint(context, [self transformPoint:greenPoint[1]].x, [self transformPoint:greenPoint[1]].y);
    CGContextAddLineToPoint(context, [self transformPoint:greenPoint[0]].x, [self transformPoint:greenPoint[0]].y);
    CGContextAddLineToPoint(context, [self transformPoint:redPoint[0]].x, [self transformPoint:redPoint[0]].y);
    //    CGContextAddLineToPoint(context, originX, SCREENHEIGHT-originX);
    CGContextClosePath(context);
    [[UIColor colorWithRed:0.7 green:0.0 blue:0.0 alpha:0.15] set];
    //3.渲染
    CGContextDrawPath(context, kCGPathFillStroke);
    
    //画绿点
    //绿点放到后面,避免被红色块遮挡
    for (NSInteger i = 0; i<5; i++) {
        [self drawPointWithContext:context color:[UIColor greenColor] point:greenPoint[i] pointDiameter:2.0];
    }
}

//画基本坐标
-(void)drawBaseWithContext:(CGContextRef)context{
    CGContextMoveToPoint(context, originX, SCREENHEIGHT-originX);
    CGContextAddLineToPoint(context, SCREENWIDTH-originX, originY);
    CGContextStrokePath(context);
}

//画虚线
-(void)drawDashLine:(CGContextRef)context{
    
    CGFloat dashPhase = 0;
    CGFloat lengths[] = {1,2};
    CGContextSetLineDash(context, dashPhase, lengths, 2);
    //横虚线
    for (NSInteger i = 0; i < 4 ; i++) {
        CGContextMoveToPoint(context, originX, originY-dashlineH - i*dashlineH);
        CGContextAddLineToPoint(context, SCREENWIDTH-originX, originY-dashlineH - i*dashlineH);
    }
    //纵虚线
    for (NSInteger i = 0; i < 5 ; i++) {
        CGContextMoveToPoint(context, originX+i*dashWidth, SCREENHEIGHT-originX*6);
        CGContextAddLineToPoint(context, originX+i*dashWidth, SCREENHEIGHT-originX*1);
    }
    CGContextStrokePath(context);
}

/**
 *  画点
 *
 *  @param context context
 *  @param color          点的颜色
 *  @param pointX         点的X坐标, 为整数1,2,3,4,5 分别代表2月 ~ 6月
 *  @param pointY         点的Y坐标, 范围:0~25
 *  @param pointDiameter  点的直径
 */
-(void)drawPointWithContext:(CGContextRef)context
                      color:(UIColor *)color
                      point:(CGPoint)point
              pointDiameter:(CGFloat)pointDiameter
{
    //    CGFloat X1 = originX + (pointX-1)*dashWidth;
    //    CGFloat Y1 = originY - (pointY*4);
    CGPoint point1 = [self transformPoint:point];
    CGContextSetRGBStrokeColor(context, 1.0, 1.0, 1.0, 0.0);
    CGContextAddArc(context, point1.x, point1.y, pointDiameter, 0, M_PI*2, 1);
    //设置填充颜色
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextDrawPath(context, kCGPathFillStroke);
}

/**
 *  根据点数组连线
 *
 *  @param context context
 *  @param point   点数组,注意这里是C数组
 *  @param R       r
 *  @param G       g
 *  @param B       b
 */
-(void)connectLineWithContext:(CGContextRef)context points:(CGPoint *)point colorR:(CGFloat)R colorG:(CGFloat)G colorB:(CGFloat)B{
    CGContextSetRGBStrokeColor(context, R, G, B, 1.0);
    int count = sizeof(point) / sizeof(point[0]);
    CGPoint greenLines[count];
    for (NSInteger i = 0; i< count; i++) {
        CGPoint afterPoint = [self transformPoint:point[i]];
        greenLines[i] = afterPoint;
    }
    CGContextSetLineWidth(context, 1.0);
    CGFloat dashPhase = 0;
    CGFloat lengths[] = {1,0};
    CGContextSetLineDash(context, dashPhase, lengths, 2);
    CGContextAddLines(context, greenLines, sizeof(greenLines)/sizeof(greenLines[0]));
    CGContextStrokePath(context);
}

/**
 *  自定义坐标系转换成图表坐标系
 */
-(CGPoint)transformPoint:(CGPoint)point{
    CGPoint afterPoint;
    afterPoint.x = originX + (point.x-1)*dashWidth;
    afterPoint.y = originY - (point.y*4);
    return afterPoint;
}

@end
