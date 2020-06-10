//
//  ViewControllerOTP.h
//  UNiGHTS
//
//  Created by user on 03/07/18.
//  Copyright © 2018 RVTechnologies Softwares PVT. LTD. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewControllerOTP : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *text6;
@property (weak, nonatomic) IBOutlet UITextField *text5;

@property (weak, nonatomic) IBOutlet UITextField *text1;
@property (weak, nonatomic) IBOutlet UITextField *text2;
@property (weak, nonatomic) IBOutlet UITextField *text3;
@property (weak, nonatomic) IBOutlet UITextField *text4;
@property (strong,nonatomic) NSString *nameStr;
@property (strong,nonatomic) NSString *SurnameStr;
@property (strong,nonatomic) NSString *emailStr;
@property (strong,nonatomic) NSString *passStr;
- (IBAction)confirmPasswordTxt:(id)sender;
@property (strong,nonatomic) NSString *PhoneStr;
@property (strong,nonatomic) NSString *confirmPasword;
@property (strong, nonatomic) IBOutlet UILabel *otpTxt;

@end
