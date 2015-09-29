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
    
    [self addLabel];
    [self addTextField];
    [self addPasswordField];
    [self addLoginButton]; //call addLoginButtonmethod on view load
    }

    //create label
- (void)addLabel{
    
    UILabel *myLabel = [[UILabel alloc]initWithFrame:CGRectMake(100, 50, 200, 40)];
    [myLabel setBackgroundColor:[UIColor greenColor]];
    [myLabel setText:@"Enter login information"];
    [self.view addSubview:myLabel];
}

     //create Text field
- (void)addTextField{
    myTextField = [[UITextField alloc] initWithFrame:(CGRectMake(100, 100, 200, 40))];
    [myTextField setBackgroundColor:[UIColor clearColor]];
    myTextField.placeholder = @"User Name";
    [myTextField setBorderStyle:UITextBorderStyleLine];
    [myTextField clearsOnBeginEditing];
    [self.view addSubview:myTextField];
}



- (void)addPasswordField{
    //create password field
    myPasswordField = [[UITextField alloc] initWithFrame:CGRectMake(100, 150, 200, 40)];
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
    submitButton.frame = CGRectMake(100, 200, 200, 40);
    [submitButton setBackgroundColor:[UIColor redColor]];
    [submitButton addTarget:self action:@selector(loginButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:submitButton];
    
}

    //login button click action
- (void)loginButtonAction{
    //check password and user name string.
    /*if ([myTextField.text isEqualToString:@"admin"] && [myPasswordField.text isEqualToString:@"pwd"]) {
        //open another page if the credentials are correct.*/
        SecondViewController *s = [[SecondViewController alloc] init];
        [self presentViewController:s animated:true completion:nil];/*

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
    }*/
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
