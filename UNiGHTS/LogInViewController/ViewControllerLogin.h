//
//  ViewControllerLogin.h
//  UNiGHTS
//
//  Created by user on 29/06/18.
//  Copyright © 2018 RVTechnologies Softwares PVT. LTD. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewControllerLogin : UIViewController
@property (weak, nonatomic) IBOutlet UIView *ChooseRoleView;
@property (weak, nonatomic) IBOutlet UIView *PurpLeBlurView;
- (IBAction)OpenRoleView:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;
@property (weak, nonatomic) IBOutlet UITextField *emailTxt;
@property (weak, nonatomic) IBOutlet UITextField *passwordTxt;




@end
