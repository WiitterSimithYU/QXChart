//
//  QXPiePointerChart.m
//  QXChart
//
//  Created by qxliu on 2018/2/27.
//  Copyright © 2018年 e3info. All rights reserved.
//

#import "QXPiePointerChart.h"

@implementation QXPiePointerChart
-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}
-(void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    CGContextRef  contextRef = UIGraphicsGetCurrentContext();
    //画笔颜色 红色
    CGContextSetRGBStrokeColor(contextRef, 1, 0, 0, 1);
    //画线的线宽
    CGContextSetLineWidth(contextRef, 5);
    //画线的边帽
    CGContextSetLineCap(contextRef, kCGLineCapRound);
    //画线的缝合样式
    CGContextSetLineJoin(contextRef, kCGLineJoinRound);
    //    圆形
    CGContextAddArc(contextRef,self.center.x,self.bounds.size.height/2,self.bounds.size.height/4, 0, M_PI*2, 1);
    //封闭当前路径
    CGContextClosePath(contextRef);
    [[UIColor blueColor]setFill];
    //填充
    CGContextFillPath(contextRef);
    //绘制
    CGContextStrokePath(contextRef);
    
//绘制虚线箭头
    //求和
    float sum=0;
    for (NSNumber *str in self.dataArray) {
        
        sum += [str intValue];
    }
    CGFloat startAngle = 0;
    CGFloat endAngle =0;
    for (int i =0; i<self.dataArray.count; i++) {
        //求每一个的占比
        float zhanbi = [self.dataArray[i] floatValue]/sum;
        
        endAngle = startAngle + zhanbi*2*M_PI;
        
        UIColor*lineColor =self.colorArray[i];
        
        CAShapeLayer *shapeLayer = [CAShapeLayer layer];
        [shapeLayer setStrokeColor:lineColor.CGColor];
        [shapeLayer setLineWidth:2];
        [shapeLayer setLineJoin:kCALineJoinRound];
        //设置虚线的线宽及间距
        [shapeLayer setLineDashPattern:[NSArray arrayWithObjects:[NSNumber numberWithInt:3], [NSNumber numberWithInt:3], nil]];
        //创建虚线绘制路径
        CGMutablePathRef path = CGPathCreateMutable();
        CGPathMoveToPoint(path, NULL, self.center.x,self.bounds.size.height/2);
        CGFloat lineX = self.center.x +(self.bounds.size.height/4+2) * cos(startAngle);
        CGFloat lineY = self.bounds.size.height/2 +(self.bounds.size.height/4+2)* sin(startAngle);
        CGPathAddLineToPoint(path, NULL, lineX,lineY);
        //设置虚线绘制路径
        [shapeLayer setPath:path];
        CGPathRelease(path);
        [self.layer addSublayer:shapeLayer];
        CABasicAnimation*animation=[CABasicAnimation animationWithKeyPath:@"strokeEnd"];
        animation.duration=1.5;
        animation.timingFunction=[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        animation.fromValue=[NSNumber numberWithFloat:0];
        animation.toValue=[NSNumber numberWithFloat:1.0];
        [shapeLayer addAnimation:animation forKey:@"strokeEndAnimation"];
        
        //绘制箭头
        
        UIView *triangleView = [[UIView alloc]init];
        triangleView.center = CGPointMake(self.center.x,self.bounds.size.height/2);
        triangleView.bounds = CGRectMake(0, 0, 20, 20);
//        triangleView.backgroundColor = [UIColor greenColor];
        [self addSubview:triangleView];
        [UIView animateWithDuration:1.5 animations:^{
            triangleView.center = CGPointMake(lineX, lineY);
        }];
        //开始绘画
        UIGraphicsBeginImageContext(triangleView.frame.size);
        CGContextRef gc = UIGraphicsGetCurrentContext();
        //设置中心点
        CGContextTranslateCTM(gc, 0, 4);
        CGContextMoveToPoint(gc, 0 , 0);
        CGContextAddLineToPoint(gc, 10 , 6);
        CGContextAddLineToPoint(gc, 0,12);
        CGContextClosePath(gc);
        [lineColor setFill];
        CGContextDrawPath(gc, kCGPathFill);
        //结束绘画
        UIImage *destImg = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        //创建UIImageView并显示在界面上
        UIImageView *imgView = [[UIImageView alloc] initWithImage:destImg];
        [triangleView addSubview:imgView];
        //    imgView.transform = CGAffineTransformMakeRotation(startAngle);
        
        triangleView.transform = CGAffineTransformMakeRotation(startAngle);
          startAngle = endAngle;
        
    }
}
@end
