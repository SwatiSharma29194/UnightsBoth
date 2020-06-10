  //
//  ViewControllerEvents.m
//  UNiGHTS
//
//  Created by user on 13/06/18.
//  Copyright © 2018 RVTechnologies Softwares PVT. LTD. All rights reserved.
//

#import "ViewControllerEvents.h"
#import "TableViewCellTonight.h"
#import "SWRevealViewController.h"
#import <GoogleMaps/GoogleMaps.h>
#import <GooglePlaces/GooglePlaces.h>
#import <GoogleMaps/GoogleMaps.h>
#import <GooglePlaces/GooglePlaces.h>
#import <CoreLocation/CoreLocation.h>
#import "common.h"
#include "markerViews.h"
#import "SVProgressHUD.h"
#import "UIImageView+WebCache.h"
#import "ViewControllerDescription.h"
#import "SidebarTableViewController.h"
#import <MapKit/MapKit.h>
#import "CalloutAnnotationView.h"

@interface ViewControllerEvents ()<GMSMapViewDelegate,CLLocationManagerDelegate,GMSAutocompleteTableDataSourceDelegate,UITableViewDelegate,UITableViewDataSource,GMSAutocompleteViewControllerDelegate,UIScrollViewDelegate,MKMapViewDelegate>

@property (nonatomic) CGFloat lastContentOffset;
@end

@implementation ViewControllerEvents

NSMutableArray * Post_type_array;
NSMutableArray * Post_type_Latarray;
NSMutableArray * Post_type_Longarray;
NSString * QueryPickerdataSeleted;
NSMutableArray * EventImages;
BOOL getlistMap;
NSString *param;
CLLocationManager *EventslocationManager;
CLGeocoder *Eventsgeocoder;
CLPlacemark *Eventsplacemark;
NSString *getSt;
NSString *LatN;
NSString * LongN;
NSString *LatN2;
NSString * LongN3;
GMSMapView *EventsmapView_;
NSString *eventWeek;
NSString *eventMonth;
NSMutableArray *getEventArr;
int valueSave;
int valueSave2;
int valueSave3;
int getWe;
int scrollInt;
int a;
int b;
int page;
NSString* cityNameChose;
NSString *eventTonight;
 UIDatePicker *myPickerView;
UIButton *btn_cancel;
UIView * selectView;
int page;
NSString *dateFetch;
NSString * getIdCancel;
NSMutableArray *getLocationName;
NSMutableArray *ArrInfo;
NSDictionary *bb;
NSString * next_page_url;
NSMutableArray *ArrInfo2;
 NSArray*getf;
NSString *getDD;
NSString *gettype;
    SidebarTableViewController *getS;

- (void)viewDidLoad {
    [super viewDidLoad];
  
    self.mapApple2.delegate = self;
    a = 0;
    b = 0;
    _EventsScrollView.tag = 1;
    EventImages =[[NSMutableArray alloc]init];
    Post_type_Longarray =[[NSMutableArray alloc]init];
     Post_type_Latarray =[[NSMutableArray alloc]init];
    getEventArr =[[NSMutableArray alloc]init];
 eventMonth = @"";
    eventWeek = @"";
    eventTonight= @"1";
    scrollInt = 0;
    valueSave = 0;
     valueSave2 = 0;
     valueSave3 = 0;
    getWe = 0;
    _EventsScrollView.delegate = self;
    // Load mAPvIEW
    getlistMap = false;
    
    EventslocationManager.distanceFilter = kCLDistanceFilterNone;
    EventslocationManager.desiredAccuracy = kCLLocationAccuracyBest;
    EventslocationManager.delegate = self;
    [EventslocationManager startUpdatingLocation];
    [EventslocationManager requestWhenInUseAuthorization];
    [EventslocationManager requestAlwaysAuthorization];
    double latitude = EventslocationManager.location.coordinate.latitude;
    double longitude = EventslocationManager.location.coordinate.longitude;
 //   _monthBtn.userInteractionEnabled = NO;
//    NSString * Driverlat=[NSString stringWithFormat:@"%.15f", latitude];
//    NSString * Driverlong=[NSString stringWithFormat:@"%.15f", longitude];
    if(!([CLLocationManager authorizationStatus] == kCLAuthorizationStatusAuthorizedAlways))
    {
        if ([EventslocationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
            
            [EventslocationManager requestWhenInUseAuthorization];
            [EventslocationManager startUpdatingLocation];
            [EventslocationManager requestAlwaysAuthorization];
            
        }
    }
    //GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:[Driverlat doubleValue]
//                                                            longitude:[Driverlong doubleValue]
//                                                                 zoom:5];

//    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:EventslocationManager.latitude
//                                                                longitude:longitude
//                                                                     zoom:7];
    
//    [[NSUserDefaults standardUserDefaults]setValue:getLong forKey:@"getLong"];
//    [[NSUserDefaults standardUserDefaults]setValue:getLat forKey:@"getLat"];



//    EventsmapView_.delegate = self;
//    EventsmapView_.myLocationEnabled = YES;
//    EventsmapView_.settings.scrollGestures = YES;
//    EventsmapView_.settings.zoomGestures = YES;
  //  [self.SrollingMapview addSubview:EventsmapView_];
    NSError* error;
    NSBundle *mainBundle = [NSBundle mainBundle];
    NSURL *styleUrl = [mainBundle URLForResource:@"MapStyle" withExtension:@"json"];
    // Set the map style by passing the URL for style.json.
    GMSMapStyle *style = [GMSMapStyle styleWithContentsOfFileURL:styleUrl error:&error];
    NSString * sd= [[NSUserDefaults standardUserDefaults] valueForKey:@"getLat"];
    NSString * sd2= [[NSUserDefaults standardUserDefaults] valueForKey:@"getLong"];
    double latdouble = [sd doubleValue];
    NSLog(@"latdouble: %f", latdouble);
    
    double lngdouble = [sd2 doubleValue];
    NSLog(@"latdouble: %f", lngdouble);
//    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:latdouble longitude:lngdouble zoom:14];
//
//    EventsmapView_ = [GMSMapView mapWithFrame:CGRectMake(0,0, self.view.frame.size.width, self.SrollingMapview.frame.size.height) camera:camera];
//    EventsmapView_.delegate = self;
//    EventsmapView_.myLocationEnabled = YES;
//    EventsmapView_.settings.scrollGestures = YES;
//    EventsmapView_.settings.zoomGestures = YES;
//    [self.SrollingMapview addSubview:EventsmapView_];
    
    
//    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(26,15,60,60)];
//    label.text = [NSString stringWithFormat:@"%d",d+1];
//    //label.font = ...;
//    [label sizeToFit];
//
   
//    [view2 addSubview:label];
    //i.e. customize view to get what you need
    
    
//    UIImage *markerIcon = [self imageFromView:view2];
  //  _london.icon = markerIcon;
  //  _london.map = mapView_;
    if (!style) {
        NSLog(@"The style definition could not be loaded: %@", error);
    }
   // EventsmapView_.mapStyle = style;
   // [self GetUsersOnMap];
    
//    [EventImages addObject:@"1.jpg"];
//    [EventImages addObject:@"2.jpg"];
//    [EventImages addObject:@"3.jpg"];
//    [EventImages addObject:@"4.jpg"];
//    [EventImages addObject:@"5.JPG"];
//    [EventImages addObject:@"7.jpeg"];
//    [EventImages addObject:@"9.jpg"];
//    [EventImages addObject:@"6.jpg"];
//    [EventImages addObject:@"8.jpg"];
//    [EventImages addObject:@"10.jpg"];
//    [EventImages addObject:@"11.jpg"];

    
    Post_type_array =[[NSMutableArray alloc]init];
    
//    if([UserRole  isEqual: @"0"])
//    {
//        _SelectedLocation.text = @"Nearby";
//        [Post_type_array addObject:@"Nearby"];
//        [Post_type_array addObject:@"Nottingham"];
//        [Post_type_array addObject:@"Birmingham"];
//        [Post_type_array addObject:@"Leeds"];
//        [Post_type_array addObject:@"Sheffield"];
//        [Post_type_array addObject:@"Leicester"];
//        [Post_type_array addObject:@"Manchester"];
//    }
//    else
//    {
//        _SelectedLocation.text = @"Nottingham";
//        [Post_type_array addObject:@"Nottingham"];
//        [Post_type_array addObject:@"Birmingham"];
//        [Post_type_array addObject:@"Leeds"];
//        [Post_type_array addObject:@"Sheffield"];
//        [Post_type_array addObject:@"Leicester"];
//        [Post_type_array addObject:@"Manchester"];
//    }
  
    
//    Post_type_Studentarray =[[NSMutableArray alloc]init];
//    [Post_type_Studentarray addObject:@"Nottingham"];
//    [Post_type_Studentarray addObject:@"Birmingham"];
//    [Post_type_Studentarray addObject:@"Leeds"];
//    [Post_type_Studentarray addObject:@"Sheffield"];
//    [Post_type_Studentarray addObject:@"Leicester"];
//    [Post_type_Studentarray addObject:@"Manchester"];
    
    
    self.revealViewController.delegate = self;
    self.automaticallyAdjustsScrollViewInsets = NO;
    SWRevealViewController *revealViewController = self.revealViewController;
    CGSize screenSize=[[UIScreen mainScreen] bounds].size;
    
    UIImageView *header = [[UIImageView alloc] initWithFrame:CGRectMake(0,0,screenSize.width,64)];
    
    [header setBackgroundColor:[UIColor clearColor]];
    header.userInteractionEnabled=YES;
    [self.view addSubview:header];
    

    UIButton *navigationButton=[[UIButton alloc] init];
    [navigationButton setExclusiveTouch:YES];
    
    NSLog(@"%.0f", [[UIScreen mainScreen] bounds].size.width);
    NSLog(@"%.0f", [[UIScreen mainScreen] bounds].size.height);
    if ([[UIScreen mainScreen] bounds].size.height == 812)
    {
     navigationButton.frame = CGRectMake(12, 38, 25, 17);
    }
    else
    {
       navigationButton.frame = CGRectMake(12, 27, 25, 17);
    }
    navigationButton.userInteractionEnabled=YES;
    navigationButton.contentMode=UIViewContentModeCenter;
    navigationButton.showsTouchWhenHighlighted = NO;
    navigationButton.imageView.contentMode=UIViewContentModeScaleAspectFit;
    navigationButton.userInteractionEnabled=YES;
    navigationButton.multipleTouchEnabled=YES;
    [navigationButton setImage:[UIImage imageNamed:@"HumburgerIcon"]forState:UIControlStateNormal];
    [navigationButton addTarget:self.revealViewController action:@selector(revealToggle:) forControlEvents:UIControlEventTouchUpInside];
    revealViewController.rearViewRevealWidth = self.view.frame.size.width-50;
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    [header addSubview:_AutoCompleteBtn];
    [header addSubview:_MapViewBtn];
    [header addSubview:_ListViewbtn];
    [header addSubview:_AutoCompleteBtn];
    [header addSubview:navigationButton];
    _GrayBlackTransperant.hidden=YES;
    _LocationPickerView.hidden=YES;
    _DoneBtn.layer.cornerRadius=5;
    _DoneBtn.clipsToBounds=YES;
    _cancelBtn.layer.cornerRadius=5;
    _cancelBtn.clipsToBounds=YES;
    _LocationPickerView.layer.cornerRadius=7;
    _LocationPickerView.clipsToBounds=YES;
    [_EventsScrollView setContentSize:CGSizeMake(self.EventsScrollView.frame.size.width*3, self.EventsScrollView.frame.size.height)];
    
    [_MapViewScroll setContentSize:CGSizeMake(self.MapViewScroll.frame.size.width*3, self.MapViewScroll.frame.size.height)];
    _MapViewScroll.hidden=YES;
      [self getCities];
}
-(void)getCities{
    NSURLSession *session = [NSURLSession sharedSession];
    [Post_type_array removeAllObjects];
   
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
         [SVProgressHUD showWithStatus:@"Please wait.." maskType:SVProgressHUDMaskTypeBlack];
    });
    NSString *URL = @"http://18.188.52.230/unights/public/api/get-cities";
    

    
    NSURL *theURL = [NSURL URLWithString:URL];
    
    NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:theURL cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:30.0f];
    
    
    
    NSString *strBearer =@"Bearer ";
    NSString *strAccessToken =  [[NSUserDefaults standardUserDefaults]objectForKey:@"acessToken"];
    [theRequest setHTTPMethod:@"GET"];
    
    [theRequest setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    
    [theRequest setValue:[strBearer stringByAppendingString:strAccessToken] forHTTPHeaderField:@"Authorization"];
    
    [theRequest setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    
     NSURLSessionDataTask * task=  [session dataTaskWithRequest:theRequest completionHandler:^(NSData *  data, NSURLResponse * response, NSError *  error) {
    
//    [NSURLConnection sendAsynchronousRequest:theRequest queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
    
        // if(data != nil){
        
        
        
        NSString *noti = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        
        //  NSLog(@"Response:: %@", noti);
        
        
        
        if(data!=nil){
            
            NSError *jsonError;
            
            NSData *objectdata = [noti dataUsingEncoding:NSUTF8StringEncoding];
            
            
            
            NSDictionary *json = [NSJSONSerialization JSONObjectWithData:objectdata
                                  
                                                                 options:NSJSONReadingMutableContainers
                                  
                                                                   error:&jsonError];
            NSString * getSuccess;
            
            getSuccess = [NSString stringWithFormat:@"%@",[json valueForKey:@"success"]];
            
            if([getSuccess  isEqual: @"1"])
            {
                
                NSLog(@"%@",json);
            
                
               NSArray *getArr=[json valueForKey:@"data"];
                
                if([UserRole  isEqual: @"0"])
                {
                    [Post_type_array addObject:@"Nearby"];
                    [Post_type_Latarray addObject:[NSString stringWithFormat:@"%f",EventslocationManager.location.coordinate.latitude]];
                    [Post_type_Longarray addObject:[NSString stringWithFormat:@"%f",EventslocationManager.location.coordinate.longitude]];
                    getSt = @"";
                    cityNameChose = @"";
                    //                    LatN2 = @"36.3232";
                    //                    LongN3 = @"70.43434";
                    
                    LatN2 = [[NSUserDefaults standardUserDefaults]valueForKey:@"getLat"];
                    LongN3 = [[NSUserDefaults standardUserDefaults]valueForKey:@"getLong"];
                    dispatch_async(dispatch_get_main_queue(), ^{
                        
                     
                  
             
                    _SelectedLocation.text = @"Nearby";
                   
                     
                    });
                    
                }
                else
                {
                     dispatch_async(dispatch_get_main_queue(), ^{
                         
                         _SelectedLocation.text = @"Nottingham";
                     });
                    
                    getSt = @"1";
                    cityNameChose = @"Nottingham";
                    LatN2 = @"";
                    LongN3 = @"";

                    
                }
                int i = 0;
                
                for (i =0;i<getArr.count;i++)
                {
                    NSDictionary *getdict = [getArr objectAtIndex:i];
                    NSString *getSt = [getdict valueForKey:@"city"];
                    [Post_type_array addObject:getSt];
                    NSString *getStLat = [getdict valueForKey:@"latitude"];
                    [Post_type_Latarray addObject:getStLat];
                    
                    NSString *getStLong = [getdict valueForKey:@"longitude"];
                    [Post_type_Longarray addObject:getStLong];
                  
                                    }
                
               
               
               
                //cityNameChose = @"Nottingham";
//                _LocationPicker.delegate = self;
//                _LocationPicker.dataSource = self;
                dispatch_async(dispatch_get_main_queue(), ^{
                      [_LocationPicker reloadAllComponents];
                    [SVProgressHUD dismiss];
                });
              
                
               valueSave = 1;
                [self getEvents];
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                   [SVProgressHUD dismiss];
                });
                
            }
            
            //  NSLog(@"%@",user_name_array_mymatches);
            
            //   NSLog(@"%@",user_phone_array_mymatches);
            
            
            
            
            
            
        }
        else
            
        {
            
            UIAlertController * alert = [UIAlertController
                                         alertControllerWithTitle:@"UNiGHTS"
                                         message:@"Connection Error"
                                         preferredStyle:UIAlertControllerStyleAlert];
            
            //Add Buttons
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [SVProgressHUD dismiss];
            });
            
            
            UIAlertAction* noButton = [UIAlertAction
                                       actionWithTitle:@"OK"
                                       style:UIAlertActionStyleDefault
                                       handler:^(UIAlertAction * action) {
                                           //Handle no, thanks button
                                       }];
            
            //Add your buttons to alert controller
            
            
            [alert addAction:noButton];
            
            [self presentViewController:alert animated:YES completion:nil];
            
            // no internet
            
        }
        
    }];
    
    [task resume];
    
    
    
    
}
-(void) getPoints
{
    NSURLSession *session = [NSURLSession sharedSession];
    dispatch_async(dispatch_get_main_queue(), ^{
        
        [SVProgressHUD showWithStatus:@"Please wait.." maskType:SVProgressHUDMaskTypeBlack];
    });
   
    
    
    NSString *URL = @"http://18.188.52.230/unights/public/api/get-points";
    
    
    
    NSURL *theURL = [NSURL URLWithString:URL];
    
    NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:theURL cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:30.0f];
    
    
    
    NSString *strBearer =@"Bearer ";
    NSString *strAccessToken =  [[NSUserDefaults standardUserDefaults]objectForKey:@"acessToken"];
    [theRequest setHTTPMethod:@"GET"];
    
    [theRequest setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    
    [theRequest setValue:[strBearer stringByAppendingString:strAccessToken] forHTTPHeaderField:@"Authorization"];
    
    [theRequest setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    
     NSURLSessionDataTask * task=  [session dataTaskWithRequest:theRequest completionHandler:^(NSData *  data, NSURLResponse * response, NSError *  error) {
    
//    [NSURLConnection sendAsynchronousRequest:theRequest queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
    
        // if(data != nil){
        
        
        
        NSString *noti = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        
        //  NSLog(@"Response:: %@", noti);
        
        
        
        if(data!=nil){
            
            NSError *jsonError;
            
            NSData *objectdata = [noti dataUsingEncoding:NSUTF8StringEncoding];
            
            
            
            NSDictionary *json = [NSJSONSerialization JSONObjectWithData:objectdata
                                  
                                                                 options:NSJSONReadingMutableContainers
                                  
                                                                   error:&jsonError];
            NSString * getSuccess;
            
            getSuccess = [NSString stringWithFormat:@"%@",[json valueForKey:@"success"]];
            
            if([getSuccess  isEqual: @"1"])
            {
              
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                   [SVProgressHUD dismiss];
                });
                
                if(!([[json valueForKey:@"points"] isKindOfClass:[NSNull class]]))
                {
                    NSString *points = [NSString stringWithFormat:@"%@",[json valueForKey:@"points"]];
                    
                    [NSUserDefaults.standardUserDefaults setValue:points forKey:@"pointsEarn"];
                    [[NSNotificationCenter defaultCenter]
                     postNotificationName:@"TestNotification"
                     object:self];
                }
              else
              {
                  NSString *points = @"0";
                  
                  [NSUserDefaults.standardUserDefaults setValue:points forKey:@"stripe_account"];
              }
                
                
            }
            
            else
            {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [SVProgressHUD dismiss];
                    
                });
                UIAlertController * alert=[UIAlertController
                                           
                                           alertControllerWithTitle:@"Message!" message:@"Something went wrong" preferredStyle:UIAlertControllerStyleAlert];
                
                UIAlertAction* yesButton = [UIAlertAction
                                            
                                            actionWithTitle:@"Ok"
                                            
                                            style:UIAlertActionStyleDefault
                                            
                                            handler:^(UIAlertAction * action)
                                            
                                            {
                                                
                                                
                                                
                                            }];
                
                
                
                [alert addAction:yesButton];
                
                [self presentViewController:alert animated:YES completion:nil];
            }
            
            //  NSLog(@"%@",user_name_array_mymatches);
            
            //   NSLog(@"%@",user_phone_array_mymatches);
            
            
            
            
            
            
        }
        else
            
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [SVProgressHUD dismiss];
            });
            
            UIAlertController * alert=[UIAlertController
                                       
                                       alertControllerWithTitle:@"Message!" message:@"Something went wrong" preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction* yesButton = [UIAlertAction
                                        
                                        actionWithTitle:@"Ok"
                                        
                                        style:UIAlertActionStyleDefault
                                        
                                        handler:^(UIAlertAction * action)
                                        
                                        {
                                            
                                            
                                            
                                        }];
            
            
            
            [alert addAction:yesButton];
            
            [self presentViewController:alert animated:YES completion:nil];
            
            // no internet
            
        }
        
    }];
    [task resume];
}
//- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView
//                  willDecelerate:(BOOL)decelerate
//{
//    int page = scrollView.contentOffset.x / scrollView.frame.size.width;
//
//    NSLog(@"%d",page);
//
//
//}

