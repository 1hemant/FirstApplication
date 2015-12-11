//
//  LoginViewController.m
//  FirstApplication
//
//  Created by Hemant Rathore on 05/10/15.
//  Copyright © 2015 Hemant Rathore. All rights reserved.
//

#import "LoginViewController.h"


#import "UserInfoViewController.h"
#import "SharedManager.h"
#import "Constant.h"

#import "BFPaperButton.h"

#import "MBProgressHUD.h"

@interface LoginViewController ()
{
    MBProgressHUD *HUD;
    id json;
    
    UIView *viewLogin;
    
    UITextField *username, *password;
    
    id jsonMonth;
    id jsonRegion;
}

@end

@implementation LoginViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"Login";
    self.navigationController.navigationBarHidden = true;
    self.view.backgroundColor = UIColorFromRGB(0x478ABE);//[UIColor whiteColor];
    
    [self addLoginView];
    
    /*NSString *myUrlString = URL_GET_CHART_DATA;
     myUrlString = [myUrlString stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding];
     
     NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
     [request setURL:[NSURL URLWithString:myUrlString]];
     
     [request addValue:@"Basic YWRtaW46YWRtaW5AZGV2MTIzNA==" forHTTPHeaderField:@"Authorization"];
     
     [request setHTTPMethod:@"GET"];
     
     [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
     
     dispatch_async(dispatch_get_main_queue(), ^{
     
     json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
     NSLog(@"JSON : %@",json);
     //[self processJson];
     });
     }];*/
    
    NSData *nsdata = [@"admin:admin@dev1234"
                      dataUsingEncoding:NSUTF8StringEncoding];
    
    // Get NSString from NSData object in Base64
    NSString *base64Encoded = [nsdata base64EncodedStringWithOptions:0];
    
    // Print the Base64 encoded string
    NSLog(@"Encoded: %@", base64Encoded);
    
    // Let's go the other way...
    
    // NSData from the Base64 encoded str
    NSData *nsdataFromBase64String = [[NSData alloc]
                                      initWithBase64EncodedString:base64Encoded options:0];
    
    // Decoded NSString from the NSData
    NSString *base64Decoded = [[NSString alloc]
                               initWithData:nsdataFromBase64String encoding:NSUTF8StringEncoding];
    NSLog(@"Decoded: %@", base64Decoded);
    
    //TestFileViewController * myOb = nil;//[TestFileViewController newInstanceNamed:@"Janet"];
}

- (void)getMonthData
{
    NSArray *array = [NSArray arrayWithObjects:@"26-Apr-2015", @"19-Apr-2016", nil];
    NSString *myUrlString = URL_GET_MONTH_DATA;
    
    myUrlString = [myUrlString stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding];
    NSURLResponse *response;
    NSError *error;
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:myUrlString]];
    
    [request setHTTPMethod:@"GET"];
    
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    
    if (error == nil) {
        jsonMonth = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        
        NSArray *arr = [jsonMonth objectForKey:@"resultset"];
        NSLog(@"Month : %@",arr);
        dispatch_async(dispatch_get_main_queue(), ^{
            [[SharedManager sharedManager] setArrayMonth:arr];
        });
    }
    else
    {
        
    }
}

- (void)getRegionData
{
    
    NSString *myUrlString = URL_GET_REGION_DATA;
    
    myUrlString = [myUrlString stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding];
    NSURLResponse *response;
    NSError *error;
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:myUrlString]];
    
    [request setHTTPMethod:@"GET"];
    
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    
    if (error == nil) {
        jsonRegion = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        NSArray *arr = [jsonRegion objectForKey:@"resultset"];
        NSLog(@"Month : %@",arr);
        dispatch_async(dispatch_get_main_queue(), ^{
            [[SharedManager sharedManager] setArrayRegion:arr];
        });
    }
    else
    {
        
    }
}

