//
//  ViewControllerTravel.m
//  UNiGHTS
//
//  Created by user on 18/06/18.
//  Copyright © 2018 RVTechnologies Softwares PVT. LTD. All rights reserved.
//

#import "ViewControllerTravel.h"

@interface ViewControllerTravel ()

@end

@implementation ViewControllerTravel

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
-(void)viewWillAppear:(BOOL)animated
{
    [_TravelScrollView setContentSize:CGSizeMake(self.TravelScrollView.frame.size.width*3, self.TravelScrollView.frame.size.height)];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
