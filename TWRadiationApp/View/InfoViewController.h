//
//  InfoViewController.h
//  TWRadiationApp
//
//  Created by Kent Huang on 2014/4/19.
//  Copyright (c) 2014年 g0v.tw. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "DetailInfoViewController.h"

@interface InfoViewController : UITableViewController
{
    TWRadiationCoreAPI   *coreApi;
    NSArray *locationInfoList;
}

@end
