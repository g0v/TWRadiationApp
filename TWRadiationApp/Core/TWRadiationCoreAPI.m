//
//  TWRadiationCoreAPI.m
//  TWRadiationCoreAPI
//
//  Created by Kent Huang on 2014/4/28.
//  Copyright (c) 2014年 g0v.tw. All rights reserved.
//

#import "TWRadiationCoreAPI.h"

@implementation TWRadiationCoreAPI

#pragma mark Init

- (id)init {
    if ((self = [super init])) {
        // TODO: Do something when init
        isLogin = NO;
    }
    return self;
}

#pragma mark Api for User Account Information
- (BOOL)isLogin
{
    return isLogin;
}

- (BOOL)isActiveAccount
{
    return NO;
}

- (NSDictionary *)loginWithAccount:(NSString *)account passwd:(NSString *)passwd {
    NSDictionary *userInfo = @{@"Name":account};
    return userInfo;
}

- (BOOL)sendAccountInformationForRegist:(NSString *)account passwd:(NSString *)passwd deviceType:(NSString *)deviceType
{
    return NO;
}

- (NSDictionary *)getUsableDeviceList
{
    return nil;
}

#pragma mark Api for Geography Information
- (NSDictionary *)getLocationInfo
{
    return nil;
}
- (NSString *)getCurrentAddress
{
    return nil;
}
@end