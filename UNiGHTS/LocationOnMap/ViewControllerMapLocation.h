//
//  ViewControllerMapLocation.h
//  UNiGHTS
//
//  Created by user on 20/06/18.
//  Copyright © 2018 RVTechnologies Softwares PVT. LTD. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
@interface ViewControllerMapLocation : UIViewController<MKMapViewDelegate,CLLocationManagerDelegate>
{
    double getLat;
    double getLong;
}
@property (strong, nonatomic) IBOutlet MKMapView *mapViewApple;



- (IBAction)CurrentLocationTapped:(id)sender;
@property (weak , nonatomic) NSString * lat_sting_vc;
@property (weak , nonatomic) NSString * long_sting_vc;
@property (strong , nonatomic) NSString * nameEvent;

- (IBAction)LocationBackTapped:(id)sender;
@property (strong, nonatomic) IBOutlet UIView *Home_page_map;



@end
