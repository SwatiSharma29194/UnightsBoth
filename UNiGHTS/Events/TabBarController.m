//
//  TabBarController.m
//  JamesApp
//
//  Created by RV-APPLE on 8/29/16.
//  Copyright © 2016 Rvtech. All rights reserved.
//

#import "TabBarController.h"
@interface TabBarController ()

@end

@implementation TabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    UITabBarItem *item0 = [self.tabBar.items objectAtIndex:0];
    UITabBarItem *item1 = [self.tabBar.items objectAtIndex:1];
    UITabBarItem *item2 = [self.tabBar.items objectAtIndex:2];
    
    item0.title = @"Events";
    item1.title = @"Location";
    item2.title = @"Travel";

   UIColor * Appcolcor =[UIColor colorWithRed:(99/255.0) green:(59/255.0) blue:(151/255.0) alpha:1] ;

    [[UITabBar appearance] setBackgroundImage:[UIImage imageNamed:@"Tabbar"]];
    [item0 setImage:[[UIImage imageNamed:@"EventWhite.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    [item0 setSelectedImage:[[UIImage imageNamed:@"EventPurple.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    
    [item1 setImage:[[UIImage imageNamed:@"LocationWhite.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    [item1 setSelectedImage:[[UIImage imageNamed:@"LocationPurple.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    
    [item2 setSelectedImage:[[UIImage imageNamed:@"travelPurple.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    [item2 setImage:[[UIImage imageNamed:@"travelWhite.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    
    [[UITabBarItem appearance] setTitleTextAttributes:@{ NSForegroundColorAttributeName :Appcolcor }
                                             forState:UIControlStateSelected];
    [[UITabBarItem appearance] setTitleTextAttributes:@{ NSForegroundColorAttributeName : [UIColor whiteColor] }
                                             forState:UIControlStateNormal];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item
{
    NSLog(@"tab selected: %@", item.title);
}
@end
