//
//  voucherawardsViewController.m
//  UNiGHTS
//
//  Created by user on 7/19/18.
//  Copyright © 2018 RVTechnologies Softwares PVT. LTD. All rights reserved.
//

#import "voucherawardsViewController.h"
#import "voucherTableViewCell.h"
#import "SVProgressHUD.h"

@interface voucherawardsViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    voucherTableViewCell * cell;
    NSArray *getdata;
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation voucherawardsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    _tableView.delegate = self;
    _tableView.dataSource = self;
     [self getVouchers];
    // Do any additional setup after loading the view.
}

- (IBAction)backBtnTap:(id)sender {
    
    [self.navigationController popViewControllerAnimated:true];
}

-(void)getVouchers{
    NSURLSession *session = [NSURLSession sharedSession];
    [SVProgressHUD showWithStatus:@"Please wait.." maskType:SVProgressHUDMaskTypeBlack];
    
    
    NSString *URL = @"http://18.188.52.230/unights/public/api/vouchers";
    
    
    
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
                NSDictionary *getDi = [json objectForKey:@"data"];
                
                getdata=[getDi objectForKey:@"data"];
                
                
                
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    [SVProgressHUD dismiss];
                    _tableView.delegate = self;
                    _tableView.dataSource = self;
                    [_tableView reloadData];
                });
            }
            
            //  NSLog(@"%@",user_name_array_mymatches);
            
            //   NSLog(@"%@",user_phone_array_mymatches);
            
            
            
            
            
            
        }
        else
            
        {
            
            // no internet
            
        }
        
    }];
    
    [task resume];
    
    
    
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return getdata.count;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    tableView.rowHeight = 142;
    
    cell=[tableView dequeueReusableCellWithIdentifier:@"voucherCell"];
    if (cell == nil) {
        
        cell=[[voucherTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"voucherCell"];
        
        
        
        
    }
    NSDictionary *getVoucherData = [getdata objectAtIndex:indexPath.row];
    NSDictionary *voucher = [getVoucherData valueForKey:@"voucher"];
    cell.promoCode.text = [voucher valueForKey:@"voucher"];
    cell.offerOn.text = [voucher valueForKey:@"title"];
    NSString *getPoints = @"20";
    NSString *getP = [NSString stringWithFormat:@"%s%@%s%@%s","You got ",[voucher valueForKey:@"title"]," for ",[NSString stringWithFormat:@"%@",[voucher valueForKey:@"deduction_points"]]," points"];
    cell.voucherEarn.text = getP;
    return cell;
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
