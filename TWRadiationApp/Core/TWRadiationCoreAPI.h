//
//  TWRadiationCoreAPI.h
//  TWRadiationCoreAPI
//
//  Created by Kent Huang on 2014/4/28.
//  Copyright (c) 2014年 g0v.tw. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

#define RADIATION_SERVER_REST_RUL   @""

@interface TWRadiationCoreAPI : NSObject
{
    BOOL isLogin;
}

- (BOOL) isLogin;
- (BOOL) isActiveAccount;

- (BOOL) sendAccountInformationForRegist:(NSString*) account passwd:(NSString*) passwd deviceType:(NSString*) deviceType;
- (NSDictionary *) loginWithAccount:(NSString*) account passwd:(NSString*) passwd;
- (NSDictionary *) getUsableDeviceList;

- (NSDictionary *) getLocationInfo;
- (NSString *) getCurrentAddress;

@end
