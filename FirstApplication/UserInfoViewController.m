//
//  UserInfoViewController.m
//  FirstApplication
//
//  Created by Hemant Rathore on 06/10/15.
//  Copyright © 2015 Hemant Rathore. All rights reserved.
//

#import "UserInfoViewController.h"
//#import "ChartViewController.h"
//#import "RegionMonthChartViewController.h"
//#import "Dashboard2ViewController.h"
//#import "SharedManager.h"
//#import "Constant.h"

@interface UserInfoViewController () <UITableViewDelegate, UITableViewDataSource, UIAlertViewDelegate>
{
    UIView *viewHeader;
    
    UIView *viewLeft;
    UIView *viewRight;
    
    UITableView *tableViewChart;
    
    NSString *stringToday, *string7Day, *string14Day;
    
    id jsonData;
}

@end

@implementation UserInfoViewController
static NSString *cellIdentifier = @"TestCellIdentifier";
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self getUserConfiguration];
    
    //[self showButton];
    
    [self addViews];
    [self getLast7Date];
    
    NSArray *arrLogin = [[SharedManager sharedManager] getArrayLogin];
    
    NSLog(@"array login : %@",arrLogin);
    
    NSArray *array = @[@"26-Apr-2015", @"19-Apr-2015"];
    
    [[SharedManager sharedManager] setArrayDate:array];
}

- (void)addViews
{
    viewHeader = [UIView new];
    viewHeader.frame = CGRectMake(0, 0, CGRectGetWidth(self.view.frame), 60);
    viewHeader.backgroundColor = UIColorFromRGB(0xeeffff);
    viewHeader.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    [self.view addSubview:viewHeader];
    
    /*UIImageView *imageView = [UIImageView new];
     imageView.frame = CGRectMake(0, 100, 300, 200);
     imageView.center = CGPointMake(CGRectGetMidX(self.view.frame), CGRectGetMidY(imageView.frame));
     imageView.image = [UIImage imageNamed:@"App.jpg"];
     [self.view addSubview:imageView];
     
     UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
     btn.frame = CGRectMake(0, 0, 400, 200);
     btn.backgroundColor = [UIColor greenColor];
     [btn addTarget:self action:@selector(goToChart) forControlEvents:UIControlEventTouchUpInside];
     [self.view addSubview:imageView];*/
    
    UIView *viewLine = [UIView new];
    viewLine.frame = CGRectMake(0, CGRectGetHeight(viewHeader.frame)-1, CGRectGetWidth(viewHeader.frame), 1);
    viewLine.backgroundColor = UIColorFromRGB(0x00ffff);
    viewLine.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
    [viewHeader addSubview:viewLine];
    
    CGFloat widthLeft = CGRectGetWidth(self.view.frame)/2.5;
    CGFloat heightLeft = CGRectGetHeight(self.view.frame) - CGRectGetHeight(viewHeader.frame);
    
    viewLeft = [UIView new];
    viewLeft.frame = CGRectMake(0, CGRectGetMaxY(viewHeader.frame), widthLeft, heightLeft);
    viewLeft.layer.borderWidth = 1.0;
    viewLeft.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleWidth;
    //[self.view addSubview:viewLeft];
    
    CGFloat widthRight = CGRectGetWidth(self.view.frame);
    CGFloat heightRight = heightLeft;
    
    viewRight = [UIView new];
    viewRight.frame = CGRectMake(0, CGRectGetMaxY(viewHeader.frame), widthRight, heightRight);
    viewRight.layer.borderWidth = 1.0;
    viewRight.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    [self.view addSubview:viewRight];
    
    
    tableViewChart = [UITableView new];
    tableViewChart.frame = CGRectMake(0, 0, CGRectGetWidth(viewRight.frame), CGRectGetHeight(viewRight.frame));
    tableViewChart.delegate = self;
    tableViewChart.dataSource = self;
    [viewRight addSubview:tableViewChart];
    
    [tableViewChart registerClass:[UITableViewCell class] forCellReuseIdentifier:cellIdentifier];
    
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = true;
    //self.navigationItem.hidesBackButton = true;
    //self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Logout" style:UIBarButtonItemStylePlain target:self action:@selector(logoutUser:)];
    
    /*UIButton *btnLogout = [UIButton buttonWithType:UIButtonTypeRoundedRect];
     [btnLogout setFrame:CGRectMake(CGRectGetWidth(self.view.frame) - 80, 20, 60, 30)];
     [btnLogout setTitle:@"Logout" forState:UIControlStateNormal];
     [btnLogout addTarget:self action:@selector(logoutUser:) forControlEvents:UIControlEventTouchUpInside];
     [viewHeader addSubview:btnLogout];*/
    
    /*UIButton *buttonSync = [UIButton buttonWithType:UIButtonTypeCustom];
     [buttonSync setBackgroundImage:[UIImage imageNamed:@"Sync.png"] forState:UIControlStateNormal];
     [buttonSync addTarget:self action:@selector(syncData) forControlEvents:UIControlEventTouchUpInside];
     buttonSync.frame = CGRectMake(CGRectGetWidth(self.view.frame) - 20 - 40, 20, 40, 40);
     buttonSync.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin;
     [viewHeader addSubview:buttonSync];*/
    
    UIButton *buttonLogout = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [buttonLogout setTitle:@"Logout" forState:UIControlStateNormal];
    [buttonLogout addTarget:self action:@selector(logoutUser:) forControlEvents:UIControlEventTouchUpInside];
    buttonLogout.frame = CGRectMake(20, 20, 100, 40);
    [viewHeader addSubview:buttonLogout];
    
    
    
}

