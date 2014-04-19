//
//  RadiatonMapViewController.m
//  TWRadiationApp
//
//  Created by Kent Huang on 2014/4/19.
//  Copyright (c) 2014年 g0v.tw. All rights reserved.
//

#import "RadiatonMapViewController.h"

@interface RadiatonMapViewController ()

@end

@implementation RadiatonMapViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    locationManager.distanceFilter = kCLDistanceFilterNone;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;

}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [currentAddress setText:@""];
    [locationManager startUpdatingLocation];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    CLLocation *currentLocation = [locations lastObject];
    NSLog(@"Current location: %f %f",currentLocation.coordinate.latitude, currentLocation.coordinate.longitude);
    [manager stopUpdatingLocation];
    [self sendHttpRequestToAskAddressByLocation:[locations lastObject]];
}

- (void)sendHttpRequestToAskAddressByLocation:(CLLocation*) location
{
    NSString *urlString = [NSString stringWithFormat:@"http://maps.googleapis.com/maps/api/geocode/json?latlng=%f,%f&sensor=false&language=zh-tw",location.coordinate.latitude, location.coordinate.longitude];
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest * urlRequest = [NSURLRequest requestWithURL:url];
    NSURLResponse * response = nil;
    NSError * error = nil;
    NSData * data = [NSURLConnection sendSynchronousRequest:urlRequest
                                          returningResponse:&response
                                                      error:&error];
    
    if (error == nil)
    {
        // Parse data here
        NSObject *jsonObj = nil;
        //NSLog(@"%@",[NSString stringWithCString:[data bytes] encoding:NSUTF8StringEncoding]);
        jsonObj = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
        if ([[(NSDictionary*)jsonObj objectForKey:@"status"] isEqualToString:@"OK"]) {
            [currentAddress setText:@""];
            [self showAddressResultByGoogleApi:(NSDictionary*)jsonObj];
        }
    }

}

- (void)showAddressResultByGoogleApi:(NSDictionary*) jsonObj
{
    NSArray *result = [jsonObj objectForKey:@"results"];
    NSLog(@"%@", [[result objectAtIndex:0] objectForKey:@"formatted_address"]);
    [currentAddress setText:[[result objectAtIndex:0] objectForKey:@"formatted_address"]];
    
}

- (void)pushUpdateAddressButton:(id)sender
{
    [currentAddress setText:@""];
    [locationManager startUpdatingLocation];
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