- (void)addLoginView
{
    
    CGFloat xPadding = (CGRectGetHeight(self.view.frame)*20.5)/100;
    CGFloat yPadding = (CGRectGetHeight(self.view.frame)*4.5)/100;
    CGFloat width = CGRectGetWidth(self.view.frame) - (2*xPadding);
    CGFloat height = 120;//loginViewHeight - (2*yPadding);
    
    viewLogin = [[UIView alloc] initWithFrame:CGRectMake(xPadding, yPadding, width, height)];
    viewLogin.layer.cornerRadius = 10.0;
    viewLogin.backgroundColor = [UIColor clearColor];
    viewLogin.layer.borderWidth = 3.5;
    viewLogin.layer.borderColor = [[UIColor clearColor] CGColor];//[[UIColor colorWithRed:(185.0/255.0) green:(50.0/255.0) blue:(52.0/255.0) alpha:1.0] CGColor];
    viewLogin.center = CGPointMake(CGRectGetMidX(self.view.frame), CGRectGetMidY(self.view.frame));
    viewLogin.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin;
    viewLogin.center = CGPointMake(CGRectGetMidX(self.view.frame), CGRectGetMidY(self.view.frame));
    [self.view addSubview:viewLogin];
    
    xPadding = 10;
    CGFloat xVal = xPadding;
    yPadding = 10;
    CGFloat yVal = yPadding;
    
    CGFloat viewHeight = 45;//(CGRectGetHeight(viewLogin.frame) - (4*yPadding))/3;
    CGFloat viewWidth = CGRectGetWidth(viewLogin.frame) - (2*xPadding);
    
    //width = width - 2*xPadding;
    //height = (CGRectGetHeight(self.view.frame)*6.8)/100;
    
    UIView *usernameView = [[UIView alloc] init];
    usernameView.frame = CGRectMake(xVal, yVal, viewWidth, viewHeight);
    usernameView.layer.borderColor = [[UIColor grayColor] CGColor];
    usernameView.layer.borderWidth = 1.0;
    usernameView.layer.cornerRadius = 5.0;
    usernameView.tag = 101;
    usernameView.backgroundColor = [UIColor whiteColor];
    [viewLogin addSubview:usernameView];
    
    /*CGFloat xPaddingImage = 5;
     CGFloat yPaddingImage = 5;
     
     CGFloat imageViewDim = CGRectGetHeight(usernameView.frame) - (2*yPaddingImage);
     
     UIImageView *imageViewPerson = [[UIImageView alloc] init];
     imageViewPerson.frame = CGRectMake(xPaddingImage, yPaddingImage, imageViewDim, imageViewDim);
     imageViewPerson.backgroundColor = [UIColor clearColor];
     imageViewPerson.image = [UIImage imageNamed:@"username.png"];
     //imageViewPerson.layer.borderWidth = 0.5;
     //imageViewPerson.layer.cornerRadius = 3.0;
     [usernameView addSubview:imageViewPerson];*/
    
    xVal = 5;//xPaddingImage;//CGRectGetMaxX(imageViewPerson.frame) + xPaddingImage;
    yVal = 5;//CGRectGetMinY(imageViewPerson.frame);
    
    CGFloat textWidth = CGRectGetWidth(usernameView.frame) - (2*xVal);//CGRectGetWidth(usernameView.frame) - (3* xPaddingImage) - CGRectGetWidth(imageViewPerson.frame);
    CGFloat textHeight = CGRectGetHeight(usernameView.frame) - (2*yVal);
    //CGFloat fontSize = textHeight - (2*yPaddingImage);
    
    username = [[UITextField alloc] initWithFrame:CGRectMake(xVal, yVal, textWidth, textHeight)];
    username.font = [UIFont fontWithName:@"Segoe UI" size:20];//[UIFont fontWithName:@"HelveticaNeue-Light" size:fontSize];
    username.placeholder = @"Username";
    username.text = @"iostest@netlink.com";
    //username.text = @"iostest1@netlink.com";
    username.borderStyle = UITextBorderStyleRoundedRect;
    username.layer.cornerRadius = 5.0;
    username.keyboardType = UIKeyboardTypeEmailAddress;
    //username.delegate = self;
    //username.userInteractionEnabled = false;
    username.autocorrectionType = UITextAutocorrectionTypeNo;
    username.autocapitalizationType = UITextAutocapitalizationTypeNone;
    username.tag = 31;
    [usernameView addSubview:username];
    
    xVal = CGRectGetMinX(usernameView.frame);
    
    yVal = CGRectGetMaxY(usernameView.frame) + yPadding;
    UIView *passwordView = [[UIView alloc] init];
    passwordView.frame = CGRectMake(xVal, yVal, viewWidth, viewHeight);
    passwordView.layer.borderColor = [[UIColor grayColor] CGColor];
    passwordView.layer.borderWidth = 1.0;
    passwordView.layer.cornerRadius = 5.0;
    passwordView.tag = 102;
    passwordView.backgroundColor = [UIColor whiteColor];
    [viewLogin addSubview:passwordView];
    
    /*UIImageView *imageViewPwd = [[UIImageView alloc] init];
     imageViewPwd.frame = CGRectMake(xPaddingImage, yPaddingImage, imageViewDim, imageViewDim);
     imageViewPwd.backgroundColor = [UIColor whiteColor];
     imageViewPwd.alpha = 1.0;
     //imageViewPwd.layer.borderWidth = 0.5;
     //imageViewPwd.layer.cornerRadius = 3.0;
     imageViewPwd.image = [UIImage imageNamed:@"password.png"];
     [passwordView addSubview:imageViewPwd];*/
    
    xVal = 5;//CGRectGetMaxX(imageViewPwd.frame) + xPaddingImage;
    yVal = 5;//CGRectGetMinY(imageViewPwd.frame);
    
    textWidth = CGRectGetWidth(passwordView.frame) - (2* xVal);
    textHeight = CGRectGetHeight(passwordView.frame) - (2* yVal);
    //CGFloat fontSize = textHeight - (2*yPaddingImage);
    
    password = [[UITextField alloc] initWithFrame:CGRectMake(xVal, yVal, textWidth, textHeight)];
    password.borderStyle = UITextBorderStyleRoundedRect;
    password.secureTextEntry = true;
    password.returnKeyType = UIReturnKeyDone;
    password.font = [UIFont fontWithName:@"Segoe UI" size:20];//[UIFont fontWithName:@"HelveticaNeue-Light" size:fontSize];
    password.placeholder = @"Password";
    password.layer.cornerRadius = 5.0;
    password.text = @"test1234";
    //password.text = @"password4$";
    password.tag = 32;
    //password.userInteractionEnabled = false;
    //password.delegate = self;
    [passwordView addSubview:password];
    
    
    xVal = CGRectGetMinX(passwordView.frame);
    
    yVal = CGRectGetMaxY(passwordView.frame) + yPadding;
    
    /*UIButton *loginButton = [UIButton buttonWithType:UIButtonTypeCustom];
     loginButton.frame = CGRectMake(xVal, yVal, viewWidth, viewHeight);
     [loginButton setTitle:@"Login" forState:UIControlStateNormal];
     [loginButton setBackgroundColor:UIColorFromRGB(0x0F436B)];
     [loginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
     loginButton.titleLabel.font = [UIFont fontWithName:@"Segoe UI" size:20];//[UIFont fontWithName:@"HelveticaNeue-Light" size:20];
     [loginButton addTarget:self action:@selector(loginTapped) forControlEvents:UIControlEventTouchUpInside];
     //loginButton.center = CGPointMake(CGRectGetMidX(loginButton.frame), midYBtn);
     [viewLogin addSubview:loginButton];*/
    
    BFPaperButton *loginButton = [[BFPaperButton alloc] initWithFrame:CGRectMake(xVal, yVal, viewWidth, viewHeight) raised:NO];
    [loginButton setTitle:@"Login" forState:UIControlStateNormal];
    loginButton.backgroundColor = UIColorFromRGB(0x0F436B);  // This is from the included cocoapod "UIColor+BFPaperColors".
    [loginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [loginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    [loginButton addTarget:self action:@selector(loginTapped) forControlEvents:UIControlEventTouchUpInside];
    [viewLogin addSubview:loginButton];
    
    viewLogin.frame = CGRectMake(CGRectGetMinX(viewLogin.frame), CGRectGetMinY(viewLogin.frame), CGRectGetWidth(viewLogin.frame), CGRectGetMaxY(loginButton.frame) + yPadding);
    
    
    UIImageView *imageViewLogo = [UIImageView new];
    imageViewLogo.frame = CGRectMake(0, 0, 350, 53);
    imageViewLogo.image = [UIImage imageNamed:@"tcc.png"];
    imageViewLogo.backgroundColor = UIColorFromRGB(0xFFFFFF);
    imageViewLogo.center = CGPointMake(CGRectGetWidth(self.view.frame)/2, 120);
    [self.view addSubview:imageViewLogo];
}

- (void)loginTapped
{
    [self.view endEditing:true];
    
    if (username.text.length == 0) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@""
                                                        message:@"Please Enter Your Username"
                                                       delegate:nil
                                              cancelButtonTitle:ALERT_BUTTON_TITLE_OK
                                              otherButtonTitles:nil];
        [alert show];
        
        return;
    }
    
    if (password.text.length == 0) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@""
                                                        message:@"Please Enter Your Password"
                                                       delegate:nil
                                              cancelButtonTitle:ALERT_BUTTON_TITLE_OK
                                              otherButtonTitles:nil];
        [alert show];
        
        return;
    }
    
    if ([[SharedManager sharedManager] connected])
    {
        
        NSString *myUrlString = URL_LOGIN;
        
        [self showLoader];
        myUrlString = [myUrlString stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding];
        NSString *params = [NSString stringWithFormat:@"j_username=%@&j_password=%@",username.text,password.text];//@"email=ashish@netsouls.net&password=value2";
        
        NSData *postData = [params dataUsingEncoding:NSASCIIStringEncoding                            allowLossyConversion:YES];
        
        NSString *postLength = [NSString stringWithFormat:@"%lu", (unsigned long)[postData length]];
        
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
        [request setURL:[NSURL URLWithString:myUrlString]];
        
        [request setHTTPMethod:@"POST"];
        [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
        [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
        [request setHTTPBody:postData];
        
        [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
            [self hideLoader];
            NSString *str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            
            NSLog(@"DATA : %@",str);
            
            if ([str containsString:STRING_LOGIN_SUCCESSFUL])
            {
                NSLog(@"User Logged In");
                [self saveLoginDetailsToPlist];
                [self goToUserInfo];
            }
            else
            {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:ALERT_TITLE_LOGIN_ERROR
                                                                message:ALERT_MESSAGE_LOGIN_UNSUCCESSFUL
                                                               delegate:nil
                                                      cancelButtonTitle:ALERT_BUTTON_TITLE_OK
                                                      otherButtonTitles:nil];
                [alert show];
            }
        }];
    }
    else
    {
        NSArray *arr = [[SharedManager sharedManager] getArrayLogin];
        if (arr.count > 0) {
            NSDictionary  *dict = [NSDictionary dictionaryWithObjects:@[username.text,password.text] forKeys:@[@"username", @"password"]];
            
            if ([arr containsObject:dict])
            {
                [self goToUserInfo];
            }
            else
            {
                //wrong credentials
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:ALERT_TITLE_LOGIN_ERROR
                                                                message:@"Username OR Password you have entered is wrong. Please try again."
                                                               delegate:nil
                                                      cancelButtonTitle:ALERT_BUTTON_TITLE_OK
                                                      otherButtonTitles:nil];
                [alert show];
                
            }
        }
        else
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:ALERT_TITLE_LOGIN_ERROR
                                                            message:@"Please connect to Internet."
                                                           delegate:nil
                                                  cancelButtonTitle:ALERT_BUTTON_TITLE_OK
                                                  otherButtonTitles:nil];
            [alert show];
            
        }
    }
}

