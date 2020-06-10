//
//  ViewControllerDescription.m
//  UNiGHTS
//
//  Created by user on 19/06/18.
//  Copyright © 2018 RVTechnologies Softwares PVT. LTD. All rights reserved.
//

#import "ViewControllerDescription.h"
#import <GoogleMaps/GoogleMaps.h>
#import <GooglePlaces/GooglePlaces.h>
#import <CoreLocation/CoreLocation.h>
#import "SVProgressHUD.h"
#import "UIImageView+WebCache.h"
#import "ViewControllerBookTicket.h"
#import "common.h"
#import "ViewControllerMapLocation.h"
#import <MapKit/MapKit.h>
#import "ViewControllerAddEvents.h"
@interface ViewControllerDescription ()<GMSMapViewDelegate,CLLocationManagerDelegate,GMSAutocompleteTableDataSourceDelegate,GMSAutocompleteViewControllerDelegate>
@end

@implementation ViewControllerDescription
NSDictionary *getTicketJ;
NSString *getID;
NSString *getTypeBooking;
//GMSMapView *mapView2;
NSDictionary *json2;
NSMutableArray* imageScroll;
NSMutableArray* imageIDScroll;
NSString * eventNameget;
NSString * cityNameget;
NSString * venueNameget;
NSString * venuePostcodeNameget;
NSString * venueAddressNameget;
NSString * startDateNameget;
NSString * endDateNameget;
NSString * statusTicketNameget;
NSString * earlyBirdPriceNameget;
NSString * earlyBirdQuantityNameget;
NSString * standardPriceNameget;
NSString * standardQuantityNameget;
NSString * vipPriceNameget;
NSString * vipQuantityNameget;
NSString * descriptionNameget;
NSString * image1Nameget;
NSString * image2Nameget;
NSString * image3Nameget;
NSString * eventbnNameget;
NSString * startTimeNameGet;
NSString * endTimeNameGet;
NSString * getPricePay;
double latdoubleC;
double lngdoubleC;
double londouble;
double latdouble;
NSString *getEventName;
- (void)viewDidLoad {
    [super viewDidLoad];
    _descTicket.editable = NO;
    _pageControl.currentPage = 0;
    imageScroll = [[NSMutableArray alloc]init];
    imageIDScroll = [[NSMutableArray alloc]init];;
    _carscrollview.delegate = self;
    //[mapView2.settings setAllGesturesEnabled:NO];
    NSString * sd= [[NSUserDefaults standardUserDefaults] valueForKey:@"getLat"];
    NSString * sd2= [[NSUserDefaults standardUserDefaults] valueForKey:@"getLong"];
   latdoubleC = [sd doubleValue];
    NSLog(@"latdouble: %f", latdoubleC);
    
     lngdoubleC = [sd2 doubleValue];
    NSLog(@"latdouble: %f", lngdoubleC);
  
  
    if([UserRole isEqualToString:@"0"])
    {
        _remainingEarlyBird.hidden = YES;
        _remainingsellticket.hidden = YES;
        _remainingvipticket.hidden = YES;
        _vipTi.text = @"VIP TICKET:";
        _standardTi.text = @"STANDARD TICKET:";
        _earlyBirdTi.text = @"EARLY BIRD TICKET:";
    }
    else
    {
        _remainingEarlyBird.hidden = NO;
        _remainingsellticket.hidden = NO;
        _remainingvipticket.hidden = NO;
        _vipTi.text = @"VIP TICKET:(-20% Admin fees)";
        _standardTi.text = @"STANDARD TICKET:(-20% Admin fees)";
        _earlyBirdTi.text = @"EARLY BIRD TICKET:(-20% Admin fees)";
    }
    
    [self getEventsDetails];
    // Do any additional setup after loading the view.
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
     int page = scrollView.contentOffset.x / scrollView.frame.size.width;
    _pageControl.currentPage = page;
    NSLog(@"%dsd",page);
}

- (IBAction)closeBooking:(id)sender {
    
    [self getcancelBooking];
}

