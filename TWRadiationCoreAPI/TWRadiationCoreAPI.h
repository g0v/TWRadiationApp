//
//  TWRadiationCoreAPI.h
//  TWRadiationCoreAPI
//
//  Created by Kent Huang on 2014/4/28.
//  Copyright (c) 2014年 g0v.tw. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TWRadiationCoreAPI : NSObject
{
    BOOL isLogin;
}

- (BOOL) isLogin;
- (NSDictionary*) loginWithAccount:(NSString*) account passwd:(NSString*) passwd;
- (NSDictionary*) getLocationInfo;

@end
