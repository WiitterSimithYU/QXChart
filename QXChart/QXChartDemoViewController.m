//
//  QXChartDemoViewController.m
//  QXChart
//
//  Created by qxliu on 2018/2/28.
//  Copyright © 2018年 e3info. All rights reserved.
//

#import "QXChartDemoViewController.h"

@interface QXChartDemoViewController ()

@end

@implementation QXChartDemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    switch (self.qxChartType) {
        case 0:
        {
            QXHColumnChart *chart = [[QXHColumnChart alloc]initWithFrame:CGRectMake(0, 100, self.view.frame.size.width,self.view.frame.size.height/2-100 )];
            chart.dataArray = @[@50,@50,@30,@50,@40,@100,@40,@50,@30,@50,@40];
            [self.view addSubview:chart];
        }
            break;
        case 1:
        {
            QXPiecewiseColumnChart *chart = [[QXPiecewiseColumnChart alloc]initWithFrame:CGRectMake(0, 100, self.view.frame.size.width,self.view.frame.size.height/2-100)];
            chart.dataArray =@[@40,@60,@80,@60,@65,@55,@70,@50,@55];
            [self.view addSubview:chart];
        }
            break;
        case 2:
        {
            QXLineChart *chart = [[QXLineChart alloc]initWithFrame:CGRectMake(0, 100, self.view.frame.size.width,self.view.frame.size.height/2-100 )];
            chart.dataArray= @[@40,@60,@80,@60,@65,@55,@70,@50,@55,@60,@50];
            [self.view addSubview:chart];
        }
            break;
        case 3:
        {
            QXPiePointerChart *chart = [[QXPiePointerChart alloc]initWithFrame:CGRectMake(0, 100, self.view.frame.size.width,self.view.frame.size.height/2-100 )];
            chart.dataArray =@[@20,@40,@60,@80,@60];
            chart.colorArray = @[[UIColor redColor],[UIColor yellowColor],[UIColor greenColor],[UIColor orangeColor],[UIColor blackColor]];
            [self.view addSubview:chart];
            
        }
            break;
        case 4:
        {
            QXPieChart *chart = [[QXPieChart alloc]initWithFrame:CGRectMake(0, 100, self.view.frame.size.width,self.view.frame.size.height/2-100 )];
            chart.dataArray =@[@20,@40,@60,@80,@60];
            chart.colorArray = @[[UIColor redColor],[UIColor yellowColor],[UIColor greenColor],[UIColor orangeColor],[UIColor blueColor]];
            [self.view addSubview:chart];
            
        }
            break;
            
        case 5:
        {
            QXVColumnaLineChart *chart = [[QXVColumnaLineChart alloc]initWithFrame:CGRectMake(0, 100, self.view.frame.size.width,self.view.frame.size.height/2-100 )];
            chart.columnaArr =@[@20,@40,@60,@100,@60];
            chart.lineArr = @[@30,@50,@50,@90,@100];
            [self.view addSubview:chart];
            
        }
            break;
            
        default:
            break;
    }
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
