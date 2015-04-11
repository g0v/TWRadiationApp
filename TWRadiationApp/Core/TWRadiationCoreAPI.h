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
#import "Device.h"
#import <Parse/Parse.h>
#import <ParseFacebookUtils/PFFacebookUtils.h>

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

#define USER_ACCOUNT_PLIST          @"account.plist"

#define LOGIN_TYPE_NONE             0
#define LOGIN_TYPE_EMAIL            1
#define LOGIN_TYPE_FACEBOOK         2
#define LOGIN_TYPE_TWITTER          3

typedef enum {
    NONE,
    EMAIL,
    FACEBOOK,
    TWITTER
} LOGIN_TYPE;

typedef enum {
    ground = 6,
    meter = 7
} HighType;

typedef enum {
    indoor = 8,
    outdoor = 9
} AreaType;

typedef enum {
    people = 16,
    expert = 15
} PositionType;

@interface TWRadiationCoreAPI : NSObject
{
    BOOL        isLogin;
    LOGIN_TYPE  loginType;
    PFUser*     currentUser;
    NSString*   currentUserName;
    
    
    NSDictionary *categoryTypeMapping;
}

- (BOOL) isLogin;
- (BOOL) isActiveAccount;
- (NSString*) getCurrentUserName;

- (BOOL) sendAccountInformationForRegist:(NSString*) account passwd:(NSString*) passwd deviceType:(NSString*) deviceType;
- (NSDictionary*) loginWithAccount:(NSString*) account passwd:(NSString*) passwd;
- (void) logout;
- (BOOL) signUpWithUsername:(NSString*) username password:(NSString*)password email:(NSString*)email error:(NSError **)error;
- (NSDictionary*) getUsableDeviceList;

- (void)didLoginWithEmail:(PFUser*)user;
- (void)didLoginWithFacebook:(PFUser*)user;
- (void)didLoginWithTwitter:(PFUser*)user;

- (NSArray*) getLocationInfoList;
- (NSString*) getCurrentAddress;
- (NSArray*) getCategorieList;
- (NSArray*) getDeviceList;
- (NSDictionary*) getCurrentTime;

- (id) submitLocationInfoWithValue:(NSString*) microSievert
                        locationName:(NSString*) locationName
                            location:(CLLocation*) location
                                high:(HighType) high
                                area:(AreaType) area
                              device:(Device*) device
                            position:(PositionType) position
                               photo:(NSData*) photo;

- (NSString *) makeRestApiUrl:(NSString*)url task:(NSString*)action;
- (id) getUshahidiRestApi:(NSString*)url task:(NSString *)action parameters:(NSDictionary*)params error:(NSError **)error;
- (id) postUshahidiRestApi:(NSString*)url task:(NSString *)action parameters:(NSDictionary *)params error:(NSError **)error;
- (id) getPresistentDataByName:(NSString*) plistName;
- (BOOL) updatePresistentDataByName:(NSString*) plistName presistentData:(NSMutableDictionary*) presistentData;
@end
