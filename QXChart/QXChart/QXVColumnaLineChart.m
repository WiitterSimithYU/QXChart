//
//  QXVColumnaLineChart.m
//  QXChart
//
//  Created by qxliu on 2018/2/28.
//  Copyright © 2018年 e3info. All rights reserved.
//

#import "QXVColumnaLineChart.h"

@implementation QXVColumnaLineChart

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
#pragma mark 柱状图
    CGFloat chartW = self.frame.size.width;
    CGFloat chartH = self.frame.size.height;
  
    //纵坐标
    for (int i = 0; i<6; i++) {
        UILabel *Ylabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 10+i*(chartH-40)/6, 40, (chartH-40)/6)];
        Ylabel.text = [NSString stringWithFormat:@"%d",i];
        Ylabel.font = [UIFont systemFontOfSize:8];
        Ylabel.textAlignment = NSTextAlignmentRight;
        Ylabel.textColor = [UIColor grayColor];
        [self addSubview:Ylabel];
        //刻度线
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(50,30+i*(chartH -40)/6, chartW-100, 1)];
        label.backgroundColor = [UIColor groupTableViewBackgroundColor];
        [self addSubview:label];
    }
    //横坐标
    for (int i = 0; i<self.columnaArr.count; i++) {
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(65+i*(chartW-100)/(_columnaArr.count), chartH-35,(chartW-100)/(_columnaArr.count*2), 30)];
        label.text = [NSString stringWithFormat:@"%d",i];
        label.font = [UIFont systemFontOfSize:8];
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = [UIColor grayColor];
        [self addSubview:label];
        
        
        CAShapeLayer *backLayer = [CAShapeLayer layer];
        backLayer.frame =self.bounds;
        backLayer.lineWidth = (chartW-100)/(_columnaArr.count*2);
        backLayer.strokeColor = [UIColor blueColor].CGColor;
        backLayer.fillColor =[UIColor clearColor].CGColor;
        [self.layer addSublayer:backLayer];
        
        UIBezierPath *backPath =[UIBezierPath bezierPathWithRect:CGRectMake(0, 0, 0, 0)];
        [backPath moveToPoint:CGPointMake(80+i*(chartW-100)/(_columnaArr.count), chartH-49)];
        [backPath addLineToPoint:CGPointMake(80+i*(chartW-100)/(_columnaArr.count),(chartH-49)-(chartH-80)*([self.columnaArr[i]floatValue]/100))];
        backLayer.path = backPath.CGPath;
        
        CABasicAnimation*backAnimation=[CABasicAnimation animationWithKeyPath:@"strokeEnd"];
        backAnimation.duration=1.5;
        backAnimation.timingFunction=[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        backAnimation.fromValue=[NSNumber numberWithFloat:0];
        backAnimation.toValue=[NSNumber numberWithFloat:1.0];
        [backLayer addAnimation:backAnimation forKey:@"strokeEndAnimation"];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            UILabel *topLabel = [[UILabel alloc]initWithFrame:CGRectMake(65+i*(chartW-100)/(_columnaArr.count), (chartH-49)-(chartH-80)*([self.columnaArr[i]floatValue]/100), (chartW-100)/(_columnaArr.count*2),20 )];
            topLabel.text = [NSString stringWithFormat:@"%.1f%%",[_columnaArr[i]floatValue]];
            topLabel.font = [UIFont systemFontOfSize:8];
            topLabel.textAlignment = NSTextAlignmentCenter;
            topLabel.textColor = [UIColor whiteColor];
            [self addSubview:topLabel];
        });
    }
    
#pragma mark 折线图
    
    CAShapeLayer *lineLayer = [CAShapeLayer layer];
    UIBezierPath *linePath =[UIBezierPath bezierPathWithRect:CGRectMake(0, 0, 0, 0)];
    
    //三角形
  
    for (int i =0; i<self.lineArr.count; i++) {
        
        CGFloat pointX =80+i*(chartW-100)/(_lineArr.count);
        CGFloat pointY =(chartH-49)-(chartH-80)*([_lineArr[i]floatValue]/100);
        UIView *triangleView = [[UIView alloc]init];
        triangleView.center = CGPointMake(pointX,pointY);
        triangleView.bounds = CGRectMake(0, 0, 20, 20);
//        triangleView.backgroundColor = [UIColor greenColor];
        [self addSubview:triangleView];
        UIGraphicsBeginImageContext(triangleView.frame.size);
        CGContextRef contextRef = UIGraphicsGetCurrentContext();

        CGContextMoveToPoint(contextRef, 2 , 18);
        CGContextAddLineToPoint(contextRef, 18 , 18);
        CGContextAddLineToPoint(contextRef, 10,2);
        CGContextClosePath(contextRef);
        [[UIColor orangeColor] setFill];
        CGContextDrawPath(contextRef, kCGPathFill);
        //结束绘画
        UIImage *destImg = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        //创建UIImageView并显示在界面上
        UIImageView *imgView = [[UIImageView alloc] initWithImage:destImg];
        [triangleView addSubview:imgView];
      
        if (i>0) {
            lineLayer.frame = self.bounds;
            lineLayer.lineWidth = 2;
            lineLayer.strokeColor = [UIColor redColor].CGColor;
            lineLayer.fillColor =[UIColor clearColor].CGColor;
            
            [linePath moveToPoint:CGPointMake(80+(i-1)*(chartW-100)/(_lineArr.count),(chartH-49)-(chartH-80)*([_lineArr[i-1]floatValue]/100))];
            [linePath addLineToPoint:CGPointMake(80+i*(chartW-100)/(_lineArr.count),(chartH-49)-(chartH-80)*([_lineArr[i]floatValue]/100))];
            lineLayer.path = linePath.CGPath;
        }
    }
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{

        [self.layer addSublayer:lineLayer];
        CABasicAnimation*lineAnimation=[CABasicAnimation animationWithKeyPath:@"strokeEnd"];
        lineAnimation.duration=1.5;
        lineAnimation.timingFunction=[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        lineAnimation.fromValue=[NSNumber numberWithFloat:0];
        lineAnimation.toValue=[NSNumber numberWithFloat:1.0];
        [lineLayer addAnimation:lineAnimation forKey:@"strokeEndAnimation"];
    });
    
}

@end