//-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
//{
//    page = scrollView.contentOffset.x / scrollView.frame.size.width;
//
//    NSLog(@"%f",_lastContentOffset);
//
//    NSLog(@"%f",scrollView.contentOffset.y);
//      NSLog(@"%f",scrollView.contentOffset.x);
//      NSLog(@"%f",self.lastContentOffset);
//
////    if (self.lastContentOffset < scrollView.contentOffset.x)
////    {
////
////        // moved right
////        NSLog(@"Right");
////        [self updateApiData];
////    }
////    else if (self.lastContentOffset > scrollView.contentOffset.x)
////    {
////        // moved left
////        NSLog(@"Left");
////        [self updateApiData];
////    }
////    else
////    {
////        // didn't move
////        NSLog(@"Updown");
////    }
//
//    if (self.lastContentOffset < (int)scrollView.contentOffset.x)
//    {
//        NSLog(@"Scrolled Right");
//        [self updateApiData];
//    }
//    else if (_lastContentOffset> (int)scrollView.contentOffset.x) {
//        NSLog(@"Scrolled Left");
//    }
//
//    else if (_lastContentOffset < scrollView.contentOffset.y)
//    {
//        NSLog(@"Scrolled Down");
//    }
//
//    else if (_lastContentOffset > scrollView.contentOffset.y)
//    {
//        NSLog(@"Scrolled Up");
//    }
//    else if(scrollView.contentOffset.y == 0 && !(scrollView.contentOffset.x == 0))
//    {
//        NSLog(@"Scrolled Up");
//
//    }
//    else
//    {
//         [self updateApiData];
//    }
//
//}
//
//-(void)updateApiData
//{
//    if(page == 0)
//    {
//        _view1.hidden = NO;
//        _view2.hidden = YES;
//        _view3.hidden = YES;
//
//        eventWeek = @"";
//        eventMonth = @"";
//
//
//    }
//    if(page == 1)
//    {
//        _view1.hidden = YES;
//        _view2.hidden = NO;
//        _view3.hidden = YES;
//        eventWeek = @"1";
//        eventMonth = @"";
//
//
//    }
//    if(page == 2)
//    {
//        _view1.hidden = YES;
//        _view2.hidden = YES;
//        _view3.hidden = NO;
//        eventWeek = @"";
//        eventMonth = @"1";
//
//
//    }
//    NSLog(@"%dddd",page);
//
//    [self getEvents];
//}
- (IBAction)tonoghtBtn:(id)sender {
    gettype = @"1";
    self.EventsScrollView.contentOffset = CGPointMake(0, 0);
    
    _view1.hidden = NO;
    _view2.hidden = YES;
    _view3.hidden = YES;
    if (valueSave == 1) {
        valueSave = 0;
    }
    

//    if (valueSave == 2) {
//        valueSave = 0;
//
//    }
    
    if (valueSave == 0) {
        
        
        eventWeek = @"";
        eventMonth = @"";
        eventTonight = @"1";
        dateFetch = @"";
        //  _monthBtn.userInteractionEnabled = NO;
        [myPickerView removeFromSuperview];
        [selectView removeFromSuperview];
        
        [self getEvents];
        valueSave = 1;
    }

   
    
//    valueSave = 1;
}

- (IBAction)thisWeekBtn:(id)sender {
     gettype = @"1";
    self.EventsScrollView.contentOffset = CGPointMake(self.EventsScrollView.frame.size.width, 0);
    _view1.hidden = YES;
    _view2.hidden = NO;
    _view3.hidden = YES;
    
    
    if (valueSave == 1) {
        eventWeek = @"1";
        eventMonth = @"";
        eventTonight = @"";
        dateFetch = @"";
        [myPickerView removeFromSuperview];
        [selectView removeFromSuperview];
        //    _monthBtn.userInteractionEnabled = NO;
        [self getEvents];
        valueSave = 2;
    }
    
    
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    

//
//    if([gettype isEqualToString: @"1"])
//    {
//        int getP = scrollView.contentOffset.x / scrollView.frame.size.width;
//        page = getP - 1;
//    }
//        else
//        {
    
      page = scrollView.contentOffset.x / scrollView.frame.size.width;
     //   }

    if(scrollView.tag == 1)
    {
    if(page == 0)
    {


        _view1.hidden = NO;
        _view2.hidden = YES;
        _view3.hidden = YES;
        
        if (valueSave == 2) {
            valueSave = 0;
        }
       
        if (valueSave == 0) {
            
            
            eventWeek = @"";
            eventMonth = @"";
            eventTonight = @"1";
            dateFetch = @"";
          //  _monthBtn.userInteractionEnabled = NO;
            [myPickerView removeFromSuperview];
            [selectView removeFromSuperview];
            [self getEvents];
        }
        valueSave = 1;
    }
    if(page == 1)
    {
        _view1.hidden = YES;
        _view2.hidden = NO;
        _view3.hidden = YES;
     
        
        if (valueSave == 1) {
            eventWeek = @"1";
            eventMonth = @"";
            eventTonight = @"";
            dateFetch = @"";
            [myPickerView removeFromSuperview];
            [selectView removeFromSuperview];
        //    _monthBtn.userInteractionEnabled = NO;
            [self getEvents];
        }
        
        valueSave = 2;
    }

    if(page == 2)
    {
    _view1.hidden = YES;
    _view2.hidden = YES;
    _view3.hidden = NO;
    
        if (valueSave == 2) {
            eventWeek = @"";
            eventMonth = @"1";
            eventTonight = @"";
          //  _monthBtn.userInteractionEnabled = YES;
            NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
            [dateFormatter setDateFormat:@"yyyy-MM-dd"];
            // or @"yyyy-MM-dd hh:mm:ss a" if you prefer the time with AM/PM
        
            dateFetch = [dateFormatter stringFromDate:[NSDate date]];
            
             [self showPicker];
            [self getEvents];
        }

    valueSave = 1;
    }
    
    NSLog(@"%dddd",page);
    }
    
    gettype = @"";
}


-(void)revealController:(SWRevealViewController *)revealController didMoveToPosition:(FrontViewPosition)position
{
    if (revealController.frontViewPosition == 4) {
        UIView *lockingView = [[UIView alloc] initWithFrame:revealController.frontViewController.view.frame];
        //[lockingView setBackgroundColor:[UIColor lightGrayColor]];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:revealController action:@selector(revealToggle:)];
        [lockingView addGestureRecognizer:tap];
        [lockingView setTag:1000];
        revealController.rearViewRevealWidth = self.view.frame.size.width-50;
        
        [revealController.frontViewController.view addSubview:lockingView];
    }
    else
        [[revealController.frontViewController.view viewWithTag:1000] removeFromSuperview];
    
}

- (UIView *)mapView:(GMSMapView *)mapView markerInfoWindow:(GMSMarker *)marker
{
    
    markerViews * Cview = [[[NSBundle mainBundle] loadNibNamed:@"markerViews" owner:nil options:nil] firstObject];
     dispatch_async(dispatch_get_main_queue(), ^{
         int a = [marker.accessibilityLabel intValue];
         NSString *getT = marker.title;
         
         NSLog(@"%@getvvv",getT);
         NSArray *getS = [getT componentsSeparatedByString:@"\\"];
         NSLog(@"%@getvvv",getS);
         
         
    Cview.eventName.text = getS[1];
         
    Cview.StartTime.text = getS[2];
         
     Cview.endTime.text = getS[3];
         
     [Cview.imgevent sd_setImageWithURL:[NSURL URLWithString:getS[4]]];
         
    getDD = getS[0];
         
    for (int i = 0 ;i<getLocationName.count;i++)
    {
        Cview.eventName.text = getLocationName[i];
    }
    
    
    Cview.layer.cornerRadius = 8;
    
    Cview.clipsToBounds = YES;
     
    

    
         });
    return Cview;
}