- (void)goToUserInfo
{
    [[SharedManager sharedManager] setLoginId:username.text];
    
    UserInfoViewController *u = [UserInfoViewController new];
    [self.navigationController pushViewController:u animated:true];
    
    dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [self getMonthData];
        [self getRegionData];
    });
    
    //[[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_GO_TO_LANDING_PAGE object:self];
}

- (void)saveLoginDetailsToPlist
{
    NSMutableArray *arrayLoginDetails = [[NSMutableArray alloc] initWithArray:[[SharedManager sharedManager] getArrayLogin]];//[[[SharedManager sharedManager] getArrayLogin] mutableCopy];
    //NSMutableArray *array = [NSMutableArray new];
    
    NSDictionary  *dict = [NSDictionary dictionaryWithObjects:@[username.text,password.text] forKeys:@[@"username", @"password"]];
    
    if (![arrayLoginDetails containsObject:dict])
    {
        [arrayLoginDetails addObject:dict];
    }
    
    [[SharedManager sharedManager] saveData:arrayLoginDetails toPlist:NAME_PLIST_LOGIN];
}



- (void)showLoader
{
    HUD = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:HUD];
    
    //HUD.delegate = self;
    HUD.labelText = @"Loading";
    
    [HUD show:YES];
}

- (void)hideLoader
{
    [HUD hide:true];
    [HUD removeFromSuperview];
    HUD = nil;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
