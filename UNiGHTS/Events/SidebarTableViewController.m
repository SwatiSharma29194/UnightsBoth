//
//  SidebarTableViewController.m
//  SidebarDemo
//
//  Created by Simon Ng on 10/11/14.
//  Copyright (c) 2014 AppCoda. All rights reserved.
//

#import "SidebarTableViewController.h"
#import "SWRevealViewController.h"
#import "TableViewCellMenu.h"
#import "common.h"
#import "UIImageView+WebCache.h"
#import <FBSDKLoginKit/FBSDKLoginKit.h>
@interface SidebarTableViewController ()

@end

@implementation SidebarTableViewController {
    NSArray *menuItems;
}
NSMutableArray * menu_images;
NSMutableArray * menu_names;
- (void) receiveTestNotification:(NSNotification *) notification
{
    // [notification name] should always be @"TestNotification"
    // unless you use this method for observation of other notifications
    // as well.
    
    if ([[notification name] isEqualToString:@"TestNotification"])
        
        NSLog (@"Successfully received the test notification!");
    
     dispatch_async(dispatch_get_main_queue(), ^{
         
    [_Menutable_view reloadData];
         
     });
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(receiveTestNotification:)
                                                 name:@"TestNotification"
                                               object:nil];
    UIImageView *tempImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg.jpg"]];
    [tempImageView setFrame:self.tableView.frame];
    self.Menutable_view.backgroundView = tempImageView;
    
    NSLog(@"testingggg");
    NSArray *fontFamilies = [UIFont familyNames];
    for (int i = 0; i < [fontFamilies count]; i++) {
        NSString *fontFamily = [fontFamilies objectAtIndex:i];
        NSArray *fontNames = [UIFont fontNamesForFamilyName:[fontFamilies objectAtIndex:i]];
        NSLog (@"%@: %@", fontFamily, fontNames);
    }
   
        menu_images=[[NSMutableArray alloc]init];
        menu_names=[[NSMutableArray alloc]init];
    
        if ([UserRole isEqualToString:@"0"])
       {
           [menu_names addObject:@"Events"];
           [menu_names addObject:@"My Tickets"];
           [menu_names addObject:@"Awards"];
           [menu_names addObject:@"Settings"];

           [menu_names addObject:@"Logout"];
        
           [menu_images addObject:@"Events"];
           [menu_images addObject:@"Tickets"];
           [menu_images addObject:@"Awards"];
           [menu_images addObject:@"settings.png"];

   
           [menu_images addObject:@"logout_btn.png"];
           
       }
       else
       {
           [menu_names addObject:@"Events"];
           [menu_names addObject:@"Add Event"];
           [menu_names addObject:@"Scan QR"];
             [menu_names addObject:@"My Events"];
            [menu_names addObject:@"Settings"];
           
           [menu_names addObject:@"Logout"];
           
           [menu_images addObject:@"Events"];
           [menu_images addObject:@"AddEvents"];
           [menu_images addObject:@"ScanQR.png"];
                   [menu_images addObject:@"history.png"];
               [menu_images addObject:@"settings.png"];
      
           [menu_images addObject:@"logout_btn.png"];
       }
    menuItems = @[@"title",@"home", @"news", @"comments", @"map", @"calendar", @"bookmark", @"tag",@"wishlist"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return menu_names.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"TableViewCellMenu";
    TableViewCellMenu *FAQ_Cell = (TableViewCellMenu *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (FAQ_Cell == nil) {
        NSArray *nib =[[NSBundle mainBundle]loadNibNamed:@"TableViewCellMenu" owner:self options:nil];
        FAQ_Cell=[nib objectAtIndex:0];
    }
    
    UIColor * Appcolcor =[UIColor colorWithRed:(99/255.0) green:(59/255.0) blue:(151/255.0) alpha:1] ;
    
    UIImageView *tempImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg.jpg"]];
    [tempImageView setFrame:self.tableView.frame];
    self.Menutable_view.backgroundView = tempImageView;
    FAQ_Cell.menu_name.text=[menu_names objectAtIndex:indexPath.row];
    FAQ_Cell.menu_image.image=[UIImage imageNamed:[menu_images objectAtIndex:indexPath.row]];
     FAQ_Cell.contentView.backgroundColor=[UIColor clearColor];
     _Menutable_view.backgroundColor=[UIColor clearColor];
     [FAQ_Cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    _Menutable_view.alpha=0.85;
    FAQ_Cell.backgroundColor=[UIColor clearColor];
    return FAQ_Cell;
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 40;
   }
- (void) mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    switch (result)
    {
        case MFMailComposeResultCancelled:
            NSLog(@"Mail cancelled");
            break;
        case MFMailComposeResultSaved:
            NSLog(@"Mail saved");
            break;
        case MFMailComposeResultSent:
            NSLog(@"Mail sent");
            break;
        case MFMailComposeResultFailed:
            NSLog(@"Mail sent failure: %@", [error localizedDescription]);
            break;
        default:
            break;
    }
    [self dismissViewControllerAnimated:YES completion:NULL];
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 145;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
      return 145;
}
-(UIView *) tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, _Menutable_view.bounds.size.width, 145)];
    //    [headerView setBackgroundColor:];
    UIImageView *Image_for_dp = [[UIImageView alloc] initWithFrame:CGRectMake(140, 2, 79, 79)];
    Image_for_dp.image=[UIImage imageNamed:@"Logo_Image.png"];
    
    Image_for_dp.clipsToBounds=YES;
    
    [headerView addSubview:Image_for_dp];
    if([UserRole isEqualToString:@"1"])
    {
        Image_for_dp.frame=CGRectMake(60, 50, 200, 80);
    }
    else
    {
        Image_for_dp.frame=CGRectMake(60, headerView.center.y, 200, 80);
    }
    
 
   
    return headerView;
}
-(void) getProfile
{
     if([UserRole isEqualToString:@"0"])
     {
         [self.revealViewController revealToggleAnimated:YES];
         UIStoryboard *obj=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
         UIViewController *str=[obj instantiateViewControllerWithIdentifier:@"studentProfile"];
         [self.navigationController pushViewController:str animated:true];
     }
    else
    {
    [self.revealViewController revealToggleAnimated:YES];
    UIStoryboard *obj=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *str=[obj instantiateViewControllerWithIdentifier:@"promoterProfile"];
    [self.navigationController pushViewController:str animated:true];
    }
    
}
- (UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIColor * Appcolcor =[UIColor colorWithRed:(99/255.0) green:(59/255.0) blue:(151/255.0) alpha:1] ;
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, _Menutable_view.bounds.size.width, 145)];
//    [headerView setBackgroundColor:];
     UIImageView *Image_for_dp = [[UIImageView alloc] initWithFrame:CGRectMake(headerView.center.x - 70, 7, 70, 70)];
    NSString *getImageUser = [[NSUserDefaults standardUserDefaults]valueForKey:@"imageProfile"];
     Image_for_dp.image=[UIImage imageNamed:@"user (4).png"];
    NSString *getStringProfile = @"http://18.188.52.230/unights/public/profile/";
    NSString *getIm = [getStringProfile stringByAppendingString:getImageUser];
    
    [Image_for_dp sd_setImageWithURL:[NSURL URLWithString:getIm]];
  
    Image_for_dp.layer.cornerRadius=Image_for_dp.frame.size.width/2;
    Image_for_dp.clipsToBounds=YES;
    [headerView addSubview:Image_for_dp];
  
     UILabel *User_name = [[UILabel alloc] initWithFrame:CGRectMake(0, headerView.center.y + 10, headerView.frame.size.width-50, 30)];
    
 //   Image_for_dp.frame=CGRectMake(125, 7, 79, 79);
    User_name.backgroundColor=[UIColor clearColor];
        NSString *getnameUser = [[NSUserDefaults standardUserDefaults]valueForKey:@"nameUser"];
    
    User_name.text=getnameUser;
    User_name.textColor=[UIColor whiteColor];
    User_name.textAlignment=NSTextAlignmentCenter;
    User_name.font = [UIFont fontWithName:@"Lato-Semibold" size:25];
    
    UILabel *User_point = [[UILabel alloc] initWithFrame:CGRectMake(0, headerView.center.y + 40, headerView.frame.size.width-50, 30)];
    
    //   Image_for_dp.frame=CGRectMake(125, 7, 79, 79);
    User_point.backgroundColor=[UIColor clearColor];
   // NSString *getnameUser = [[NSUserDefaults standardUserDefaults]valueForKey:@"nameUser"];
    if([UserRole isEqualToString:@"0"])
    {
    NSString *getP;
    if(!([[[NSUserDefaults standardUserDefaults]valueForKey:@"pointsEarn"] isKindOfClass:[NSNull class]] || ([[NSUserDefaults standardUserDefaults]valueForKey:@"pointsEarn"] == nil)))
    {
     NSString *getuserpoint = [[NSUserDefaults standardUserDefaults]valueForKey:@"pointsEarn"];
    
    getP = [@"Points: " stringByAppendingString:getuserpoint];
    }
    
    else
    {
        getP = @"Points: 0";
    }
    User_point.text=getP;
    User_point.textColor=[UIColor whiteColor];
    User_point.textAlignment=NSTextAlignmentCenter;
    User_point.font = [UIFont fontWithName:@"Lato-Semibold" size:15];
         [headerView addSubview:User_point];
    }
     UIButton *Userview = [[UIButton alloc] initWithFrame:CGRectMake(0,0, headerView.bounds.size.width, headerView.bounds.size.height)];
    [Userview addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    UIButton *BtnProfile = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 145)];
    
    [BtnProfile addTarget:self action:@selector(getProfile) forControlEvents:UIControlEventTouchUpInside];
    
    // [BtnProfile addTarget:self action:@selector(getProfile) forControlEvents:UIControlEventTouchUpInside];
  
 
    [headerView addSubview:User_name];
    [headerView addSubview:Userview];
    
      [headerView addSubview:BtnProfile];
    return headerView;
}
-(void) buttonClicked:(UIButton*)sender
{
//    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
//    ViewControllerUserProfile *rootViewController = [storyboard instantiateViewControllerWithIdentifier:@"User_prodile_data"];
//    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:rootViewController];
//    [navController setViewControllers: @[rootViewController] animated: YES];
//    [self.revealViewController setFrontViewController:navController];
//    [self.revealViewController setFrontViewPosition: FrontViewPositionLeft animated: YES];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if([UserRole isEqualToString:@"0"])
    {
        if(indexPath.row == 0)
        {
             [self.revealViewController revealToggleAnimated:YES];
        }
        if(indexPath.row == 1)
        {
            [self.revealViewController revealToggleAnimated:YES];
            UIStoryboard *obj=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
            UIViewController *str=[obj instantiateViewControllerWithIdentifier:@"ViewControllerMyTickets"];
            [self.navigationController pushViewController:str animated:true];
        }
        else if (indexPath.row == 2)
        {
            
            [self.revealViewController revealToggleAnimated:YES];
            UIStoryboard *obj=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
            UIViewController *str=[obj instantiateViewControllerWithIdentifier:@"voucherAward"];
            [self.navigationController pushViewController:str animated:true];
            
        }
        else if (indexPath.row == 3)
        {
            [self.revealViewController revealToggleAnimated:YES];
            UIStoryboard *obj=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
            UIViewController *str=[obj instantiateViewControllerWithIdentifier:@"payment"];
            [self.navigationController pushViewController:str animated:true];
            
        }
      
         else if (indexPath.row == 4)
        {
             [NSUserDefaults.standardUserDefaults setValue:0 forKey:@"CounterValue"];
            FBSDKLoginManager *loginManager = [[FBSDKLoginManager alloc] init];
            [loginManager logOut];
            [self.revealViewController revealToggleAnimated:YES];
            UIStoryboard *obj=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
            UIViewController *str=[obj instantiateViewControllerWithIdentifier:@"ViewControllerLogin"];
            [self.navigationController pushViewController:str animated:true];
            
            
        }
    
    }
    else
    {
        
        if(indexPath.row == 0)
        {
            [self.revealViewController revealToggleAnimated:YES];
        }
        if(indexPath.row == 1)
        {
             [self.revealViewController revealToggleAnimated:YES];
            
            UIStoryboard *obj=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
            UIViewController *str=[obj instantiateViewControllerWithIdentifier:@"ViewControllerAddEvents"];
            [self.navigationController pushViewController:str animated:true];
          //  stripe_account
//            if(!([[NSUserDefaults standardUserDefaults] valueForKey:@"stripe_account"] == nil || [[[NSUserDefaults standardUserDefaults] valueForKey:@"stripe_account"] isKindOfClass:[NSNull class]]))
//            {
//            NSString * getStripeToken = [[NSUserDefaults standardUserDefaults] valueForKey:@"stripe_account"];
//
//            if([getStripeToken  isEqual: @""])
//            {
//                UIStoryboard *obj=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
//                UIViewController *str=[obj instantiateViewControllerWithIdentifier:@"bankDetails"];
//                [self.navigationController pushViewController:str animated:true];
//            }
//                else
//                {
//                    UIStoryboard *obj=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
//                    UIViewController *str=[obj instantiateViewControllerWithIdentifier:@"ViewControllerAddEvents"];
//                    [self.navigationController pushViewController:str animated:true];
//                }
       //     }
            
//            else
//
//            {
//                UIStoryboard *obj=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
//                UIViewController *str=[obj instantiateViewControllerWithIdentifier:@"bankDetails"];
//                [self.navigationController pushViewController:str animated:true];
//            }
       
      
    }
        else if (indexPath.row == 2)
        {
            
            [self.revealViewController revealToggleAnimated:YES];
            UIStoryboard *obj=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
            UIViewController *str=[obj instantiateViewControllerWithIdentifier:@"qrscanning"];
            [self.navigationController pushViewController:str animated:true];
            
        }
        else if (indexPath.row == 3)
        {
            
            [self.revealViewController revealToggleAnimated:YES];
            UIStoryboard *obj=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
            UIViewController *str=[obj instantiateViewControllerWithIdentifier:@"eventHistory"];
            [self.navigationController pushViewController:str animated:true];
        }
        else if (indexPath.row == 4)
        {
            [self.revealViewController revealToggleAnimated:YES];
            UIStoryboard *obj=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
            UIViewController *str=[obj instantiateViewControllerWithIdentifier:@"payment"];
            [self.navigationController pushViewController:str animated:true];
        }
  
        else if (indexPath.row == 5)
        {
            UIStoryboard *obj=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
            UIViewController *str=[obj instantiateViewControllerWithIdentifier:@"ViewControllerLogin"];
            [self.navigationController pushViewController:str animated:true];
                [NSUserDefaults.standardUserDefaults setValue:0 forKey:@"CounterValue"];
        }
      
    }
}


@end
