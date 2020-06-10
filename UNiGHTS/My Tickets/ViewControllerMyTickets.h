//
//  ViewControllerMyTickets.h
//  UNiGHTS
//
//  Created by user on 20/06/18.
//  Copyright © 2018 RVTechnologies Softwares PVT. LTD. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SWRevealViewController.h"
@interface ViewControllerMyTickets : UIViewController<SWRevealViewControllerDelegate>
@property (weak, nonatomic) IBOutlet UITableView *TicketsTable;
- (IBAction)TicketBookingBack:(id)sender;
@property (strong, nonatomic) IBOutlet UILabel *noTicketsTiltel;


@end
