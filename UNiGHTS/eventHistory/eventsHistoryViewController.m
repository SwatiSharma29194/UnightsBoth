//
//  eventsHistoryViewController.m
//  UNiGHTS
//
//  Created by user on 7/11/18.
//  Copyright © 2018 RVTechnologies Softwares PVT. LTD. All rights reserved.
//

#import "eventsHistoryViewController.h"
#import "TableViewCellTonight.h"
#import "SVProgressHUD.h"
#import "UIImageView+WebCache.h"
#import "ViewControllerDescription.h"
@interface eventsHistoryViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation eventsHistoryViewController
{
    NSArray *getDataEvent;
    NSMutableArray *ArrInfo;
    NSDictionary *bb;
    NSString * next_page_url;
    NSArray *ArrInfo2;
}

NSMutableArray * EventImages2;

- (void)viewDidLoad {
    [super viewDidLoad];

    
    [self geteventHistory];
//    Post_type_array =[[NSMutableArray alloc]init];
//    [Post_type_array addObject:@"Nottingham"];
//    [Post_type_array addObject:@"Birmingham"];
//    [Post_type_array addObject:@"Leeds"];
//    [Post_type_array addObject:@"Sheffield"];
//    [Post_type_array addObject:@"Leicester"];
    // Do any additional setup after loading the view.
}
- (IBAction)backbtn:(id)sender {
      [self.navigationController popViewControllerAnimated:YES];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return ArrInfo.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"TableViewCellTonight";
    TableViewCellTonight * contest_cell = (TableViewCellTonight *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (contest_cell == nil) {
        NSArray *nib =[[NSBundle mainBundle]loadNibNamed:@"TableViewCellTonight" owner:self options:nil];
        contest_cell=[nib objectAtIndex:0];
    }
    
//    contest_cell.closeBooking.hidden = YES;
    NSDictionary * j = [ArrInfo objectAtIndex:indexPath.row];
    
    NSString * getEventname = [NSString stringWithFormat:@"%@",[j valueForKey:@"event_name"]];
    // venue name, city and post code
    
    NSString * getEventAddr = [NSString stringWithFormat:@"%@",[j valueForKey:@"venue_address"]];
    NSString * getnameevent = [NSString stringWithFormat:@"%@",[j valueForKey:@"venue_name"]];
    NSString * getEventcity = [NSString stringWithFormat:@"%@",[j valueForKey:@"city"]];
    NSString * getEventpost = [NSString stringWithFormat:@"%@",[j valueForKey:@"post_code"]];
    
    
    NSString * getEventtime = [NSString stringWithFormat:@"%@",[j valueForKey:@"start_time"]];
    
    NSString * getEventDate = [NSString stringWithFormat:@"%@",[j valueForKey:@"start_date"]];
    
    NSArray * getEventArr = [j valueForKey:@"event_images"];
    NSDictionary *getDictImage = [getEventArr objectAtIndex:0];
    
    NSString * getEventImg = [NSString stringWithFormat:@"%@",[getDictImage valueForKey:@"image"]];
    NSString * ticketType = [NSString stringWithFormat:@"%@",[j valueForKey:@"ticket_type"]];
    if([ticketType  isEqual: @"1"])
    {
        contest_cell.viewColour.backgroundColor = [UIColor redColor];
        contest_cell.typeTicket.text = @"SELL TICKETS";
    }
    else if([ticketType  isEqual: @"0"])
    {
        contest_cell.viewColour.backgroundColor = [UIColor greenColor];
        contest_cell.typeTicket.text = @"FREE TICKETS";
    }
    else
    {
        contest_cell.viewColour.backgroundColor = [UIColor yellowColor];
        contest_cell.typeTicket.text = @"PAY ON DOOR";
    }
    NSString * ImgbaseUrl = @"http://18.188.52.230/unights/public/events/";
    if (getEventImg.length==0 || [getEventImg isEqual:[NSNull null]] || [getEventImg isEqualToString:@""] ||  [getEventImg isKindOfClass:[NSNull class]] || getEventImg == (id)[NSNull null])
    {
        
    }
    else
    {
        ImgbaseUrl= [ImgbaseUrl stringByAppendingString:getEventImg];
        
        [contest_cell.EventBanner sd_setImageWithURL:[NSURL URLWithString:ImgbaseUrl]];
        
        
    }
    if (getEventname.length==0 || [getEventname isEqual:[NSNull null]] || [getEventname isEqualToString:@""] ||  [getEventname isKindOfClass:[NSNull class]] || getEventname == (id)[NSNull null])
    {
        contest_cell.eventName.text = @"";
    }
    else
    {
        contest_cell.eventName.text = getEventname;
    }
    
    if (getnameevent.length==0 || [getnameevent isEqual:[NSNull null]] || [getnameevent isEqualToString:@""] ||  [getnameevent isKindOfClass:[NSNull class]] || getnameevent == (id)[NSNull null])
    {
        contest_cell.eventAddress.text = @"";
    }
    else
    {
        //        NSString * getnameevent = [NSString stringWithFormat:@"%@",[j valueForKey:@"venue_name"]];
        //        NSString * getEventcity = [NSString stringWithFormat:@"%@",[j valueForKey:@"city"]];
        //        NSString * getEventpost = [NSString stringWithFormat:@"%@",[j valueForKey:@"post_code"]];
        contest_cell.eventAddress.text = [NSString stringWithFormat:@"%@%@%@%@%@%@%@%@",getnameevent,@",",@" ",getEventcity,@",",@" ",@" ",getEventpost];
    }
    
    if (getEventtime.length==0 || [getEventtime isEqual:[NSNull null]] || [getEventtime isEqualToString:@""] ||  [getEventtime isKindOfClass:[NSNull class]] || getEventtime == (id)[NSNull null])
    {
        contest_cell.timeLbl.text = @"";
        contest_cell.AMPM.text = @"";
    }
    else
    {
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"HH:mm:ss"];
        NSDate *date = [dateFormatter dateFromString:getEventtime];
        NSCalendar *calendar = [NSCalendar currentCalendar];
        NSDateComponents *components = [calendar components:(NSCalendarUnitHour | NSCalendarUnitMinute) fromDate:date];
        NSInteger hour = [components hour];
        NSInteger minute = [components minute];
        
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"hh:mm a"];
        NSLog(@"Current Date: %@", [formatter stringFromDate:date]);
        NSString * getdate = [formatter stringFromDate:date];
        
        contest_cell.timeLbl.text = getdate;
        
        NSLog(@"testing");
        
    }
    
    if (getEventDate.length==0 || [getEventDate isEqual:[NSNull null]] || [getEventDate isEqualToString:@""] ||  [getEventDate isKindOfClass:[NSNull class]] || getEventDate == (id)[NSNull null])
    {
        contest_cell.eventday.text = @"";
        contest_cell.EventMonth.text = @"";
    }
    else
    {
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        NSDate *date = [dateFormatter dateFromString:getEventDate];
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"MMM dd"];
        NSLog(@"Current Date: %@", [formatter stringFromDate:date]);
        NSString * getdate = [formatter stringFromDate:date];
        
        
        contest_cell.EventMonth.text = getdate;
        
        
        //  contest_cell.EventMonth.text = @"";
    }
    
   contest_cell.selectionStyle=UITableViewCellSelectionStyleNone;
    
    
    
    
