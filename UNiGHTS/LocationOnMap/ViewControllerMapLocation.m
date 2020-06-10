//
//  ViewControllerMapLocation.m
//  UNiGHTS
//
//  Created by user on 20/06/18.
//  Copyright © 2018 RVTechnologies Softwares PVT. LTD. All rights reserved.
//

#import "ViewControllerMapLocation.h"
#import <GoogleMaps/GoogleMaps.h>
#import <GooglePlaces/GooglePlaces.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>
@interface ViewControllerMapLocation ()<GMSMapViewDelegate,CLLocationManagerDelegate,GMSAutocompleteTableDataSourceDelegate,GMSAutocompleteViewControllerDelegate,MKMapViewDelegate,MKAnnotation>

@end

@implementation ViewControllerMapLocation
CLGeocoder *geocoder;
CLPlacemark *placemark;
CLLocationManager *locationManager;
//GMSMapView *mapView_;
NSMutableArray * UsersLattitude;
NSMutableArray * UsersLongitude;
- (void)viewDidLoad {
    [super viewDidLoad];
    self.mapViewApple.delegate=self;
    self.mapViewApple.showsTraffic=YES;
    self.mapViewApple.showsCompass = YES;
    self.mapViewApple.showsBuildings = YES;
//    float latitude = 30.7000;
//    float longitude = 76.7532;
//    NSString * Driverlat=[NSString stringWithFormat:@"%.15f", latitude];
//    NSString * Driverlong=[NSString stringWithFormat:@"%.15f", longitude];
    NSString * Driverlat=_lat_sting_vc;
    NSString * Driverlong=_long_sting_vc;
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
                                                                 zoom:16];
//    mapView_ = [GMSMapView mapWithFrame:CGRectMake(0,0, self.view.frame.size.width, self.Home_page_map.frame.size.height) camera:camera];
//    mapView_.delegate = self;
//    //mapView_.myLocationEnabled = YES;
//    [self.Home_page_map addSubview:mapView_];
    NSError* error;
    
    NSBundle *mainBundle = [NSBundle mainBundle];
    
    NSURL *styleUrl = [mainBundle URLForResource:@"MapStyle" withExtension:@"json"];
    // Set the map style by passing the URL for style.json.
    GMSMapStyle *style = [GMSMapStyle styleWithContentsOfFileURL:styleUrl error:&error];
    
    if (!style) {
        NSLog(@"The style definition could not be loaded: %@", error);
    }
    
    CLLocationCoordinate2D annotationCoord;
    
    annotationCoord.latitude = [Driverlat doubleValue];
    
    annotationCoord.longitude = [Driverlong doubleValue];
    
    MKPointAnnotation *annotationPoint = [[MKPointAnnotation alloc] init];
    
    annotationPoint.coordinate = annotationCoord;
    
    annotationPoint.title = _nameEvent;
    
    //annotationPoint.subtitle = @"Microsoft's headquarters";
    [self.mapViewApple addAnnotation:annotationPoint];
    
    MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(annotationCoord, 100, 100);
    
    // 3
    [self.mapViewApple setRegion:viewRegion animated:YES];
    
    
    
  //  mapView_.mapStyle = style;
    
//    GMSMarker *marker = [ [GMSMarker alloc] init];
//    marker.position = CLLocationCoordinate2DMake([Driverlat doubleValue], [Driverlong doubleValue]);
//    marker.appearAnimation = kGMSMarkerAnimationPop;
//    marker.icon = [UIImage imageNamed:@"RedPin"];
//    marker.title = _nameEvent;
//   // marker.snippet = @"New York, NY, USA";
//    marker.appearAnimation = kGMSMarkerAnimationPop;
//    marker.infoWindowAnchor = CGPointMake(0.44f, 0.30f);
//    marker.map = mapView_;
//    [mapView_ setSelectedMarker:marker];
  //  marker.zIndex=0;
    //CLLocation *sd = ["23","23"];
  //  GMSMutablePath *path = [GMSMutablePath path];
   // [path addCoordinate:CLLocationCoordinate2DMake(30.7333, 76.7794)];