-(void) getcancelBooking{
    
    NSURLSession *session = [NSURLSession sharedSession];
    
    NSString *strtoken  =[[NSUserDefaults standardUserDefaults]objectForKey:@"acessToken"];
    
    NSString *strBearer = @"Bearer ";
    
    NSString *URL = @"http://18.188.52.230/unights/public/api/event-is-booking";
    
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
    NSString *param;
    
    
    if([getTypeBooking  isEqual: @"1"])
    {
       param=[NSString stringWithFormat:@"event_id=%@&isbooking=%@",_getIdEvent,@"0"];
      //  [_closeBookingBtn setTitle:@"Open booking" forState:UIControlStateNormal];
    }
    
    else
    {
        //getTypeBooking = @"1";
        //[_closeBookingBtn setTitle:@"Close booking" forState:UIControlStateNormal];
        param=[NSString stringWithFormat:@"event_id=%@&isbooking=%@",_getIdEvent,@"1"];
    }
    
    
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
            
            NSDictionary *json2 = [NSJSONSerialization JSONObjectWithData:objectData
                                   
                                                                  options:NSJSONReadingMutableContainers
                                   
                                                                    error:&jsonError];
            
            NSLog(@"%@",json2);
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [SVProgressHUD dismiss];
            });
            NSString * getSuccess;
            //
            getSuccess = [NSString stringWithFormat:@"%@",[json2 valueForKey:@"success"]];
            
            if([getSuccess  isEqual: @"1"])
            {
                
                
                if([getTypeBooking  isEqual: @"1"])
                {
                    getTypeBooking = @"0";
                    dispatch_async(dispatch_get_main_queue(), ^{
                        
                          [_closeBookingBtn setTitle:@"Open booking" forState:UIControlStateNormal];
                    });
                  
                }
                
                else
                {
                    getTypeBooking = @"1";
                    dispatch_async(dispatch_get_main_queue(), ^{
                        
                    [_closeBookingBtn setTitle:@"Close booking" forState:UIControlStateNormal];
                    });
                   
                }
            }
            
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
-(void) requestForPayment
{
    NSURLSession *session = [NSURLSession sharedSession];
        NSString *strtoken  =[[NSUserDefaults standardUserDefaults]objectForKey:@"acessToken"];
        
        NSString *strBearer = @"Bearer ";
        
        NSString *URL = @"http://18.188.52.230/unights/public/api/transfer-request";
        
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
        NSString *param;
        

            param=[NSString stringWithFormat:@"event_id=%@",_getIdEvent];
            //  [_closeBookingBtn setTitle:@"Open booking" forState:UIControlStateNormal];
    
        
        
        NSLog(@"%@",param);
        NSData *postData = [param dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
        
        [theRequest setHTTPBody:postData];
         NSURLSessionDataTask * task=  [session dataTaskWithRequest:theRequest completionHandler:^(NSData *  data, NSURLResponse * response, NSError *  error) {
        
        
//        [NSURLConnection sendAsynchronousRequest:theRequest queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
    
            // if(data != nil){
            
            
            
            
            
            NSString *noti = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            
            NSLog(@"Response:: %@", noti);
            
            
            
            
            
            if(data!=nil){
                
                NSError *jsonError;
                
                NSData *objectData = [noti dataUsingEncoding:NSUTF8StringEncoding];
                
                NSDictionary *json2 = [NSJSONSerialization JSONObjectWithData:objectData
                                       
                                                                      options:NSJSONReadingMutableContainers
                                       
                                                                        error:&jsonError];
                
                NSLog(@"%@",json2);
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    [SVProgressHUD dismiss];
                });
                NSString * getSuccess;
                //
                getSuccess = [NSString stringWithFormat:@"%@",[json2 valueForKey:@"success"]];
                
                if([getSuccess  isEqual: @"1"])
                {
                    
                    UIAlertController * alert = [UIAlertController
                                                 alertControllerWithTitle:@"UNiGHTS"
                                                 message:@"Request has been sent . Please wait until admin give you the payment for your event"
                                                 preferredStyle:UIAlertControllerStyleAlert];
                    
                    //Add Buttons
                    dispatch_async(dispatch_get_main_queue(), ^{
                        
                        [SVProgressHUD dismiss];
                    });
                    
                    
                    UIAlertAction* noButton = [UIAlertAction
                                               actionWithTitle:@"OK"
                                               style:UIAlertActionStyleDefault
                                               handler:^(UIAlertAction * action) {
                                                   
                                                   [self.navigationController popViewControllerAnimated:true];
                                                   //Handle no, thanks button
                                               }];
                    
                    //Add your buttons to alert controller
                    
                    
                    [alert addAction:noButton];
                    
                    [self presentViewController:alert animated:YES completion:nil];
              
                }
                
                else
                {
                    
                }
                
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
- (IBAction)requestPaymentTap:(id)sender {
    [self requestForPayment];
}
-(void) getEventsDetails{
    
    NSURLSession *session = [NSURLSession sharedSession];
    
    NSString *strtoken  =[[NSUserDefaults standardUserDefaults]objectForKey:@"acessToken"];
    
    NSString *strBearer = @"Bearer ";
    
    NSString *URL = @"http://18.188.52.230/unights/public/api/get-event-detail";
    
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
    NSString *param;
    
    param=[NSString stringWithFormat:@"event_id=%@",_getIdEvent];
    
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
            
            json2 = [NSJSONSerialization JSONObjectWithData:objectData
                                  
                                                                 options:NSJSONReadingMutableContainers
                                  
                                                                   error:&jsonError];
            
            NSLog(@"%@",json2);
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [SVProgressHUD dismiss];
            });
            NSString * getSuccess;
            //
            getSuccess = [NSString stringWithFormat:@"%@",[json2 valueForKey:@"success"]];
            
            if([getSuccess  isEqual: @"1"])
            {
                
               
                NSString *getname = [[NSUserDefaults standardUserDefaults]valueForKey:@"nameUser"];
                NSString * getName = @"An evening with ";
                  getTicketJ = [json2 valueForKey:@"data"];
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    [SVProgressHUD showWithStatus:@"Please wait.." maskType:SVProgressHUDMaskTypeBlack];
                    
                    
                    
               
                _username.text = [getName stringByAppendingString:getname];
                _address.text = [getTicketJ valueForKey:@"event_name"];
               getID = [getTicketJ valueForKey:@"id"];
             
               venueNameget = [NSString stringWithFormat:@"%@",[getTicketJ valueForKey:@"venue_name"]];
                cityNameget = [NSString stringWithFormat:@"%@",[getTicketJ valueForKey:@"city"]];
               venuePostcodeNameget = [NSString stringWithFormat:@"%@",[getTicketJ valueForKey:@"post_code"]];
                    venueAddressNameget = [NSString stringWithFormat:@"%@",[getTicketJ valueForKey:@"venue_address"]];
                    _addresst.text = [NSString stringWithFormat:@"%@%@%@%@%@%@%@%@",venueNameget,@",",@" ",cityNameget,@",",@" ",@" ",venuePostcodeNameget];
                
startDateNameget = [NSString stringWithFormat:@"%@",[getTicketJ valueForKey:@"start_date"]];
                    endDateNameget = [NSString stringWithFormat:@"%@",[getTicketJ valueForKey:@"end_date"]];
startTimeNameGet = [NSString stringWithFormat:@"%@",[getTicketJ valueForKey:@"start_time"]];
                    endTimeNameGet = [NSString stringWithFormat:@"%@",[getTicketJ valueForKey:@"end_time"]];
 statusTicketNameget = [NSString stringWithFormat:@"%@",[getTicketJ valueForKey:@"ticket_type"]];

                    
                //_addresst.text = [getTicketJ valueForKey:@"venue_address"];
                _eventName.text = [getTicketJ valueForKey:@"event_name"];
                    getEventName = [getTicketJ valueForKey:@"event_name"];
                NSString *getTicketType = [NSString stringWithFormat:@"%@",[getTicketJ valueForKey:@"ticket_type"]];
                NSString *getTransferStatus = [NSString stringWithFormat:@"%@",[getTicketJ valueForKey:@"transfer_status"]];
                NSString *getBooking = [NSString stringWithFormat:@"%@", [getTicketJ valueForKey:@"is_booking"]];
                
                
                if([UserRole isEqualToString:@"0"])
                {
                if([getBooking  isEqual: @"1"])
                {
                    
                    
                    getTypeBooking = @"1";
                    [_closeBookingBtn setTitle:@"Close booking" forState:UIControlStateNormal];
                    _booknowbtn.hidden = YES;
                    
                    
                }
                
                else
                {
                    
                    
                    getTypeBooking = @"0";
                    [_closeBookingBtn setTitle:@"Open booking" forState:UIControlStateNormal];
                    _booknowbtn.hidden = YES;
                    
                    
                }
                }
                
                if(!([UserRole isEqualToString:@"0"]))
                {
                if([getTicketType isEqualToString: @"1"])
                {
                _requestPayment.hidden = NO;
                if([getTransferStatus  isEqual: @"pending"])
                {
                    [_requestPayment setTitle:@"Send Request for payment" forState:UIControlStateNormal];
                    _requestPayment.userInteractionEnabled = true;
                    
                }
                else
                {
                    [_requestPayment setTitle:@"Request sent" forState:UIControlStateNormal];
                    _requestPayment.userInteractionEnabled = false;
                }
                }
                else
                {
                    _requestPayment.hidden = YES;
                }
                }
                
                if([UserRole isEqualToString:@"0"])
                {
                if([_getHistory  isEqual: @"history"])
                {
                    _booknowbtn.hidden = YES;
                    if([getTicketType isEqualToString: @"1"])
                    {
                        _requestPayment.hidden = NO;
                    }
                    
                    else
                    {
                        _requestPayment.hidden = YES;
                    }
                    
                }
                else
                {
                    if([getTicketType isEqualToString: @"1"])
                    {
                         _booknowbtn.hidden = NO;
                        _typeTicket.text = @"TICKETS AND PRICES";
                      
                        _requestPayment.hidden = NO;
                        _typeTicketBt.backgroundColor = [UIColor redColor];
                        
                        //                        _eventBlackView.frame =  CGRectMake(0, 190, self.view.frame.size.height, 63)
                        
                        _sellTicketView.frame = CGRectMake(0, _typeTicketBt.frame.origin.y + _typeTicketBt.frame.size.height, self.view.frame.size.width, self.sellTicketView.frame.size.height);
                        
                        _upperView.frame = CGRectMake(0, 8, self.view.frame.size.width, self.sellTicketView.frame.origin.y + self.sellTicketView.frame.size.height);
                        
                        _payonDoorView.hidden = YES;
                        
                        _sellTicketView.hidden = NO;
                        
                    }
                    else if ([getTicketType isEqualToString: @"0"])
                    {
                        _typeTicketBt.backgroundColor = [UIColor greenColor];
                        _typeTicket.text = @"FREE ENTRY";
                        _requestPayment.hidden = YES;
                        _upperView.frame = CGRectMake(0, 8, self.view.frame.size.width, self.typeTicketBt.frame.origin.y + self.typeTicketBt.frame.size.height);
                        _payonDoorView.hidden = YES;
                        _sellTicketView.hidden = YES;
                        
                    }
                    else
                        
                    {
                        _typeTicketBt.backgroundColor = [UIColor yellowColor];
                        _typeTicket.text = @"PAY ON DOOR";
                        _payonDoorView.hidden = NO;
                        _sellTicketView.hidden = YES;
                        _requestPayment.hidden = YES;
                        _payonDoorView.frame = CGRectMake(0, _typeTicketBt.frame.origin.y + _typeTicketBt.frame.size.height, self.view.frame.size.width, self.payonDoorView.frame.size.height);
                        _upperView.frame = CGRectMake(0, 8, self.view.frame.size.width, self.payonDoorView.frame.origin.y + self.payonDoorView.frame.size.height);
                        
                    }
                    
                    
                    _closeBookingBtn.hidden = YES;
                    _requestPayment.hidden = YES;
                }
                }
                
                else
                {
                    _booknowbtn.hidden = YES;
                    _closeBookingBtn.hidden = NO;
                    _eventBlackView.frame = CGRectMake(0, self.carscrollview.frame.size.height + _carscrollview.frame.origin.y - self.eventBlackView.frame.size.height , self.view.frame.size.width, self.eventBlackView.frame.size.height);
                    
                     _typeTicketBt.frame = CGRectMake(0, _eventBlackView.frame.size.height + _eventBlackView.frame.origin.y, self.view.frame.size.width, self.typeTicketBt.frame.size.height);
                    
                 
                    if([getTicketType isEqualToString: @"1"])
                    {
                        _typeTicket.text = @"TICKETS AND PRICES";
                        _requestPayment.hidden = NO;
                        _typeTicketBt.backgroundColor = [UIColor redColor];
//                        _eventBlackView.frame =  CGRectMake(0, 190, self.view.frame.size.height, 63)
                      
                        _sellTicketView.frame = CGRectMake(0, _typeTicketBt.frame.origin.y + _typeTicketBt.frame.size.height, self.view.frame.size.width, self.sellTicketView.frame.size.height);
                        
                           _upperView.frame = CGRectMake(0, 8, self.view.frame.size.width, self.sellTicketView.frame.origin.y + self.sellTicketView.frame.size.height);
                        
                        _payonDoorView.hidden = YES;
                        
                        _sellTicketView.hidden = NO;
                        
                    }
                    else if ([getTicketType isEqualToString: @"0"])
                    {
                        _typeTicketBt.backgroundColor = [UIColor greenColor];
                        _typeTicket.text = @"FREE ENTRY";
                       _requestPayment.hidden = YES;
                           _upperView.frame = CGRectMake(0, 8, self.view.frame.size.width, self.typeTicketBt.frame.origin.y + self.typeTicketBt.frame.size.height);
                        _payonDoorView.hidden = YES;
                        _sellTicketView.hidden = YES;
                        
                    }
                    else
             
                    {
                        _typeTicketBt.backgroundColor = [UIColor yellowColor];
                        _typeTicket.text = @"PAY ON DOOR";
                        _payonDoorView.hidden = NO;
                        _sellTicketView.hidden = YES;
                        _requestPayment.hidden = YES;
                          _payonDoorView.frame = CGRectMake(0, _typeTicketBt.frame.origin.y + _typeTicketBt.frame.size.height, self.view.frame.size.width, self.payonDoorView.frame.size.height);
                           _upperView.frame = CGRectMake(0, 8, self.view.frame.size.width, self.payonDoorView.frame.origin.y + self.payonDoorView.frame.size.height);
                        
                    }
                    
                    
                }
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    [SVProgressHUD dismiss];
                });
             
             if(!([[getTicketJ valueForKey:@"price"] isKindOfClass:[NSNull class]]))
             {
                 NSString *price = [NSString stringWithFormat:@"%@", [getTicketJ valueForKey:@"price"]];
                 getPricePay = [NSString stringWithFormat:@"%@",price];
                 self.pricePayonDoor.text = [NSString stringWithFormat:@"%@%@",@"£",price];
             }
                
           
                NSDictionary *getTicket = [getTicketJ valueForKey:@"event_price"];
                if(!([[getTicket valueForKey:@"early_bird_price"] isKindOfClass:[NSNull class]]))
                {
                    _earlyTicketTxt.text = @"Early Bird Tickets have price of";
               
                    
                    
                    _earlyPrice.text = [NSString stringWithFormat:@"%@%@",@"£",[getTicket valueForKey:@"early_bird_price"]];
                    earlyBirdPriceNameget = [NSString stringWithFormat:@"%@",[getTicket valueForKey:@"early_bird_price"]];
                    earlyBirdQuantityNameget = [NSString stringWithFormat:@"%@",[getTicket valueForKey:@"early_bird_quantity"]];
                   
//                    _earlyPrice.text = [getTicket valueForKey:@"early_bird_price"];
                }
                else
                {
                    _earlyTicketTxt.text = @"Early Bird Tickets have price of";
                    _EarlyBirdTicketPrice.text = @"N/A";
                    earlyBirdPriceNameget = @"";
                    earlyBirdQuantityNameget = @"";
                }
                if(!([[getTicket valueForKey:@"standard_price"] isKindOfClass:[NSNull class]]))
                {
                    _standardbirdTxt.text = @"Early Bird Tickes have price of";
                    _standardPrice.text = [NSString stringWithFormat:@"%@%@",@"£",[getTicket valueForKey:@"standard_price"]];
                    standardPriceNameget = [NSString stringWithFormat:@"%@",[getTicket valueForKey:@"standard_price"]];
                    standardQuantityNameget = [NSString stringWithFormat:@"%@",[getTicket valueForKey:@"standard_quantity"]];
           
                    
                }
                else
                {
//                    _ear.text = @"Early Bird Tickes have price of";
                    _standardPrice.text = @"N/A";
                    standardPriceNameget = @"";
                    standardQuantityNameget = @"";
                }
                
                if(!([[getTicket valueForKey:@"vip_price"] isKindOfClass:[NSNull class]]))
                {
                    _vipTicket.text = @"Early Bird Tickes have price of";
                    
                    _vipPrice.text = [NSString stringWithFormat:@"%@%@",@"£",[getTicket valueForKey:@"vip_price"]];
                    vipPriceNameget = [NSString stringWithFormat:@"%@",[getTicket valueForKey:@"vip_price"]];
                    vipQuantityNameget = [NSString stringWithFormat:@"%@",[getTicket valueForKey:@"vip_quantity"]];
                }
                else
                {
                    _vipTicket.text = @"Early Bird Tickes have price of";
                    _vipPrice.text = @"N/A";
                    vipPriceNameget = @"";
                    vipQuantityNameget = @"";
                }
                   
                _descTicket.text = [getTicketJ valueForKey:@"description"];
                descriptionNameget = _descTicket.text;
                    CGSize constraint = CGSizeMake(_descTicket.frame.size.width, CGFLOAT_MAX);
                    CGSize size;
                    
                    NSStringDrawingContext *context = [[NSStringDrawingContext alloc] init];
                    CGSize boundingBox = [_descTicket.text boundingRectWithSize:constraint
                                                                  options:NSStringDrawingUsesLineFragmentOrigin
                                                               attributes:@{NSFontAttributeName:_descTicket.font}
                                                                  context:context].size;
                    
                    size = CGSizeMake(ceil(boundingBox.width), ceil(boundingBox.height));
                   
                
                 
                    
                           _desciew.frame = CGRectMake(0, self.upperView.frame.size.height + self.upperView.frame.origin.y + 10, self.view.frame.size.width, size.height + 60);
                 _descTicket.frame = CGRectMake(0, 50, self.view.frame.size.width, size.height + 10);
//
            
                    
                    _lowerView.frame = CGRectMake(0, self.desciew.frame.origin.y + self.desciew.frame.size.height + 10, self.view.frame.size.width, _booknowbtn.frame.origin.y + _booknowbtn.frame.size.height);
                    
                           _viewg.frame = CGRectMake(0, 0, self.view.frame.size.width, self.lowerView.frame.origin.y + _lowerView.frame.size.height + 20);
                    
                    
                     [_DescriptionScrollView setContentSize:CGSizeMake(_DescriptionScrollView.frame.size.width, _viewg.frame.origin.y + _viewg.frame.size.height + 10)];
                    
                  
                  
                if(!([[getTicketJ valueForKey:@"longitude"] isKindOfClass:[NSNull class]]))
                {
                    
                    
                    NSString *getLat = [NSString stringWithFormat:@"%@",[getTicketJ valueForKey:@"latitude"]];
                    
                      NSString *getLong = [NSString stringWithFormat:@"%@",[getTicketJ valueForKey:@"longitude"]];
                     londouble = [getLong doubleValue];
                     latdouble = [getLat doubleValue];
                    

//
//                    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:latdouble longitude:londouble zoom:16];
//                    mapView2 = [GMSMapView mapWithFrame:CGRectMake(0,0, self.view.frame.size.width, self.mapView.frame.size.height) camera:camera];
//                    mapView2.delegate = self;
//                    mapView2.userInteractionEnabled = NO;
                    
                    //mapView_.myLocationEnabled = YES;
//                    [self.mapView addSubview:mapView2];
//                    GMSMarker *marker = [ [GMSMarker alloc] init];
//                    marker.position = CLLocationCoordinate2DMake(latdouble, londouble);
//                    marker.appearAnimation = kGMSMarkerAnimationPop;
//                    marker.icon = [UIImage imageNamed:@"RedPin"];
//                    marker.title = getEventName;
////                    marker.snippet = @"New York, NY, USA";
//                    marker.appearAnimation = kGMSMarkerAnimationPop;
//                    marker.infoWindowAnchor = CGPointMake(0.44f, 0.30f);
//                    marker.map = mapView2;
//                    [mapView2 setSelectedMarker:marker];

                  
                    
//                    GMSMarker *marker = [ [GMSMarker alloc] init];
//                    marker.position = CLLocationCoordinate2DMake(londouble, latdouble);
//                    marker.appearAnimation = kGMSMarkerAnimationPop;
//                    marker.icon = [UIImage imageNamed:@"RedPin"];
//                    //marker.title = @"Bar club";
//                   // marker.snippet = @"Chandigarh";
//                    marker.appearAnimation = kGMSMarkerAnimationPop;
//
//                    marker.map = mapView2;
//                    [mapView2 setSelectedMarker:marker];
                    
                    CLLocationCoordinate2D annotationCoord;
                    
                    annotationCoord.latitude = latdouble;
                    annotationCoord.longitude = londouble;
                    
                    MKPointAnnotation *annotationPoint = [[MKPointAnnotation alloc] init];
                    annotationPoint.coordinate = annotationCoord;
                    annotationPoint.title = getEventName;
                //    annotationPoint.subtitle = @"Microsoft's headquarters";
                    [self.appleMap addAnnotation:annotationPoint];
                    MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(annotationCoord, 100, 100);
                    
                    // 3
                    [self.appleMap setRegion:viewRegion animated:YES];
                    
                    
                }
                else
                {
                    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:12.1212 longitude:21.21 zoom:14];
                    
                    CLLocationCoordinate2D annotationCoord;
                    
                    annotationCoord.latitude = latdouble;
                    annotationCoord.longitude = londouble;
                    
                    MKPointAnnotation *annotationPoint = [[MKPointAnnotation alloc] init];
                    annotationPoint.coordinate = annotationCoord;
                    annotationPoint.title = getEventName;
                    //annotationPoint.subtitle = @"Microsoft's headquarters";
                    [self.appleMap addAnnotation:annotationPoint];
//                    mapView2 = [GMSMapView mapWithFrame:CGRectMake(0,0, self.view.frame.size.width, self.mapView.frame.size.height) camera:camera];
//                    mapView2.delegate = self;
//
//
//                    //mapView_.myLocationEnabled = YES;
//                    [self.mapView addSubview:mapView2];
//                    GMSMarker *marker = [ [GMSMarker alloc] init];
//                    marker.position = CLLocationCoordinate2DMake(lngdoubleC, lngdoubleC);
//                    marker.appearAnimation = kGMSMarkerAnimationPop;
//                    marker.icon = [UIImage imageNamed:@"RedPin"];
//                    marker.title = @"Bar club";
//                    marker.snippet = @"Chandigarh";
//                    marker.appearAnimation = kGMSMarkerAnimationPop;
//
//                    marker.map = mapView2;
//                    [mapView2 setSelectedMarker:marker];
                    
                }
                 NSArray * getEventArr = [getTicketJ valueForKey:@"event_images"];
                
                for(int i = 0;i<getEventArr.count;i++)
                {
//                    let imageviewdata = UIImageView()
//                    imageviewdata.frame = CGRect(x: CGFloat(self.to_scroll.frame.size.width * CGFloat(x)), y: 0, width: self.to_scroll.frame.size.width, height: self.to_scroll.frame.size.height)
                    
                    UIImageView *getl;
                    getl = [[UIImageView alloc]init];
                    getl.frame = CGRectMake(self.carscrollview.frame.size.width * i, 0, self.carscrollview.frame.size.width, self.carscrollview.frame.size.width);
                    getl.contentMode = UIViewContentModeScaleAspectFill;
                    getl.clipsToBounds = YES;
                    NSDictionary *getDictImage = [getEventArr objectAtIndex:i];
                    
                                    NSString * getEventImg = [NSString stringWithFormat:@"%@",[getDictImage valueForKey:@"image"]];
                            NSString * getEventImgId = [NSString stringWithFormat:@"%@",[getDictImage valueForKey:@"id"]];
                                    NSString * ImgbaseUrl = @"http://18.188.52.230/unights/public/events/";
                                    if(!([[ImgbaseUrl stringByAppendingString:getEventImg] isKindOfClass:[NSNull class]])){
                    
                    
                    
                                        ImgbaseUrl= [ImgbaseUrl stringByAppendingString:getEventImg];
                    
                                        [getl sd_setImageWithURL:[NSURL URLWithString:ImgbaseUrl]];
                    
                                        
                }
                    
                    [self.carscrollview addSubview:getl];
                    [imageScroll addObject:ImgbaseUrl];
                    [imageIDScroll addObject:getEventImgId];
                    
                   
                }
                _carscrollview.contentSize = CGSizeMake(self.carscrollview.frame.size.width * getEventArr.count, self.carscrollview.frame.size.height);
                
                   [[NSUserDefaults standardUserDefaults]setObject:getEventArr forKey:@"ImgbaseUrl"];

                
                
                    
            
                
 
                
              NSString *getEventDate = [NSString stringWithFormat:@"%@",[getTicketJ valueForKey:@"start_date"]];
            
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setDateFormat:@"yyyy-MM-dd"];
            NSDate *date = [dateFormatter dateFromString:getEventDate];
            
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            [formatter setDateFormat:@"MMM dd"];
            NSLog(@"Current Date: %@", [formatter stringFromDate:date]);
            NSString * getdate = [formatter stringFromDate:date];
                    
                    
            
            
                _EventMonthTxt.text = getdate;
                    [[NSUserDefaults standardUserDefaults] setValue:getdate forKey:@"getEventDate"];
                    NSString *getEventtime = [NSString stringWithFormat:@"%@",[getTicketJ valueForKey:@"start_time"]];
                    
                    NSDateFormatter *dateFormatter3 = [[NSDateFormatter alloc] init];
                    [dateFormatter3 setDateFormat:@"HH:mm:ss"];
                    NSDate *date32 = [dateFormatter3 dateFromString:getEventtime];
                    
                    NSDateFormatter *formatter3 = [[NSDateFormatter alloc] init];
                    [formatter3 setDateFormat:@"hh:mm a"];
                    NSLog(@"Current Date: %@", [formatter3 stringFromDate:date32]);
                    NSString * getdate3 = [formatter3 stringFromDate:date32];
                    _start_time.text = getdate3;
              NSDictionary *getTicketsQuantity = [json2 valueForKey:@"remaining_tickets"];
                NSString *getTicketQEarly = [NSString stringWithFormat:@"%@", [getTicketsQuantity valueForKey:@"early_ticket"]];
                if([[getTicketsQuantity valueForKey:@"early_ticket"] isKindOfClass:[NSNull class]])
                {
                    getTicketQEarly = @"0";
                }
                _remainingEarlyBird.text = [@"Remaining Tickets: " stringByAppendingString:getTicketQEarly];
                
                NSString *getTicketQstandard = [NSString stringWithFormat:@"%@", [getTicketsQuantity valueForKey:@"standard_ticket"]];
                if([[getTicketsQuantity valueForKey:@"standard_ticket"] isKindOfClass:[NSNull class]])
                {
                    getTicketQstandard = @"0";
                }
                _remainingsellticket.text = [@"Remaining Tickets: " stringByAppendingString:getTicketQstandard];
                
                NSString *getTicketQvip = [NSString stringWithFormat:@"%@", [getTicketsQuantity valueForKey:@"vip_tickets"]];
                if([[getTicketsQuantity valueForKey:@"vip_tickets"] isKindOfClass:[NSNull class]])
                {
                    getTicketQvip = @"0";
                }
                _remainingvipticket.text = [@"Remaining Tickets: " stringByAppendingString:getTicketQvip];
                
               
                NSString *getEventendDate = [NSString stringWithFormat:@"%@",[getTicketJ valueForKey:@"end_date"]];
                
                
                NSDateFormatter *dateFormatter2 = [[NSDateFormatter alloc] init];
                [dateFormatter2 setDateFormat:@"yyyy-MM-dd"];
                NSDate *date2 = [dateFormatter2 dateFromString:getEventendDate];
                NSDate* date3 = [NSDate date];
                
                if(!([UserRole isEqualToString:@"0"]))
                {
                    if([getTicketType isEqualToString: @"1"])
                    {
                        
                        if ([date3 laterDate:date2] == date3) {
                           
                            NSDate *sevenDaysAgo = [date2 dateByAddingTimeInterval:+3*24*60*60];
                             if ([sevenDaysAgo laterDate:date3] == date3) {
                                 _requestPayment.hidden = NO;
                                 }
                            else
                            {
                              _requestPayment.hidden = YES;
                            }
                            _closeBookingBtn.hidden = YES;
                            
                            
                        }
                        else {
                            _closeBookingBtn.hidden = NO;
                            _requestPayment.hidden = YES;
                        }
                    }
                }
                else
                {
                    _closeBookingBtn.hidden = YES;
                    _requestPayment.hidden = YES;
                }
               
