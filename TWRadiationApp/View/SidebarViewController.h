//
//  SidebarViewController.h
//  TWRadiationApp
//
//  Created by Kent Huang on 2014/4/19.
//  Copyright (c) 2014年 g0v.tw. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "SWRevealViewController.h"
#import "TWRadiationCoreAPI.h"

#define LoginMenuItemList   @[@"empty", @"login", @"upload"]
#define LogoutMenuItemList  @[@"title", @"logout", @"upload"]

@interface SidebarViewController : UIViewController <userLoginCallback, UITableViewDelegate, UITableViewDataSource>
{
    TWRadiationCoreAPI *coreApi;
    BOOL                shouldUpdateMenu;
}

@end