//    [path addCoordinate:CLLocationCoordinate2DMake(31.5143, 75.9115)];
//   // [path addCoordinate:CLLocationCoordinate2DMake(-33.73, 151.41)];
//    GMSPolyline *polyline = [GMSPolyline polylineWithPath:path];
//    polyline.strokeWidth = 3;
//
//    polyline.strokeColor = [UIColor blueColor];
//
//    polyline.map = mapView_;
//    [self fetchPolylineWithOrigin:myOrigin destination:myDestination completionHandler:^(GMSPolyline *polyline)
//     {
//         if(polyline)
//             polyline.map = self.myMap;
//     }];
//    NSString *originString = [NSString stringWithFormat:@"%f,%f", 30.7333, 76.7794];
//    NSString *destinationString = [NSString stringWithFormat:@"%f,%f", 31.5143, 75.9115];
//    NSString *directionsAPI = @"https://maps.googleapis.com/maps/api/directions/json?";
//    NSString *directionsUrlString = [NSString stringWithFormat:@"%@&origin=%@&destination=%@&mode=driving&sensor=false &key=AIzaSyD4fxvfkSz2HuPyPBihyxSFIBWZZtWq5Z4", directionsAPI, originString, destinationString];
//    NSURL *directionsUrl = [NSURL URLWithString:directionsUrlString];
//
//
//    NSURLSessionDataTask *fetchDirectionsTask = [[NSURLSession sharedSession] dataTaskWithURL:directionsUrl completionHandler:
//                                                 ^(NSData *data, NSURLResponse *response, NSError *error)
//                                                 {
//                                                     NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
////                                                     if(error)
////                                                     {
////                                                         if(completionHandler)
////                                                             completionHandler(nil);
////                                                         return;
////                                                     }
//
//                                                     NSArray *routesArray = [json objectForKey:@"routes"];
//
//                                                     GMSPolyline *polyline = nil;
//                                                     if ([routesArray count] > 0)
//                                                     {
//                                                         NSDictionary *routeDict = [routesArray objectAtIndex:0];
//                                                         NSDictionary *routeOverviewPolyline = [routeDict objectForKey:@"overview_polyline"];
//                                                         NSString *points = [routeOverviewPolyline objectForKey:@"points"];
//                                                         GMSPath *path = [GMSPath pathFromEncodedPath:points];
//                                                         polyline = [GMSPolyline polylineWithPath:path];
//                                                         polyline.strokeColor = [UIColor blueColor];
//                                                         //
//                                                           polyline.map = mapView_;
//                                                     }
//
//                                                     // run completionHandler on main thread
//                                                     dispatch_sync(dispatch_get_main_queue(), ^{
////                                                         if(completionHandler)
////                                                             completionHandler(polyline);
//                                                     });
//                                                 }];
//    [fetchDirectionsTask resume];

}
- (IBAction)directionsTap:(id)sender {
   // NSString *get = [NSString stringWithFormat:@"%@comgooglemaps://?saddr=&daddr=@%s%@%@",_lat_sting_vc,",",_long_sting_vc,@"&directionsmode=driving"];
    
    
    
//    NSString *sd = [NSString stringWithFormat:@"%@%@%@%@%@",@"comgooglemaps://?saddr=&daddr=",_lat_sting_vc,@",",_long_sting_vc,@"&directionsmode=driving"];
//    NSLog(@"%@",sd);
//
//       [[UIApplication sharedApplication] openURL:[NSURL URLWithString:sd]];
  NSString *LatN2 = [[NSUserDefaults standardUserDefaults]valueForKey:@"getLat"];
 NSString *LongN3 = [[NSUserDefaults standardUserDefaults]valueForKey:@"getLong"];
    
    NSString* directionsURL = [NSString stringWithFormat:@"http://maps.apple.com/?saddr=%@,%@&daddr=%@,%f",LatN2, LongN3, _lat_sting_vc, _long_sting_vc];
    if ([[UIApplication sharedApplication] respondsToSelector:@selector(openURL:options:completionHandler:)]) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString: directionsURL] options:@{} completionHandler:^(BOOL success) {}];
    } else {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString: directionsURL]];
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (MKOverlayRenderer *)mapView:(MKMapView *)map viewForOverlay:(id <MKOverlay>)overlay
{
    MKCircleRenderer *circleView = [[MKCircleRenderer alloc] initWithOverlay:overlay];
    circleView.strokeColor = [UIColor redColor];
    circleView.fillColor = [[UIColor clearColor] colorWithAlphaComponent:0.1];
    return circleView;
}



