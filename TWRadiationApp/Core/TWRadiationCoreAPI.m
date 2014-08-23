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
        categoryTypeMapping = @{@"6": HIGHT_TYPE,
                                @"7": HIGHT_TYPE,
                                @"8": AREA_TYPE,
                                @"9": AREA_TYPE,
                                @"15": POSITION_TYPE,
                                @"16": POSITION_TYPE};
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

- (NSString*)generatePostRequestBodyFromParams: (NSDictionary*) params
{
    NSArray *allKeys = [params allKeys];
    NSString *requestBody = @"";
    for (id key in allKeys) {
        if ([allKeys lastObject] == key) {
            requestBody = [requestBody stringByAppendingFormat:@"%@=%@",key,[params objectForKey:key]];
        }
        else {
            requestBody = [requestBody stringByAppendingFormat:@"%@=%@&",key,[params objectForKey:key]];
        }
    }
    return requestBody;
}

- (id) postUshahidiRestApi:(NSString*)url task:(NSString *)action parameters:(NSDictionary *)params error:(NSError **)error
{
    NSObject            *jsonObj    = nil;
    NSHTTPURLResponse   *response   = nil;
    NSString            *requestUrl = [self makeRestApiUrl:url task:action];
    NSMutableURLRequest *request    = nil;
    NSData              *respoundData = nil;
    
    NSString            *requestBody = nil;
    NSData              *requestBodyData = nil;
    
    if (requestUrl) {
        requestBody = [self generatePostRequestBodyFromParams:params];
        request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:requestUrl]];
        [request setHTTPMethod:@"POST"];
        requestBodyData = [NSData dataWithBytes: [requestBody UTF8String] length: [requestBody length ]];
        [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"content-type"];
        [request setHTTPBody: requestBodyData];
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