-(void)viewWillAppear:(BOOL)animated
{
     if([UserRole  isEqual: @"0"])
     {
    [self getPoints];
     }
    else
    {

    }
 
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)mapView:(GMSMapView *)mapView didTapInfoWindowOfMarker:(GMSMarker *)marker
{
    UIStoryboard *obj=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
    ViewControllerDescription *str=[obj instantiateViewControllerWithIdentifier:@"ViewControllerDescription"];
    str.getIdEvent = getDD;
    [self.navigationController pushViewController:str animated:true];
    
}
- (IBAction)monthBtnTap:(id)sender {

  gettype = @"1";

    self.EventsScrollView.contentOffset = CGPointMake(self.EventsScrollView.frame.size.width * 2, 0);
//
    _view1.hidden = YES;
    _view2.hidden = YES;
    _view3.hidden = NO;
     if (valueSave == 1)
     {
         valueSave = 2;
     }
    if (valueSave == 2) {
        
        eventWeek = @"";
        
        eventMonth = @"1";
        
        eventTonight = @"";
        
        //  _monthBtn.userInteractionEnabled = YES;
        NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
        
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        // or @"yyyy-MM-dd hh:mm:ss a" if you prefer the time with AM/PM
        
        dateFetch = [dateFormatter stringFromDate:[NSDate date]];
        
        [self showPicker];
        
        [self getEvents];
        
        valueSave = 1;
    }
    
  
    
 }


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return ArrInfo.count;
}

-(void)btnProposeAnOfferFunction :(UIButton *)sender{



    NSDictionary * j = [getEventArr objectAtIndex:sender.tag];

    getIdCancel = [NSString stringWithFormat:@"%@",[j valueForKey:@"id"]];

   
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if(tableView == _TonightTable)
    {
    
  
        
        static NSString *cellIdentifier = @"TableViewCellTonight";
        TableViewCellTonight * contest_cell = (TableViewCellTonight *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        
        if (contest_cell == nil) {
            NSArray *nib =[[NSBundle mainBundle]loadNibNamed:@"TableViewCellTonight" owner:self options:nil];
            contest_cell=[nib objectAtIndex:0];
        }
        
//    contest_cell.closeBooking.hidden = NO;
//            contest_cell.closeBooking.tag = indexPath.row;
//        [contest_cell.closeBooking addTarget:self action:@selector(btnProposeAnOfferFunction :) forControlEvents:UIControlEventTouchUpInside];

    NSDictionary * j = [ArrInfo objectAtIndex:indexPath.row];
       
    NSString * getEventname = [NSString stringWithFormat:@"%@",[j valueForKey:@"event_name"]];
       // venue name, city and post code

    NSString * getEventAddr = [NSString stringWithFormat:@"%@",[j valueForKey:@"venue_address"]];
            NSString * getnameevent = [NSString stringWithFormat:@"%@",[j valueForKey:@"venue_name"]];
            NSString * getEventcity = [NSString stringWithFormat:@"%@",[j valueForKey:@"city"]];
        NSString * getEventpost = [NSString stringWithFormat:@"%@",[j valueForKey:@"post_code"]];
        
    
    NSString * getEventtime = [NSString stringWithFormat:@"%@",[j valueForKey:@"start_time"]];
    
    NSString * getEventDate = [NSString stringWithFormat:@"%@",[j valueForKey:@"start_date"]];
      NSString * ticketType = [NSString stringWithFormat:@"%@",[j valueForKey:@"ticket_type"]];
        if([ticketType  isEqual: @"1"])
        {
            contest_cell.viewColour.backgroundColor = [UIColor redColor];
            contest_cell.typeTicket.text = @"SELL TICKETS";
        }
       else if([ticketType  isEqual: @"0"])
        {
            contest_cell.viewColour.backgroundColor = [UIColor greenColor];
            contest_cell.typeTicket.text = @"FREE TICKETS";
        }
        else
        {
            contest_cell.viewColour.backgroundColor = [UIColor yellowColor];
            contest_cell.typeTicket.text = @"PAY ON DOOR";
        }
    NSArray * getEventArr = [j valueForKey:@"event_images"];
        NSDictionary *getDictImage = [getEventArr objectAtIndex:0];
        
        NSString * getEventImg = [NSString stringWithFormat:@"%@",[getDictImage valueForKey:@"image"]];
    NSString * ImgbaseUrl = @"http://18.188.52.230/unights/public/events/";
    
    if (getEventname.length==0 || [getEventname isEqual:[NSNull null]] || [getEventname isEqualToString:@""] ||  [getEventname isKindOfClass:[NSNull class]] || getEventname == (id)[NSNull null])
    {
        contest_cell.eventName.text = @"";
    }
    else
    {
        contest_cell.eventName.text = getEventname;
    }
    
    if (getnameevent.length==0 || [getnameevent isEqual:[NSNull null]] || [getnameevent isEqualToString:@""] ||  [getnameevent isKindOfClass:[NSNull class]] || getnameevent == (id)[NSNull null])
    {
        contest_cell.eventAddress.text = @"";
    }
    else
    {
//        NSString * getnameevent = [NSString stringWithFormat:@"%@",[j valueForKey:@"venue_name"]];
//        NSString * getEventcity = [NSString stringWithFormat:@"%@",[j valueForKey:@"city"]];
//        NSString * getEventpost = [NSString stringWithFormat:@"%@",[j valueForKey:@"post_code"]];
        contest_cell.eventAddress.text = [NSString stringWithFormat:@"%@%@%@%@%@%@%@%@",getnameevent,@",",@" ",getEventcity,@",",@" ",@" ",getEventpost];
    }
    
    if (getEventtime.length==0 || [getEventtime isEqual:[NSNull null]] || [getEventtime isEqualToString:@""] ||  [getEventtime isKindOfClass:[NSNull class]] || getEventtime == (id)[NSNull null])
    {
        contest_cell.timeLbl.text = @"";
        contest_cell.AMPM.text = @"";
    }
    else
    {
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"HH:mm:ss"];
        NSDate *date = [dateFormatter dateFromString:getEventtime];
        NSCalendar *calendar = [NSCalendar currentCalendar];
        NSDateComponents *components = [calendar components:(NSCalendarUnitHour | NSCalendarUnitMinute) fromDate:date];
        NSInteger hour = [components hour];
        NSInteger minute = [components minute];
        
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"hh:mm a"];
        NSLog(@"Current Date: %@", [formatter stringFromDate:date]);
        NSString * getdate = [formatter stringFromDate:date];
        
        contest_cell.timeLbl.text = getdate;
        
        NSLog(@"testing");
        
    }
    
    if (getEventDate.length==0 || [getEventDate isEqual:[NSNull null]] || [getEventDate isEqualToString:@""] ||  [getEventDate isKindOfClass:[NSNull class]] || getEventDate == (id)[NSNull null])
    {
        contest_cell.eventday.text = @"";
        contest_cell.EventMonth.text = @"";
    }
    else
    {
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        NSDate *date = [dateFormatter dateFromString:getEventDate];
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"MMM dd"];
        NSLog(@"Current Date: %@", [formatter stringFromDate:date]);
        NSString * getdate = [formatter stringFromDate:date];
        
        
        contest_cell.EventMonth.text = getdate;
        
        
      //  contest_cell.EventMonth.text = @"";
    }
    
    if (getEventImg.length==0 || [getEventImg isEqual:[NSNull null]] || [getEventImg isEqualToString:@""] ||  [getEventImg isKindOfClass:[NSNull class]] || getEventImg == (id)[NSNull null])
    {
        
    }
    else
    {
        ImgbaseUrl= [ImgbaseUrl stringByAppendingString:getEventImg];
        
        [contest_cell.EventBanner sd_setImageWithURL:[NSURL URLWithString:ImgbaseUrl]];
        
        
    }
    
    
    
    
    if (contest_cell == nil) {
        NSArray *nib =[[NSBundle mainBundle]loadNibNamed:@"TableViewCellTonight" owner:self options:nil];
        contest_cell=[nib objectAtIndex:0];
    }
    contest_cell.selectionStyle=UITableViewCellSelectionStyleNone;
  //  contest_cell.EventBanner.image=[UIImage imageNamed:[EventImages objectAtIndex:indexPath.row]];
    return contest_cell;
}
    
    else if (tableView == _thisweekTbl)
    {
        
        static NSString *cellIdentifier = @"TableViewCellTonight";
        TableViewCellTonight * contest_cell = (TableViewCellTonight *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (contest_cell == nil) {
            NSArray *nib =[[NSBundle mainBundle]loadNibNamed:@"TableViewCellTonight" owner:self options:nil];
            contest_cell=[nib objectAtIndex:0];
        }
//       contest_cell.closeBooking.hidden = NO;
        NSDictionary * j = [ArrInfo objectAtIndex:indexPath.row];
        
        NSString * getEventname = [NSString stringWithFormat:@"%@",[j valueForKey:@"event_name"]];
        
        NSString * getEventAddr = [NSString stringWithFormat:@"%@",[j valueForKey:@"venue_address"]];
        
        NSString * getEventtime = [NSString stringWithFormat:@"%@",[j valueForKey:@"start_time"]];
        
        NSString * getEventDate = [NSString stringWithFormat:@"%@",[j valueForKey:@"start_date"]];
        
        NSArray * getEventArr = [j valueForKey:@"event_images"];
        NSDictionary *getDictImage = [getEventArr objectAtIndex:0];
        
        NSString * getEventImg = [NSString stringWithFormat:@"%@",[getDictImage valueForKey:@"image"]];
        NSString * ticketType = [NSString stringWithFormat:@"%@",[j valueForKey:@"ticket_type"]];
        if([ticketType  isEqual: @"1"])
        {
            contest_cell.viewColour.backgroundColor = [UIColor redColor];
            contest_cell.typeTicket.text = @"SELL TICKETS";
        }
        else if([ticketType  isEqual: @"0"])
        {
            contest_cell.viewColour.backgroundColor = [UIColor greenColor];
            contest_cell.typeTicket.text = @"FREE TICKETS";
        }
        else
        {
            contest_cell.viewColour.backgroundColor = [UIColor yellowColor];
            contest_cell.typeTicket.text = @"PAY ON DOOR";
        }
        NSString * ImgbaseUrl = @"http://18.188.52.230/unights/public/events/";
        
        if (getEventname.length==0 || [getEventname isEqual:[NSNull null]] || [getEventname isEqualToString:@""] ||  [getEventname isKindOfClass:[NSNull class]] || getEventname == (id)[NSNull null])
        {
            contest_cell.eventName.text = @"";
        }
        else
        {
            contest_cell.eventName.text = getEventname;
        }
        
        if (getEventAddr.length==0 || [getEventAddr isEqual:[NSNull null]] || [getEventAddr isEqualToString:@""] ||  [getEventAddr isKindOfClass:[NSNull class]] || getEventAddr == (id)[NSNull null])
        {
            contest_cell.eventAddress.text = @"";
        }
        else
        {
            contest_cell.eventAddress.text = getEventAddr;
        }
        
        if (getEventtime.length==0 || [getEventtime isEqual:[NSNull null]] || [getEventtime isEqualToString:@""] ||  [getEventtime isKindOfClass:[NSNull class]] || getEventtime == (id)[NSNull null])
        {
            contest_cell.timeLbl.text = @"";
            contest_cell.AMPM.text = @"";
        }
        else
        {
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setDateFormat:@"HH:mm:ss"];
            NSDate *date = [dateFormatter dateFromString:getEventtime];
            NSCalendar *calendar = [NSCalendar currentCalendar];
            NSDateComponents *components = [calendar components:(NSCalendarUnitHour | NSCalendarUnitMinute) fromDate:date];
            NSInteger hour = [components hour];
            NSInteger minute = [components minute];
            
            
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            [formatter setDateFormat:@"hh:mm a"];
            NSLog(@"Current Date: %@", [formatter stringFromDate:date]);
            NSString * getdate = [formatter stringFromDate:date];
            
            contest_cell.timeLbl.text = getdate;
            
            NSLog(@"testing");
            
        }
        
        if (getEventDate.length==0 || [getEventDate isEqual:[NSNull null]] || [getEventDate isEqualToString:@""] ||  [getEventDate isKindOfClass:[NSNull class]] || getEventDate == (id)[NSNull null])
        {
            contest_cell.eventday.text = @"";
            contest_cell.EventMonth.text = @"";
        }
        else
        {
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setDateFormat:@"yyyy-MM-dd"];
            NSDate *date = [dateFormatter dateFromString:getEventDate];
            
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            [formatter setDateFormat:@"MMM dd"];
            NSLog(@"Current Date: %@", [formatter stringFromDate:date]);
            NSString * getdate = [formatter stringFromDate:date];
            
            
            contest_cell.EventMonth.text = getdate;
            
            
            //  contest_cell.EventMonth.text = @"";
        }
        
        if (getEventImg.length==0 || [getEventImg isEqual:[NSNull null]] || [getEventImg isEqualToString:@""] ||  [getEventImg isKindOfClass:[NSNull class]] || getEventImg == (id)[NSNull null])
        {
            
        }
        else
        {
            ImgbaseUrl= [ImgbaseUrl stringByAppendingString:getEventImg];
            
            [contest_cell.EventBanner sd_setImageWithURL:[NSURL URLWithString:ImgbaseUrl]];
            
            
        }
        
        
        
        
        if (contest_cell == nil) {
            NSArray *nib =[[NSBundle mainBundle]loadNibNamed:@"TableViewCellTonight" owner:self options:nil];
            contest_cell=[nib objectAtIndex:0];
        }
        contest_cell.selectionStyle=UITableViewCellSelectionStyleNone;
        //  contest_cell.EventBanner.image=[UIImage imageNamed:[EventImages objectAtIndex:indexPath.row]];
        return contest_cell;
    }
    
    else
    
    {
        
        
        static NSString *cellIdentifier = @"TableViewCellTonight";
        TableViewCellTonight * contest_cell = (TableViewCellTonight *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (contest_cell == nil) {
            NSArray *nib =[[NSBundle mainBundle]loadNibNamed:@"TableViewCellTonight" owner:self options:nil];
            contest_cell=[nib objectAtIndex:0];
        }
       // contest_cell.closeBooking.hidden = YES;
        NSDictionary * j = [ArrInfo objectAtIndex:indexPath.row];
        
        NSString * getEventname = [NSString stringWithFormat:@"%@",[j valueForKey:@"event_name"]];
        
        NSString * getEventAddr = [NSString stringWithFormat:@"%@",[j valueForKey:@"venue_address"]];
        
        NSString * getEventtime = [NSString stringWithFormat:@"%@",[j valueForKey:@"start_time"]];
        
        NSString * getEventDate = [NSString stringWithFormat:@"%@",[j valueForKey:@"start_date"]];
        
        NSArray * getEventArr = [j valueForKey:@"event_images"];
        NSDictionary *getDictImage = [getEventArr objectAtIndex:0];
        
        NSString * getEventImg = [NSString stringWithFormat:@"%@",[getDictImage valueForKey:@"image"]];
        NSString * ticketType = [NSString stringWithFormat:@"%@",[j valueForKey:@"ticket_type"]];
        if([ticketType  isEqual: @"1"])
        {
            contest_cell.viewColour.backgroundColor = [UIColor redColor];
            contest_cell.typeTicket.text = @"SELL TICKETS";
        }
        else if([ticketType  isEqual: @"0"])
        {
            contest_cell.viewColour.backgroundColor = [UIColor greenColor];
            contest_cell.typeTicket.text = @"FREE TICKETS";
        }
        else
        {
            contest_cell.viewColour.backgroundColor = [UIColor yellowColor];
            contest_cell.typeTicket.text = @"PAY ON DOOR";
        }
        NSString * ImgbaseUrl = @"http://18.188.52.230/unights/public/events/";
        
        if (getEventname.length==0 || [getEventname isEqual:[NSNull null]] || [getEventname isEqualToString:@""] ||  [getEventname isKindOfClass:[NSNull class]] || getEventname == (id)[NSNull null])
        {
            contest_cell.eventName.text = @"";
        }
        else
        {
            contest_cell.eventName.text = getEventname;
        }
        
        if (getEventAddr.length==0 || [getEventAddr isEqual:[NSNull null]] || [getEventAddr isEqualToString:@""] ||  [getEventAddr isKindOfClass:[NSNull class]] || getEventAddr == (id)[NSNull null])
        {
            contest_cell.eventAddress.text = @"";
        }
        else
        {
            contest_cell.eventAddress.text = getEventAddr;
        }
        
        if (getEventtime.length==0 || [getEventtime isEqual:[NSNull null]] || [getEventtime isEqualToString:@""] ||  [getEventtime isKindOfClass:[NSNull class]] || getEventtime == (id)[NSNull null])
        {
            contest_cell.timeLbl.text = @"";
            contest_cell.AMPM.text = @"";
        }
        else
        {
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setDateFormat:@"HH:mm:ss"];
            NSDate *date = [dateFormatter dateFromString:getEventtime];
            NSCalendar *calendar = [NSCalendar currentCalendar];
            NSDateComponents *components = [calendar components:(NSCalendarUnitHour | NSCalendarUnitMinute) fromDate:date];
            NSInteger hour = [components hour];
            NSInteger minute = [components minute];
            
            
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            [formatter setDateFormat:@"hh:mm a"];
            NSLog(@"Current Date: %@", [formatter stringFromDate:date]);
            NSString * getdate = [formatter stringFromDate:date];
            
            contest_cell.timeLbl.text = getdate;
            
            NSLog(@"testing");
            
        }
        
        if (getEventDate.length==0 || [getEventDate isEqual:[NSNull null]] || [getEventDate isEqualToString:@""] ||  [getEventDate isKindOfClass:[NSNull class]] || getEventDate == (id)[NSNull null])
        {
            contest_cell.eventday.text = @"";
            contest_cell.EventMonth.text = @"";
        }
        else
        {
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setDateFormat:@"yyyy-MM-dd"];
            NSDate *date = [dateFormatter dateFromString:getEventDate];
            
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            [formatter setDateFormat:@"MMM dd"];
            NSLog(@"Current Date: %@", [formatter stringFromDate:date]);
            NSString * getdate = [formatter stringFromDate:date];
            
            
            contest_cell.EventMonth.text = getdate;
            
            
            //  contest_cell.EventMonth.text = @"";
        }
        
        if (getEventImg.length==0 || [getEventImg isEqual:[NSNull null]] || [getEventImg isEqualToString:@""] ||  [getEventImg isKindOfClass:[NSNull class]] || getEventImg == (id)[NSNull null])
        {
            
        }
        else
        {
            ImgbaseUrl= [ImgbaseUrl stringByAppendingString:getEventImg];
            
            [contest_cell.EventBanner sd_setImageWithURL:[NSURL URLWithString:ImgbaseUrl]];
            
            
        }
        
        
        
        
        if (contest_cell == nil) {
            NSArray *nib =[[NSBundle mainBundle]loadNibNamed:@"TableViewCellTonight" owner:self options:nil];
            contest_cell=[nib objectAtIndex:0];
        }
        contest_cell.selectionStyle=UITableViewCellSelectionStyleNone;
        //  contest_cell.EventBanner.image=[UIImage imageNamed:[EventImages objectAtIndex:indexPath.row]];
        return contest_cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 190;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(tableView == _TonightTable)
    {
        NSDictionary * j = [ArrInfo objectAtIndex:indexPath.row];
        
        NSString * getEventId = [NSString stringWithFormat:@"%@",[j valueForKey:@"id"]];
    UIStoryboard *obj=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
    ViewControllerDescription *str=[obj instantiateViewControllerWithIdentifier:@"ViewControllerDescription"];
        str.getIdEvent = getEventId;
    [self.navigationController pushViewController:str animated:true];
    }
    
    else if (tableView == _thisweekTbl)
    {
        NSDictionary * j = [ArrInfo objectAtIndex:indexPath.row];
        
        NSString * getEventId = [NSString stringWithFormat:@"%@",[j valueForKey:@"id"]];
        UIStoryboard *obj=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
        ViewControllerDescription *str=[obj instantiateViewControllerWithIdentifier:@"ViewControllerDescription"];
        str.getIdEvent = getEventId;
        [self.navigationController pushViewController:str animated:true];
    }
    else
    {
        NSDictionary * j = [ArrInfo objectAtIndex:indexPath.row];
        
        NSString * getEventId = [NSString stringWithFormat:@"%@",[j valueForKey:@"id"]];
        UIStoryboard *obj=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
        ViewControllerDescription *str=[obj instantiateViewControllerWithIdentifier:@"ViewControllerDescription"];
        str.getIdEvent = getEventId;
        [self.navigationController pushViewController:str animated:true];
    }
}

