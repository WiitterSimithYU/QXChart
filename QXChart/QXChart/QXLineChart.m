//
//  QXLineChart.m
//  QXChart
//
//  Created by qxliu on 2018/2/26.
//  Copyright © 2018年 e3info. All rights reserved.
//

#import "QXLineChart.h"
@interface QXLineChart ()

@property(nonatomic,assign)CGFloat chartW;
@property(nonatomic,assign)CGFloat chartH;
@end

@implementation QXLineChart

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.chartW = self.frame.size.width;
        self.chartH = self.frame.size.height;
    }
    return self;
}
-(void)drawRect:(CGRect)rect
{
    [self drawUI];
    [self drawAverageXuxian];
}
-(void)drawUI
{
    //纵坐标label
    UILabel *yLabel = [[UILabel alloc]initWithFrame:CGRectMake(50, 10, 100,20 )];
    yLabel.text = @"MW";
    [self addSubview:yLabel];
    //坐标系
    CAShapeLayer *layer = [CAShapeLayer layer];
    layer.fillColor = [UIColor clearColor].CGColor;
    layer.strokeColor = [UIColor grayColor].CGColor;
    layer.lineWidth = 1.0;
    [self.layer addSublayer:layer];
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    
    //坐标轴原点
    CGPoint rPoint = CGPointMake(60, _chartH-30);
    
    //画y轴
    [path moveToPoint:rPoint];
    [path addLineToPoint:CGPointMake(60, 30)];
    
    //画x轴
    [path moveToPoint:rPoint];
    [path addLineToPoint:CGPointMake(_chartW-50, _chartH-30)];
    layer.path = path.CGPath;
    
    CGPoint statrPoint;
    CGFloat endHeight;
    for (int i = 1; i<self.dataArray.count; i++) {
        //画虚线
        statrPoint =CGPointMake(60+i*(_chartW-120)/(_dataArray.count-1),_chartH-30);
        endHeight =  (_chartH - 60)*([self.dataArray[i]floatValue]/100);
        [self drawXuxian:statrPoint andEndHeight:endHeight];
    }
    //画折线
    CAShapeLayer *lineShaper = [CAShapeLayer layer];
    UIBezierPath *linePath =[UIBezierPath bezierPathWithRect:CGRectMake(0, 0, 0, 0)];

    [self.layer addSublayer:lineShaper];
    for (int i = 0; i<self.dataArray.count; i++) {
        if (i>0) {
            lineShaper.frame = self.bounds;
            lineShaper.lineWidth = 3;
            lineShaper.strokeColor = [UIColor blueColor].CGColor;
            lineShaper.fillColor =[UIColor clearColor].CGColor;
            
            linePath.lineCapStyle = kCGLineCapRound;  //线条拐角
            linePath.lineJoinStyle = kCGLineCapRound;  //终点处理
            
            CGFloat spacing = (_chartW-120)/(_dataArray.count-1);
            CGFloat halfSpacing = (_chartW-120)/((_dataArray.count-1)*4);
            
            [linePath moveToPoint:CGPointMake(60+(i-1)*spacing,(_chartH-30)-((_chartH-60)*[self.dataArray[i-1]floatValue]/100))];
//            [linePath addLineToPoint:CGPointMake(80+i*spacing,(_chartH-30)-((_chartH-60)*[self.dataArray[i]floatValue]/100))];
            
            [linePath addCurveToPoint:CGPointMake(60+i*spacing,(_chartH-30)-((_chartH-60)*[self.dataArray[i]floatValue]/100)) controlPoint1:CGPointMake(60+(i-1)*spacing+halfSpacing,(_chartH-30)-((_chartH-60)*[self.dataArray[i-1]floatValue]/100)) controlPoint2:CGPointMake(60+i*spacing-halfSpacing,(_chartH-30)-((_chartH-60)*[self.dataArray[i]floatValue]/100))];
            lineShaper.path = linePath.CGPath;
        }
        
    }
    CABasicAnimation*animation=[CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    animation.duration=1.5;
    animation.timingFunction=[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation.fromValue=[NSNumber numberWithFloat:0];
    animation.toValue=[NSNumber numberWithFloat:1.0];
    [lineShaper addAnimation:animation forKey:@"strokeEndAnimation"];
    
    linePath = nil;
    lineShaper = nil;
    animation =nil;
}
//绘制竖虚线
- (void)drawXuxian:(CGPoint)statrPoint andEndHeight:(CGFloat)endHeight
{
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    
    [shapeLayer setStrokeColor:[UIColor blueColor].CGColor];
    
    [shapeLayer setLineWidth:1];
    [shapeLayer setLineJoin:kCALineJoinRound];
    
    //设置虚线的线宽及间距
    [shapeLayer setLineDashPattern:[NSArray arrayWithObjects:[NSNumber numberWithInt:2], [NSNumber numberWithInt:3], nil]];
    
    //创建虚线绘制路径
    CGMutablePathRef path = CGPathCreateMutable();
    
    //设置y轴方向的虚线
    CGPathMoveToPoint(path, NULL, statrPoint.x,_chartH-30-endHeight);
    CGPathAddLineToPoint(path, NULL, statrPoint.x,_chartH-30);
    
//    //设置x轴方向的虚线
//    CGPathMoveToPoint(path, NULL, point.x, point.y);
//    CGPathAddLineToPoint(path, NULL, 1.3*margin, point.y);
    
    //设置虚线绘制路径
    [shapeLayer setPath:path];
    CGPathRelease(path);
    
    [self.layer addSublayer:shapeLayer];
}

//绘制平均值虚线

- (void)drawAverageXuxian
{
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    
    [shapeLayer setStrokeColor:[UIColor blueColor].CGColor];
    
    [shapeLayer setLineWidth:1];
    [shapeLayer setLineJoin:kCALineJoinRound];
    
    //设置虚线的线宽及间距
    [shapeLayer setLineDashPattern:[NSArray arrayWithObjects:[NSNumber numberWithInt:2], [NSNumber numberWithInt:3], nil]];
    
    //创建虚线绘制路径
    CGMutablePathRef path = CGPathCreateMutable();
    
    //设置y轴方向的虚线
    CGPathMoveToPoint(path, NULL, 60,(_chartH-30)-(_chartH-60)*50/100);
    CGPathAddLineToPoint(path, NULL, _chartW-120,(_chartH-30)-(_chartH-60)*50/100);
    //设置虚线绘制路径
    [shapeLayer setPath:path];
    CGPathRelease(path);
    
    [self.layer addSublayer:shapeLayer];
    
    UILabel *aLabel =[[UILabel alloc]initWithFrame:CGRectMake(_chartW-120, (_chartH-35)-(_chartH-60)*50/100, 100, 20)];
    aLabel.text = @"平均负荷";
    [self addSubview:aLabel];
    
}


@end