- (void)syncData
{
    if (![[SharedManager sharedManager] connected]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@""
                                                        message:@"Please connect to internet for Sync."
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles: nil];
        [alert show];
        return;
    }
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@""
                                                    message:@"For how many days data you want to sync ?"
                                                   delegate:self
                                          cancelButtonTitle:@"Cancel"
                                          otherButtonTitles:@"1 Week", @"2 Week", nil];
    [alert show];
    
}


- (void)logoutUser:(id)sender
{
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
    [self.navigationController popViewControllerAnimated:true];
}

- (void)showButton
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    button.frame = CGRectMake(0, 0, 150, 30);
    [button setTitle:@"Show Chart" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(goToChart) forControlEvents:UIControlEventTouchUpInside];
    button.center = CGPointMake(CGRectGetWidth(self.view.frame)/2, CGRectGetHeight(self.view.frame)/2);
    [self.view addSubview:button];
}

- (void)goToChart
{
    NSArray *arr = [[SharedManager sharedManager] getChartInfo];
    NSLog(@"%@",arr);
    Dashboard2ViewController *c = [Dashboard2ViewController new];
    //c.arrayConfig = arr;
    [self presentViewController:c animated:true completion:nil];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 8;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    
    UIImageView *imageView = (UIImageView *)[cell.contentView viewWithTag:101];
    UILabel *lblName = (UILabel *)[cell.contentView viewWithTag:102];
    UILabel *lblTime = (UILabel *)[cell.contentView viewWithTag:103];
    UILabel *lblTap = (UILabel *)[cell.contentView viewWithTag:104];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    if (imageView == nil) {
        imageView = [UIImageView new];
        imageView.tag = 101;
        imageView.frame = CGRectMake(10, 10, 80, 80);
        imageView.layer.borderWidth = 0.5;
        [cell.contentView addSubview:imageView];
    }
    
    if (lblName == nil) {
        lblName = [UILabel new];
        lblName.tag = 102;
        lblName.textColor = [UIColor darkTextColor];
        lblName.frame = CGRectMake(CGRectGetMaxX(imageView.frame) + 20, 15, 200, 20);
        lblName.text = [NSString stringWithFormat:@"Dashboard %d",(int)indexPath.row+1];
        [cell.contentView addSubview:lblName];
    }
    
    if (lblTime == nil) {
        lblTime = [UILabel new];
        lblTime.tag = 103;
        lblTime.frame = CGRectMake(CGRectGetMaxX(imageView.frame) + 20, CGRectGetMaxY(lblName.frame) + 5, 200, 20);
        lblTime.textColor = [UIColor lightGrayColor];
        lblTime.text = @"30/10/15 4:00 pm";
        [cell.contentView addSubview:lblTime];
    }
    
    if (lblTap == nil) {
        lblTap = [UILabel new];
        lblTap.tag = 104;
        lblTap.frame = CGRectMake(CGRectGetMaxX(imageView.frame) + 20, CGRectGetMaxY(lblTime.frame) + 5, 200, 20);
        lblTap.text = @"Tap To Open";
        lblTap.textColor = UIColorFromRGB(0xDE5B79);
        [cell.contentView addSubview:lblTap];
    }
    
    if (indexPath.row == 0)
    {
        imageView.image = [UIImage imageNamed:@"icon1.png"];
    }
    else if (indexPath.row == 1)
    {
        imageView.image = [UIImage imageNamed:@"icon2.png"];
    }
    else if (indexPath.row == 2)
    {
        imageView.image = [UIImage imageNamed:@"icon3.png"];
    }
    else if (indexPath.row == 3)
    {
        imageView.image = [UIImage imageNamed:@"icon4.png"];
    }
    
    if (indexPath.row == 4)
    {
        imageView.image = [UIImage imageNamed:@"icon1.png"];
    }
    else if (indexPath.row == 5)
    {
        imageView.image = [UIImage imageNamed:@"icon2.png"];
    }
    else if (indexPath.row == 6)
    {
        imageView.image = [UIImage imageNamed:@"icon3.png"];
    }
    else if (indexPath.row == 7)
    {
        imageView.image = [UIImage imageNamed:@"icon4.png"];
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 200;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIImageView *view = [UIImageView new];
    view.frame = CGRectMake(0, 0, CGRectGetWidth(tableView.frame), 200);
    view.backgroundColor = UIColorFromRGB(0x0D89BD);
    view.contentMode = UIViewContentModeScaleToFill;
    
    UIImageView *imgView = [UIImageView new];
    imgView.frame = CGRectMake(0, 0, CGRectGetWidth(tableView.frame), 200);
    imgView.image = [UIImage imageNamed:@"App.jpg"];
    imgView.contentMode = UIViewContentModeScaleAspectFit;
    [view addSubview:imgView];
    return view;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self goToChart];
}


