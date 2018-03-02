//
//  QXPieChart.m
//  QXChart
//
//  Created by qxliu on 2018/2/28.
//  Copyright © 2018年 e3info. All rights reserved.
//

#import "QXPieChart.h"

@implementation QXPieChart
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
    //原点
    CGPoint originPoint = CGPointMake(self.center.x, self.self.bounds.size.height/2);
    CGFloat startAngle = 0;
    CGFloat endAngle =0;
    float r = self.bounds.size.height/2;
    //求和
    float sum=0;
    for (NSNumber *str in self.dataArray) {
        
        sum += [str intValue];
    }
    
    for (int i=0; i<self.dataArray.count; i++) {
        //求每一个的占比
        float zhanbi = [self.dataArray[i] floatValue]/sum;
        
        endAngle = startAngle + zhanbi*2*M_PI;
        
        CAShapeLayer *layer = [CAShapeLayer layer];
        UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:originPoint radius:r startAngle:startAngle endAngle:endAngle clockwise:YES];
        [path addLineToPoint:originPoint];
        [path closePath];
        layer.path = path.CGPath;
        UIColor *color = self.colorArray[i];
        layer.fillColor = color.CGColor;
        layer.strokeColor = [UIColor clearColor].CGColor;
        [self.layer addSublayer:layer];
        startAngle = endAngle;
        
        layer = nil;
        path = nil;
    }
    for (int i=0; i<self.dataArray.count; i++) {
        
        //求每一个的占比
        float zhanbi = [self.dataArray[i] floatValue]/sum;
         endAngle = startAngle + zhanbi*2*M_PI;
        CGFloat bLWidth = 40;
        CGFloat lab_x = originPoint.x +r/1.5  * cos((startAngle + (endAngle - startAngle)/2)) ;
        CGFloat lab_y = originPoint.y + r/1.5  * sin((startAngle + (endAngle - startAngle)/2));
        UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(lab_x, lab_y, bLWidth, bLWidth/2)];
        lab.text = [NSString stringWithFormat:@"%.1f%@",zhanbi*100,@"%"];
        lab.textColor = [UIColor whiteColor];
        lab.numberOfLines = 0;
        lab.backgroundColor = [UIColor blackColor];
        lab.alpha = 0.7;
        lab.font = [UIFont boldSystemFontOfSize:8];
        lab.textAlignment = NSTextAlignmentCenter;
        [self addSubview:lab];
         startAngle = endAngle;
    }
    CABasicAnimation *rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    
    rotationAnimation.duration = 0.5;
    rotationAnimation.autoreverses = YES;
    rotationAnimation.byValue = @0.1;
    [self.layer addAnimation:rotationAnimation forKey:@"scale"];
    rotationAnimation = nil;
    
}

@end
