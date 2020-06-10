//
//  paymentViewController.h
//  UNiGHTS
//
//  Created by user on 7/18/18.
//  Copyright © 2018 RVTechnologies Softwares PVT. LTD. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface paymentViewController : UIViewController
@property (strong, nonatomic) IBOutlet UIView *paymentView;
@property (strong, nonatomic) IBOutlet UIButton *editProfileBtn;
@property (strong, nonatomic) IBOutlet UIButton *changePasswordBtn;
@property (strong, nonatomic) IBOutlet UIButton *paymentSettingsBtn;
@property(strong,nonatomic) NSString *FromBooking;
@property(strong,nonatomic) NSString *priceEarly;
@property(strong,nonatomic) NSString *priceStandard;
@property(strong,nonatomic) NSString *priceVIP;
@property(strong,nonatomic) NSString *ticketsEarly;
@property(strong,nonatomic) NSString *ticketsStandard;
@property(strong,nonatomic) NSString *ticketsVIP;
@property(strong,nonatomic) NSString *geTotalAmount;
@property(strong,nonatomic) NSString *pointsTotal;
@property (strong, nonatomic) IBOutlet UIButton *existBtn;
@property (strong, nonatomic) IBOutlet UIButton *addNewCard;



@end
