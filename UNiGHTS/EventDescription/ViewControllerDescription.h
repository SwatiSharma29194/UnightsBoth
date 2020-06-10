//
//  ViewControllerDescription.h
//  UNiGHTS
//
//  Created by user on 19/06/18.
//  Copyright © 2018 RVTechnologies Softwares PVT. LTD. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface ViewControllerDescription : UIViewController <MKMapViewDelegate>

@property (strong, nonatomic) IBOutlet UILabel *EventMonthTxt;
@property (strong, nonatomic) IBOutlet UIImageView *eventIm;
@property (strong, nonatomic) IBOutlet UILabel *EarlyBirdTicketPrice;
- (IBAction)DescriptionBack:(id)sender;
- (IBAction)EventLocationtapped:(id)sender;
- (IBAction)SahreBtnTapped:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *mapView;
@property (strong, nonatomic) IBOutlet UILabel *username;
@property (weak, nonatomic) IBOutlet UIView *lowerView;
@property (strong, nonatomic) IBOutlet UILabel *address;
@property (weak, nonatomic) IBOutlet UIScrollView *DescriptionScrollView;
@property (strong, nonatomic) IBOutlet UILabel *earlyTicketTxt;
@property (strong, nonatomic) IBOutlet UILabel *standardbirdTxt;
@property (strong, nonatomic) IBOutlet UILabel *vipTicket;
@property (strong, nonatomic) IBOutlet UITextView *descTicket;
@property (weak, nonatomic) IBOutlet UIView *upperView;

@property (weak, nonatomic) IBOutlet UIButton *mapBtn;
@property (strong, nonatomic) IBOutlet UILabel *eventName;
@property (strong, nonatomic) IBOutlet UILabel *addresst;
@property (strong , nonatomic) NSString *getIdEvent;
@property (strong, nonatomic) IBOutlet UILabel *standardPrice;
@property (strong, nonatomic) IBOutlet UILabel *vipPrice;
@property (strong, nonatomic) IBOutlet UILabel *earlyPrice;
@property (strong, nonatomic) IBOutlet UILabel *typeTicket;
@property (strong, nonatomic) IBOutlet UIButton *booknowbtn;
@property (strong , nonatomic) NSString *getHistory;
@property (strong, nonatomic) IBOutlet UIScrollView *carscrollview;
@property (strong, nonatomic) IBOutlet UIView *viewg;

@property (strong, nonatomic) IBOutlet UILabel *remainingEarlyBird;
@property (strong, nonatomic) IBOutlet UILabel *remainingsellticket;
@property (strong, nonatomic) IBOutlet UILabel *remainingvipticket;
@property (strong, nonatomic) IBOutlet UIButton *closeBookingBtn;
@property (strong, nonatomic) IBOutlet UIView *mainV;
@property (strong, nonatomic) IBOutlet MKMapView *appleMap;

@property (strong, nonatomic) IBOutlet UIButton *requestPayment;
@property (weak, nonatomic) IBOutlet UIView *desciew;
@property (strong, nonatomic) IBOutlet UIButton *editEventDesc;
@property (strong, nonatomic) IBOutlet UIView *typeTicketBt;
@property (strong, nonatomic) IBOutlet UILabel *pricePayonDoor;

@property (strong, nonatomic) IBOutlet UIView *addressView;
@property (strong, nonatomic) IBOutlet UIPageControl *pageControl;
@property (strong, nonatomic) IBOutlet UILabel *earlyBirdTi;
@property (strong, nonatomic) IBOutlet UILabel *standardTi;
@property (strong, nonatomic) IBOutlet UILabel *vipTi;
@property (strong, nonatomic) IBOutlet UIView *sellTicketView;
@property (strong, nonatomic) IBOutlet UIView *payonDoorView;
@property (strong, nonatomic) IBOutlet UIView *eventBlackView;
@property (strong, nonatomic) IBOutlet UILabel *start_time;

@end