-(void)Get_loc
{
        GMSAutocompleteViewController *acController = [[GMSAutocompleteViewController alloc] init];
        acController.delegate = self;
        [self presentViewController:acController animated:YES completion:nil];
}
- (void)viewController:(GMSAutocompleteViewController *)viewController
didFailAutocompleteWithError:(NSError *)error
{
    [self dismissViewControllerAnimated:YES completion:nil];
    // TODO: handle the error.
    NSLog(@"Error: %@", [error description]);
}
    
    // User canceled the operation.
- (void)wasCancelled:(GMSAutocompleteViewController *)viewController
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
    
    // Turn the network activity indicator on and off again.
- (void)didRequestAutocompletePredictions:(GMSAutocompleteViewController *)viewController
{
        [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
}
- (void)didUpdateAutocompletePredictions:(GMSAutocompleteViewController *)viewController
{
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}
- (void)mapView:(GMSMapView *)mapView didLongPressAtCoordinate:(CLLocationCoordinate2D)coordinate
{
    
        NSLog(@"You tapped at %f,%f", coordinate.latitude, coordinate.longitude);
}

- (IBAction)SearchLocationTapped:(id)sender
{
    _LocationPickerView.hidden=NO;
    _GrayBlackTransperant.hidden=NO;
       // [self Get_loc];
}
- (void)viewController:(GMSAutocompleteViewController *)viewController
  didAutocompleteWithPlace:(GMSPlace *)place
{
        [self dismissViewControllerAnimated:YES completion:nil];
        // Do something with the selected place.
        NSLog(@"Place name %@", place.name);
        NSLog(@"Place address %@", place.formattedAddress);
        NSString * complete_address=place.name;
        NSLog(@"Place attributions %@", place.attributions.string);
        NSArray * get_data=place.addressComponents;
        float  lat1=place.coordinate.latitude;
        float longi1=place.coordinate.longitude;
}
- (IBAction)LocationDoneTapped:(id)sender
{
    _LocationPickerView.hidden=YES;
    _GrayBlackTransperant.hidden=YES;
    if (QueryPickerdataSeleted!=nil)
    {
        _SelectedLocation.text=QueryPickerdataSeleted;
        
     
    }
    

    if (!([QueryPickerdataSeleted  isEqual: @"Nearby"])) {
        getSt = @"1";
//        LatN2 = @"";
//        LongN3 = @"";
//        LatN2 = [[NSUserDefaults standardUserDefaults]valueForKey:@"getLat"];
//        LongN3 = [[NSUserDefaults standardUserDefaults]valueForKey:@"getLong"];
            }
    else
    {
        getSt = @"";
//        LatN2 = @"76.32323";
//        LongN3 = @"35.32323";
                LatN2 = [[NSUserDefaults standardUserDefaults]valueForKey:@"getLat"];
                LongN3 = [[NSUserDefaults standardUserDefaults]valueForKey:@"getLong"];
//        LatN2 = [NSString stringWithFormat:@"%f",EventslocationManager.location.coordinate.latitude];
//        LongN3 = [NSString stringWithFormat:@"%f",EventslocationManager.location.coordinate.longitude];
//

    }
    
    
    [self getEvents];
}
MKPinAnnotationView * annView;

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation
{
    if ([annotation isKindOfClass:[MKUserLocation class]])
    {
        return nil;  //return nil to use default white dot view
    }
    else
    {
        annView = [[MKPinAnnotationView alloc] init];
       // annView.image = [UIImage imageNamed:@"location-pointer2"];

       // annView.pinTintColor = [UIColor clearColor];
        UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@""]];
       // annView.animatesDrop = TRUE;
        UIView * View1 = [[UIView alloc] init];
        View1.frame = CGRectMake(0, 0, 250, 50);
       
      
        UILabel * lbl = [[UILabel alloc]init];
        lbl.frame = CGRectMake(50, 5, 195, 20);
        lbl.text = @"87";
        [View1 addSubview:lbl];
        UIView * star_view = [[UIView alloc]initWithFrame:(CGRectMake(50, 30, 70, 10))];
       
        
        UIView * price_view = [[UIView alloc]initWithFrame:(CGRectMake(125, 30, 70, 10))];
       
        [View1 addSubview:price_view]; UIView *subView = View1;
        subView.backgroundColor = [UIColor clearColor];
        subView.opaque = NO;
   
        markerViews * Cview = [[[NSBundle mainBundle] loadNibNamed:@"markerViews" owner:nil options:nil] firstObject];

        
        
        NSString *getT = annotation.subtitle;
        
        
        
        NSArray *getS = [getT componentsSeparatedByString:@"\\"];
        Cview.eventName.text = getS[1];
     
        Cview.StartTime.text = getS[2];
        
        Cview.endTime.text = getS[3];
         [Cview.imgevent sd_setImageWithURL:[NSURL URLWithString:getS[4]]];
        
     
         UIImage * image1;
        image1 = [self imageWithView:Cview];
        NSData* imageData =  UIImagePNGRepresentation(image1);
        UIImage* pngImage1 = [UIImage imageWithData:imageData];
        UIImageView *snapshotImageView1;
        snapshotImageView1 = [[UIImageView alloc] initWithImage:image1];
        
      MKPointAnnotation *annotation = [[MKPointAnnotation alloc] init];
        
    //    annotation.subtitle = @"jkjk";
      
        
        getDD = getS[0];
        
//        for (int i = 0 ;i<getLocationName.count;i++)
//        {
//            Cview.eventName.text = getLocationName[i];
//        }
        NSString *jjj;
        
        
         annView.detailCalloutAccessoryView = snapshotImageView1;
        annView.calloutOffset = CGPointMake(-5,5);
     
        annView.enabled = YES;
       annView.canShowCallout = YES;
       [annView addSubview:imageView];
        return annView;
    }
    
   