- (void)getLast7Date
{
    NSCalendar *cal = [NSCalendar currentCalendar];
    NSDateComponents *components = [cal components:( NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit ) fromDate:[[NSDate alloc] init]];
    
    [components setHour:-[components hour]];
    [components setMinute:-[components minute]];
    [components setSecond:-[components second]];
    NSDate *today = [cal dateByAddingComponents:components toDate:[[NSDate alloc] init] options:0]; //This variable should now be pointing at a date object that is the start of today (midnight);
    
    [components setHour:-24];
    [components setMinute:0];
    [components setSecond:0];
    //NSDate *yesterday = [cal dateByAddingComponents:components toDate: today options:0];
    
    components = [cal components:NSWeekdayCalendarUnit | NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit fromDate:[[NSDate alloc] init]];
    
    /*[components setDay:([components day] - ([components weekday] - 1))];
     NSDate *thisWeek  = [cal dateFromComponents:components];*/
    
    [components setDay:([components day] - 7)];
    NSDate *lastWeek1st  = [cal dateFromComponents:components];
    
    [components setDay:([components day] - 7)];
    NSDate *lastWeek2nd  = [cal dateFromComponents:components];
    
    /*[components setDay:([components day] - ([components day] -1))];
     NSDate *thisMonth = [cal dateFromComponents:components];
     
     [components setMonth:([components month] - 1)];
     NSDate *lastMonth = [cal dateFromComponents:components];*/
    
    stringToday = [self curentDateStringFromDate:today withFormat:@"yyyy-MM-dd"];
    string7Day = [self curentDateStringFromDate:lastWeek1st withFormat:@"dd-MM-yyyy"];
    string14Day = [self curentDateStringFromDate:lastWeek2nd withFormat:@"dd-MM-yyyy"];
    NSLog(@"today=%@, %@",today, stringToday);
    //NSLog(@"yesterday=%@",yesterday);
    //NSLog(@"thisWeek=%@",thisWeek);
    NSLog(@"lastWeek1st=%@",lastWeek1st);
    NSLog(@"lastWeek2nd=%@",lastWeek2nd);
    //NSLog(@"thisMonth=%@",thisMonth);
    //NSLog(@"lastMonth=%@",lastMonth);
}


