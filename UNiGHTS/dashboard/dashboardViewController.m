//
//  dashboardViewController.m
//  UNiGHTS
//
//  Created by user on 8/9/18.
//  Copyright © 2018 RVTechnologies Softwares PVT. LTD. All rights reserved.
//

#import "dashboardViewController.h"
#import "common.h"
@interface dashboardViewController ()

@end

@implementation dashboardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    CLLocationManager *we;
    [we stopUpdatingLocation];
    // Do any additional setup after loading the view.
}
- (IBAction)studentBtnTap:(id)sender {
    
    UserRole =@"0";
    UIStoryboard *obj=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *str=[obj instantiateViewControllerWithIdentifier:@"ViewControllerLogin"];
    [self.navigationController pushViewController:str animated:true];
    
}
- (IBAction)promoterBtnTap:(id)sender {
    
    UserRole =@"1";
    
    UIStoryboard *obj=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *str=[obj instantiateViewControllerWithIdentifier:@"ViewControllerLogin"];
    [self.navigationController pushViewController:str animated:true];
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
