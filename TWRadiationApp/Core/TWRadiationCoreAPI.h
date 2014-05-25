//
//  TWRadiationCoreAPI.h
//  TWRadiationCoreAPI
//
//  Created by Kent Huang on 2014/4/28.
//  Copyright (c) 2014年 g0v.tw. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import "AFNetworking.h"

#define TASK_INVALID                @"invalid"
#define TASK_INCIDENTS              @"incidents"
#define TASK_SUBMIT                 @"report"
#define TASK_CATEGORIES             @"categories"
#define REST_API_CMD                @"?task="
#define RADIATION_SERVER_REST_RUL   @"http://www.knownuke.tw/map/index.php/api"

@interface TWRadiationCoreAPI : NSObject
{
    BOOL isLogin;
}

- (BOOL) isLogin;
- (BOOL) isActiveAccount;

- (BOOL) sendAccountInformationForRegist:(NSString*) account passwd:(NSString*) passwd deviceType:(NSString*) deviceType;
- (NSDictionary *) loginWithAccount:(NSString*) account passwd:(NSString*) passwd;
- (NSDictionary *) getUsableDeviceList;

- (NSArray*) getLocationInfoList;
- (NSString *) getCurrentAddress;


- (NSString *) makeRestApiUrl:(NSString*)url task:(NSString*)action;
- (id) getUshahidiRestApi:(NSString*)url task:(NSString *)action parameters:(NSArray *)params error:(NSError **)error;

@end
