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

- (BOOL)isLogin
{
    return isLogin;
}

- (NSDictionary *)loginWithAccount:(NSString *)account passwd:(NSString *)passwd {
    NSDictionary *userInfo = @{@"Name":account};
    return userInfo;
}

- (NSDictionary *)getLocationInfo
{
    return nil;
}

@end