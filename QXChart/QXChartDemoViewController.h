//
//  QXChartDemoViewController.h
//  QXChart
//
//  Created by qxliu on 2018/2/28.
//  Copyright © 2018年 e3info. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QXChart.h"
typedef enum : NSUInteger {
    HColumnChart,
    PiecewiseColumnChart,
    LineChart,
    PiePointerChart,
    PieChart,
    VColumnaLineChart
} QXChartType;
@interface QXChartDemoViewController : UIViewController
@property (nonatomic, assign) QXChartType qxChartType;

@end
