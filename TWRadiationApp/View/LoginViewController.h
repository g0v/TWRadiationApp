//
//  LoginViewController.h
//  TWRadiationApp
//
//  Created by Charles Lu on 14/6/11.
//  Copyright (c) 2014年 g0v.tw. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FacebookSDK/FacebookSDK.h>
#import <Social/Social.h>
#import "AppDelegate.h"
#import <Parse/Parse.h>

@interface LoginViewController : UIViewController </*FBLoginViewDelegate,*/UITextFieldDelegate, UIAlertViewDelegate>
{
    TWRadiationCoreAPI   *coreApi;
    IBOutlet UITextField *userAccount;
    IBOutlet UITextField *userPasswd;
    IBOutlet UIButton    *loginButton;
}

@property (nonatomic, strong) NSString *userID;
@property (nonatomic, strong) NSString *userPassword;


- (IBAction)pushLoginButton:(id)sender;
//- (IBAction)revealToggle:(id)sender;
@end
