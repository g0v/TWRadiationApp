//
//  AppDelegate.h
//  TWRadiationApp
//
//  Created by Kent Huang on 2014/4/19.
//  Copyright (c) 2014年 g0v.tw. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TWRadiationCoreAPI.h"
#import <FacebookSDK/FacebookSDK.h>

@protocol userLoginCallback <NSObject>
-(void) fbLogin:(NSString*) displayName shortname:(NSString*)shortName andID:(NSString*)userid;
@end

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) id<userLoginCallback> _delegate;
@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) TWRadiationCoreAPI *coreApi;

- (void)sessionStateChanged:(FBSession *)session state:(FBSessionState) state error:(NSError *)error;
@end
