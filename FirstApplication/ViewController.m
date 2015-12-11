//
//  ViewController.m
//  FirstApplication
//
//  Created by Hemant Rathore on 28/09/15.
//  Copyright © 2015 Hemant Rathore. All rights reserved.
//

#import "ViewController.h"
#import "SecondViewController.h"
#import "SharedManager.h"
#import "MBProgressHUD.h"
#import "Constant.h"

@interface ViewController ()<UITextFieldDelegate>
{
    MBProgressHUD *HUD;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:0.063f green:0.537f blue:0.745f alpha:1.00f];
    // Do any additional setup after loading the view, typically from a nib.
    [self addHomeImage];
    [self addLabel];
    [self addTextField];
    [self addPasswordField];
    [self addLoginButton]; //call addLoginButtonmethod on view load
    
    }

    //insert image
- (void)addHomeImage{
    UIImageView *imageHome = [[UIImageView alloc]init];
    imageHome.frame = CGRectMake(20, 200, 600, 300);
    imageHome.image = [UIImage imageNamed:@"App.jpg"];
    imageHome.center = CGPointMake(CGRectGetWidth(self.view.frame)/2, 200);
    [self.view addSubview:imageHome];
    
}


    //create label
- (void)addLabel{
    
    UILabel *myLabel = [[UILabel alloc]initWithFrame:CGRectMake(300, 400, 200, 40)];
    [myLabel setBackgroundColor:[UIColor greenColor]];
    [myLabel setText:@"Enter login information"];
    [self.view addSubview:myLabel];
}

     //create Text field
- (void)addTextField{
    userName = [[UITextField alloc] initWithFrame:(CGRectMake(300, 450, 200, 40))];
    [userName setBackgroundColor:[UIColor clearColor]];
    userName.text = @"iostest@netlink.com";
    userName.placeholder = @"User Name";
    [userName setBorderStyle:UITextBorderStyleLine];
    [userName clearsOnBeginEditing];
    [self.view addSubview:userName];
}



- (void)addPasswordField{
    //create password field
    password = [[UITextField alloc] initWithFrame:CGRectMake(300, 500, 200, 40)];
    password.secureTextEntry= YES;
    [password setBackgroundColor:[UIColor clearColor]];
    password.text = @"test1234";
    password.placeholder = @"User Password";
    [password setBorderStyle:UITextBorderStyleLine];
    [password clearsOnBeginEditing];
    [self.view addSubview:password];

}

    //create login button

- (void)addLoginButton{
    UIButton *submitButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [submitButton setTitle:@"Login" forState:UIControlStateNormal];
    submitButton.frame = CGRectMake(300, 550, 200, 40);
    [submitButton setBackgroundColor:[UIColor redColor]];
    [submitButton addTarget:self action:@selector(loginTapped) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:submitButton];
    
}


    //login button click action
- (void)loginTapped{
    {
        [self.view endEditing:true];
        
        if ((userName.text.length == 0) || (password.text.length == 0)) {
            
            UIAlertController * alert=   [UIAlertController
                                          alertControllerWithTitle:@""
                                          message:@"Enter User Credentials"
                                          preferredStyle:UIAlertControllerStyleAlert];
            
            [self presentViewController:alert animated:YES completion:nil];
            
            return;
        }
        
        
        if ([[SharedManager sharedManager] connected])
        {
            
            NSString *myUrlString = URL_LOGIN;
            
          //  [self showLoader];
            myUrlString = [myUrlString stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding];
            NSString *params = [NSString stringWithFormat:@"j_username=%@&j_password=%@",userName.text,password.text];//@"email=ashish@netsouls.net&password=value2";
            
            NSData *postData = [params dataUsingEncoding:NSASCIIStringEncoding                            allowLossyConversion:YES];
            
            NSString *postLength = [NSString stringWithFormat:@"%lu", (unsigned long)[postData length]];
            
            NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
            [request setURL:[NSURL URLWithString:myUrlString]];
            
            [request setHTTPMethod:@"POST"];
            [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
            [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
            [request setHTTPBody:postData];
            
            [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
             //   [self hideLoader];
                NSString *str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                
                NSLog(@"DATA : %@",str);
                
                if ([str containsString:STRING_LOGIN_SUCCESSFUL])
                {
                    NSLog(@"User Logged In");
                 //   [self saveLoginDetailsToPlist];
                 //   [self goToUserInfo];
                    SecondViewController *s = [[SecondViewController alloc] init];
                    [self presentViewController:s animated:true completion:nil];

                }
                else
                {
                    
                    
                    UIAlertController * alert=   [UIAlertController
                                                  alertControllerWithTitle:ALERT_TITLE_LOGIN_ERROR
                                                  message:ALERT_MESSAGE_LOGIN_UNSUCCESSFUL
                                                  preferredStyle:UIAlertControllerStyleAlert];
                    
                    [self presentViewController:alert animated:YES completion:nil];
                    
                    
                }
            }];
        }
        else
        {
            NSArray *arr = [[SharedManager sharedManager] getArrayLogin];
            if (arr.count > 0) {
                NSDictionary  *dict = [NSDictionary dictionaryWithObjects:@[userName.text,password.text] forKeys:@[@"username", @"password"]];
                
                if ([arr containsObject:dict])
                {
              //      [self goToUserInfo];
                }
                else
                {
                    //wrong credentials
                    UIAlertController * alert=   [UIAlertController
                                                  alertControllerWithTitle:ALERT_TITLE_LOGIN_ERROR
                                                  message:@"Username OR Password you have entered is wrong. Please try again."
                                                  preferredStyle:UIAlertControllerStyleAlert];
                    
                    [self presentViewController:alert animated:YES completion:nil];
                    
                }
            }
            else
            {
                UIAlertController * alert=   [UIAlertController
                                              alertControllerWithTitle:ALERT_TITLE_LOGIN_ERROR
                                              message:@"Please connect to internet."
                                              preferredStyle:UIAlertControllerStyleAlert];
                
                [self presentViewController:alert animated:YES completion:nil];
                
            }
        }
    }
}

   /* - (void)goToUserInfo
    {
        [[SharedManager sharedManager] setLoginId:userName.text];
        
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
    }*/
/*
    - (void)showLoader
    {
        HUD = [[MBProgre ssHUD alloc] initWithView:self.view];
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
*/

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end


