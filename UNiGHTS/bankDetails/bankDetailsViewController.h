//
//  bankDetailsViewController.h
//  UNiGHTS
//
//  Created by user on 8/20/18.
//  Copyright © 2018 RVTechnologies Softwares PVT. LTD. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface bankDetailsViewController : UIViewController


@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) IBOutlet UITextField *bankEmail;
@property (strong, nonatomic) IBOutlet UITextField *bankFirstName;
@property (strong, nonatomic) IBOutlet UITextField *bankLastName;
@property (strong, nonatomic) IBOutlet UITextField *bankaccountholdername;
@property (strong, nonatomic) IBOutlet UITextField *bankaccountNumber;
@property (strong, nonatomic) IBOutlet UITextField *bankRoutingNumber;
@property (strong, nonatomic) IBOutlet UITextField *bankDob;


@property (strong, nonatomic) IBOutlet UIButton *addBtn;
@property (strong, nonatomic) IBOutlet UITextField *bankline1;

@property (strong, nonatomic) IBOutlet UITextField *postalcodetxt;
@property (strong, nonatomic) IBOutlet UIButton *deleteBtn;
@property (strong, nonatomic) IBOutlet UIButton *idPrrofBtn;
@property (strong, nonatomic) IBOutlet UIButton *dobBtn;
@property (strong, nonatomic) IBOutlet UIImageView *idProofImg;

@end
