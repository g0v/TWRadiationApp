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
}

- (IBAction)facebookLogin:(id)sender {
    
    // If the session state is any of the two "open" states when the button is clicked
    if (FBSession.activeSession.state == FBSessionStateOpen
        || FBSession.activeSession.state == FBSessionStateOpenTokenExtended) {
        
        // Close the session and remove the access token from the cache
        // The session state handler (in the app delegate) will be called automatically
        [FBSession.activeSession closeAndClearTokenInformation];
        
        // If the session state is not any of the two "open" states when the button is clicked
    } else {
        // Open a session showing the user the login UI
        // You must ALWAYS ask for public_profile permissions when opening a session
        [FBSession openActiveSessionWithReadPermissions:@[@"public_profile"]
                                           allowLoginUI:YES
                                      completionHandler:
         ^(FBSession *session, FBSessionState state, NSError *error) {
             
             // Retrieve the app delegate
             AppDelegate* appDelegate = [UIApplication sharedApplication].delegate;
             // Call the app delegate's sessionStateChanged:state:error method to handle session state changes
             [appDelegate sessionStateChanged:session state:state error:error];
         }];
    }
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
            } else {
                // The login failed. Check error to see why.
                UIAlertView* loginAlert = [[UIAlertView alloc] initWithTitle:@"Error" message:[[error userInfo] objectForKey:@"error"] delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
                [loginAlert show];
            }
    }];
}

@end