- (NSString *)curentDateStringFromDate:(NSDate *)dateTimeInLine withFormat:(NSString *)dateFormat {
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    
    [formatter setDateFormat:dateFormat];
    
    NSString *convertedString = [formatter stringFromDate:dateTimeInLine];
    
    return convertedString;
}

#pragma mark UIAlertViewDelegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSString *date1, *date2;
    if (buttonIndex == 1)
    {
        NSLog(@"1 week");
        date1 = @"2015-01-30";//[stringToday substringToIndex:10];
        date2 = @"2015-01-22";//[string7Day substringToIndex:10];
    }
    else if (buttonIndex == 2)
    {
        NSLog(@"2 Week");
        date1 = @"2015-01-30";//[stringToday substringToIndex:10];
        date2 = @"2015-01-17";//[string14Day substringToIndex:10];
    }
    
    [self getGraphData:date1 toDate:date2];
}

- (void)getDataFor:(NSString *)weeks
{
    if ([weeks isEqualToString:@"1 week"])
    {
        
    }
    else
    {
        
    }
}

- (void)getUserConfiguration
{
    NSString *myUrlString = URL_GET_USER_COFIG_INFO;
    
    myUrlString = [myUrlString stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding];
    NSURLResponse *response;
    NSError *error;
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:myUrlString]];
    
    [request setHTTPMethod:@"GET"];
    
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    if (error == nil)
    {
        jsonData = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        [[SharedManager sharedManager] saveDataDict:jsonData toPlist:NAME_PLIST_USER_CONFIG];
    }
}


- (void)getGraphData:(NSString *)stringFirstDate toDate:(NSString *)stringSecondDate
{
    NSString *myUrlString = [NSString stringWithFormat:@"https://uat-analytics.thecarecloud.com/netlink/plugin/cda/api/doQuery?path=/home/test/IOS App/IOS1.0.cda&dataAccessId=qry_TotalHoursBySupplierName&parampStartDate=%@&parampEndDate=%@&parampLocation=All",stringSecondDate, stringFirstDate];
    
    myUrlString = [myUrlString stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding];
    NSURLResponse *response;
    NSError *error;
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:myUrlString]];
    
    [request setHTTPMethod:@"GET"];
    
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    
    if (error == nil) {
        jsonData = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        
        NSArray *arr = [jsonData objectForKey:@"resultset"];
        NSLog(@"Location : %@",arr);
        dispatch_async(dispatch_get_main_queue(), ^{
            //[[SharedManager sharedManager] saveGraphArray:arr];
            [[SharedManager sharedManager] saveDataDict:jsonData toPlist:NAME_PLIST_DATA_GRAPH];
            //[[SharedManager sharedManager] saveData:arr toPlist:NAME_PLIST_DATA_GRAPH];
            NSLog(@"arr : %@",arr.description);
        });
    }
    else
    {
        
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
