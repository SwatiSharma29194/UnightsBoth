//
//  ViewControllerVerify.h
//  UNiGHTS
//
//  Created by user on 03/07/18.
//  Copyright © 2018 RVTechnologies Softwares PVT. LTD. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewControllerVerify : UIViewController
@property (strong, nonatomic) IBOutlet UITextField *nameTxt;
@property (strong, nonatomic) IBOutlet UITextField *surnameTxt;
@property (strong, nonatomic) IBOutlet UITextField *emailTxt;
@property (strong, nonatomic) IBOutlet UITextField *passwordTxt;

@property (weak, nonatomic) IBOutlet UILabel *label;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
- (IBAction)GetCountryCode:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *phtext;
@property (strong, nonatomic) IBOutlet UITextField *confirmPasswordTxt;

@end
