//
//  TWRadiationCoreApiTests.m
//  TWRadiationApp
//
//  Created by Kent Huang on 2014/5/25.
//  Copyright (c) 2014年 g0v.tw. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "TWRadiationCoreAPI.h"

@interface TWRadiationCoreApiTests : XCTestCase
{
    TWRadiationCoreAPI *coreApi;
}

@end

@implementation TWRadiationCoreApiTests

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    if (coreApi == nil) {
        coreApi = [[TWRadiationCoreAPI alloc] init];
    }
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testMakeRestApiUrl
{
    NSString *url = nil;
    url = [coreApi makeRestApiUrl:RADIATION_SERVER_REST_RUL task:TASK_INCIDENTS];
    XCTAssertEqualObjects(@"http://www.knownuke.tw/map/index.php/api?task=incidents", url, @"");
    url = [coreApi makeRestApiUrl:nil task:TASK_INCIDENTS];
    XCTAssertNil(url, @"");
    url = [coreApi makeRestApiUrl:RADIATION_SERVER_REST_RUL task:nil];
    XCTAssertNil(url, @"");
}

- (void)testGetUshahidiRestApi
{
    id      jsonObj = nil;
    NSError *error = nil;
    jsonObj = [coreApi getUshahidiRestApi:RADIATION_SERVER_REST_RUL task:TASK_INCIDENTS parameters:nil error:&error];
    XCTAssert(jsonObj,@"");
    XCTAssertEqualObjects([[jsonObj objectForKey:@"error"] objectForKey:@"code"], @"0", @"");
}

- (void)testGetUshahidiRestApiInvalid
{
    id      jsonObj = nil;
    NSError *error = nil;
    
    // Test for invalid task
    jsonObj = [coreApi getUshahidiRestApi:RADIATION_SERVER_REST_RUL task:TASK_INVALID parameters:nil error:&error];
    XCTAssert(jsonObj,@"");
    XCTAssertEqualObjects([[jsonObj objectForKey:@"error"] objectForKey:@"code"], @"999", @"");
    
    // Test for invalid REST API url
    jsonObj = [coreApi getUshahidiRestApi:@"http://www.google.com" task:TASK_INCIDENTS parameters:nil error:&error];
    XCTAssertNil(jsonObj, @"");

    // Test for nil REST API url
    jsonObj = [coreApi getUshahidiRestApi:nil task:TASK_INCIDENTS parameters:nil error:&error];
    XCTAssertNil(jsonObj, @"");
}

- (void)testGetLocationInfo
{
    NSArray *locationInfo = nil;
    locationInfo = [coreApi getLocationInfoList];
    XCTAssert(locationInfo, @"");
}

- (void)testGetCurrentAddress
{
    [coreApi getCurrentAddress];
}

- (void)testGetCategoriesList
{
    [coreApi getCategorieList];
}

- (void)testSubmitLocationInfo
{
    CLLocation *testLoction = [[CLLocation alloc] initWithLatitude:25.03861 longitude:121.92417];
    id jsonObj = nil;
    jsonObj = [coreApi submitLocationInfoWithValue:@"0.01" locationName:@"g0v" location:testLoction hight:@"一公尺" area:@"於室外" device:@"儀器D" position:@"一般人士" photo:nil];
    XCTAssert(jsonObj, @"");
    XCTAssert([jsonObj objectForKey:@"error"], @"");
    XCTAssert([[jsonObj objectForKey:@"error"] objectForKey:@"code"], @"");
    XCTAssertEqualObjects([[jsonObj objectForKey:@"error"] objectForKey:@"code"], @"0", @"");
    
}
@end
