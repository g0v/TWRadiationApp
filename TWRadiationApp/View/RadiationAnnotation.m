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

#define RGB2UIColor(r, g, b)  [UIColor colorWithRed:((r) / 255.0) green:((g) / 255.0) blue:((b) / 255.0) alpha:1.0]

/*-(MKPinAnnotationView*) annotationView {
    MKPinAnnotationView *annotationView = [[MKPinAnnotationView alloc] initWithAnnotation:self reuseIdentifier:@"raditationAnnotation"];
    
    annotationView.enabled = YES;
    annotationView.canShowCallout = YES;
    annotationView.image = [UIImage imageNamed:@"radiation"];
    annotationView.pinColor = MKPinAnnotationColorPurple;
    
    return annotationView;
}*/

-(UIColor*) getColor {
    UIColor *color;
    if (self.radiationValue <0.11)
        color = RGB2UIColor(0x28, 0x94, 0xff);
    else if (self.radiationValue <0.19)
        color = RGB2UIColor(0x0, 0xbb, 0);
    else if (self.radiationValue <0.49)
        color = RGB2UIColor(0xff, 0xdc, 0x35);
    else if (self.radiationValue <0.99)
        color = RGB2UIColor(0xf7, 0x50, 0x0);
    else
        color = RGB2UIColor(0x7e, 0x3d, 0x76);
    return color;
}

-(UIImage*) getImage {
    UIImage *image;
    if (self.radiationValue <0.11)
        image = [UIImage imageNamed:@"pin2894FF.png"];
    else if (self.radiationValue <0.19)
        image = [UIImage imageNamed:@"pin00bb00.png"];
    else if (self.radiationValue <0.49)
        image = [UIImage imageNamed:@"pinffdc35.png"];
    else if (self.radiationValue <0.99)
        image = [UIImage imageNamed:@"pinf75000.png"];
    else
        image = [UIImage imageNamed:@"pin7e3d76.png"];
    return image;
}
@end
