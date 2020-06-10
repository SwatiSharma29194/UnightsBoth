//
//  TableViewCellTonight.h
//  UNiGHTS
//
//  Created by user on 18/06/18.
//  Copyright © 2018 RVTechnologies Softwares PVT. LTD. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TableViewCellTonight : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *EventBanner;
@property (weak, nonatomic) IBOutlet UILabel *eventName;
@property (weak, nonatomic) IBOutlet UILabel *eventAddress;
@property (weak, nonatomic) IBOutlet UILabel *timeLbl;
@property (weak, nonatomic) IBOutlet UILabel *AMPM;
@property (weak, nonatomic) IBOutlet UILabel *EventMonth;
@property (weak, nonatomic) IBOutlet UILabel *eventday;
@property (strong, nonatomic) IBOutlet UIButton *closeBooking;
@property (strong, nonatomic) IBOutlet UIView *viewColour;
@property (strong, nonatomic) IBOutlet UILabel *typeTicket;

@end
