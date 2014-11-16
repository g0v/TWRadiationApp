//
//  LoginViewController.m
//  TWRadiationApp
//
//  Created by Charles Lu on 14/6/11.
//  Copyright (c) 2014年 g0v.tw. All rights reserved.
//

#import "LoginViewController.h"
#import "MapViewController.h"
#import "AppDelegate.h"

@interface LoginViewController ()
@property (nonatomic) IBOutlet UIBarButtonItem* revealButtonItem;

@end

@implementation LoginViewController
@synthesize userPassword, userID;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    if (coreApi == nil) {
        AppDelegate *appDelegate = [[UIApplication sharedApplication]delegate];
        coreApi = [appDelegate coreApi];
    }
    
    [self.revealButtonItem setAction: @selector(revealToggle:)];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [userAccount setText:userID];
    [userPasswd setText:userPassword];
}

- (IBAction)emailLogin:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (IBAction)twitterLogin:(id)sender {
    [PFTwitterUtils logInWithBlock:^(PFUser *user, NSError *error) {
        if (!user) {
            NSLog(@"Uh oh. The user cancelled the Twitter login.");
            return;
        } else if (user.isNew) {
            NSLog(@"User signed up and logged in with Twitter!");
            [coreApi didLoginWithTwitter:user];
        } else {
            NSLog(@"User logged in with Twitter!");
            [coreApi didLoginWithTwitter:user];
        }     
    }];
}

- (IBAction)facebookLogin:(id)sender {
    
    [PFFacebookUtils logInWithPermissions:@[@"publish_actions"] block:^(PFUser *user, NSError *error) {
        if (!user) {
            NSLog(@"Uh oh. The user cancelled the Facebook login.");
        } else if (user.isNew) {
            NSLog(@"User signed up and logged in through Facebook!");
            [coreApi didLoginWithFacebook:user];
        } else {
            NSLog(@"User logged in through Facebook!");
            [coreApi didLoginWithFacebook:user];
        }
    }];
}

#pragma mark - UITextField Delegate
// Hidden the keyboard after user push return button
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

#pragma mark - check user login
- (IBAction)pushLoginButton:(id)sender
{

    [PFUser logInWithUsernameInBackground:userAccount.text password:userPasswd.text
        block:^(PFUser *user, NSError *error) {
            if (user) {
                // Do stuff after successful login.
                NSLog(@"Login succussfully");
                [coreApi didLoginWithEmail:user];
            } else {
                // The login failed. Check error to see why.
                UIAlertView* loginAlert = [[UIAlertView alloc] initWithTitle:@"Error" message:[[error userInfo] objectForKey:@"error"] delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
                [loginAlert show];
            }
    }];
}

@end
