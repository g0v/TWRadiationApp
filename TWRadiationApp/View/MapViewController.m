//
//  RadiatonMapViewController.m
//  TWRadiationApp
//
//  Created by Kent Huang on 2014/4/19.
//  Copyright (c) 2014年 g0v.tw. All rights reserved.
//

#import "MapViewController.h"
#import "TWRadiationConstant.h"
#import "RadiationAnnotation.h"
#import "TWRadiationCoreAPI.h"
#import "AppDelegate.h"
#import <MapKit/MapKit.h>
#import <UIKit/UIKit.h>

@interface RadiatonMapViewController ()

@end

@implementation RadiatonMapViewController {
    TWRadiationCoreAPI   *coreApi;
    NSArray *locationInfoList;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    locationManager.distanceFilter = kCLDistanceFilterNone;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    
    [mapView setDelegate:self];
    [mapView setShowsUserLocation:YES];
//    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:WEB_HOMEPAGE]]];
    
    if (coreApi == nil) {
        AppDelegate *appDelegate = [[UIApplication sharedApplication]delegate];
        coreApi = [appDelegate coreApi];
    }

/*    UIBarButtonItem *rightButton = self.navigationItem.rightBarButtonItem;
    [rightButton setTintColor: nil];
    [rightButton setEnabled: YES];*/
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [currentAddress setText:@""];
    [locationManager startUpdatingLocation];

    locationInfoList = [coreApi getLocationInfoList];
    NSLog(@">>loc=%@",locationInfoList);
    
    NSArray *locArray = [self createAnnotations:locationInfoList];
    [mapView addAnnotations:locArray];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*#pragma mark - UIWebViewDelegate methods
- (void)webViewDidStartLoad:(UIWebView *)webView {
    [loadingIndicator startAnimating];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [loadingIndicator stopAnimating];
}*/

#pragma mark - Custom methods
- (NSMutableArray *)createAnnotations:(NSArray *) locArray {
    
    NSMutableArray *annotations = [[NSMutableArray alloc] init];
    for (NSDictionary *locationInfo in locArray) {
        RadiationAnnotation *annos = [[RadiationAnnotation alloc] init];
        
        //Create coordinates from the latitude and longitude values
        NSNumber *latitude = [locationInfo objectForKey:@"locationLatitude"];
        NSNumber *longitude = [locationInfo objectForKey:@"locationLongitude"];
        
        annos.title = [NSString stringWithFormat:@"%@ %@",[locationInfo objectForKey:@"locationName"],[locationInfo objectForKey:@"area"]];
        annos.subtitle = [NSString stringWithFormat:@"%@ (%@)",[locationInfo objectForKey:@"microSievert"],[locationInfo objectForKey:@"device"]];
        annos.coordinate = CLLocationCoordinate2DMake(latitude.doubleValue, longitude.doubleValue);;
        annos.radiationValue = [[locationInfo objectForKey:@"microSievert"] floatValue];        
        [annotations addObject:annos];
    }
    return annotations;
}

- (void)askAddressByLocation:(CLLocation*) location {
    CLGeocoder *geoCoder = [[CLGeocoder alloc] init];
    [geoCoder reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError *error) {
        if (error){
            NSLog(@"Geocode failed with error: %@", error);
            return;
        }
        if(placemarks && placemarks.count > 0) {
            CLPlacemark *placemark = [placemarks objectAtIndex:0];
            NSString *locatedAt = [[placemark.addressDictionary valueForKey:@"FormattedAddressLines"] componentsJoinedByString:@", "];
            [currentAddress setText:locatedAt];
        }
    }];
}

- (BOOL)sendHttpRequestToAskAddressByLocation:(CLLocation*) location
{
    BOOL result = false;
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
        result = true;
    }
    return result;

}

- (void)showAddressResultByGoogleApi:(NSDictionary*) jsonObj
{
    NSArray *result = [jsonObj objectForKey:@"results"];
    NSLog(@"addr=%@", [[result objectAtIndex:0] objectForKey:@"formatted_address"]);
    [currentAddress setText:[[result objectAtIndex:0] objectForKey:@"formatted_address"]];
//    [currentAddress setBackgroundColor:[UIColor blackColor]];
}

