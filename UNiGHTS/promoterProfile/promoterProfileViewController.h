//
//  promoterProfileViewController.h
//  UNiGHTS
//
//  Created by user on 8/6/18.
//  Copyright © 2018 RVTechnologies Softwares PVT. LTD. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface promoterProfileViewController : UIViewController
@property (strong, nonatomic) IBOutlet UITextField *lastnametxt;

@property (weak, nonatomic) IBOutlet UITextField *nameTxt;
@property (weak, nonatomic) IBOutlet UITextField *companyTxt;
@property (weak, nonatomic) IBOutlet UITextField *addressTxt;
@property (weak, nonatomic) IBOutlet UITextField *postCodeTxt;
@property (weak, nonatomic) IBOutlet UITextField *emailIdTxt;
@property (weak, nonatomic) IBOutlet UITextField *passwordTxt;
@property (weak, nonatomic) IBOutlet UIImageView *profileImg;

@end
