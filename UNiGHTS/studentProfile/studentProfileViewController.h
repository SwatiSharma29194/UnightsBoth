//
//  studentProfileViewController.h
//  UNiGHTS
//
//  Created by user on 8/6/18.
//  Copyright © 2018 RVTechnologies Softwares PVT. LTD. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface studentProfileViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *emailTxt;
@property (weak, nonatomic) IBOutlet UITextField *nameTxt;

@property (strong, nonatomic) IBOutlet UITextField *lastname;
@property (weak, nonatomic) IBOutlet UIImageView *imgStudent;

@property (strong, nonatomic) IBOutlet UITextField *universityTxt;
@end
