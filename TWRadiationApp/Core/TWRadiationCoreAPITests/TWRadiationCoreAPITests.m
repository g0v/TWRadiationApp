//
//  TWRadiationCoreAPITests.m
//  TWRadiationCoreAPITests
//
//  Created by Kent Huang on 2014/4/28.
//  Copyright (c) 2014年 g0v.tw. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "TWRadiationCoreAPI.h"

@interface TWRadiationCoreAPITests : XCTestCase
@end

@implementation TWRadiationCoreAPITests

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testUserLogin
{
    TWRadiationCoreAPI *coreApi = [[TWRadiationCoreAPI alloc] init];
    NSDictionary *userInfo = [coreApi loginWithAccount:@"Kent" passwd:@"test123"];
    XCTAssertEqual([userInfo objectForKey:@"Name"], @"Kent", @"Should be Kent");
}

@end
