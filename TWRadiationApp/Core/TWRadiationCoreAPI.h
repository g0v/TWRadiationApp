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
#define RADIATION_DEV_REST_RUL      @"http://u273.stark.tw/api"

#define HIGHT_TYPE                  @"1"
#define AREA_TYPE                   @"2"
#define DEVICE_TYPE                 @"3"
#define POSITION_TYPE               @"14"

@interface TWRadiationCoreAPI : NSObject
{
    BOOL isLogin;
    NSDictionary *categoryTypeMapping;
}

- (BOOL) isLogin;
- (BOOL) isActiveAccount;

- (BOOL) sendAccountInformationForRegist:(NSString*) account passwd:(NSString*) passwd deviceType:(NSString*) deviceType;
- (NSDictionary*) loginWithAccount:(NSString*) account passwd:(NSString*) passwd;
- (NSDictionary*) getUsableDeviceList;

- (NSArray*) getLocationInfoList;
- (NSString*) getCurrentAddress;
- (NSArray*) getCategorieList;
- (NSArray*) getDeviceList;

- (id) submitLocationInfoWithValue:(NSString*) microSievert
                        locationName:(NSString*) locationName
                            location:(CLLocation*) location
                               hight:(NSString*) hight
                                area:(NSString*) area
                              device:(NSString*) device
                            position:(NSString*) position
                               photo:(NSData*) photo;

- (NSString *) makeRestApiUrl:(NSString*)url task:(NSString*)action;
- (id) getUshahidiRestApi:(NSString*)url task:(NSString *)action parameters:(NSDictionary*)params error:(NSError **)error;
- (id) postUshahidiRestApi:(NSString*)url task:(NSString *)action parameters:(NSDictionary *)params error:(NSError **)error;
@end
