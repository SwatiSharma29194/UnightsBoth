//
//  ViewController.h
//  UNiGHTS
//
//  Created by user on 12/06/18.
//  Copyright © 2018 RVTechnologies Softwares PVT. LTD. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
- (IBAction)LoginBtTapped:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *nameTxt;
@property (weak, nonatomic) IBOutlet UITextField *emailTxt;
@property (strong, nonatomic) IBOutlet UITextField *universityTxt;

@property (weak, nonatomic) IBOutlet UITextField *passwordTxt;

@end

