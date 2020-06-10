//
//  ViewControllerLocation.m
//  UNiGHTS
//
//  Created by user on 18/06/18.
//  Copyright © 2018 RVTechnologies Softwares PVT. LTD. All rights reserved.
//

#import "ViewControllerLocation.h"
#import <GoogleMaps/GoogleMaps.h>
#import <GooglePlaces/GooglePlaces.h>
#import <CoreLocation/CoreLocation.h>

@interface ViewControllerLocation ()<GMSMapViewDelegate,CLLocationManagerDelegate,GMSAutocompleteTableDataSourceDelegate,GMSAutocompleteViewControllerDelegate>

@end
@implementation ViewControllerLocation
CLGeocoder *geocoder;
CLPlacemark *placemark;
CLLocationManager *locationManager;
GMSMapView *mapView_;
NSMutableArray * UsersLattitude;
NSMutableArray * UsersLongitude;
int Cameravalue = 10;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
-(void)viewWillAppear:(BOOL)animated
{
   
    UsersLattitude =[[NSMutableArray alloc]init];
    UsersLongitude =[[NSMutableArray alloc]init];
    
    
    [UsersLattitude addObject:@"30.567398"];
    [UsersLongitude addObject:@"76.7827"];
    
    [UsersLattitude addObject:@"30.3237398"];
    [UsersLongitude addObject:@"76.42237827"];
    
    [UsersLattitude addObject:@"30.1117398"];
    [UsersLongitude addObject:@"76.767827"];
    
    [UsersLattitude addObject:@"30.1217398"];
    [UsersLongitude addObject:@"76.312227827"];
    [self.LocationScrollview setContentSize:CGSizeMake(self.LocationScrollview.frame.size.width*3, self.LocationScrollview.frame.size.height)];
    locationManager = [[CLLocationManager alloc] init];
    locationManager.distanceFilter = kCLDistanceFilterNone;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    locationManager.delegate = self;
    [locationManager startUpdatingLocation];
    [locationManager requestWhenInUseAuthorization];
    [locationManager requestAlwaysAuthorization];
    float latitude = locationManager.location.coordinate.latitude;
    float longitude = locationManager.location.coordinate.longitude;
   NSString * Driverlat=[NSString stringWithFormat:@"%.15f", latitude];
   NSString * Driverlong=[NSString stringWithFormat:@"%.15f", longitude];
    if(!([CLLocationManager authorizationStatus] == kCLAuthorizationStatusAuthorizedAlways))
    {
        if ([locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
            
            [locationManager requestWhenInUseAuthorization];
            [locationManager startUpdatingLocation];
            [locationManager requestAlwaysAuthorization];
            
        }
    }
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:[Driverlat doubleValue]
                                                            longitude:[Driverlong doubleValue]
                                                                 zoom:Cameravalue];
    mapView_ = [GMSMapView mapWithFrame:CGRectMake(0,0, self.view.frame.size.width, self.Home_page_map.frame.size.height) camera:camera];
    mapView_.delegate = self;
    mapView_.myLocationEnabled = YES;
    [self.Home_page_map addSubview:mapView_];
    NSError* error;
    NSBundle *mainBundle = [NSBundle mainBundle];
    NSURL *styleUrl = [mainBundle URLForResource:@"MapStyle" withExtension:@"json"];
    // Set the map style by passing the URL for style.json.
    GMSMapStyle *style = [GMSMapStyle styleWithContentsOfFileURL:styleUrl error:&error];
    
    if (!style) {
        NSLog(@"The style definition could not be loaded: %@", error);
    }
     mapView_.mapStyle = style;
    [self GetUsersOnMap];
}

-(void)GetUsersOnMap
{
    for (int x=0; x<UsersLattitude.count; x++)
    {
        
        NSString * latvalue =[UsersLattitude objectAtIndex:x];
        NSString * longvalue =[UsersLongitude objectAtIndex:x];
        
        GMSMarker *marker = [ [GMSMarker alloc] init];
        marker.position = CLLocationCoordinate2DMake([latvalue doubleValue], [longvalue doubleValue]);
        marker.appearAnimation = kGMSMarkerAnimationPop;
        marker.icon = [UIImage imageNamed:@"LocationPurple.png"];
        marker.map = mapView_;
        marker.zIndex=x;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
