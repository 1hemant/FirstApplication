//
//  SecondViewController.m
//  FirstApplication
//
//  Created by Hemant Rathore on 28/09/15.
//  Copyright © 2015 Hemant Rathore. All rights reserved.
//

#import "SecondViewController.h"

@interface SecondViewController (){
    id jsonData;
    NSMutableArray *dataArray;
}


@end

@implementation SecondViewController{
    
    NSMutableArray *arrayTempMutable;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithRed:0.063f green:0.537f blue:0.745f alpha:1.00f];
  //  [self getHourlyData];
    // Do any additional setup after loading the view.
    arrayTempMutable = [[NSMutableArray alloc] initWithObjects:@"10",@"20",@"80",@"40",@"50", nil];
    [self addHomeButton];
    [self createPieChart];
    [self createBarChart];
    [barChartView reloadData];

    
    
}


    //**create button for home page
- (void)addHomeButton{
    UIButton *homeButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [homeButton addTarget:self action:@selector(homeButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [homeButton setTitle:@"Home" forState:UIControlStateNormal];
    homeButton.frame =  CGRectMake(100, 675, 200, 40);
    [homeButton setBackgroundColor:[UIColor greenColor]];
    [self.view addSubview:homeButton];
}


- (void)homeButtonAction{
    //ViewController *vC = [[ViewController alloc] init];
    //[self presentViewController:vC animated:true completion:nil];
    
    [self dismissViewControllerAnimated:true completion:nil];
}
//**HomeButton end




//**PieChart creation
- (void)createPieChart{
    pieChart = [[XYPieChart alloc] initWithFrame:CGRectMake(10, 100, 200, 200) Center:CGPointMake(110, 110) Radius:100];
    [self.view addSubview:pieChart];
    pieChart.dataSource = self;
    
    [self performSelector:@selector(reloadPieChart) withObject:nil afterDelay:0.25];
}

- (void)reloadPieChart
{
    [pieChart reloadData];

}

- (NSUInteger)numberOfSlicesInPieChart:(XYPieChart *)pieChart{
    return 3;
}
- (CGFloat)pieChart:(XYPieChart *)pieChart valueForSliceAtIndex:(NSUInteger)index{
    return 30;
}
//**PieChartEnd



//**JBBarChartCreation
- (void)createBarChart{
    barChartView = [[JBBarChartView alloc] init];
    barChartView.dataSource = self;
    barChartView.delegate = self;
    barChartView.frame = CGRectMake(10, 350, 200, 200);
    [barChartView reloadData];
    [self.view addSubview:barChartView];
    
}

- (NSUInteger)numberOfBarsInBarChartView:(JBBarChartView *)barChartView
{
    //return 5; // number of bars in chart
    //return [arrayTempMutable count]; //to consume static data
    return [dataArray count]; //to use UAT data
    
}

- (CGFloat)barChartView:(JBBarChartView *)barChartView heightForBarViewAtIndex:(NSUInteger)index
{
    //return 10; // height of bar at index
    //CGFloat value = [[arrayTempMutable objectAtIndex:index] floatValue]; ////to consume static data
    //CGFloat value = [[dataArray objectAtIndex:index] floatValue]; //to use UAT data
    CGFloat value = [[[dataArray objectAtIndex:index] objectForKey:@"1"] floatValue]; //to use UAT data for trial
    
    return value;
    
}


- (UIColor *)barChartView:(JBBarChartView *)barChartView colorForBarViewAtIndex:(NSUInteger)index{
    //return [UIColor greenColor];
    return (index % 2 == 0) ? [UIColor blueColor] : [UIColor greenColor];
}

- (void)dealloc
{

}

//**JBBarChartEnd







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
