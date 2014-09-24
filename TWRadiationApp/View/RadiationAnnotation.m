//
//  RadiationAnnotation.m
//  TWRadiationApp
//
//  Created by Charles Lu on 2014/8/5.
//  Copyright (c) 2014年 g0v.tw. All rights reserved.
//

#import "RadiationAnnotation.h"

@implementation RadiationAnnotation
@synthesize coordinate;
@synthesize title;
@synthesize subtitle;

-(MKAnnotationView*) annotationView {
    MKAnnotationView *annotationView = [[MKAnnotationView alloc] initWithAnnotation:self reuseIdentifier:@"raditationAnnotation"];
    
    annotationView.enabled = YES;
    annotationView.canShowCallout = YES;
    annotationView.image = [UIImage imageNamed:@"radiation"];
    return annotationView;
}
@end