//    CalloutAnnotationView *anotationCua = [[CalloutAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"CallOutAnnotationVifew"];
//  anotationCua.calloutOffset = CGPointMake(10, 10);
//
////    NSArray *ary = [[NSBundle mainBundle] loadNibNamed:@"Display" owner:self options:nil];
//
// //   UIView *view1 = [ary objectAtIndex:0];
//
//   // [anotationCua.contentView addSubview:view1];
//
//    return anotationCua;
//    if ([annotation isKindOfClass:[MKUserLocation class]])
//    {
//        return nil;  //return nil to use default white dot view
//    }
//    else
//    {
//        annView = [[MKPinAnnotationView alloc] init];
//        annView.image = [UIImage imageNamed:@"location-pin"];
//        annView.pinTintColor = [UIColor clearColor];
//        UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"location-pin"]];
//        annView.animatesDrop = TRUE;
//        UIView * View1 = [[UIView alloc] init];
//        View1.frame = CGRectMake(0, 0, 250, 50);
//        NSURL * url1 = [[NSURL alloc]initWithString:@"kp"];
//        NSData * data1 = [[NSData alloc] initWithContentsOfURL:url1];
//        UIImage * img_food =[[UIImage alloc]initWithData:data1];
//        UIImageView * img = [[UIImageView alloc]init];
//        img.frame = CGRectMake(5, 5, 40, 40);
//        img.image = img_food;
//        [View1 addSubview:img];
//        UILabel * lbl = [[UILabel alloc]init];
//        lbl.frame = CGRectMake(50, 5, 195, 20);
//        lbl.text = @"iui";
//        [View1 addSubview:lbl];
//        UIView * star_view = [[UIView alloc]initWithFrame:(CGRectMake(50, 30, 70, 10))];
//
//
//        annView.backgroundColor = [UIColor redColor];
//        UIView * price_view = [[UIView alloc]initWithFrame:(CGRectMake(125, 30, 70, 10))];
//
//        [View1 addSubview:price_view]; UIView *subView = View1;
//        subView.backgroundColor = [UIColor clearColor];
//        subView.opaque = NO;
//        UIImage * image1;
//
//        NSData* imageData =  UIImagePNGRepresentation(image1);
//        UIImage* pngImage = [UIImage imageWithData:imageData];
//        UIImageView *snapshotImageView;
//        snapshotImageView = [[UIImageView alloc] initWithImage: annView.image];
////        var multiLineView= UIView(frame: CGRectMake(0, 0, 23, 23))
////        multiLineView.addSubview(lable1)
////        multiLineView.addSubview(lable2)
////        annotationView.leftCalloutAccessoryView = multiLineView
//        View1.frame = CGRectMake(0, 0, 400, 980);
//        annView.detailCalloutAccessoryView = View1;
//
//        annView.calloutOffset = CGPointMake(-5,5);
//        annView.enabled = YES;
//        annView.canShowCallout = YES;
//            imageView.backgroundColor = [UIColor orangeColor];
//        [annView addSubview:View1];
//        return annView;
//    }
    NSString *getS = annotation.subtitle;
    
//    NSLog(@"%@",getS);
//    if ([annotation isKindOfClass:[MKUserLocation class]])
//        return nil;
//
//    // Handle any custom annotations.
//    if ([annotation isKindOfClass:[MKPointAnnotation class]])
//    {
//        // Try to dequeue an existing pin view first.
//        MKAnnotationView *pinView = (MKAnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier:@"CustomPinAnnotationView"];
//        if (!pinView)
//        {
//            // If an existing pin view was not available, create one.
//            pinView = [[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"CustomPinAnnotationView"];
//            pinView.canShowCallout = YES;
//            pinView.image = [UIImage imageNamed:@"RedPin.png"];
//            pinView.calloutOffset = CGPointMake(0, 0);
//
//            // Add a detail disclosure button to the callout.
//            UIButton* rightButton = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
//            pinView.rightCalloutAccessoryView = rightButton;
//            pinView.calloutOffset = CGPointMake(0, 0);
//            pinView.tintColor = UIColor.redColor;
//
//    //        NSString *getT = annotation.title;
//
////            NSLog(@"%@getvvv",getT);
////            NSArray *getS = [getT componentsSeparatedByString:@"\\"];
////            NSLog(@"%@getvvv",getS);
////
////
////            Cview.eventName.text = getS[1];
//
////            Cview.StartTime.text = getS[2];
////
////            Cview.endTime.text = getS[3];
//            // Add an image to the left callout.
//
//            UIImageView *iconView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bank-account.png"]];
//            UIView *gsd = [[UIView alloc]init];
//            gsd.frame = CGRectMake(0, 0, 200, 200);
//
//            gsd.backgroundColor = [UIColor blueColor];
////
////            let widthConstraint = NSLayoutConstraint(item: myView, attribute: .Width, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1, constant: 40)
////            myView.addConstraint(widthConstraint)
////
////            let heightConstraint = NSLayoutConstraint(item: myView, attribute: .Height, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1, constant: 20)
////            myView.addConstraint(heightConstraint)
////
//
//                [iconView sd_setImageWithURL:[NSURL URLWithString:getS]];
//            iconView.frame = CGRectMake(0, 0, 100, 100);
//            iconView.contentMode = UIViewContentModeScaleAspectFit;
//            iconView.clipsToBounds = YES;
//
//         //pinView.leftCalloutAccessoryView = iconView;
//           // markerViews * Cview = [[[NSBundle mainBundle] loadNibNamed:@"markerViews" owner:nil options:nil] firstObject];
//
//
//
//           // pinView.detailCalloutAccessoryView.frame = CGRectMake(0, 0, 100, 100);
//            pinView.detailCalloutAccessoryView = gsd;
//            pinView.canShowCallout = YES;
////            pinView.layer.borderColor = [UIColor purpleColor].CGColor;
////            pinView.layer.borderWidth
//            //pinView.layer.cornerRadius = 5;
//          //  pinView.clipsToBounds = true;
//        } else {
//            pinView.annotation = annotation;
//        }
//        return pinView;
//    }
//    return nil;
}
//-(void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control {
//    id <MKAnnotation> annotation = [view annotation];
//    if ([annotation isKindOfClass:[MKPointAnnotation class]])
//    {
//        NSLog(@"Clicked Pizza Shop");
//    }
//    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Disclosure Pressed" message:@"Click Cancel to Go Back" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK", nil];
//    [alertView show];
//}
- (UIImage *)imageWithView:(UIView *)view
{
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, view.opaque, 0.0);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    
    UIImage * img = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return img;
}


-(void) mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view
{
    
         NSLog(@"23223232");
   
  

    
}
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return Post_type_array.count;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return [Post_type_array objectAtIndex:row];
}
- (void)pickerView:(UIPickerView *)thePickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    
    QueryPickerdataSeleted=[Post_type_array objectAtIndex:row];
    LatN = [Post_type_Latarray objectAtIndex:row];
     LongN = [Post_type_Longarray objectAtIndex:row];
    if([UserRole  isEqual: @"0"])
    {
        
        if(row == 0)
        {
       cityNameChose = @"";
        }
        else
        
        {
            cityNameChose = QueryPickerdataSeleted;
        }
        
        
    }
    else
    {
     
        
        cityNameChose = QueryPickerdataSeleted;
    }
    
    
  
}
- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    //[ProgressHUD dismiss];
    UILabel *tView = (UILabel*)view;
    if (Post_type_array.count>0) {
        if (!tView)
        {
            tView = [[UILabel alloc] init];
            [tView setTextColor:[UIColor blackColor]];
            [tView setFont:[UIFont fontWithName:@"Loto-regular" size:12]];
            tView.text=[Post_type_array objectAtIndex:row];
            [tView setTextAlignment:NSTextAlignmentCenter];
            return tView;
        }
    }
    return tView;
}
- (IBAction)LocationCamcelTapped:(id)sender
{
    _LocationPickerView.hidden=YES;
    _GrayBlackTransperant.hidden=YES;
}
- (IBAction)EventsMapview:(id)sender
{
    
    _MapViewScroll.hidden=NO;
    
    _EventsScrollView.hidden=YES;
    
}
- (IBAction)MaplistView:(id)sender
{
    if(getlistMap == false)
    {
        getlistMap = true;
        _MapViewScroll.hidden=NO;
        
      //  _EventsScrollView.hidden=YES;
        _Image_Mapview.image = [UIImage imageNamed:@"note.png"];
//        eventWeek = @"";
//        eventMonth = @"";
//        eventTonight = @"1";
        dateFetch = @"";
      //  _monthBtn.userInteractionEnabled = NO;
        [myPickerView removeFromSuperview];
        [selectView removeFromSuperview];
     //   [self getEvents];
    }
   else
   {
       getlistMap = false;
       _MapViewScroll.hidden=YES;
       
      // _EventsScrollView.hidden=NO;
        _Image_Mapview.image = [UIImage imageNamed:@"Mapview"];

     
      
   }
    
}

