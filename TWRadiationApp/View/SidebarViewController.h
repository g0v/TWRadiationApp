//
//  SidebarViewController.h
//  TWRadiationApp
//
//  Created by Kent Huang on 2014/4/19.
//  Copyright (c) 2014年 g0v.tw. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

@interface SidebarViewController : UITableViewController <userLoginCallback>
{
    NSArray *menuItems;
    IBOutlet UITableView *tableview;
}

@end
