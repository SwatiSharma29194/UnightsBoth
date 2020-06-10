//
//  markerViews.h
//  UNiGHTS
//
//  Created by user on 7/4/18.
//  Copyright © 2018 RVTechnologies Softwares PVT. LTD. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
@interface markerViews : UIView
@property (strong, nonatomic) IBOutlet UILabel *eventName;
@property (strong, nonatomic) IBOutlet UILabel *StartTime;
@property (strong, nonatomic) IBOutlet UILabel *endTime;
@property (strong, nonatomic) IBOutlet UIImageView *imgevent;
@property (strong, nonatomic) IBOutlet MKAnnotationView *annoView;

@end