-(void) getEvents{
    NSURLSession *session = [NSURLSession sharedSession];
    [ArrInfo removeAllObjects];
    
     [ArrInfo2 removeAllObjects];
    [self.mapApple2 removeAnnotations:_mapApple2.annotations];


    NSString *strtoken  =[[NSUserDefaults standardUserDefaults]objectForKey:@"acessToken"];
    
    NSString *strBearer = @"Bearer ";
    
    NSString *URL = @"http://18.188.52.230/unights/public/api/get-events";
    
    NSURL *theURL = [NSURL URLWithString:URL];
    
    NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:theURL cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:30.0f];
    
    [theRequest setHTTPMethod:@"POST"];
    
    [theRequest setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    
    
    
    [theRequest setValue:[strBearer stringByAppendingString:strtoken] forHTTPHeaderField:@"Authorization"];
    
    [theRequest setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    
    
    
    
    //NSString *post = [URL stringByAppendingString:stringWithoutSpaces];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        [SVProgressHUD showWithStatus:@"Please wait.." maskType:SVProgressHUDMaskTypeBlack];
        
        
        
    });
    
   // 1 eventWeek empty , eventMonth empty
   // 2 eventWeek 1   , eventMonth empty
   // 3 eventWeek empty , eventMonth 1

    param=[NSString stringWithFormat:@"cityfilter=%@&longitude=%@&latitude=%@&week=%@&month=%@&city=%@&tonight=%@&form_date=%@",getSt,LongN3,LatN2,eventWeek,eventMonth,cityNameChose,eventTonight,dateFetch];
    
    NSLog(@"%@",param);
    NSData *postData = [param dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    
    [theRequest setHTTPBody:postData];
     NSURLSessionDataTask * task=  [session dataTaskWithRequest:theRequest completionHandler:^(NSData *  data, NSURLResponse * response, NSError *  error) {
    
    
//    [NSURLConnection sendAsynchronousRequest:theRequest queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
    
        // if(data != nil){
        
        
        
        
        
        NSString *noti = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        
        NSLog(@"Response:: %@", noti);
        
        
        
        
        
        if(data!=nil){
            
            NSError *jsonError;
            
            NSData *objectData = [noti dataUsingEncoding:NSUTF8StringEncoding];
            
            NSDictionary *json = [NSJSONSerialization JSONObjectWithData:objectData
                                  
                                                                 options:NSJSONReadingMutableContainers
                                  
                                                                   error:&jsonError];
            
            NSLog(@"%@",json);
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [SVProgressHUD dismiss];
            });
            NSString * getSuccess;
            //
                            getSuccess = [NSString stringWithFormat:@"%@",[json valueForKey:@"success"]];
        
                            if([getSuccess  isEqual: @"1"])
                            {
                                
                                NSDictionary *getEvent = [json valueForKey:@"event"];
                                bb = [json valueForKey:@"event"];
                                getEventArr = [getEvent valueForKey:@"data"];
                                ArrInfo = [getEventArr mutableCopy];
                           if(getEventArr.count > 0)
                           {
                                NSDictionary * j = [getEventArr objectAtIndex:getEventArr.count - 1];
                                
                                NSString * getEventname = [NSString stringWithFormat:@"%@",[j valueForKey:@"event_name"]];
                                NSString *getLat2;
                                NSString * getlong2;
                                getlong2 = [j valueForKey:@"longitude"];
                                getLat2 = [j valueForKey:@"latitude"];
                                double londouble = [getlong2 doubleValue];
                                double latdouble = [getLat2 doubleValue];
                                GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:latdouble longitude:londouble zoom:14];
                               
                               dispatch_async(dispatch_get_main_queue(), ^{
                                   
                                   
                               
                                   EventsmapView_ = [GMSMapView mapWithFrame:CGRectMake(0,0, self.view.frame.size.width, self.SrollingMapview.frame.size.height) camera:camera];

                                   EventsmapView_.delegate = self;
                                   EventsmapView_.myLocationEnabled = YES;
                                   EventsmapView_.settings.scrollGestures = YES;
                                   EventsmapView_.settings.zoomGestures = YES;
                                 //[self.SrollingMapview addSubview:EventsmapView_];
                              });
                               
                               
                               
                           }
                                
                                else
                                {
                                  
                                }
                                if([eventWeek  isEqual: @""] && [eventMonth  isEqual: @""])
                                {
                                    dispatch_async(dispatch_get_main_queue(), ^{
                                    _thisweekV.hidden = YES;
                                    _monthV.hidden = YES;
                                    _tonightV.hidden = NO;
                                    });
                                    if(getEventArr.count == 0)
                                    {
                                        
                                        dispatch_async(dispatch_get_main_queue(), ^{
                                        _noeventTonight.hidden = NO;
                                        _TonightTable.hidden = YES;
                                        });
                                 
                                        
                                    }
                                    else
                                    {
                                        dispatch_async(dispatch_get_main_queue(), ^{
                                            
                                            _noeventTonight.hidden = YES;
                                            _TonightTable.hidden = NO;
                                            _TonightTable.delegate = self;
                                            _TonightTable.dataSource = self;
                                            [_TonightTable reloadData];
                                        });
                                       
                                        int i;
                                        for(i =0;i<ArrInfo.count;i++)
                                        {
                                            
                                            NSDictionary * j = [getEventArr objectAtIndex:i];
                                            
                                            NSString * getEventname = [NSString stringWithFormat:@"%@",[j valueForKey:@"event_name"]];
                                           
                                            NSString *getLat;
                                            NSString * getlong;
                                            getlong = [NSString stringWithFormat:@"%@",[j valueForKey:@"longitude"]];

                                            getLat = [NSString stringWithFormat:@"%@",[j valueForKey:@"latitude"]];
                                            // venue name, city and post code

//                                            NSString * getEventAddr = [NSString stringWithFormat:@"%@",[j valueForKey:@"venue_address"]];

                                            double latdouble = [getLat doubleValue];
                                            double longdouble = [getlong doubleValue];
 dispatch_async(dispatch_get_main_queue(), ^{
                                            GMSMarker *_london;
                                            CLLocationCoordinate2D position = CLLocationCoordinate2DMake(latdouble, longdouble);
                                            _london = [GMSMarker markerWithPosition:position];
                                            NSString * getEventID = [NSString stringWithFormat:@"%@",[j valueForKey:@"id"]];
                                            NSString * getEventstartDate = [NSString stringWithFormat:@"%@",[j valueForKey:@"start_date"]];
                                            NSString * getEventendDate = [NSString stringWithFormat:@"%@",[j valueForKey:@"end_date"]];
                                            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
                                            [dateFormatter setDateFormat:@"yyyy-MM-dd"];
                                            NSDate *date = [dateFormatter dateFromString:getEventendDate];

                                            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
                                            [formatter setDateFormat:@"MMM dd"];
                                            NSLog(@"Current Date: %@", [formatter stringFromDate:date]);
                                            NSString * getdate = [formatter stringFromDate:date];

                                            NSDate *date2 = [dateFormatter dateFromString:getEventstartDate];

                                            NSDateFormatter *formatter2 = [[NSDateFormatter alloc] init];
                                            [formatter2 setDateFormat:@"MMM dd"];
                                            NSLog(@"Current Date: %@", [formatter stringFromDate:date2]);
                                            NSString * getdate2 = [formatter stringFromDate:date2];
     NSArray * getEventArr2 = [j valueForKey:@"event_images"];
     NSDictionary *getDictImage2 = [getEventArr2 objectAtIndex:0];
     
     NSString * getEventImg2 = [NSString stringWithFormat:@"%@",[getDictImage2 valueForKey:@"image"]];
     NSString * ImgbaseUrl2 = @"http://18.188.52.230/unights/public/events/";
     NSString *getImg2 = [NSString stringWithFormat:@"%@%@",ImgbaseUrl2,getEventImg2];

                                            NSString * df = [NSString stringWithFormat:@"%@%@%@%@%@%@%@%@%@",getEventID,@"\\",getEventname,@"\\",getdate2,@"\\",getdate,@"\\",getImg2];
                                            _london.title = [NSString stringWithFormat:@"%@",df];

                                            NSLog(@"%@",[NSString stringWithFormat:@"%d",i]);
                                            _london.icon = [UIImage imageNamed:@"location-pointer2"];
                                            //_london.zIndex=d;
                                            //_london.iconView = _londonView;
                                            _london.tracksViewChanges = YES;
                                           _london.map = EventsmapView_;
     CLLocationCoordinate2D annotationCoord;
     ;


     annotationCoord.latitude = [getLat doubleValue];
     annotationCoord.longitude = [getlong doubleValue];
     
     MKPointAnnotation *annotationPoint = [[MKPointAnnotation alloc] init];
     annotationPoint.coordinate = annotationCoord;
     annotationPoint.subtitle = [NSString stringWithFormat:@"%@",df];
    
  
     NSArray * getEventArr = [j valueForKey:@"event_images"];
     NSDictionary *getDictImage = [getEventArr objectAtIndex:0];
     
     NSString * getEventImg = [NSString stringWithFormat:@"%@",[getDictImage valueForKey:@"image"]];
     NSString * ImgbaseUrl = @"http://18.188.52.230/unights/public/events/";
     NSString *getImg = [NSString stringWithFormat:@"%@%@",ImgbaseUrl,getEventImg];
        annotationPoint.subtitle = [NSString stringWithFormat:@"%@",df];
     //    annotationPoint.subtitle = @"Microsoft's headquarters";
     [self.mapApple2 addAnnotation:annotationPoint];
     MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(annotationCoord, 100, 100);
     
     // 3
     [self.mapApple2 setRegion:viewRegion animated:YES];
     
 });
                                        
                                        }
                               
                                   
                                    
                                    [self performSelector:@selector(subscribe) withObject:self afterDelay:3.0 ];
                                }
                                    
                                    
                                }
                                else if([eventWeek  isEqual: @"1"] && [eventMonth  isEqual: @""])
                                {
                                    
                                    dispatch_async(dispatch_get_main_queue(), ^{
                                        
                                        [SVProgressHUD dismiss];
                                        _monthV.hidden = YES;
                                        _tonightV.hidden = YES;
                                        _thisweekV.hidden = NO;
                                    });
                                    if(getEventArr.count == 0)
                                    {
                                         dispatch_async(dispatch_get_main_queue(), ^{
                                        _noeventThisWeek.hidden = NO;
                                        _thisweekTbl.hidden = YES;
                                         });
                                 
                                    }
                                    else
                                    {
                                        dispatch_async(dispatch_get_main_queue(), ^{
                                            
                                            _noeventThisWeek.hidden = YES;
                                            _thisweekTbl.hidden = NO;
                                            _thisweekTbl.delegate = self;
                                            _thisweekTbl.dataSource = self;
                                            [_thisweekTbl reloadData];
                                        });
                                       
                                        int i;
                                        for(i =0;i<ArrInfo.count;i++)
                                        {
                                            
                                            NSDictionary * j = [getEventArr objectAtIndex:i];
                                            
                                            NSString * getEventname = [NSString stringWithFormat:@"%@",[j valueForKey:@"event_name"]];
                                            
                                            NSString *getLat;
                                            NSString * getlong;
                                            getlong = [NSString stringWithFormat:@"%@",[j valueForKey:@"longitude"]];
                                            
                                            getLat = [NSString stringWithFormat:@"%@",[j valueForKey:@"latitude"]];
                                            // venue name, city and post code
                                            
                                            //                                            NSString * getEventAddr = [NSString stringWithFormat:@"%@",[j valueForKey:@"venue_address"]];
                                            
                                            double latdouble = [getLat doubleValue];
                                            double longdouble = [getlong doubleValue];
                                             dispatch_async(dispatch_get_main_queue(), ^{
                                            GMSMarker *_london;
                                            _london = [ [GMSMarker alloc] init];
                                            CLLocationCoordinate2D position = CLLocationCoordinate2DMake(latdouble, longdouble);
                                            _london = [GMSMarker markerWithPosition:position];
                                            NSString * getEventID = [NSString stringWithFormat:@"%@",[j valueForKey:@"id"]];
                                            NSString * getEventstartDate = [NSString stringWithFormat:@"%@",[j valueForKey:@"start_date"]];
                                            NSString * getEventendDate = [NSString stringWithFormat:@"%@",[j valueForKey:@"end_date"]];
                                            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
                                            [dateFormatter setDateFormat:@"yyyy-MM-dd"];
                                            NSDate *date = [dateFormatter dateFromString:getEventendDate];
                                            
                                            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
                                            [formatter setDateFormat:@"MMM dd"];
                                            NSLog(@"Current Date: %@", [formatter stringFromDate:date]);
                                            NSString * getdate = [formatter stringFromDate:date];
                                            
                                            NSDate *date2 = [dateFormatter dateFromString:getEventstartDate];
                                            
                                            NSDateFormatter *formatter2 = [[NSDateFormatter alloc] init];
                                            [formatter2 setDateFormat:@"MMM dd"];
                                            NSLog(@"Current Date: %@", [formatter stringFromDate:date2]);
                                            NSString * getdate2 = [formatter stringFromDate:date2];
                                            
                                            
                                                 NSArray * getEventArr2 = [j valueForKey:@"event_images"];
                                                 NSDictionary *getDictImage2 = [getEventArr2 objectAtIndex:0];
                                                 
                                                 NSString * getEventImg2 = [NSString stringWithFormat:@"%@",[getDictImage2 valueForKey:@"image"]];
                                                 NSString * ImgbaseUrl2 = @"http://18.188.52.230/unights/public/events/";
                                                 NSString *getImg2 = [NSString stringWithFormat:@"%@%@",ImgbaseUrl2,getEventImg2];
                                                 
                                                 NSString * df = [NSString stringWithFormat:@"%@%@%@%@%@%@%@%@%@",getEventID,@"\\",getEventname,@"\\",getdate2,@"\\",getdate,@"\\",getImg2];
                                            _london.title = [NSString stringWithFormat:@"%@",df];
                                            
                                            NSLog(@"%@",[NSString stringWithFormat:@"%d",i]);
                                            _london.icon = [UIImage imageNamed:@"location-pointer2"];
                                            //_london.zIndex=d;
                                       //     _london.iconView = _londonView;
                                            _london.tracksViewChanges = YES;
                                            _london.map = EventsmapView_;
                                           // [EventsmapView_ setSelectedMarker:_london];
                                                 CLLocationCoordinate2D annotationCoord;
                                                 ;
                                                 
                                                 
                                                 annotationCoord.latitude = [getLat doubleValue];
                                                 annotationCoord.longitude = [getlong doubleValue];
                                                 
                                                 MKPointAnnotation *annotationPoint = [[MKPointAnnotation alloc] init];
                                                 annotationPoint.coordinate = annotationCoord;
                                                 annotationPoint.subtitle = [NSString stringWithFormat:@"%@",df];
                                                 NSArray * getEventArr = [j valueForKey:@"event_images"];
                                                 NSDictionary *getDictImage = [getEventArr objectAtIndex:0];
                                                 
                                                 NSString * getEventImg = [NSString stringWithFormat:@"%@",[getDictImage valueForKey:@"image"]];
                                                 NSString * ImgbaseUrl = @"http://18.188.52.230/unights/public/events/";
                                                 NSString *getImg = [NSString stringWithFormat:@"%@%@",ImgbaseUrl,getEventImg];
                                                 annotationPoint.subtitle = [NSString stringWithFormat:@"%@",df];
                                                 //    annotationPoint.subtitle = @"Microsoft's headquarters";
                                                 [self.mapApple2 addAnnotation:annotationPoint];
                                                 MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(annotationCoord, 0.5*1, 0.5*1);
                                                 
                                                 // 3
                                                 [self.mapApple2 setRegion:viewRegion animated:YES];
                                             });
                                            
                                        }
                            
                                  
                              
                                    }
                                }
                                else
                                {
                                     dispatch_async(dispatch_get_main_queue(), ^{
                                    _thisweekV.hidden = YES;
                                    _tonightV.hidden = YES;
                                    _monthV.hidden = NO;
                                    if(getEventArr.count == 0)
                                    {
                                        _noeventMonth.hidden = NO;
                                        _monthTblView.hidden = YES;
                                        
                                      
                                    }
                                    else
                                    
                                    {
                                        dispatch_async(dispatch_get_main_queue(), ^{
                                            
                                            _noeventMonth.hidden = YES;
                                            _monthTblView.hidden = NO;
                                            _monthTblView.delegate = self;
                                            _monthTblView.dataSource = self;
                                            [_monthTblView reloadData];
                                        });
                                       
                                        int i;
                                        for(i =0;i<ArrInfo.count;i++)
                                        {
                                            
                                            NSDictionary * j = [getEventArr objectAtIndex:i];
                                            
                                            NSString * getEventname = [NSString stringWithFormat:@"%@",[j valueForKey:@"event_name"]];
                                            
                                            NSString *getLat;
                                            NSString * getlong;
                                            getlong = [NSString stringWithFormat:@"%@",[j valueForKey:@"longitude"]];
                                            
                                            getLat = [NSString stringWithFormat:@"%@",[j valueForKey:@"latitude"]];
                                            // venue name, city and post code
                                            
                                            //                                            NSString * getEventAddr = [NSString stringWithFormat:@"%@",[j valueForKey:@"venue_address"]];
                                            
                                            double latdouble = [getLat doubleValue];
                                            double longdouble = [getlong doubleValue];
                                             dispatch_async(dispatch_get_main_queue(), ^{
                                            GMSMarker *_london;
                                              _london = [ [GMSMarker alloc] init];
                                            CLLocationCoordinate2D position = CLLocationCoordinate2DMake(latdouble, longdouble);
                                            _london = [GMSMarker markerWithPosition:position];
                                            NSString * getEventID = [NSString stringWithFormat:@"%@",[j valueForKey:@"id"]];
                                            NSString * getEventstartDate = [NSString stringWithFormat:@"%@",[j valueForKey:@"start_date"]];
                                            NSString * getEventendDate = [NSString stringWithFormat:@"%@",[j valueForKey:@"end_date"]];
                                            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
                                            [dateFormatter setDateFormat:@"yyyy-MM-dd"];
                                            NSDate *date = [dateFormatter dateFromString:getEventendDate];
                                            
                                            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
                                            [formatter setDateFormat:@"MMM dd"];
                                            NSLog(@"Current Date: %@", [formatter stringFromDate:date]);
                                            NSString * getdate = [formatter stringFromDate:date];
                                            
                                            NSDate *date2 = [dateFormatter dateFromString:getEventstartDate];
                                            
                                            NSDateFormatter *formatter2 = [[NSDateFormatter alloc] init];
                                            [formatter2 setDateFormat:@"MMM dd"];
                                            NSLog(@"Current Date: %@", [formatter stringFromDate:date2]);
                                            NSString * getdate2 = [formatter stringFromDate:date2];
                                            
                                            
                                                 NSArray * getEventArr2 = [j valueForKey:@"event_images"];
                                                 NSDictionary *getDictImage2 = [getEventArr2 objectAtIndex:0];
                                                 
                                                 NSString * getEventImg2 = [NSString stringWithFormat:@"%@",[getDictImage2 valueForKey:@"image"]];
                                                 NSString * ImgbaseUrl2 = @"http://18.188.52.230/unights/public/events/";
                                                 NSString *getImg2 = [NSString stringWithFormat:@"%@%@",ImgbaseUrl2,getEventImg2];
                                                 
                                                 NSString * df = [NSString stringWithFormat:@"%@%@%@%@%@%@%@%@%@",getEventID,@"\\",getEventname,@"\\",getdate2,@"\\",getdate,@"\\",getImg2];
                                            
                                            _london.title = [NSString stringWithFormat:@"%@",df];
                                            
                                            NSLog(@"%@",[NSString stringWithFormat:@"%d",i]);
                                            _london.icon = [UIImage imageNamed:@"location-pointer2"];
                                            //_london.zIndex=d;
                                            //_london.iconView = _londonView;
                                            _london.tracksViewChanges = YES;
                                           _london.map = EventsmapView_;
                                                 CLLocationCoordinate2D annotationCoord;
                                                 ;
                                                 
                                                 
                                                 annotationCoord.latitude = [getLat doubleValue];
                                                 annotationCoord.longitude = [getlong doubleValue];
                                                 
                                                 MKPointAnnotation *annotationPoint = [[MKPointAnnotation alloc] init];
                                                 annotationPoint.coordinate = annotationCoord;
                                                 annotationPoint.subtitle = [NSString stringWithFormat:@"%@",df];
                                                 NSArray * getEventArr = [j valueForKey:@"event_images"];
                                                 NSDictionary *getDictImage = [getEventArr objectAtIndex:0];
                                                 
                                                 NSString * getEventImg = [NSString stringWithFormat:@"%@",[getDictImage valueForKey:@"image"]];
                                                 NSString * ImgbaseUrl = @"http://18.188.52.230/unights/public/events/";
                                                 NSString *getImg = [NSString stringWithFormat:@"%@%@",ImgbaseUrl,getEventImg];
                                                 annotationPoint.subtitle = [NSString stringWithFormat:@"%@",df];
                                                 //    annotationPoint.subtitle = @"Microsoft's headquarters";
                                                 [self.mapApple2 addAnnotation:annotationPoint];
                                                 MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(annotationCoord, 0.5*1, 0.5*1);
                                                 
                                                 // 3
                                                 [self.mapApple2 setRegion:viewRegion animated:YES];
                                             });
                                            
                                        }
                                       
                                    }
                                    dispatch_async(dispatch_get_main_queue(), ^{
                                        
                                        [SVProgressHUD dismiss];
                                    });
                                });
                           
                                }
                                
                             
                                
                                
            
                                
                                
                             
                            }
        else
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [SVProgressHUD dismiss];
            });
        }
          
            
            //                NSArray *arrdata =[json objectForKey:@"day"];
            
            //
            
            //                NSDictionary *dict =[arrdata objectAtIndex:0];
            
            
            
            
            
        }
        else
        {
            
            UIAlertController * alert = [UIAlertController
                                         alertControllerWithTitle:@"UNiGHTS"
                                         message:@"Connection Error"
                                         preferredStyle:UIAlertControllerStyleAlert];
            
            //Add Buttons
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [SVProgressHUD dismiss];
            });
            
            
            UIAlertAction* noButton = [UIAlertAction
                                       actionWithTitle:@"OK"
                                       style:UIAlertActionStyleDefault
                                       handler:^(UIAlertAction * action) {
                                           //Handle no, thanks button
                                       }];
            
            //Add your buttons to alert controller
            
            
            [alert addAction:noButton];
            
            [self presentViewController:alert animated:YES completion:nil];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [SVProgressHUD dismiss];
            });
        }
        
        
        
        
        
    }];
    [task resume];
    
}

