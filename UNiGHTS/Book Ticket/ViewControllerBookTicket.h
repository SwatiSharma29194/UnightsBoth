//
//  ViewControllerBookTicket.h
//  UNiGHTS
//
//  Created by user on 20/06/18.
//  Copyright © 2018 RVTechnologies Softwares PVT. LTD. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewControllerBookTicket : UIViewController
@property (strong, nonatomic) IBOutlet UILabel *earlyBirdTicketQuantity;
@property (strong, nonatomic) IBOutlet UILabel *standardTicketQuantity;
- (IBAction)BookTicketTapped:(id)sender;
@property (strong, nonatomic) IBOutlet UILabel *vipTicketPrice;
@property(strong,nonatomic) NSString*getPriceEarlyBird;
@property(strong,nonatomic) NSString*getpriceVip;
@property(strong,nonatomic) NSString*getpriceStandard;
@property(strong,nonatomic) NSString*geteventId;
@property (strong, nonatomic) IBOutlet UIStepper *stepper1;
@property (strong, nonatomic) IBOutlet UIStepper *stepper2;
@property (strong, nonatomic) IBOutlet UIStepper *stepper3;
@property (strong, nonatomic) IBOutlet UILabel *subtotalPrice;
@property (strong, nonatomic) IBOutlet UILabel *totalPrice;
@property (strong, nonatomic) IBOutlet UIImageView *eventImg;
@property (strong, nonatomic) IBOutlet UILabel *dateTicket;
@property (strong, nonatomic) IBOutlet UILabel *pointsTxt;

@property (strong, nonatomic) IBOutlet UIScrollView *carscrollview;
@property (strong, nonatomic) IBOutlet UILabel *pomits;
@property(strong,nonatomic) NSString*vipPoints;
@property(strong,nonatomic) NSString*standardPoints;
@property(strong,nonatomic) NSString*earlyPoints;
@property(strong,nonatomic) NSString*remainingTicketsEarly;
@property(strong,nonatomic) NSString*remainingTicketsvip;
@property(strong,nonatomic) NSString*remainingTicketsstandard;



@end
