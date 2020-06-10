//
//  ticketDetailsViewController.h
//  UNiGHTS
//
//  Created by user on 7/5/18.
//  Copyright © 2018 RVTechnologies Softwares PVT. LTD. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ticketDetailsViewController : UIViewController
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
@property (strong,nonatomic) NSString *getCountTicketsEarly;
@property (strong,nonatomic) NSString *getCountTicketsStandard;
@property (strong,nonatomic) NSString *getCountTicketsVIP;
@property (strong,nonatomic) NSString *usedTicket;
@property (strong, nonatomic) IBOutlet UIView *viewShare;
@property (strong, nonatomic) IBOutlet UIView *shareTicket;
@property (strong, nonatomic) IBOutlet UILabel *timeStart;
@property (strong,nonatomic) NSString *eventNamed;
@property (strong,nonatomic) NSString *getStartTime;
@property (strong,nonatomic) NSString *getImgEvent;
@property (strong, nonatomic) IBOutlet UIImageView *eventImg;



@property (strong, nonatomic) IBOutlet UILabel *eventNameT;







@end
