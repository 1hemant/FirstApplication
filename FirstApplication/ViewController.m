//
//  ViewController.m
//  FirstApplication
//
//  Created by Hemant Rathore on 28/09/15.
//  Copyright © 2015 Hemant Rathore. All rights reserved.
//

#import "ViewController.h"
#import "SecondViewController.h"


@interface ViewController ()<UITextFieldDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
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
    imageHome.frame = CGRectMake(20, 100, 400, 200);
    imageHome.image = [UIImage imageNamed:@"App.jpg"];
    imageHome.center = CGPointMake(CGRectGetWidth(self.view.frame)/2, 150);
    [self.view addSubview:imageHome];
    
}


    //create label
- (void)addLabel{
    
    UILabel *myLabel = [[UILabel alloc]initWithFrame:CGRectMake(100, 300, 200, 40)];
    [myLabel setBackgroundColor:[UIColor greenColor]];
    [myLabel setText:@"Enter login information"];
    [self.view addSubview:myLabel];
}

     //create Text field
- (void)addTextField{
    myTextField = [[UITextField alloc] initWithFrame:(CGRectMake(100, 350, 200, 40))];
    [myTextField setBackgroundColor:[UIColor clearColor]];
    myTextField.placeholder = @"User Name";
    [myTextField setBorderStyle:UITextBorderStyleLine];
    [myTextField clearsOnBeginEditing];
    [self.view addSubview:myTextField];
}



- (void)addPasswordField{
    //create password field
    myPasswordField = [[UITextField alloc] initWithFrame:CGRectMake(100, 400, 200, 40)];
    myPasswordField.secureTextEntry= YES;
    [myPasswordField setBackgroundColor:[UIColor clearColor]];
    myPasswordField.placeholder = @"User Password";
    [myPasswordField setBorderStyle:UITextBorderStyleLine];
    [myPasswordField clearsOnBeginEditing];
    [self.view addSubview:myPasswordField];

}

    //create login button

- (void)addLoginButton{
    UIButton *submitButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [submitButton setTitle:@"Login" forState:UIControlStateNormal];
    submitButton.frame = CGRectMake(100, 450, 200, 40);
    [submitButton setBackgroundColor:[UIColor redColor]];
    [submitButton addTarget:self action:@selector(loginButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:submitButton];
    
}

    //login button click action
- (void)loginButtonAction{
    [self.view endEditing:true];
    /*if ([myTextField.text.length == 0] || [myPasswordField.text.length == 0]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@""
                                                        message:@"Please Enter Your Username"
                                                       delegate:nil
                                              cancelButtonTitle:ALERT_BUTTON_TITLE_OK
                                              otherButtonTitles:nil];
        [alert show];
        
        return;
    }*/   //Use above commneted code for upgrade

    //check password and user name string.
    if ([myTextField.text isEqualToString:@"admin"] && [myPasswordField.text isEqualToString:@"pwd"]) {
        //open another page if the credentials are correct.*/
        SecondViewController *s = [[SecondViewController alloc] init];
        [self presentViewController:s animated:true completion:nil];

    } else {
        //show an error message.
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Error"
                                                                                 message:@"UserName/password is incorrect!"
                                                                          preferredStyle:UIAlertControllerStyleAlert];
        //We add buttons to the alert controller by creating UIAlertActions:
        UIAlertAction *actionOk = [UIAlertAction actionWithTitle:@"Ok"
                                                           style:UIAlertActionStyleDefault
                                                         handler:nil]; //You can use a block here to handle a press on this button
        [alertController addAction:actionOk];
        [self presentViewController:alertController animated:YES completion:nil];
    }
    //myTextField.text = @"";
    //myPasswordField.text = @"";
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
