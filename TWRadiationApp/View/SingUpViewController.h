//
//  SingUpViewController.h
//  TWRadiationApp
//
//  Created by Kent Huang on 2014/8/24.
//  Copyright (c) 2014年 g0v.tw. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

@interface SingUpViewController : UIViewController <UIAlertViewDelegate>
{
    TWRadiationCoreAPI   *coreApi;
    IBOutlet UITextField *userAccount;
    IBOutlet UITextField *userPasswd;
    IBOutlet UITextField *userEmail;
}

- (IBAction)pushSubmitButton:(id)sender;

@end
