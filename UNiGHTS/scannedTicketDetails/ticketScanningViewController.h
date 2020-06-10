//
//  ticketScanningViewController.h
//  UNiGHTS
//
//  Created by user on 7/11/18.
//  Copyright © 2018 RVTechnologies Softwares PVT. LTD. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ticketScanningViewController : UIViewController
@property (strong, nonatomic) IBOutlet UILabel *refNumber;

@property (strong, nonatomic) IBOutlet UILabel *ticketNumber;

@property (strong, nonatomic) IBOutlet UILabel *paidAmount;

@property (strong, nonatomic) IBOutlet UIImageView *qrImage;

@property (strong, nonatomic) IBOutlet UILabel *name;

@property (strong, nonatomic) IBOutlet UILabel *dateCheck;

@property (strong, nonatomic) IBOutlet UILabel *addressTxt;

@property (strong,nonatomic) NSString *getRef;

@property (strong,nonatomic) NSString *getCountTickets;

@property (strong,nonatomic) NSString *getpaidAmount;

@property (strong,nonatomic) NSString *QRCode;

@property (strong,nonatomic) NSString *getUsername;

@property (strong,nonatomic) NSString *addressget;

@property (strong,nonatomic) NSString *getDate;
@property (strong,nonatomic) NSString *getIduser;
@property (strong,nonatomic) NSString *getStartTime;

@property (strong, nonatomic) IBOutlet UIStepper *stepperEarly;
@property (strong,nonatomic) NSString *getCountTicketsEarly;
@property (strong,nonatomic) NSString *getCountTicketsStandard;
@property (strong,nonatomic) NSString *getCountTicketsVIP;
@property (strong, nonatomic) IBOutlet UIStepper *stepperStandard;
@property (strong, nonatomic) IBOutlet UIStepper *stepperVIP;
@property (strong, nonatomic) IBOutlet UILabel *ticketEarly;
@property (strong, nonatomic) IBOutlet UILabel *ticketStandard;
@property (strong, nonatomic) IBOutlet UILabel *ticketVIP;
@property (strong, nonatomic) IBOutlet UITextField *promoCode;
@property (strong,nonatomic) NSString *orderID;
@end