//    if (contest_cell == nil) {
//        NSArray *nib =[[NSBundle mainBundle]loadNibNamed:@"TableViewCellTonight" owner:self options:nil];
//        contest_cell=[nib objectAtIndex:0];
//    }
//    contest_cell.selectionStyle=UITableViewCellSelectionStyleNone;
//    //  contest_cell.EventBanner.image=[UIImage imageNamed:[EventImages objectAtIndex:indexPath.row]]; contest_cell.selectionStyle=UITableViewCellSelectionStyleNone;
//    contest_cell.EventBanner.image=[UIImage imageNamed:[EventImages2 objectAtIndex:indexPath.row]];
//
  return contest_cell;
    
    
        
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 190;
}
//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    UIStoryboard *obj=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
//    UIViewController *str=[obj instantiateViewControllerWithIdentifier:@"soldTicketDesc"];
//    [self.navigationController pushViewController:str animated:true];
//}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   
        NSDictionary * j = [ArrInfo objectAtIndex:indexPath.row];
        
        NSString * getEventId = [NSString stringWithFormat:@"%@",[j valueForKey:@"id"]];
        UIStoryboard *obj=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
        ViewControllerDescription *str=[obj instantiateViewControllerWithIdentifier:@"ViewControllerDescription"];
        str.getIdEvent = getEventId;
    str.getHistory = @"history";
        [self.navigationController pushViewController:str animated:true];
    
}
-(void) geteventHistory
{
    NSURLSession *session = [NSURLSession sharedSession];
    [SVProgressHUD showWithStatus:@"Please wait.." maskType:SVProgressHUDMaskTypeBlack];
    
    
   NSString *URL = @"http://18.188.52.230/unights/public/api/get-event-history";
   
    
    
    NSURL *theURL = [NSURL URLWithString:URL];
    
    NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:theURL cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:30.0f];
    
    
    
    NSString *strBearer =@"Bearer ";
    NSString *strAccessToken =  [[NSUserDefaults standardUserDefaults]objectForKey:@"acessToken"];
    [theRequest setHTTPMethod:@"GET"];
    
    [theRequest setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    
    [theRequest setValue:[strBearer stringByAppendingString:strAccessToken] forHTTPHeaderField:@"Authorization"];
    
    [theRequest setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    
    NSURLSessionDataTask * task=  [session dataTaskWithRequest:theRequest completionHandler:^(NSData *  data, NSURLResponse * response, NSError *  error) {
    
//    [NSURLConnection sendAsynchronousRequest:theRequest queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
    
        // if(data != nil){
        
        
        
        NSString *noti = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        
        //  NSLog(@"Response:: %@", noti);
        
        
        
        if(data!=nil){
            
            NSError *jsonError;
            
            NSData *objectdata = [noti dataUsingEncoding:NSUTF8StringEncoding];
            
            
            
            NSDictionary *json = [NSJSONSerialization JSONObjectWithData:objectdata
                                  
                                                                 options:NSJSONReadingMutableContainers
                                  
                                                                   error:&jsonError];
            NSString * getSuccess;
            
            getSuccess = [NSString stringWithFormat:@"%@",[json valueForKey:@"success"]];
            
            if([getSuccess  isEqual: @"1"])
            {
                
                NSLog(@"%@",json);
                
            
                NSDictionary *getDatas = [json valueForKey:@"event"];
                bb = [json valueForKey:@"event"];
                getDataEvent=[getDatas objectForKey:@"data"];
                ArrInfo = [getDataEvent mutableCopy];
                
                
                
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    [SVProgressHUD dismiss];
                    _tableView.delegate = self;
                    _tableView.dataSource = self;
                    
                    [_tableView reloadData];
                });
            }
            else
            {
                UIAlertController * alert = [UIAlertController
                                             alertControllerWithTitle:@"UNiGHTS"
                                             message:@"No events"
                                             preferredStyle:UIAlertControllerStyleAlert];
                
                //Add Buttons
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    [SVProgressHUD dismiss];
                });
                
                
                UIAlertAction* noButton = [UIAlertAction
                                           actionWithTitle:@"OK"
                                           style:UIAlertActionStyleDefault
                                           handler:^(UIAlertAction * action) {
                                               //Handle no, thanks button
                                           }];
                
                //Add your buttons to alert controller
                
                
                [alert addAction:noButton];
                
                [self presentViewController:alert animated:YES completion:nil];
                
            }
            
        }
        else
        {
            UIAlertController * alert = [UIAlertController
                                         alertControllerWithTitle:@"UNiGHTS"
                                         message:@"Connection Error"
                                         preferredStyle:UIAlertControllerStyleAlert];
            
            //Add Buttons
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [SVProgressHUD dismiss];
            });
            
            
            UIAlertAction* noButton = [UIAlertAction
                                       actionWithTitle:@"OK"
                                       style:UIAlertActionStyleDefault
                                       handler:^(UIAlertAction * action) {
                                           //Handle no, thanks button
                                       }];
            
            //Add your buttons to alert controller
            
            
            [alert addAction:noButton];
            
            [self presentViewController:alert animated:YES completion:nil];
            
        }
        
        
        
    }];
    [task resume];
}
-(void) geteventHistory2
{
    NSURLSession *session = [NSURLSession sharedSession];
    [SVProgressHUD showWithStatus:@"Please wait.." maskType:SVProgressHUDMaskTypeBlack];
    
//    let nextUrl = bb.value(forKey: "next_page_url") as! String
//    var newUrl = nextUrl.components(separatedBy: "?")
//    connection.startConnectionWithSting2(getUrlString: "getallvideo?\(newUrl[1])"
    
    NSString *getSt = [bb valueForKey:@"next_page_url"];
    NSArray *getA = [getSt componentsSeparatedByString:@"?"];
    NSString *fd = @"http://18.188.52.230/unights/public/api/get-event-history?";
    NSString *sd = getA[1];
    
    NSString *URL = [fd stringByAppendingString:getA[1]];
    
    
    
    NSURL *theURL = [NSURL URLWithString:URL];
    
    NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:theURL cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:30.0f];
    
    
    
    NSString *strBearer =@"Bearer ";
    NSString *strAccessToken =  [[NSUserDefaults standardUserDefaults]objectForKey:@"acessToken"];
    [theRequest setHTTPMethod:@"GET"];
    
    [theRequest setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    
    [theRequest setValue:[strBearer stringByAppendingString:strAccessToken] forHTTPHeaderField:@"Authorization"];
    
    [theRequest setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    
    NSURLSessionDataTask * task=  [session dataTaskWithRequest:theRequest completionHandler:^(NSData *  data, NSURLResponse * response, NSError *  error) {
    
//    [NSURLConnection sendAsynchronousRequest:theRequest queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
    
        // if(data != nil){
        
        
        
        NSString *noti = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        
        //  NSLog(@"Response:: %@", noti);
        
        
        
        if(data!=nil){
            
            NSError *jsonError;
            
            NSData *objectdata = [noti dataUsingEncoding:NSUTF8StringEncoding];
            
            
            
            NSDictionary *json = [NSJSONSerialization JSONObjectWithData:objectdata
                                  
                                                                 options:NSJSONReadingMutableContainers
                                  
                                                                   error:&jsonError];
            NSString * getSuccess;
            
            getSuccess = [NSString stringWithFormat:@"%@",[json valueForKey:@"success"]];
            
            if([getSuccess  isEqual: @"1"])
            {
                
                NSLog(@"%@",json);
                
                
                NSDictionary *getDatas = [json valueForKey:@"event"];
                bb = [json valueForKey:@"event"];
                ArrInfo2=[getDatas objectForKey:@"data"];
                [ArrInfo addObjectsFromArray:ArrInfo2];
               
                
                
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    _tableView.delegate = self;
                    _tableView.dataSource = self;
                    
                    [_tableView reloadData];
                    
                    [SVProgressHUD dismiss];
                });
            }
            else
            {
                UIAlertController * alert = [UIAlertController
                                             alertControllerWithTitle:@"UNiGHTS"
                                             message:@"No events"
                                             preferredStyle:UIAlertControllerStyleAlert];
                
                //Add Buttons
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    [SVProgressHUD dismiss];
                });
                
                
                UIAlertAction* noButton = [UIAlertAction
                                           actionWithTitle:@"OK"
                                           style:UIAlertActionStyleDefault
                                           handler:^(UIAlertAction * action) {
                                               //Handle no, thanks button
                                           }];
                
                //Add your buttons to alert controller
                
                
                [alert addAction:noButton];
                
                [self presentViewController:alert animated:YES completion:nil];
                
            }
            
        }
        else
        {
            UIAlertController * alert = [UIAlertController
                                         alertControllerWithTitle:@"UNiGHTS"
                                         message:@"Connection Error"
                                         preferredStyle:UIAlertControllerStyleAlert];
            
            //Add Buttons
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [SVProgressHUD dismiss];
            });
            
            
            UIAlertAction* noButton = [UIAlertAction
                                       actionWithTitle:@"OK"
                                       style:UIAlertActionStyleDefault
                                       handler:^(UIAlertAction * action) {
                                           //Handle no, thanks button
                                       }];
            
            //Add your buttons to alert controller
            
            
            [alert addAction:noButton];
            
            [self presentViewController:alert animated:YES completion:nil];
            
        }
        
        
        
    }];
    [task resume];
}
-(void) tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(ArrInfo.count - 1 == indexPath.row){
        
        if(([[bb valueForKey:@"next_page_url"] isKindOfClass:[NSNull class]]) || [[bb valueForKey:@"next_page_url"] isEqualToString:@""])
        {
            
        }
        else
        {
            next_page_url = [bb valueForKey:@"next_page_url"];
            [self geteventHistory2];
            
            NSLog(@"%luArrInfo.count",(unsigned long)ArrInfo.count);
        }
        
    }
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
