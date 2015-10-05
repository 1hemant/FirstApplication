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
    
    self.view.backgroundColor = [UIColor grayColor];
    [self getHourlyData];
    // Do any additional setup after loading the view.
    arrayTempMutable = [[NSMutableArray alloc] initWithObjects:@"10",@"20",@"80",@"40",@"50", nil];
    [self addHomeButton];
    
    [self createPieChart];
    [self createBarChart];
    [barChartView reloadData];

    
    
}
- (void)getHourlyData {
    NSString *hourUrlString = @"https://uat-analytics.thecarecloud.com/netlink/plugin/cda/api/doQuery?path=/public/Demo/Landing%20Page/Telco%20Business%20Brain/Network%20Management/Network%20Insights.cda&dataAccessId=HourWiseRevenue&parampWeekEnd=%2226-Apr-2015%22&parampDate=%22All%22&parampFlag=%22All%22&parampDistrict=%22All%22&parampCity=%22All%22&parampHour=%22All%22&parampBTS=%22All%22&parampDonut=%22All%22";
    NSURLResponse *hUrlResponse;
    NSError *error;
    NSMutableURLRequest *urlRequest = [[NSMutableURLRequest alloc] init];
    [urlRequest setURL:[NSURL URLWithString:hourUrlString]];
    [urlRequest setHTTPMethod:@"GET"];
    NSDate *data = [NSURLConnection sendSynchronousRequest:urlRequest returningResponse:&hUrlResponse  error:&error];
    if (error == nil) {
        NSString *str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        jsonData = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        NSLog(@"%@, %@",jsonData, str);
        NSArray* tempData = [jsonData objectForKey:@"resultset"];
        dataArray = [[NSMutableArray alloc] init];
        int i=0,a=0,b=0,c=0,d=0;
        for (; i<3; i++) {
            NSMutableDictionary *dictTempMutable = [[NSMutableDictionary alloc] init];
            if ([tempData objectAtIndex:i]) {
                NSArray* arrCopyData2 = [tempData objectAtIndex:i];
                [dictTempMutable setObject:[arrCopyData2 objectAtIndex:0] forKey:@"0"];
                [dictTempMutable setObject:[arrCopyData2 objectAtIndex:1] forKey:@"1"];
                [dictTempMutable setObject:[arrCopyData2 objectAtIndex:2] forKey:@"2"];
                [dictTempMutable setObject:[arrCopyData2 objectAtIndex:3] forKey:@"3"];
                
                NSLog(@"The value in array a before assignment %d ", a);
                a = [[arrCopyData2 objectAtIndex:1]intValue];
                NSLog(@"The value in array a after assignment %d ", a);
                b = [[arrCopyData2 objectAtIndex:2]intValue];
                NSLog(@"The value in array b after assignment %d ", b);
                c = [[arrCopyData2 objectAtIndex:3]intValue];
                d = a+b+c;
                [dictTempMutable setObject:[NSNumber numberWithInteger:d] forKey:@"4"];
                [dataArray addObject:dictTempMutable];
            }
            else
                break;
        }
        
    }
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
    return [arrayTempMutable count]; //to consume static data
    //return [dataArray count]; //to use UAT data
    
}

- (CGFloat)barChartView:(JBBarChartView *)barChartView heightForBarViewAtIndex:(NSUInteger)index
{
    //return 10; // height of bar at index
    CGFloat value = [[arrayTempMutable objectAtIndex:index] floatValue]; ////to consume static data
    //CGFloat value = [[dataArray objectAtIndex:index] floatValue]; //to use UAT data
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
