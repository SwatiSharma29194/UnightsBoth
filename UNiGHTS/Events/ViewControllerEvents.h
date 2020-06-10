//
//  ViewControllerEvents.h
//  UNiGHTS
//
//  Created by user on 13/06/18.
//  Copyright © 2018 RVTechnologies Softwares PVT. LTD. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SWRevealViewController.h"
#import <MapKit/MapKit.h>
@interface ViewControllerEvents : UIViewController<SWRevealViewControllerDelegate,MKMapViewDelegate>
@property (weak, nonatomic) IBOutlet UIView *view1;
@property (weak, nonatomic) IBOutlet UIView *view2;
@property (strong, nonatomic) IBOutlet MKMapView *mapApple2;


@property (strong, nonatomic) IBOutlet UIScrollView *EventsScrollView;
@property (weak, nonatomic) IBOutlet UITableView *TonightTable;
- (IBAction)SearchLocationTapped:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *view3;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *sidebarButton;
@property (weak, nonatomic) IBOutlet UIButton *AutoCompleteBtn;
@property (weak, nonatomic) IBOutlet UIView *GrayBlackTransperant;
@property (weak, nonatomic) IBOutlet UIView *LocationPickerView;
@property (weak, nonatomic) IBOutlet UIPickerView *LocationPicker;
@property (weak, nonatomic) IBOutlet UIButton *DoneBtn;
- (IBAction)LocationDoneTapped:(id)sender;
- (IBAction)LocationCamcelTapped:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *cancelBtn;
@property (weak, nonatomic) IBOutlet UILabel *SelectedLocation;
@property (weak, nonatomic) IBOutlet UIButton *tonightBtn;
@property (weak, nonatomic) IBOutlet UIButton *thisWekkBtn;

@property (weak, nonatomic) IBOutlet UILabel *noeventTonight;
@property (weak, nonatomic) IBOutlet UITableView *thisweekTbl;
@property (weak, nonatomic) IBOutlet UILabel *noeventThisWeek;
@property (weak, nonatomic) IBOutlet UILabel *noeventMonth;
@property (weak, nonatomic) IBOutlet UIButton *monthBtn;

- (IBAction)EventsMapview:(id)sender;
- (IBAction)MaplistView:(id)sender;
//
@property (weak, nonatomic) IBOutlet UIScrollView *MapViewScroll;
@property (weak, nonatomic) IBOutlet UIView *SrollingMapview;
@property (weak, nonatomic) IBOutlet UIButton *MapViewBtn;
@property (weak, nonatomic) IBOutlet UIButton *ListViewbtn;
@property (weak, nonatomic) IBOutlet UIImageView *Image_Mapview;
@property (weak, nonatomic) IBOutlet UITableView *monthTblView;
@property (strong, nonatomic) IBOutlet UIView *thisweekV;
@property (strong, nonatomic) IBOutlet UIView *monthV;



@property (strong, nonatomic) IBOutlet UIView *tonightV;

@end
