//
//  Device.h
//  TWRadiationApp
//
//  Created by Kent Huang on 2014/6/21.
//  Copyright (c) 2014年 g0v.tw. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Device : NSObject
{
    NSString* deviceId;
    NSString* deviceName;
}

@property (readonly) NSString* deviceId;
@property (readonly) NSString* deviceName;

- (id)init __attribute__((unavailable("init is unavailable")));

- initWithId:(NSString*) DeviceId name:(NSString*) DeviceName;

@end
