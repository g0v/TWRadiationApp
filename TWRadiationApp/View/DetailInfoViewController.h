//
//  DetailInfoViewController.h
//  TWRadiationApp
//
//  Created by Kent Huang on 2014/7/23.
//  Copyright (c) 2014年 g0v.tw. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>

@interface DetailInfoViewController : UIViewController <MKMapViewDelegate>
{
    NSDictionary        *locationDetailInfo;
    //IBOutlet UILabel *locationName;
    IBOutlet UILabel    *microSievert;
    IBOutlet UILabel    *areaAndHeight;
    IBOutlet UILabel    *deviceName;
    IBOutlet MKMapView  *mapView;
    CLLocationCoordinate2D estimateLaction;
}

@property (strong,nonatomic) NSDictionary *locationDetailInfo;

@end