-(void) getEvents2{
    NSURLSession *session = [NSURLSession sharedSession];
    
  //[EventsmapView_ clear];
  [self.mapApple2 removeAnnotations:_mapApple2.annotations];
    NSString *strtoken  =[[NSUserDefaults standardUserDefaults]objectForKey:@"acessToken"];
    
    NSString *strBearer = @"Bearer ";
    
    NSString *getSts = [bb valueForKey:@"next_page_url"];
    NSArray *getAs = [getSts componentsSeparatedByString:@"?"];
    NSString *fds = @"http://18.188.52.230/unights/public/api/get-events?";
    NSString *sds = getAs[1];
    
    NSString *URL = [fds stringByAppendingString:getAs[1]];
    
    NSURL *theURL = [NSURL URLWithString:URL];
    
    NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:theURL cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:30.0f];
    
    [theRequest setHTTPMethod:@"POST"];
    
    [theRequest setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    
    
    
    [theRequest setValue:[strBearer stringByAppendingString:strtoken] forHTTPHeaderField:@"Authorization"];
    
    [theRequest setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    
    
    
    
    //NSString *post = [URL stringByAppendingString:stringWithoutSpaces];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        [SVProgressHUD showWithStatus:@"Please wait.." maskType:SVProgressHUDMaskTypeBlack];
        
        
        
    });
    
    // 1 eventWeek empty , eventMonth empty
    // 2 eventWeek 1   , eventMonth empty
    // 3 eventWeek empty , eventMonth 1
    
    param=[NSString stringWithFormat:@"cityfilter=%@&longitude=%@&latitude=%@&week=%@&month=%@&city=%@&tonight=%@&form_date=%@",getSt,LongN3,LatN2,eventWeek,eventMonth,cityNameChose,eventTonight,dateFetch];
    
    NSLog(@"%@",param);
    NSData *postData = [param dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    
    [theRequest setHTTPBody:postData];
    
    
     NSURLSessionDataTask * task=  [session dataTaskWithRequest:theRequest completionHandler:^(NSData *  data, NSURLResponse * response, NSError *  error) {
//    [NSURLConnection sendAsynchronousRequest:theRequest queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
    
        // if(data != nil){
        
        
        
        
        
        NSString *noti = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        
        NSLog(@"Response:: %@", noti);
        
        
        
        
        
        if(data!=nil){
            
            NSError *jsonError;
            
            NSData *objectData = [noti dataUsingEncoding:NSUTF8StringEncoding];
            
            NSDictionary *json = [NSJSONSerialization JSONObjectWithData:objectData
                                  
                                                                 options:NSJSONReadingMutableContainers
                                  
                                                                   error:&jsonError];
            
            NSLog(@"%@",json);
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [SVProgressHUD dismiss];
            });
            NSString * getSuccess;
            //
            getSuccess = [NSString stringWithFormat:@"%@",[json valueForKey:@"success"]];
            
            if([getSuccess  isEqual: @"1"])
            {
                
                NSDictionary *getEvent = [json valueForKey:@"event"];
                bb = [json valueForKey:@"event"];
                
                getf = [getEvent valueForKey:@"data"];
                ArrInfo2 = [getf mutableCopy];
                
                [ArrInfo addObjectsFromArray:ArrInfo2];
                NSDictionary * j = [getEventArr objectAtIndex:getEventArr.count - 1];
                
                NSString * getEventname = [NSString stringWithFormat:@"%@",[j valueForKey:@"event_name"]];
                NSString *getLat2;
                NSString * getlong2;
                getlong2 = [j valueForKey:@"longitude"];
                getLat2 = [NSString stringWithFormat:@"%@",[j valueForKey:@"latitude"]];
                double londouble = [getlong2 doubleValue];
                double latdouble = [getLat2 doubleValue];
                GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:latdouble longitude:londouble zoom:14];
                
              
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    EventsmapView_ = [GMSMapView mapWithFrame:CGRectMake(0,0, self.view.frame.size.width, self.SrollingMapview.frame.size.height) camera:camera];
                    EventsmapView_.delegate = self;
                    EventsmapView_.myLocationEnabled = YES;
                    EventsmapView_.settings.scrollGestures = YES;
                    EventsmapView_.settings.zoomGestures = YES;
              // [self.SrollingMapview addSubview:EventsmapView_];
                });
               
                
                if([eventWeek  isEqual: @""] && [eventMonth  isEqual: @""])
                {
                    dispatch_async(dispatch_get_main_queue(), ^{
                    _thisweekV.hidden = YES;
                    _monthV.hidden = YES;
                    _tonightV.hidden = NO;
                    });
                    if(getEventArr.count == 0)
                    {
                         dispatch_async(dispatch_get_main_queue(), ^{
                        _noeventTonight.hidden = NO;
                        _TonightTable.hidden = YES;
                         });
                        
                        
                    }
                    else
                    {
                        
                        int i;
                        for(i =0;i<ArrInfo.count;i++)
                        {
                            
                            NSDictionary * j = [ArrInfo objectAtIndex:i];
                            
                            NSString * getEventname = [NSString stringWithFormat:@"%@",[j valueForKey:@"event_name"]];
                            
                            NSString *getLat;
                            NSString * getlong;
                            getlong = [NSString stringWithFormat:@"%@",[j valueForKey:@"longitude"]];
                            
                            getLat = [NSString stringWithFormat:@"%@",[j valueForKey:@"latitude"]];
                            // venue name, city and post code
                            
                            //                                            NSString * getEventAddr = [NSString stringWithFormat:@"%@",[j valueForKey:@"venue_address"]];
                            
                            double latdouble = [getLat doubleValue];
                            double longdouble = [getlong doubleValue];
                            dispatch_async(dispatch_get_main_queue(), ^{
                            GMSMarker *_london;
                            CLLocationCoordinate2D position = CLLocationCoordinate2DMake(latdouble, longdouble);
                            _london = [GMSMarker markerWithPosition:position];
                            NSString * getEventID = [NSString stringWithFormat:@"%@",[j valueForKey:@"id"]];
                            NSString * getEventstartDate = [NSString stringWithFormat:@"%@",[j valueForKey:@"start_date"]];
                            NSString * getEventendDate = [NSString stringWithFormat:@"%@",[j valueForKey:@"end_date"]];
                            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
                            [dateFormatter setDateFormat:@"yyyy-MM-dd"];
                            NSDate *date = [dateFormatter dateFromString:getEventendDate];
                            
                            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
                            [formatter setDateFormat:@"MMM dd"];
                            NSLog(@"Current Date: %@", [formatter stringFromDate:date]);
                            NSString * getdate = [formatter stringFromDate:date];
                            
                            NSDate *date2 = [dateFormatter dateFromString:getEventstartDate];
                            
                            NSDateFormatter *formatter2 = [[NSDateFormatter alloc] init];
                            [formatter2 setDateFormat:@"MMM dd"];
                            NSLog(@"Current Date: %@", [formatter stringFromDate:date2]);
                            NSString * getdate2 = [formatter stringFromDate:date2];
                            
                                NSArray * getEventArr2 = [j valueForKey:@"event_images"];
                                NSDictionary *getDictImage2 = [getEventArr2 objectAtIndex:0];
                                
                                NSString * getEventImg2 = [NSString stringWithFormat:@"%@",[getDictImage2 valueForKey:@"image"]];
                                NSString * ImgbaseUrl2 = @"http://18.188.52.230/unights/public/events/";
                                NSString *getImg2 = [NSString stringWithFormat:@"%@%@",ImgbaseUrl2,getEventImg2];
                                
                                NSString * df = [NSString stringWithFormat:@"%@%@%@%@%@%@%@%@%@",getEventID,@"\\",getEventname,@"\\",getdate2,@"\\",getdate,@"\\",getImg2];
                            _london.title = [NSString stringWithFormat:@"%@",df];
                            
                            NSLog(@"%@",[NSString stringWithFormat:@"%d",i]);
                            _london.icon = [UIImage imageNamed:@"location-pointer2"];
                            //_london.zIndex=d;
                            //_london.iconView = _londonView;
                            _london.tracksViewChanges = YES;
                         _london.map = EventsmapView_;
                            
                            
                             });
                        }
                        dispatch_async(dispatch_get_main_queue(), ^{
                            
                            _noeventTonight.hidden = YES;
                            _TonightTable.hidden = NO;
                            _TonightTable.delegate = self;
                            _TonightTable.dataSource = self;
                            [_TonightTable reloadData];
                        });
                       
                        
                        [self performSelector:@selector(subscribe) withObject:self afterDelay:3.0 ];
                    }
                    
                    
                }
                else if([eventWeek  isEqual: @"1"] && [eventMonth  isEqual: @""])
                {
                    _monthV.hidden = YES;
                    _tonightV.hidden = YES;
                    _thisweekV.hidden = NO;
                    dispatch_async(dispatch_get_main_queue(), ^{
                        
                        [SVProgressHUD dismiss];
                    });
                    if(getEventArr.count == 0)
                    {
                        _noeventThisWeek.hidden = NO;
                        _thisweekTbl.hidden = YES;
                        
                    }
                    else
                    {
                        dispatch_async(dispatch_get_main_queue(), ^{
                            
                            _noeventThisWeek.hidden = YES;
                            _thisweekTbl.hidden = NO;
                            
                            _thisweekTbl.delegate = self;
                            _thisweekTbl.dataSource = self;
                            [_thisweekTbl reloadData];
                        });
                        
                  
                        int i;
                        for(i =0;i<ArrInfo.count;i++)
                        {
                            
                            NSDictionary * j = [ArrInfo objectAtIndex:i];
                            
                            NSString * getEventname = [NSString stringWithFormat:@"%@",[j valueForKey:@"event_name"]];
                            
                            NSString *getLat;
                            NSString * getlong;
                            getlong = [NSString stringWithFormat:@"%@",[j valueForKey:@"longitude"]];
                            
                            getLat = [NSString stringWithFormat:@"%@",[j valueForKey:@"latitude"]];
                            // venue name, city and post code
                            
                            //                                            NSString * getEventAddr = [NSString stringWithFormat:@"%@",[j valueForKey:@"venue_address"]];
                            
                            double latdouble = [getLat doubleValue];
                            double longdouble = [getlong doubleValue];
                             dispatch_async(dispatch_get_main_queue(), ^{
                            GMSMarker *_london;
                            _london = [ [GMSMarker alloc] init];
                            CLLocationCoordinate2D position = CLLocationCoordinate2DMake(latdouble, longdouble);
                            _london = [GMSMarker markerWithPosition:position];
                            NSString * getEventID = [NSString stringWithFormat:@"%@",[j valueForKey:@"id"]];
                            NSString * getEventstartDate = [NSString stringWithFormat:@"%@",[j valueForKey:@"start_date"]];
                            NSString * getEventendDate = [NSString stringWithFormat:@"%@",[j valueForKey:@"end_date"]];
                            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
                            [dateFormatter setDateFormat:@"yyyy-MM-dd"];
                            NSDate *date = [dateFormatter dateFromString:getEventendDate];
                            
                            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
                            [formatter setDateFormat:@"MMM dd"];
                            NSLog(@"Current Date: %@", [formatter stringFromDate:date]);
                            NSString * getdate = [formatter stringFromDate:date];
                            
                            NSDate *date2 = [dateFormatter dateFromString:getEventstartDate];
                            
                            NSDateFormatter *formatter2 = [[NSDateFormatter alloc] init];
                            [formatter2 setDateFormat:@"MMM dd"];
                            NSLog(@"Current Date: %@", [formatter stringFromDate:date2]);
                            NSString * getdate2 = [formatter stringFromDate:date2];
                            
                            
                                 NSArray * getEventArr2 = [j valueForKey:@"event_images"];
                                 NSDictionary *getDictImage2 = [getEventArr2 objectAtIndex:0];
                                 
                                 NSString * getEventImg2 = [NSString stringWithFormat:@"%@",[getDictImage2 valueForKey:@"image"]];
                                 NSString * ImgbaseUrl2 = @"http://18.188.52.230/unights/public/events/";
                                 NSString *getImg2 = [NSString stringWithFormat:@"%@%@",ImgbaseUrl2,getEventImg2];
                                 
                                 NSString * df = [NSString stringWithFormat:@"%@%@%@%@%@%@%@%@%@",getEventID,@"\\",getEventname,@"\\",getdate2,@"\\",getdate,@"\\",getImg2];
                            _london.title = [NSString stringWithFormat:@"%@",df];
                            
                            NSLog(@"%@",[NSString stringWithFormat:@"%d",i]);
                            _london.icon = [UIImage imageNamed:@"location-pointer2"];
                            //_london.zIndex=d;
                            //_london.iconView = _londonView;
                            _london.tracksViewChanges = YES;
                         //   _london.map = EventsmapView_;
//                            [EventsmapView_ setSelectedMarker:_london];
                                 CLLocationCoordinate2D annotationCoord;
                                 ;
                                 
                                 
                                 annotationCoord.latitude = [getLat doubleValue];
                                 annotationCoord.longitude = [getlong doubleValue];
                                 
                                 MKPointAnnotation *annotationPoint = [[MKPointAnnotation alloc] init];
                                 annotationPoint.coordinate = annotationCoord;
                                 annotationPoint.subtitle = [NSString stringWithFormat:@"%@",df];
                                 NSArray * getEventArr = [j valueForKey:@"event_images"];
                                 NSDictionary *getDictImage = [getEventArr objectAtIndex:0];
                                 
                                 NSString * getEventImg = [NSString stringWithFormat:@"%@",[getDictImage valueForKey:@"image"]];
                                 NSString * ImgbaseUrl = @"http://18.188.52.230/unights/public/events/";
                                 NSString *getImg = [NSString stringWithFormat:@"%@%@",ImgbaseUrl,getEventImg];
                                 annotationPoint.subtitle = [NSString stringWithFormat:@"%@",df];
                                 //    annotationPoint.subtitle = @"Microsoft's headquarters";
                                 [self.mapApple2 addAnnotation:annotationPoint];
                                 MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(annotationCoord, 0.5*1, 0.5*1);
                                 
                                 // 3
                                 [self.mapApple2 setRegion:viewRegion animated:YES];
                             });
                        }
                    }
                }
                else
                {
                    _thisweekV.hidden = YES;
                    _tonightV.hidden = YES;
                    _monthV.hidden = NO;
                    if(getEventArr.count == 0)
                    {
                        _noeventMonth.hidden = NO;
                        _monthTblView.hidden = YES;
                        
                        
                    }
                    else
                        
                    {
                        dispatch_async(dispatch_get_main_queue(), ^{
                            
                            _noeventMonth.hidden = YES;
                            _monthTblView.hidden = NO;
                            _monthTblView.delegate = self;
                            _monthTblView.dataSource = self;
                            [_monthTblView reloadData];
                        });
                      
                        int i;
                        for(i =0;i<ArrInfo.count;i++)
                        {
                            
                            NSDictionary * j = [ArrInfo objectAtIndex:i];
                            
                            NSString * getEventname = [NSString stringWithFormat:@"%@",[j valueForKey:@"event_name"]];
                            
                            NSString *getLat;
                            NSString * getlong;
                            getlong = [NSString stringWithFormat:@"%@",[j valueForKey:@"longitude"]];
                            
                            getLat = [NSString stringWithFormat:@"%@",[j valueForKey:@"latitude"]];
                            // venue name, city and post code
                            
                            //                                            NSString * getEventAddr = [NSString stringWithFormat:@"%@",[j valueForKey:@"venue_address"]];
                            
                            double latdouble = [getLat doubleValue];
                            double longdouble = [getlong doubleValue];
                             dispatch_async(dispatch_get_main_queue(), ^{
                            GMSMarker *_london;
                            _london = [ [GMSMarker alloc] init];
                            CLLocationCoordinate2D position = CLLocationCoordinate2DMake(latdouble, longdouble);
                            _london = [GMSMarker markerWithPosition:position];
                            NSString * getEventID = [NSString stringWithFormat:@"%@",[j valueForKey:@"id"]];
                            NSString * getEventstartDate = [NSString stringWithFormat:@"%@",[j valueForKey:@"start_date"]];
                            NSString * getEventendDate = [NSString stringWithFormat:@"%@",[j valueForKey:@"end_date"]];
                            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
                            [dateFormatter setDateFormat:@"yyyy-MM-dd"];
                            NSDate *date = [dateFormatter dateFromString:getEventendDate];
                            
                            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
                            [formatter setDateFormat:@"MMM dd"];
                            NSLog(@"Current Date: %@", [formatter stringFromDate:date]);
                            NSString * getdate = [formatter stringFromDate:date];
                            
                            NSDate *date2 = [dateFormatter dateFromString:getEventstartDate];
                            
                            NSDateFormatter *formatter2 = [[NSDateFormatter alloc] init];
                            [formatter2 setDateFormat:@"MMM dd"];
                            NSLog(@"Current Date: %@", [formatter stringFromDate:date2]);
                            NSString * getdate2 = [formatter stringFromDate:date2];
                            
                            
                                 NSArray * getEventArr2 = [j valueForKey:@"event_images"];
                                 NSDictionary *getDictImage2 = [getEventArr2 objectAtIndex:0];
                                 
                                 NSString * getEventImg2 = [NSString stringWithFormat:@"%@",[getDictImage2 valueForKey:@"image"]];
                                 NSString * ImgbaseUrl2 = @"http://18.188.52.230/unights/public/events/";
                                 NSString *getImg2 = [NSString stringWithFormat:@"%@%@",ImgbaseUrl2,getEventImg2];
                                 
                                 NSString * df = [NSString stringWithFormat:@"%@%@%@%@%@%@%@%@%@",getEventID,@"\\",getEventname,@"\\",getdate2,@"\\",getdate,@"\\",getImg2];
                            _london.title = [NSString stringWithFormat:@"%@",df];
                            
                            NSLog(@"%@",[NSString stringWithFormat:@"%d",i]);
                            _london.icon = [UIImage imageNamed:@"location-pointer2"];
                            //_london.zIndex=d;
                            //_london.iconView = _londonView;
                            _london.tracksViewChanges = YES;
                            _london.map = EventsmapView_;
//                            [EventsmapView_ setSelectedMarker:_london];
                                 CLLocationCoordinate2D annotationCoord;
                                 ;
                                 
                                 
                                 annotationCoord.latitude = [getLat doubleValue];
                                 annotationCoord.longitude = [getlong doubleValue];
                                 
                                 MKPointAnnotation *annotationPoint = [[MKPointAnnotation alloc] init];
                                 annotationPoint.coordinate = annotationCoord;
                                 annotationPoint.subtitle = [NSString stringWithFormat:@"%@",df];
                                 //    annotationPoint.subtitle = @"Microsoft's headquarters";
                                 NSArray * getEventArr = [j valueForKey:@"event_images"];
                                 NSDictionary *getDictImage = [getEventArr objectAtIndex:0];
                                 
                                 NSString * getEventImg = [NSString stringWithFormat:@"%@",[getDictImage valueForKey:@"image"]];
                                 NSString * ImgbaseUrl = @"http://18.188.52.230/unights/public/events/";
                                 NSString *getImg = [NSString stringWithFormat:@"%@%@",ImgbaseUrl,getEventImg];
                                 annotationPoint.subtitle = [NSString stringWithFormat:@"%@",df];
                                 [self.mapApple2 addAnnotation:annotationPoint];
                                 MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(annotationCoord, 0.5*1, 0.5*1);
                                 
                                 // 3
                                 [self.mapApple2 setRegion:viewRegion animated:YES];
                             });
                            
                        }
                    }
                    dispatch_async(dispatch_get_main_queue(), ^{
                        
                        [SVProgressHUD dismiss];
                    });
                    
                    
                }
                
           
                
            }
            else
            {
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    [SVProgressHUD dismiss];
                });
            }
            
            
            //                NSArray *arrdata =[json objectForKey:@"day"];
            
            //
            
            //                NSDictionary *dict =[arrdata objectAtIndex:0];
            
            
            
            
            
        }
        else
        {
            
            UIAlertController * alert = [UIAlertController
                                         alertControllerWithTitle:@"UNiGHTS"
                                         message:@"Connection Error"
                                         preferredStyle:UIAlertControllerStyleAlert];
            
            //Add Buttons
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [SVProgressHUD dismiss];
            });
            
            
            UIAlertAction* noButton = [UIAlertAction
                                       actionWithTitle:@"OK"
                                       style:UIAlertActionStyleDefault
                                       handler:^(UIAlertAction * action) {
                                           //Handle no, thanks button
                                       }];
            
            //Add your buttons to alert controller
            
            
            [alert addAction:noButton];
            
            [self presentViewController:alert animated:YES completion:nil];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [SVProgressHUD dismiss];
            });
        }
        
        
        
        
        
    }];
    
    [task resume];
    
}
-(void) tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(tableView == _TonightTable)
    {
        NSLog(@"%ld",(long)indexPath.row);
        NSLog(@"%lu",ArrInfo.count - 1);
        
    if(ArrInfo.count - 1 == indexPath.row){
        
        if(([[bb valueForKey:@"next_page_url"] isKindOfClass:[NSNull class]]) || [[bb valueForKey:@"next_page_url"] isEqualToString:@""])
        {
            
        }
        else
        {
            next_page_url = [bb valueForKey:@"next_page_url"];
            [self getEvents2];
            
        }
    }
    }
   else if(tableView == _thisweekTbl)
    {
        if(ArrInfo.count - 1 == indexPath.row){
            
            if(([[bb valueForKey:@"next_page_url"] isKindOfClass:[NSNull class]]) || [[bb valueForKey:@"next_page_url"] isEqualToString:@""])
            {
                
            }
            else
            {
                next_page_url = [bb valueForKey:@"next_page_url"];
                [self getEvents2];
                [ArrInfo addObjectsFromArray:ArrInfo2];
            }
        }
    }
    else
    {
        if(ArrInfo.count - 1 == indexPath.row){
            
            if(([[bb valueForKey:@"next_page_url"] isKindOfClass:[NSNull class]]) || [[bb valueForKey:@"next_page_url"] isEqualToString:@""])
            {
                
            }
            else
            {
                next_page_url = [bb valueForKey:@"next_page_url"];
                [self getEvents2];
                [ArrInfo addObjectsFromArray:ArrInfo2];
            }
        }
    }
}
    
