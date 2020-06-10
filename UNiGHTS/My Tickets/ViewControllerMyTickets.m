//
//  ViewControllerMyTickets.m
//  UNiGHTS
//
//  Created by user on 20/06/18.
//  Copyright © 2018 RVTechnologies Softwares PVT. LTD. All rights reserved.
//

#import "ViewControllerMyTickets.h"
#import "TableViewCellTickets.h"
#import "SWRevealViewController.h"
#import "SVProgressHUD.h"
#import "ticketDetailsViewController.h"
#import "UIImageView+WebCache.h"
@interface ViewControllerMyTickets ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation ViewControllerMyTickets
{
    NSArray *getArr;
    NSMutableArray *ArrInfo;
    NSDictionary *bb;
    NSString * next_page_url;
    NSArray *ArrInfo2;
}
- (void)viewDidLoad {
    [super viewDidLoad];
  
    getArr = [[NSArray alloc]init];
    
}
-(void) viewWillAppear:(BOOL)animated
{
      [self getTickets];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (CIImage *)createQRForString:(NSString *)qrString {
    NSData *stringData = [qrString dataUsingEncoding: NSISOLatin1StringEncoding];
    
    CIFilter *qrFilter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    [qrFilter setValue:stringData forKey:@"inputMessage"];
    
    return qrFilter.outputImage;
}
- (NSInteger                                                                                                                                   )numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return ArrInfo.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *cellIdentifier = @"TableViewCellTickets";
    TableViewCellTickets * contest_cell = (TableViewCellTickets *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (contest_cell == nil) {
        NSArray *nib =[[NSBundle mainBundle]loadNibNamed:@"TableViewCellTickets" owner:self options:nil];
        contest_cell=[nib objectAtIndex:0];
    }
    
    contest_cell.BookticketInnerView.layer.cornerRadius=5;
    contest_cell.BookticketInnerView.clipsToBounds=YES;
    contest_cell.selectionStyle=UITableViewCellSelectionStyleNone;
//    @property (strong, nonatomic) IBOutlet UILabel *refNo;
//    @property (weak, nonatomic) IBOutlet UIImageView *qrImg;
//    @property (strong, nonatomic) IBOutlet UILabel *NumberofTickets;
//    @property (strong, nonatomic) IBOutlet UILabel *paidAmount;
//    @property (strong, nonatomic) IBOutlet UILabel *username;
//    @property (strong, nonatomic) IBOutlet UILabel *address;
    if(ArrInfo.count > 0)
    {
    NSDictionary *getDataC = [ArrInfo objectAtIndex:indexPath.row];
    
    contest_cell.paidAmount.text = [NSString stringWithFormat:@"%@%@",@"Amount to be paid £ ",[getDataC valueForKey:@"amount"]];
    
        contest_cell.refNo.text = [NSString stringWithFormat:@"%@%@",@"REF ",[NSString stringWithFormat:@"%@",[getDataC valueForKey:@"payment_id"]]];
        
        contest_cell.NumberofTickets.text = [NSString stringWithFormat:@"%@%@",@"Tickets: ",[getDataC valueForKey:@"total_tickets"]];
        contest_cell.username.text = [NSString stringWithFormat:@"%@%@",@"An evening with ",[[NSUserDefaults standardUserDefaults] valueForKey:@"nameUser"]];
        NSDictionary *geteventH = [getDataC valueForKey:@"event"];
        NSString * getEventAddr = [NSString stringWithFormat:@"%@",[geteventH valueForKey:@"venue_address"]];
        NSString * getnameevent = [NSString stringWithFormat:@"%@",[geteventH valueForKey:@"venue_name"]];
         contest_cell.eventName.text = [NSString stringWithFormat:@"%@",[geteventH valueForKey:@"event_name"]];
        
        NSString * getEventcity = [NSString stringWithFormat:@"%@",[geteventH valueForKey:@"city"]];
        NSString * getEventpost = [NSString stringWithFormat:@"%@",[geteventH valueForKey:@"post_code"]];
        NSArray * getEventArr = [geteventH valueForKey:@"event_images"];
        NSDictionary *getDictImage = [getEventArr objectAtIndex:0];
        
        NSString * getEventImg = [NSString stringWithFormat:@"%@",[getDictImage valueForKey:@"image"]];
        
        NSString * ImgbaseUrl = @"http://18.188.52.230/unights/public/events/";

        if (getEventImg.length==0 || [getEventImg isEqual:[NSNull null]] || [getEventImg isEqualToString:@""] ||  [getEventImg isKindOfClass:[NSNull class]] || getEventImg == (id)[NSNull null])
        {
            
        }
        else
        {
            ImgbaseUrl= [ImgbaseUrl stringByAppendingString:getEventImg];
            
            [contest_cell.imageEvent sd_setImageWithURL:[NSURL URLWithString:ImgbaseUrl]];
            
            
        }
        NSString * getEventDate = [NSString stringWithFormat:@"%@",[geteventH valueForKey:@"start_date"]];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        NSDate *date = [dateFormatter dateFromString:getEventDate];
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"MMM dd"];
        NSLog(@"Current Date: %@", [formatter stringFromDate:date]);
        NSString * getdate = [formatter stringFromDate:date];
        
        
        contest_cell.dateT.text = getdate;
        
        
        NSString * getEventDate2 = [NSString stringWithFormat:@"%@",[geteventH valueForKey:@"start_time"]];
        NSDateFormatter *dateFormatter2 = [[NSDateFormatter alloc] init];
        [dateFormatter2 setDateFormat:@"HH:mm:ss"];
        NSDate *date2 = [dateFormatter2 dateFromString:getEventDate2];
        
        NSDateFormatter *formatter2 = [[NSDateFormatter alloc] init];
        [formatter2 setDateFormat:@"hh:mm a"];
        NSLog(@"Current Date: %@", [formatter2 stringFromDate:date2]);
        NSString * getdate2 = [formatter2 stringFromDate:date2];
        
        
        contest_cell.timeT.text = getdate2;
        NSString *getStandardTicket = [NSString stringWithFormat:@"%@",[getDataC valueForKey:@"total_tickets"]];
        
        if (getnameevent.length==0 || [getnameevent isEqual:[NSNull null]] || [getnameevent isEqualToString:@""] ||  [getnameevent isKindOfClass:[NSNull class]] || getnameevent == (id)[NSNull null])
        {
            contest_cell.address.text = @"";
        }
        else
        {
        
            contest_cell.address.text = [NSString stringWithFormat:@"%@%@%@%@%@%@%@%@",getnameevent,@",",@" ",getEventcity,@",",@" ",@" ",getEventpost];
        }
        if([getStandardTicket isEqualToString:@"0"])
        {
            
        contest_cell.BookticketInnerView.layer.borderColor = [UIColor redColor].CGColor;
        contest_cell.BookticketInnerView.layer.borderWidth = 2;
        contest_cell.qrImg.image = [UIImage imageNamed:@"used_1.png"];
//            contest_cell.userInteractionEnabled = NO;
        
    }
    
    else
    {
        contest_cell.BookticketInnerView.layer.borderColor = [UIColor clearColor].CGColor;
        contest_cell.BookticketInnerView.layer.borderWidth = 0;
    
        
        
        NSString *info = [NSString stringWithFormat:@"%@",[getDataC valueForKey:@"payment_id"]];
        
        NSData *stringData = [info dataUsingEncoding: NSISOLatin1StringEncoding];
        
        CIFilter *qrFilter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
        [qrFilter setValue:stringData forKey:@"inputMessage"];
      


       
        
        CGAffineTransform transform = CGAffineTransformMakeScale(5.0f, 5.0f); // Scale by 5 times along both dimensions
        CIImage *output = [qrFilter.outputImage imageByApplyingTransform: transform];
        CIImage *barCodeImage = qrFilter.outputImage;
        
        contest_cell.qrImg.image = [UIImage imageWithCIImage:output];
        
 contest_cell.userInteractionEnabled = YES;
    }
    }
    
    
    return contest_cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 190;
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
            [self getTickets2];
            
            NSLog(@"%luArrInfo.count",(unsigned long)ArrInfo.count);
        }
        
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UIStoryboard *obj=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
    ticketDetailsViewController *str=[obj instantiateViewControllerWithIdentifier:@"ticketDetails"];
    
    NSDictionary *getDataC = [ArrInfo objectAtIndex:indexPath.row];
    
    str.getpaidAmount = [NSString stringWithFormat:@"%@%@",@"Amount to be paid £ ",[getDataC valueForKey:@"amount"]];
    
    str.getRef = [NSString stringWithFormat:@"%@%@",@"REF ",[NSString stringWithFormat:@"%@",[getDataC valueForKey:@"payment_id"]]];
    
    str.getCountTickets = [NSString stringWithFormat:@"%@%@",@"Tickets: ",[getDataC valueForKey:@"total_tickets"]];
 
    NSDictionary *geteventH = [getDataC valueForKey:@"event"];
    NSString * getEventAddr = [NSString stringWithFormat:@"%@",[geteventH valueForKey:@"venue_address"]];
      str.eventNamed = [NSString stringWithFormat:@"%@",[geteventH valueForKey:@"event_name"]];
    NSString * getnameevent = [NSString stringWithFormat:@"%@",[geteventH valueForKey:@"venue_name"]];
    NSString * getEventcity = [NSString stringWithFormat:@"%@",[geteventH valueForKey:@"city"]];
    NSString * getEventpost = [NSString stringWithFormat:@"%@",[geteventH valueForKey:@"post_code"]];
    NSArray * getEventArr = [geteventH valueForKey:@"event_images"];
    NSDictionary *getDictImage = [getEventArr objectAtIndex:0];
    
    NSString * getEventImg = [NSString stringWithFormat:@"%@",[getDictImage valueForKey:@"image"]];
    
    NSString * ImgbaseUrl = @"http://18.188.52.230/unights/public/events/";
    
       NSString *getStrImg = [ImgbaseUrl stringByAppendingString:getEventImg];
    
    str.getImgEvent = getStrImg;
    
    
    NSString * getEventDate = [NSString stringWithFormat:@"%@",[geteventH valueForKey:@"start_date"]];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *date = [dateFormatter dateFromString:getEventDate];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MMM dd"];
    NSLog(@"Current Date: %@", [formatter stringFromDate:date]);
    NSString * getdate = [formatter stringFromDate:date];
    NSString * getEventDate2 = [NSString stringWithFormat:@"%@",[geteventH valueForKey:@"start_time"]];
    NSDateFormatter *dateFormatter2 = [[NSDateFormatter alloc] init];
    [dateFormatter2 setDateFormat:@"HH:mm:ss"];
    NSDate *date2 = [dateFormatter2 dateFromString:getEventDate2];
    
    NSDateFormatter *formatter2 = [[NSDateFormatter alloc] init];
    [formatter2 setDateFormat:@"hh:mm a"];
    NSLog(@"Current Date: %@", [formatter2 stringFromDate:date2]);
    NSString * getdate2 = [formatter2 stringFromDate:date2];
    str.getStartTime = getdate2;
    
   str.getDate = getdate;
    NSString *getStandardTicket = [NSString stringWithFormat:@"%@",[getDataC valueForKey:@"total_tickets"]];
    if([getStandardTicket  isEqual: @"0"])
    {
     str.usedTicket = @"used";
    }
    
    
    if (getnameevent.length==0 || [getnameevent isEqual:[NSNull null]] || [getnameevent isEqualToString:@""] ||  [getnameevent isKindOfClass:[NSNull class]] || getnameevent == (id)[NSNull null])
    {
        str.addressget = @"";
    }
    else
    {
        
        str.addressget = [NSString stringWithFormat:@"%@%@%@%@%@%@%@%@",getnameevent,@",",@" ",getEventcity,@",",@" ",@" ",getEventpost];
    }
    
   
    NSString *info = [NSString stringWithFormat:@"%@",[getDataC valueForKey:@"payment_id"]];
    str.QRCode = info;
    
   
    
    [self.navigationController pushViewController:str animated:true];

}

