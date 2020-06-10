//
//  SidebarTableViewController.h
//  SidebarDemo
//
//  Created by Simon Ng on 10/11/14.
//  Copyright (c) 2014 AppCoda. All rights reserved.
//
#import <MessageUI/MessageUI.h>
#import <UIKit/UIKit.h>

@interface SidebarTableViewController : UITableViewController<MFMailComposeViewControllerDelegate,MFMessageComposeViewControllerDelegate>

@property (strong, nonatomic) IBOutlet UITableView *Menutable_view;

@end
