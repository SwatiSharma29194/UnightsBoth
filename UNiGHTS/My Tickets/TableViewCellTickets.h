//
//  TableViewCellTickets.h
//  UNiGHTS
//
//  Created by user on 20/06/18.
//  Copyright © 2018 RVTechnologies Softwares PVT. LTD. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TableViewCellTickets : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *BookticketInnerView;
@property (strong, nonatomic) IBOutlet UILabel *refNo;
@property (weak, nonatomic) IBOutlet UIImageView *qrImg;
@property (strong, nonatomic) IBOutlet UILabel *NumberofTickets;
@property (strong, nonatomic) IBOutlet UILabel *paidAmount;
@property (strong, nonatomic) IBOutlet UILabel *username;
@property (strong, nonatomic) IBOutlet UILabel *address;
@property (strong, nonatomic) IBOutlet UILabel *dateT;
@property (strong, nonatomic) IBOutlet UILabel *timeT;
@property (strong, nonatomic) IBOutlet UIImageView *imageEvent;
@property (strong, nonatomic) IBOutlet UILabel *eventName;

@end