- (void) showAnnotationCallOut {
    //[mapview setSelectedAnnotations:@[[[self.mapview annotations] lastObject]]];
    [self.mapViewApple setShowsUserLocation:YES];
}


-(void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control
{
    
    id <MKAnnotation> annotation = [view annotation];
    if ([annotation isKindOfClass:[MKPointAnnotation class]])
    {
                NSLog(@"Clicked Place");
                NSLog(@"%@",[annotation title]);
                NSLog(@"%f",[annotation coordinate].latitude);
                NSLog(@"%f",[annotation coordinate].longitude);
        
    }
    
}
- (IBAction)CurrentLocationTapped:(id)sender
{

//    let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
//    let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
//    self.map.setRegion(region, animated: true)
    
 
    
//    [mapView_ clear];
    locationManager = [[CLLocationManager alloc] init];
    locationManager.distanceFilter = kCLDistanceFilterNone;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    locationManager.delegate = self;
    [locationManager startUpdatingLocation];
    [locationManager requestWhenInUseAuthorization];
    [locationManager requestAlwaysAuthorization];
    float latitude = locationManager.location.coordinate.latitude;
    float longitude = locationManager.location.coordinate.longitude;
    self.mapViewApple.delegate=self;
    self.mapViewApple.showsTraffic=YES;
    self.mapViewApple.showsCompass = YES;
    self.mapViewApple.showsBuildings = YES;
    
    CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(latitude, longitude);
    MKCoordinateRegion region = [self.mapViewApple regionThatFits:MKCoordinateRegionMakeWithDistance(CLLocationCoordinate2DMake(latitude, longitude), 200, 200)];
    
    [self.mapViewApple setRegion:region animated:YES];
    
    
//    NSString * Driverlat=[NSString stringWithFormat:@"%.15f", latitude];
//    NSString * Driverlong=[NSString stringWithFormat:@"%.15f", longitude];
//    if(!([CLLocationManager authorizationStatus] == kCLAuthorizationStatusAuthorizedAlways))
//    {
//        if ([locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
//
//            [locationManager requestWhenInUseAuthorization];
//            [locationManager startUpdatingLocation];
//            [locationManager requestAlwaysAuthorization];
//
//        }
//    }
//    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:[Driverlat doubleValue]
//                                                            longitude:[Driverlong doubleValue]
//                                                                 zoom:16];
//    mapView_ = [GMSMapView mapWithFrame:CGRectMake(0,0, self.view.frame.size.width, self.Home_page_map.frame.size.height) camera:camera];
//    mapView_.delegate = self;
//    mapView_.myLocationEnabled = YES;
//    [self.Home_page_map addSubview:mapView_];
//    NSError* error;
//    NSBundle *mainBundle = [NSBundle mainBundle];
//    NSURL *styleUrl = [mainBundle URLForResource:@"MapStyle" withExtension:@"json"];
//    // Set the map style by passing the URL for style.json.
//    GMSMapStyle *style = [GMSMapStyle styleWithContentsOfFileURL:styleUrl error:&error];
//
//    if (!style) {
//        NSLog(@"The style definition could not be loaded: %@", error);
//    }
//    mapView_.mapStyle = style;
}

- (IBAction)LocationBackTapped:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
@end