- (void)pushUpdateAddressButton:(id)sender
{
    [currentAddress setText:@""];
    [locationManager startUpdatingLocation];
}
/*
- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation
{
    //    CustomMapAnnotationView *annotationView = nil;
    MKAnnotationView *annotationView = nil;
    
    // determine the type of annotation, and produce the correct type of annotation view for it.
//    MKAnnotation* myAnnotation = (MKAnnotation *)annotation;
    
    NSString* identifier = @"CustomMapAnnotation";
    MKAnnotationView *newAnnotationView = (MKAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:identifier];
    
    if(nil == newAnnotationView) {
        newAnnotationView = [[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:identifier];
    }
    
    annotationView = newAnnotationView;
    [annotationView setEnabled:YES];
    [annotationView setCanShowCallout:YES];
    
    return annotationView;
}

- (void)addAnnotation
{
    // 建立一個CLLocationCoordinate2D
    CLLocationCoordinate2D mylocation;
    mylocation.latitude = 25.01141;
    mylocation.longitude = 121.42554;
    
    // 建立一個region，待會要設定給MapView
    MKCoordinateRegion kaos_digital;
    
    // 設定經緯度
    kaos_digital.center = mylocation;
    
    // 設定縮放比例
    kaos_digital.span.latitudeDelta = 0.003;
    kaos_digital.span.longitudeDelta = 0.003;
    
    // 準備一個annotation
//    MyCompany *mycompany = [[MyCompany alloc] initWithCoordinate:mylocation];
    RadiationAnnotation *mycompany= [[RadiationAnnotation alloc] init];
    mycompany.title = @"高思數位網路";
    mycompany.subtitle = @"媽，我在這裡啦!";
    
    [mapView setRegion:kaos_digital];
    
    // 把annotation加進MapView裡
    [mapView addAnnotation:mycompany];
    
//    [super viewDidLoad];
}*/

- (MKAnnotationView *)mapView:(MKMapView *)aMapView viewForAnnotation:(id<MKAnnotation>)annotation {
    static NSString *radiationAnnoID=@"RadiationAnnotationIdentifier";
    
    if ([annotation isKindOfClass:[RadiationAnnotation class]]) {
        RadiationAnnotation *radiationAnno = (RadiationAnnotation*)annotation;
        
        MKPinAnnotationView *annotationView = (MKPinAnnotationView*)[aMapView dequeueReusableAnnotationViewWithIdentifier:radiationAnnoID];
        if (annotationView == nil) {
            annotationView=[[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:radiationAnnoID];
//            NSLog(@"title=%@ %f",radiationAnno.title, radiationAnno.radiationValue);

            annotationView.image = [radiationAnno getImage];
//            annotationView.pinColor = [radiationAnno getColor];
/*            if ((radiationAnno.radiationValue) >0.6) {
                annotationView.pinColor = MKPinAnnotationColorPurple;
            } else if ((radiationAnno.radiationValue) <0.2) {
                annotationView.pinColor = MKPinAnnotationColorGreen;
            } else
                annotationView.pinColor = MKPinAnnotationColorRed;*/
        } else {                //Do not come here
            annotationView.annotation = radiationAnno;
//            NSLog(@"title2=%@",((RadiationAnnotation*)annotation).title);
        }
        annotationView.canShowCallout= YES;
        return annotationView;
    }
    return nil;
}

#pragma mark - Methods of CLLocationManagerDelegate
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    CLLocation *currentLocation = [locations lastObject];
    NSLog(@"Current location: %f %f",currentLocation.coordinate.longitude, currentLocation.coordinate.latitude);
    [manager stopUpdatingLocation];
    
    //if Google Map API is failed, we will use iOS CLGeocoder APIs instead
    if (![self sendHttpRequestToAskAddressByLocation:[locations lastObject]])
        [self askAddressByLocation:[locations lastObject]];
    
    CLLocationCoordinate2D loc = currentLocation.coordinate;
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(loc, 250, 250);
    [mapView setRegion:region animated:YES];
}
 
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}


@end
