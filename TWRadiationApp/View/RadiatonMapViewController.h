//
//  RadiatonMapViewController.h
//  TWRadiationApp
//
//  Created by Kent Huang on 2014/4/19.
//  Copyright (c) 2014年 g0v.tw. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface RadiatonMapViewController : UIViewController <CLLocationManagerDelegate>
{
    CLLocationManager *locationManager;
    IBOutlet UILabel* currentAddress;
}

- (IBAction)pushUpdateAddressButton:(id)sender;

@end
