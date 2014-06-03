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

#pragma mark Generate REST API URL
- (NSString *)makeRestApiUrl:(NSString*)url task:(NSString *)action
{
    NSString *restApiUrl = nil;
    if (url != nil && action != nil) {
        restApiUrl = [[NSString alloc] initWithFormat:@"%@%@%@",url,REST_API_CMD, action];
    }
    return restApiUrl;
}

/*
 AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
 AFHTTPRequestOperation *req = [manager GET:requestUrl parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject){
 NSLog(@"JSON: %@", responseObject);
 } failure:^(AFHTTPRequestOperation *operation, NSError *error){
 NSLog(@"Error: %@", error);
 }];
 [req start];
 [req waitUntilFinished];
 */

- (id) getUshahidiRestApi:(NSString*)url task:(NSString *)action parameters:(NSArray *)params error:(NSError **)error
{
    NSObject            *jsonObj    = nil;
    NSHTTPURLResponse   *response   = nil;
    NSString            *requestUrl = [self makeRestApiUrl:url task:action];
    NSURLRequest        *request    = nil;
    NSData              *respoundData = nil;
    
    if (requestUrl) {
        requestUrl = [requestUrl stringByAppendingString:@"&limit=9999"];
        request = [NSURLRequest requestWithURL:[NSURL URLWithString:requestUrl]];
        respoundData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:error];
        if (respoundData) {
            jsonObj = [NSJSONSerialization JSONObjectWithData:respoundData options:NSJSONReadingMutableContainers error:error];
        }
        if (*error) {
            jsonObj = nil;
        }
    }
    else {
        *error = [NSError errorWithDomain:@"Invalid API URL" code:NSURLErrorBadURL userInfo:nil];
    }
    return jsonObj;
}

- (void) httpRequestSuccess: (AFHTTPRequestOperation *)operation object:(id) responseObject
{

}

- (void) httpRequestFailure: (AFHTTPRequestOperation *)operation error:(NSError*) error
{
    
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

- (id) getMediaFromUshahidiMediaObj:(id)mediaObj key:(NSString*)key
{
    id result = [NSNull null];
    if ([mediaObj isKindOfClass:[NSArray class]] &&
        [mediaObj count] > 0 &&
        [[mediaObj objectAtIndex:0] objectForKey:key] != nil) {
        result = [[mediaObj objectAtIndex:0] objectForKey:key];
    }
    return result;
}

- (NSArray*)parseUshahidiIncidentsJson:(id) jsonObj
{
    NSMutableArray *parsedList = nil;
    NSArray        *incidentsList = nil;
    if (jsonObj &&
        [jsonObj objectForKey:@"payload"] &&
        [[jsonObj objectForKey:@"payload"] objectForKey:@"incidents"]) {
        incidentsList = [[jsonObj objectForKey:@"payload"] objectForKey:@"incidents"];
        parsedList = [[NSMutableArray alloc] init];
        for (int i = 0; i < [incidentsList count]; i++) {
            id obj = [incidentsList objectAtIndex:i];
            id objInc = [[incidentsList objectAtIndex:i] objectForKey:@"incident"];
            NSMutableDictionary *locationInfo = [[NSMutableDictionary alloc] init];
            // Get location infromation
            [locationInfo setObject:[objInc objectForKey:@"locationname"] forKey:@"locationName"];
            [locationInfo setObject:[objInc objectForKey:@"locationlatitude"] forKey:@"locationLatitude"];
            [locationInfo setObject:[objInc objectForKey:@"locationlongitude"] forKey:@"locationLongitude"];
            [locationInfo setObject:[objInc objectForKey:@"incidenttitle"] forKey:@"milliSieverts"];
            
            // Get image
            [locationInfo setObject:[self getMediaFromUshahidiMediaObj:[obj objectForKey:@"media"] key:@"link_url"] forKey:@"imageUrl"];
            [locationInfo setObject:[self getMediaFromUshahidiMediaObj:[obj objectForKey:@"media"] key:@"thumb_url"] forKey:@"thumbUrl"];
            
            [parsedList addObject:locationInfo];
        }
    }
    return parsedList;
}

- (NSArray*)parseUshahidiJson:(NSString*) task jsonObj:(id) jsonObj
{
    if ([task isEqualToString:TASK_INCIDENTS]) {
        return [self parseUshahidiIncidentsJson:jsonObj];
    }
    return nil;
}
- (NSArray*)getLocationInfoList
{
    NSError *error              = nil;
    NSArray *locationInfoList   = nil;
    id      jsonObj             = nil;
    jsonObj = [self getUshahidiRestApi:RADIATION_SERVER_REST_RUL task:TASK_INCIDENTS parameters:nil error:&error];
    if (jsonObj == nil) {
        NSLog(@"%@",error.description);
    }
    else {
        locationInfoList = [self parseUshahidiJson:TASK_INCIDENTS jsonObj:jsonObj];
    }
    return locationInfoList;
}

- (NSString *)getCurrentAddress
{
    return nil;
}
@end