- (id) getUshahidiRestApi:(NSString*)url task:(NSString *)action parameters:(NSDictionary *)params error:(NSError **)error
{
    NSObject            *jsonObj    = nil;
    NSHTTPURLResponse   *response   = nil;
    NSString            *requestUrl = [self makeRestApiUrl:url task:action];
    NSURLRequest        *request    = nil;
    NSData              *respoundData = nil;
    
    if (requestUrl) {
        for (id key in [params allKeys]) {
            NSLog(@"&%@=%@",key,[params objectForKey:key]);
        }
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
    NSDictionary *userInfo;
    if ([account isEqualToString:@"g0v"] && [passwd isEqualToString:@"g0v"]) {
        isLogin = YES;
        userInfo = @{@"Name":account};
    }
    else {
        isLogin = NO;
        userInfo = nil;
    }
    return userInfo;
}

- (void)logout
{
    isLogin = NO;
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
    NSMutableArray *parsedList = [[NSMutableArray alloc] init];
    NSArray        *incidentsList = nil;
    if (jsonObj &&
        [jsonObj objectForKey:@"payload"] &&
        [[jsonObj objectForKey:@"payload"] objectForKey:@"incidents"]) {
        incidentsList = [[jsonObj objectForKey:@"payload"] objectForKey:@"incidents"];
        for (int i = 0; i < [incidentsList count]; i++) {
            id obj = [incidentsList objectAtIndex:i];
            id objInc = [obj objectForKey:@"incident"];
            NSMutableDictionary *locationInfo = [[NSMutableDictionary alloc] init];
            // Get location infromation
            [locationInfo setObject:[objInc objectForKey:@"locationname"] forKey:@"locationName"];
            [locationInfo setObject:[objInc objectForKey:@"locationlatitude"] forKey:@"locationLatitude"];
            [locationInfo setObject:[objInc objectForKey:@"locationlongitude"] forKey:@"locationLongitude"];
            [locationInfo setObject:[objInc objectForKey:@"incidenttitle"] forKey:@"microSievert"];
            
            // Get category information
            for (id catObj in [obj objectForKey:@"categories"]) {
                id catId = [[catObj objectForKey:@"category"] objectForKey:@"id"];
                id catTitle = [[catObj objectForKey:@"category"] objectForKey:@"title"];
                id catType = [categoryTypeMapping objectForKey:[catId stringValue]];
                
                if (catType == nil) {
                    [locationInfo setObject:catTitle forKey:@"device"];
                }
                else if ([catType isEqualToString:HIGHT_TYPE]){
                    [locationInfo setObject:catTitle forKey:@"height"];
                }
                else if ([catType isEqualToString:AREA_TYPE]){
                    [locationInfo setObject:catTitle forKey:@"area"];
                }
                else if ([catType isEqualToString:POSITION_TYPE]){
                    [locationInfo setObject:catTitle forKey:@"position"];
                }
            }
            
            // Get image
            [locationInfo setObject:[self getMediaFromUshahidiMediaObj:[obj objectForKey:@"media"] key:@"link_url"] forKey:@"imageUrl"];
            [locationInfo setObject:[self getMediaFromUshahidiMediaObj:[obj objectForKey:@"media"] key:@"thumb_url"] forKey:@"thumbUrl"];
            
            [parsedList addObject:locationInfo];
        }
    }
    return parsedList;
}

- (NSArray*)parseUshahidiCateforiesFromJson:(id) jsonObj
{
    if (jsonObj &&
        [jsonObj objectForKey:@"payload"] &&
        [[jsonObj objectForKey:@"payload"] objectForKey:@"categories"]) {
        return [[jsonObj objectForKey:@"payload"] objectForKey:@"categories"];
    }
    return nil;
}

- (NSArray*)parseUshahidiJson:(NSString*) task jsonObj:(id) jsonObj
{
    if ([task isEqualToString:TASK_INCIDENTS]) {
        return [self parseUshahidiIncidentsJson:jsonObj];
    }
    else if ([task isEqualToString:TASK_CATEGORIES]) {
        return [self parseUshahidiCateforiesFromJson:jsonObj];
    }
    return nil;
}
- (NSArray*)getLocationInfoList
{
    NSError *error              = nil;
    NSArray *locationInfoList   = nil;
    id      jsonObj             = nil;
    jsonObj = [self getUshahidiRestApi:RADIATION_DEV_REST_RUL task:TASK_INCIDENTS parameters:nil error:&error];
    if (jsonObj == nil) {
        NSLog(@"%@",error.description);
    }
    else {
        locationInfoList = [self parseUshahidiJson:TASK_INCIDENTS jsonObj:jsonObj];
    }
    return locationInfoList;
}

- (NSArray*) getCategorieList
{
    NSError *error;
    NSArray *categorieList = nil;
    id      jsonObj        = nil;
    
    jsonObj = [self getUshahidiRestApi:RADIATION_DEV_REST_RUL task:TASK_CATEGORIES parameters:nil error:&error];
    if (jsonObj == nil) {
        NSLog(@"%@",error.description);
    }
    else {
        categorieList = [self parseUshahidiJson:TASK_CATEGORIES jsonObj:jsonObj];
    }
    return categorieList;
}

- (NSArray *)getDeviceList
{
    NSArray*        categorieList = [self getCategorieList];
    NSMutableArray* deviceList = [[NSMutableArray alloc] init];
    
    if (categorieList != nil) {
        for (id obj in categorieList) {
            if ([[[obj objectForKey:@"category"] objectForKey:@"parent_id"] isEqualToString:DEVICE_TYPE]) {
                Device *device = [[Device alloc] initWithId:[[obj objectForKey:@"category"] objectForKey:@"id"]
                                                       name:[[obj objectForKey:@"category"] objectForKey:@"title"]];
                [deviceList addObject:device];
            }
        }
    }
    return deviceList;
}

- (NSString *)getCurrentAddress
{
    return nil;
}

- (NSDictionary*) getCurrentTime
{
    NSDate*             dateNow;
    NSString*           date;
    NSString*           hour;
    NSString*           minute;
    NSString*           second;
    NSString*           ampm;
    NSDateFormatter*    dateFormater;
    
    dateNow = [NSDate date];
    dateFormater = [[NSDateFormatter alloc] init];
    // Get Date
    [dateFormater setDateFormat:@"MM/dd/YYYY"];
    date = [dateFormater stringFromDate:dateNow];
    
    // Get hour
    [dateFormater setDateFormat:@"KK"];
    hour = [dateFormater stringFromDate:dateNow];
    
    // Get minute
    [dateFormater setDateFormat:@"mm"];
    minute = [dateFormater stringFromDate:dateNow];
    
    // Get second
    [dateFormater setDateFormat:@"ss"];
    second = [dateFormater stringFromDate:dateNow];
    
    // Get ampm
    [dateFormater setDateFormat:@"aa"];
    ampm = [dateFormater stringFromDate:dateNow];
    
    return @{@"date":date,
             @"hour":hour,
             @"minute":minute,
             @"second":second,
             @"ampm":[ampm lowercaseString]};
}

- (id)submitLocationInfoWithValue:(NSString *)microSievert locationName:(NSString *)locationName location:(CLLocation *)location high:(HighType)high area:(AreaType)area device:(Device *)device position:(PositionType)position photo:(NSData *)photo
{
    id          jsonObj = nil;
    NSError*    error = nil;
    NSString*   latitude = nil;
    NSString*   longitude = nil;
    NSString*   category = nil;
    NSDictionary*           currentTime = [self getCurrentTime];
    NSMutableDictionary*    submitParameters;
    
    if (device == nil) {
        return nil;
    }
    
    category = [NSString stringWithFormat:@"%d,%d,%@,%d",high,area,device.deviceId,position];
    
    latitude = [NSString stringWithFormat:@"%f",location.coordinate.latitude];
    longitude = [NSString stringWithFormat:@"%f",location.coordinate.longitude];
    submitParameters = [[NSMutableDictionary alloc] init];
    
    [submitParameters setObject:@"report" forKey:@"task"];
    [submitParameters setObject:microSievert forKey:@"incident_title"];
    [submitParameters setObject:microSievert forKey:@"incident_description"];
    [submitParameters setObject:[currentTime objectForKey:@"date"] forKey:@"incident_date"];
    [submitParameters setObject:[currentTime objectForKey:@"hour"] forKey:@"incident_hour"];
    [submitParameters setObject:[currentTime objectForKey:@"minute"] forKey:@"incident_minute"];
    [submitParameters setObject:[currentTime objectForKey:@"ampm"] forKey:@"incident_ampm"];
    [submitParameters setObject:category forKey:@"incident_category"];
    [submitParameters setObject:latitude forKey:@"latitude"];
    [submitParameters setObject:longitude forKey:@"longitude"];
    [submitParameters setObject:locationName forKey:@"location_name"];
    
    jsonObj = [self postUshahidiRestApi:RADIATION_DEV_REST_RUL task:TASK_SUBMIT parameters:submitParameters error:&error];
    return jsonObj;
}

@end