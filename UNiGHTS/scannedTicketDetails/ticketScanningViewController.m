//
//  ticketScanningViewController.m
//  UNiGHTS
//
//  Created by user on 7/11/18.
//  Copyright © 2018 RVTechnologies Softwares PVT. LTD. All rights reserved.
//

#import "ticketScanningViewController.h"
#import "SVProgressHUD.h"

@interface ticketScanningViewController ()

@end

@implementation ticketScanningViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _refNumber.text = _getRef;
    _ticketNumber.text = _getCountTickets;
    _paidAmount.text = _getpaidAmount;
    _name.text = _getUsername;
    _dateCheck.text = _getDate;
    _addressTxt.text = _addressget;
    _ticketEarly.text = _getCountTicketsEarly;
    _ticketStandard.text = _getCountTicketsStandard;
    _ticketVIP.text = _getCountTicketsVIP;
    //_stepperVIP.maximumValue = _getCountTicketsVIP;
    
    NSInteger getCountTicketsVIPInt = [_getCountTicketsVIP integerValue];
    
    NSInteger getCountTicketsStandardInt = [_getCountTicketsStandard integerValue];
    
    NSInteger getCountTicketsEarly = [_getCountTicketsEarly integerValue];
    
    _stepperVIP.maximumValue = getCountTicketsVIPInt;
    
     _stepperStandard.maximumValue = getCountTicketsStandardInt;
    
     _stepperEarly.maximumValue = getCountTicketsEarly;
    

    
    NSString *info = _QRCode;
    NSData *stringData = [info dataUsingEncoding: NSISOLatin1StringEncoding];
    
    CIFilter *qrFilter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    [qrFilter setValue:stringData forKey:@"inputMessage"];
    CGAffineTransform transform = CGAffineTransformMakeScale(5.0f, 5.0f); // Scale by 5 times along both dimensions
    CIImage *output = [qrFilter.outputImage imageByApplyingTransform: transform];
    CIImage *barCodeImage = qrFilter.outputImage;
    
    _qrImage.image = [UIImage imageWithCIImage:output];
    // Do any additional setup after loading the view.
}
- (IBAction)backBtnTap:(id)sender {
    
    [self.navigationController popViewControllerAnimated:true];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)earlyTicketValue:(id)sender {
    int vl = _stepperEarly.value;
    _ticketEarly.text = [NSString stringWithFormat:@"%d",vl];
    
}
- (IBAction)stepperStandardTap:(id)sender {
    
    int vl = _stepperStandard.value;
    _ticketStandard.text = [NSString stringWithFormat:@"%d",vl];
}
- (IBAction)stepperVip:(id)sender {
    int vl = _stepperVIP.value;
    _ticketVIP.text = [NSString stringWithFormat:@"%d",vl];
}
-(void) saveTicketsCount{
    NSURLSession *session = [NSURLSession sharedSession];
    NSString *strtoken  =[[NSUserDefaults standardUserDefaults]objectForKey:@"acessToken"];
    
    NSString *strBearer = @"Bearer ";
    
    NSString *URL = @"http://18.188.52.230/unights/public/api/use-tickets";
    
    NSURL *theURL = [NSURL URLWithString:URL];
    
    NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:theURL cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:30.0f];
    
    [theRequest setHTTPMethod:@"POST"];
    
    [theRequest setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    
    
    
    [theRequest setValue:[strBearer stringByAppendingString:strtoken] forHTTPHeaderField:@"Authorization"];
    
    [theRequest setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    
    
    
    
    //NSString *post = [URL stringByAppendingString:stringWithoutSpaces];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        [SVProgressHUD showWithStatus:@"Please wait.." maskType:SVProgressHUDMaskTypeBlack];
        
        
        
    });
  //  NSString *param;
    // 1 eventWeek empty , eventMonth empty
    // 2 eventWeek 1   , eventMonth empty
    // 3 eventWeek empty , eventMonth 1
    NSString *param=[NSString stringWithFormat:@"order_id=%@&early_ticket=%@&standard_ticket=%@&vip_ticket=%@&voucher=%@&student_id=%@",_orderID,_ticketEarly.text,_ticketStandard.text,_ticketVIP.text,_promoCode.text,_getIduser];
   // param=[NSString stringWithFormat:@"order_id=%@&early_ticket=%@&standard_ticket=%@&vip_ticket=%@",_orderID,_ticketEarly.text,_ticketStandard.text,_ticketVIP.text];
    
    NSLog(@"%@",param);
    NSData *postData = [param dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    
    [theRequest setHTTPBody:postData];
    
    
    NSURLSessionDataTask * task=  [session dataTaskWithRequest:theRequest completionHandler:^(NSData *  data, NSURLResponse * response, NSError *  error) {
//    [NSURLConnection sendAsynchronousRequest:theRequest queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
    
        // if(data != nil){
        
        
        
        
        
        NSString *noti = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        
        NSLog(@"Response:: %@", noti);
        
        
        
        
        
        if(data!=nil){
            
            NSError *jsonError;
            
            NSData *objectData = [noti dataUsingEncoding:NSUTF8StringEncoding];
            
            NSDictionary *json = [NSJSONSerialization JSONObjectWithData:objectData
                                  
                                                                 options:NSJSONReadingMutableContainers
                                  
                                                                   error:&jsonError];
            
            NSLog(@"%@",json);
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [SVProgressHUD dismiss];
            });
            NSString * getSuccess;
            //
            getSuccess = [NSString stringWithFormat:@"%@",[json valueForKey:@"success"]];
            
            if([getSuccess  isEqual: @"1"])
            {
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    [SVProgressHUD dismiss];
                });
             
                UIAlertController * alert = [UIAlertController
                                             alertControllerWithTitle:@"UNiGHTS"
                                             message:@"Confirmed"
                                             preferredStyle:UIAlertControllerStyleAlert];
                
                //Add Buttons
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    [SVProgressHUD dismiss];
                });
                
                
                UIAlertAction* noButton = [UIAlertAction
                                           actionWithTitle:@"OK"
                                           style:UIAlertActionStyleDefault
                                           handler:^(UIAlertAction * action) {
                                               
                                               [self.navigationController popViewControllerAnimated:true];
                                               //Handle no, thanks button
                                           }];
                
                //Add your buttons to alert controller
                
                
                [alert addAction:noButton];
                
                [self presentViewController:alert animated:YES completion:nil];
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    [SVProgressHUD dismiss];
                });
                
            }
        else
        {
            
            UIAlertController * alert = [UIAlertController
                                         alertControllerWithTitle:@"UNiGHTS"
                                         message:@"This voucher is not valid"
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
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [SVProgressHUD dismiss];
            });
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
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [SVProgressHUD dismiss];
            });
        }
    }];
    [task resume];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (IBAction)confirmBtnTap:(id)sender {
    
    [self saveTicketsCount];
}

@end
