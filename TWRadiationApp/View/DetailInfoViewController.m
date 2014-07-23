//
//  DetailInfoViewController.m
//  TWRadiationApp
//
//  Created by Kent Huang on 2014/7/23.
//  Copyright (c) 2014年 g0v.tw. All rights reserved.
//

#import "DetailInfoViewController.h"

@interface DetailInfoViewController ()

@end

@implementation DetailInfoViewController
@synthesize locationDetailInfo;

- (double) covertNSStringToDouble:(NSString*) string
{
    double floatingValue = 0.0;
    
    floatingValue = [[NSDecimalNumber decimalNumberWithString:string] doubleValue];
    
    return floatingValue;
}

- (MKCoordinateSpan) getSpanByRadius:(double)miles location:(CLLocationCoordinate2D) location
{
    MKCoordinateSpan span;
    double scalingFactor = ABS( (cos(2 * M_PI * location.latitude / 360.0) ));
    
    span.latitudeDelta = miles/69.0;
    span.longitudeDelta = miles/(scalingFactor * 69.0);
    
    return span;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    if (locationDetailInfo != nil) {
        double latitude = [self covertNSStringToDouble:[locationDetailInfo objectForKey:@"locationLatitude"]];
        double longitude = [self covertNSStringToDouble:[locationDetailInfo objectForKey:@"locationLongitude"]];
        NSString *combinedAreaAndHeight = [NSString stringWithFormat:@"%@%@",
                                           [locationDetailInfo objectForKey:@"area"],
                                           [locationDetailInfo objectForKey:@"height"]];
        
        microSievert.text   = [locationDetailInfo objectForKey:@"microSievert"];
        deviceName.text     = [locationDetailInfo objectForKey:@"device"];
        areaAndHeight.text  = combinedAreaAndHeight;
        self.title          = [locationDetailInfo objectForKey:@"locationName"];
        estimateLaction     = CLLocationCoordinate2DMake(latitude, longitude);
        
        // Init MKMapView
        MKCoordinateSpan span = [self getSpanByRadius:1 location:estimateLaction];
        MKCoordinateRegion region = MKCoordinateRegionMake(estimateLaction, span);
        [mapView setCenterCoordinate:estimateLaction animated:NO];
        [mapView setRegion:region];
        
    }
}


- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