-(void) showPicker
{
    
    [myPickerView removeFromSuperview];
    
    [selectView removeFromSuperview];
    myPickerView = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height-200, self.view.frame.size.width,200)];
    
    
   
        myPickerView.datePickerMode = UIDatePickerModeDate;
    
  
    myPickerView.backgroundColor = [UIColor whiteColor];
    [myPickerView addTarget:self action:@selector(pickerChanged:) forControlEvents:UIControlEventValueChanged];
    
    [self.view addSubview:myPickerView];
    
    selectView = [[UIView alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height-220, self.view.frame.size.width, 44)];
    selectView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.view addSubview:selectView];
    
    btn_cancel = [[UIButton alloc] initWithFrame:CGRectMake(10, 0, 70, 45)];
    [btn_cancel setTitle:@"Cancel" forState:UIControlStateNormal];
    [btn_cancel setTitleColor:[UIColor colorWithRed:(46/255.0f) green:(123/255.0f) blue:(185/255.0f) alpha:(1.0f)] forState:UIControlStateNormal];
    [btn_cancel addTarget:self action:@selector(canceldate) forControlEvents:UIControlEventTouchUpInside];
    [selectView addSubview:btn_cancel];
    
    UIButton *btn_save = [[UIButton alloc] initWithFrame:CGRectMake(self.view.frame.size.width - 70, 0, 50, 45)];
    [btn_save setTitle:@"Done" forState:UIControlStateNormal];
    [btn_save setTitleColor:[UIColor colorWithRed:(46/255.0f) green:(123/255.0f) blue:(185/255.0f) alpha:(1.0f)] forState:UIControlStateNormal];
    [btn_save addTarget:self action:@selector(ShowSelectedDate) forControlEvents:UIControlEventTouchUpInside];
    [selectView addSubview:btn_save];
    
    NSDate *currentDate = [NSDate date];
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    
    myPickerView.minimumDate = [calendar dateByAddingComponents:comps toDate:currentDate options:0];
    //
    //    toolBar=[[UIToolbar alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height-220, self.view.frame.size.width, 44)];
    //
    //    toolBar.barStyle = UIBarStyleDefault;
    //
    //    toolBar.translucent = YES;
    //
    //    toolBar.tintColor = [UIColor blueColor];
    //
    //    //    toolBar.barStyle = UIBarStyle.default;
    //    //
    //    //    toolBar.isTranslucent = YES;
    //    //
    //    //    toolBar.tintColor = UIColor.blue
    //
    //
    //    UIBarButtonItem *doneBtn=[[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStylePlain target:self action:@selector(ShowSelectedDate)];
    //
    //    UIBarButtonItem *cancel=[[UIBarButtonItem alloc]initWithTitle:@"Cancel" style:UIBarButtonItemStylePlain target:self action:@selector(canceldate)];
    //
    //    [toolBar setItems:[NSArray arrayWithObjects:cancel,doneBtn, nil]];
    //
    //
    //    [self.view addSubview:toolBar];
}

- (void)pickerChanged:(id)sender
{
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
  
 
        df.dateFormat = @"yyyy-MM-dd";
    
        dateFetch = [df stringFromDate:[sender date]];
  
    
    
}


- (void)ShowSelectedDate
{
    [myPickerView removeFromSuperview];
    [selectView removeFromSuperview];
//    dateFetch = [df stringFromDate:[sender date]];
    NSLog(@"print");
    [self getEvents];
}
- (void)canceldate
{
    [myPickerView removeFromSuperview];
    [selectView removeFromSuperview];
    
 
        
      //  self.endDate.text = @"";
        
    
    
    
    
    
    
}

-(void)subscribe
{
    dispatch_async(dispatch_get_main_queue(), ^{
        
       
            [_TonightTable reloadData];
            [_thisweekTbl reloadData];
            [SVProgressHUD dismiss];
      
        
    });
    
}

@end
