//
//  RadiationAnnotation.h
//  TWRadiationApp
//
//  Created by Charles Lu on 2014/8/5.
//  Copyright (c) 2014年 g0v.tw. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface RadiationAnnotation : NSObject <MKAnnotation>
@property (copy,nonatomic) NSString *title;
@property (copy,nonatomic) NSString *subtitle;
@end
