//
//  ViewController.m
//  QXChart
//
//  Created by qxliu on 2018/2/25.
//  Copyright © 2018年 e3info. All rights reserved.
//

#import "ViewController.h"
#import "QXChartDemoViewController.h"



@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UITableView *tableView = [[UITableView alloc]initWithFrame:self.view.frame style:UITableViewStylePlain];
    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    tableView.delegate =self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 6;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.textLabel.text = @[@"横柱状图",@"横分段柱状图",@"曲线图",@"指针饼图",@"分区饼图",@"竖柱状折线图"][indexPath.row];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    QXChartDemoViewController *VC = [[QXChartDemoViewController alloc]init];
    switch (indexPath.row) {
        case 0:
        {
            VC.qxChartType = HColumnChart;
        }
            break;
        case 1:
        {
            VC.qxChartType = PiecewiseColumnChart;
        }
            break;
        case 2:
        {
           VC.qxChartType = LineChart;
        }
            break;
        case 3:
        {
           VC.qxChartType = PiePointerChart;
        }
            break;
        case 4:
        {
            VC.qxChartType = PieChart;
        }
            break;
        case 5:
        {
            VC.qxChartType = VColumnaLineChart;
        }
            break;
            
        default:
            break;
    }
    [self.navigationController pushViewController:VC animated:YES];
    
}


@end
