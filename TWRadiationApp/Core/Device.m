//
//  Device.m
//  TWRadiationApp
//
//  Created by Kent Huang on 2014/6/21.
//  Copyright (c) 2014年 g0v.tw. All rights reserved.
//

#import "Device.h"

@implementation Device
@synthesize deviceId = _deviceId;
@synthesize deviceName = _deviceName;

- (id)initWithId:(NSString *)DeviceId name:(NSString *)DeviceName
{
    if ((self = [super init])) {
        _deviceName = DeviceName;
        _deviceId = DeviceId;
    }
    return self;
}
@end