//                if(date2 < date3)
//                {
//                    _closeBookingBtn.hidden = YES;
//                    _requestPayment.hidden = NO;
//                }
//                else
//                {
//                    _closeBookingBtn.hidden = NO;
//                    _requestPayment.hidden = YES;
//                }
                if([getTicketQEarly  isEqual: @"0"] && [getTicketQstandard  isEqual: @"0"] && [getTicketQvip  isEqual: @"0"])
                {
                    _closeBookingBtn.hidden = YES;
                    
                }
                      });
            }
                              
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

    
//    image1Nameget = [NSString stringWithFormat:@"%@",[getTicketJ valueForKey:@"venue_address"]];
//    image2Nameget = [NSString stringWithFormat:@"%@",[getTicketJ valueForKey:@"venue_address"]];
//    image3Nameget = [NSString stringWithFormat:@"%@",[getTicketJ valueForKey:@"venue_address"]];
//    eventbnNameget = [NSString stringWithFormat:@"%@",[getTicketJ valueForKey:@"venue_address"]];
}

- (MKAnnotationView *)mapView:(MKMapView *)map viewForAnnotation:(id )annotation
{
    MKPinAnnotationView *annView=[[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"MyPin"];
    annView.animatesDrop=TRUE;
    annView.canShowCallout = YES;
    [annView setSelected:YES];
    annView.pinColor = MKPinAnnotationColorRed;
    annView.calloutOffset = CGPointMake(15, 15);
    return annView;
}
- (IBAction)enlargeMapView:(id)sender {
    
    UIStoryboard *obj=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
    ViewControllerMapLocation *str=[obj instantiateViewControllerWithIdentifier:@"ViewControllerMapLocation"];
    str.lat_sting_vc = [NSString stringWithFormat:@"%f",latdouble];
    str.long_sting_vc = [NSString stringWithFormat:@"%f",londouble];
    str.nameEvent = [NSString stringWithFormat:@"%@", getEventName];
    [self.navigationController pushViewController:str animated:true];
}
-(void)viewWillAppear:(BOOL)animated
{
    if([UserRole isEqualToString:@"1"])
    {
        if([_getHistory  isEqual: @"history"])
        {
            _editEventDesc.hidden = NO;
        }
        else
        {
            _editEventDesc.hidden = YES;
        }
    }
    else
    {
        _editEventDesc.hidden = YES;
    }
//    if ([[UIScreen mainScreen] bounds].size.height == 812)
//    {
//        [_DescriptionScrollView setContentSize:CGSizeMake(_DescriptionScrollView.frame.size.width, 2000)];
//    }
//    else
//    {
//         [_DescriptionScrollView setContentSize:CGSizeMake(_DescriptionScrollView.frame.size.width, 2000)];
//    }
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

- (IBAction)DescriptionBack:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)EventLocationtapped:(id)sender
{
    UIStoryboard *obj=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *str=[obj instantiateViewControllerWithIdentifier:@"ViewControllerMapLocation"];
    [self.navigationController pushViewController:str animated:true];
}

- (IBAction)SahreBtnTapped:(id)sender
{
    NSString *rproputeInviteLink=@"There is one new event nearby you \n To download this amazing app please click on below link:- \n\n https://goo.gl/kagVLY";
    NSArray *objectsToShare = @[rproputeInviteLink];
    UIActivityViewController *activityVC = [[UIActivityViewController alloc] initWithActivityItems:objectsToShare applicationActivities:nil];
    NSArray *excludeActivities = @[UIActivityTypeAirDrop,
                                   UIActivityTypePrint,
                                   UIActivityTypeAssignToContact,
                                   UIActivityTypeSaveToCameraRoll,
                                   UIActivityTypeAddToReadingList,
                                   UIActivityTypePostToFlickr,
                                   UIActivityTypePostToVimeo];
    activityVC.excludedActivityTypes = excludeActivities;
    [self presentViewController:activityVC animated:YES completion:nil];
}

- (IBAction)BookTapped:(id)sender
{
    UIStoryboard *obj=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
    ViewControllerBookTicket *str=[obj instantiateViewControllerWithIdentifier:@"ViewControllerBookTicket"];
    NSDictionary *getTicket = [getTicketJ valueForKey:@"event_price"];
     NSDictionary *getTicketPoints = [json2 valueForKey:@"points"];
    if(!([[getTicket valueForKey:@"early_bird_price"] isKindOfClass:[NSNull class]]))
    {
        
      
        
       str.getPriceEarlyBird  = [NSString stringWithFormat:@"%@%@",@"£",[getTicket valueForKey:@"early_bird_price"]];
        str.earlyPoints = [NSString stringWithFormat:@"%@",[getTicketPoints valueForKey:@"early_bird_points"]];
        NSDictionary *getTicketsQuantity = [json2 valueForKey:@"remaining_tickets"];
        NSString *getTicketQEarly = [NSString stringWithFormat:@"%@", [getTicketsQuantity valueForKey:@"early_ticket"]];
        if([[getTicketsQuantity valueForKey:@"early_ticket"] isKindOfClass:[NSNull class]])
        {
            getTicketQEarly = @"0";
        }
        _remainingEarlyBird.text = [@"Remaining Tickets: " stringByAppendingString:getTicketQEarly];
        
        NSString *getTicketQstandard = [NSString stringWithFormat:@"%@", [getTicketsQuantity valueForKey:@"standard_ticket"]];
        if([[getTicketsQuantity valueForKey:@"standard_ticket"] isKindOfClass:[NSNull class]])
        {
            getTicketQstandard = @"0";
        }
        NSString *getTicketQvip = [NSString stringWithFormat:@"%@", [getTicketsQuantity valueForKey:@"vip_tickets"]];
        if([[getTicketsQuantity valueForKey:@"vip_tickets"] isKindOfClass:[NSNull class]])
        {
            getTicketQvip = @"0";
        }
        str.remainingTicketsEarly = getTicketQEarly;
               str.remainingTicketsvip = getTicketQvip;
          str.remainingTicketsstandard = getTicketQstandard;
        
        //                    _earlyPrice.text = [getTicket valueForKey:@"early_bird_price"];
    }
    else
    {
        
        str.getPriceEarlyBird = @"N/A";
    }
    if(!([[getTicket valueForKey:@"standard_price"] isKindOfClass:[NSNull class]]))
    {
       
        str.getpriceStandard = [NSString stringWithFormat:@"%@%@",@"£",[getTicket valueForKey:@"standard_price"]];
          str.standardPoints = [NSString stringWithFormat:@"%@",[getTicketPoints valueForKey:@"standard_points"]];
        
    }
    else
    {
        //                    _ear.text = @"Early Bird Tickes have price of";
       str.getpriceStandard = @"N/A";
    }
    
    if(!([[getTicket valueForKey:@"vip_price"] isKindOfClass:[NSNull class]]))
    {
     
        
        str.getpriceVip = [NSString stringWithFormat:@"%@%@",@"£",[getTicket valueForKey:@"vip_price"]];
                  str.vipPoints = [NSString stringWithFormat:@"%@",[getTicketPoints valueForKey:@"vip_points"]];
    }
    else
    {
        
        str.getpriceVip = @"N/A";
    }
    str.geteventId = getID;
    [[NSUserDefaults standardUserDefaults]setObject:getID forKey:@"getID"];
  
    [self.navigationController pushViewController:str animated:true];
}
- (IBAction)editEventTap:(id)sender {
    
    UIStoryboard *obj=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
    ViewControllerAddEvents *str=[obj instantiateViewControllerWithIdentifier:@"ViewControllerAddEvents"];
//    @property (weak,nonatomic) NSString * eventName;
//    @property (weak,nonatomic) NSString * cityName;
//    @property (weak,nonatomic) NSString * venueName;
//    @property (weak,nonatomic) NSString * venuePostcodeName;
//    @property (weak,nonatomic) NSString * startDateName;
//    @property (weak,nonatomic) NSString * endDateName;
//    @property (weak,nonatomic) NSString * statusTicketName;
//    @property (weak,nonatomic) NSString * earlyBirdPriceName;
//    @property (weak,nonatomic) NSString * earlyBirdQuantityName;
//    @property (weak,nonatomic) NSString * standardPriceName;
//    @property (weak,nonatomic) NSString * standardQuantityName;
//    @property (weak,nonatomic) NSString * vipPriceName;
//    @property (weak,nonatomic) NSString * vipQuantityName;
//    @property (weak,nonatomic) NSString * descriptionName;
//    @property (weak,nonatomic) NSString * image1Name;
//    @property (weak,nonatomic) NSString * image2Name;
//    @property (weak,nonatomic) NSString * image3Name;
//    @property (weak,nonatomic) NSString * eventbnName;
    str.eventName = _eventName.text;
    str.cityName = cityNameget;
    str.venueName = venueNameget;
    str.venueAddressName = venueAddressNameget;
    str.venuePostcodeName = venuePostcodeNameget;
    str.startDateName = startDateNameget;
      str.endDateName = endDateNameget;
      str.statusTicketName = statusTicketNameget;
      str.earlyBirdPriceName = earlyBirdPriceNameget;
      str.earlyBirdQuantityName = earlyBirdQuantityNameget;
      str.standardPriceName = standardPriceNameget;
    str.standardQuantityName = standardQuantityNameget;
    str.vipPriceName = vipPriceNameget;
    str.vipQuantityName = vipQuantityNameget;
    str.descriptionName = descriptionNameget;
     str.eventStartTimeName = startTimeNameGet;
     str.eventendTimeName = endTimeNameGet;
    str.eventbnName = @"edit";
    str.eventIdEdit = _getIdEvent;
    str.latitudeEdit = latdouble;
    str.longitudeEdit = londouble;
    str.PricePayonDoor = getPricePay;
    if(imageScroll.count > 0)
    {
    str.image1Name = imageScroll[0];
  str.imageId = imageIDScroll[0];
        
    }
    if(imageScroll.count > 1)
    {
    str.image2Name = imageScroll[1];
        str.imageId1 = imageIDScroll[1];
    }
    if (imageScroll.count > 2) {
          str.image3Name = imageScroll[2];
        str.imageId2 = imageIDScroll[2];
    }
    
  
    
    [self.navigationController pushViewController:str animated:true];
    
}


        


@end
