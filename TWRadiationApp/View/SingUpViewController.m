//
//  SingUpViewController.m
//  TWRadiationApp
//
//  Created by Kent Huang on 2014/8/24.
//  Copyright (c) 2014年 g0v.tw. All rights reserved.
//

#import "SingUpViewController.h"

@interface SingUpViewController ()

@end

@implementation SingUpViewController

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

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

// TODO:
// Change to use ansynchronous function when user sign up
- (void)pushSubmitButton:(id)sender
{
    BOOL signUpResult;
    NSError *error;
    signUpResult = [coreApi signUpWithUsername:userAccount.text password:userPasswd.text email:userEmail.text error:&error];
    if (signUpResult) {
        [self.navigationController popViewControllerAnimated:YES];
    }
    else {
        UIAlertView *signUpAlert = [[UIAlertView alloc] initWithTitle:@"Error" message:[[error userInfo] objectForKey:@"error"] delegate:self cancelButtonTitle:@"確認" otherButtonTitles: nil];
        [signUpAlert show];
    }
}


@end