- (IBAction)TicketBookingBack:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];

}
-(void) getTickets
{
    
    NSURLSession *session = [NSURLSession sharedSession];
    [SVProgressHUD showWithStatus:@"Please wait.." maskType:SVProgressHUDMaskTypeBlack];
    
    
    NSString *URL = @"http://18.188.52.230/unights/public/api/get-booked-events";
    
    
    
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
                
                NSDictionary *getD = [json valueForKey:@"data"];
               
                bb = [json valueForKey:@"data"];
                 getArr=[getD valueForKey:@"data"];
                if(getArr.count > 0)
                {
                ArrInfo = [getArr mutableCopy];
                dispatch_async(dispatch_get_main_queue(), ^{
                    _noTicketsTiltel.hidden = YES;
                    _TicketsTable.delegate = self;
                    _TicketsTable.dataSource = self;
                    [_TicketsTable reloadData];
                    
                    [SVProgressHUD dismiss];
                });
                }
                else
                {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        
                        _noTicketsTiltel.hidden = NO;
                        
                        [SVProgressHUD dismiss];
                    });
                }
                
            }
            
            //  NSLog(@"%@",user_name_array_mymatches);
            
            //   NSLog(@"%@",user_phone_array_mymatches);
            
            
            
            
            
            
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
            
            // no internet
            
        }
        
    }];
    [task resume];
    
}

-(void) getTickets2
{
    
    NSURLSession *session = [NSURLSession sharedSession];
    [SVProgressHUD showWithStatus:@"Please wait.." maskType:SVProgressHUDMaskTypeBlack];
    
    
    //NSString *URL = @"http://18.188.52.230/unights/public/api/get-booked-events";
    
    NSString *getSt = [bb valueForKey:@"next_page_url"];
    NSArray *getA = [getSt componentsSeparatedByString:@"?"];
    NSString *fd = @"http://18.188.52.230/unights/public/api/get-booked-events?";
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
                
                NSDictionary *getD = [json valueForKey:@"data"];
               
                bb = [json valueForKey:@"data"];
                getArr=[getD valueForKey:@"data"];
                [ArrInfo addObjectsFromArray:ArrInfo2];
//                _TicketsTable.delegate = self;
//                _TicketsTable.dataSource = self;
                
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    [SVProgressHUD dismiss];
                    [_TicketsTable reloadData];
                });
            }
            
            //  NSLog(@"%@",user_name_array_mymatches);
            
            //   NSLog(@"%@",user_phone_array_mymatches);
            
            
            
            
            
            
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
            
            // no internet
            
        }
        
    }];
    [task resume];
    
}
@end
