//
//  QRCodeScannerViewController.m
//  Safe2Meet
//
//  Copyright © 2016 Amit Sharma. All rights reserved.
//

#import "QRCodeScannerViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "ticketDetailsViewController.h"
#import "common.h"
#import "SVProgressHUD.h"
#import "ticketScanningViewController.h"

@interface QRCodeScannerViewController () <AVCaptureMetadataOutputObjectsDelegate,UIActionSheetDelegate,UIWebViewDelegate> {
    AVCaptureSession *avSession;
    NSString *qrCode;
    AVCaptureDevice *captureDevice;
    AVCaptureDeviceInput *input;
}

@property (nonatomic, strong) AVCaptureSession *captureSession;
@property (nonatomic, strong) AVCaptureVideoPreviewLayer *videoPreviewLayer;


@end

@implementation QRCodeScannerViewController




- (void)viewDidLoad {
    [super viewDidLoad];
    // set Camera Session

    }
- (IBAction)backBtnTap:(id)sender {
    
  
    UIStoryboard *obj=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *str=[obj instantiateViewControllerWithIdentifier:@"SwRevelController"];
    [self.navigationController pushViewController:str animated:true];
    //[self.navigationController popViewControllerAnimated:true];
     }
-(void)viewWillAppear:(BOOL)animated{
    NSError *error;
    captureDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    // Get an instance of the AVCaptureDeviceInput class using the previous device object.
    input = [AVCaptureDeviceInput deviceInputWithDevice:captureDevice error:&error];
    if (!input) {
        // If any error occurs, simply log the description of it and don't continue any more.
        NSLog(@"%@", [error localizedDescription]);
        return;
    }
    // Initialize the captureSession object.
    _captureSession = [[AVCaptureSession alloc] init];
    // Set the input device on the capture session.
    [_captureSession addInput:input];
    // Initialize a AVCaptureMetadataOutput object and set it as the output device to the capture session.
    AVCaptureMetadataOutput *captureMetadataOutput = [[AVCaptureMetadataOutput alloc] init];
    [_captureSession addOutput:captureMetadataOutput];
    // Create a new serial dispatch queue.
    dispatch_queue_t dispatchQueue;
    dispatchQueue = dispatch_queue_create("myQueue", NULL);
    [captureMetadataOutput setMetadataObjectsDelegate:self queue:dispatchQueue];
    [captureMetadataOutput setMetadataObjectTypes:[NSArray arrayWithObject:AVMetadataObjectTypeQRCode]];
    // Initialize the video preview layer and add it as a sublayer to the viewPreview view's layer.
    _videoPreviewLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:_captureSession];
    [_videoPreviewLayer setVideoGravity:AVLayerVideoGravityResizeAspectFill];
    [_videoPreviewLayer setFrame:_viewPreview.layer.bounds];
    [_viewPreview.layer addSublayer:_videoPreviewLayer];
    // Start video capture.
    [_captureSession startRunning];
}
-(void) scanEvent{
    NSURLSession *session = [NSURLSession sharedSession];
    NSString *strtoken  =[[NSUserDefaults standardUserDefaults]objectForKey:@"acessToken"];
    
    NSString *strBearer = @"Bearer ";
    
    NSString *URL = @"http://18.188.52.230/unights/public/api/scan-ticket";
    
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
    NSString *param;
    // 1 eventWeek empty , eventMonth empty
    // 2 eventWeek 1   , eventMonth empty
    // 3 eventWeek empty , eventMonth 1
    
    param=[NSString stringWithFormat:@"payment_id=%@",qrCode];
    
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
                
                ticketScanningViewController *str = [self.storyboard instantiateViewControllerWithIdentifier:@"ticketScanning"];
                
                NSDictionary *getDataC = [json valueForKey:@"data"];
                
                str.getpaidAmount = [NSString stringWithFormat:@"%@%@",@"Total Paid amount £ ",[getDataC valueForKey:@"amount"]];
                
                str.getRef = [NSString stringWithFormat:@"%@%@",@"REF ",[NSString stringWithFormat:@"%@",[getDataC valueForKey:@"payment_id"]]];
                str.orderID = [getDataC valueForKey:@"id"];
                str.getCountTickets = [NSString stringWithFormat:@"%@%@",@"Total Tickets: ",[getDataC valueForKey:@"total_tickets"]];
                
                 str.getCountTicketsEarly = [NSString stringWithFormat:@"%@",[getDataC valueForKey:@"early_bird_tickets"]];
                
                     str.getCountTicketsStandard = [NSString stringWithFormat:@"%@",[getDataC valueForKey:@"standard_tickets"]];
                
                        str.getCountTicketsVIP = [NSString stringWithFormat:@"%@",[getDataC valueForKey:@"vip_tickets"]];
                str.getUsername = [NSString stringWithFormat:@"%@%@",@"An evening with ",[[NSUserDefaults standardUserDefaults] valueForKey:@"nameUser"]];
                
                NSDictionary *getuserH = [getDataC valueForKey:@"user"];
                NSString * getuserid = [NSString stringWithFormat:@"%@",[getuserH valueForKey:@"id"]];
                
                NSDictionary *geteventH = [getDataC valueForKey:@"event"];
                NSString * getEventAddr = [NSString stringWithFormat:@"%@",[geteventH valueForKey:@"venue_address"]];
                NSString * getnameevent = [NSString stringWithFormat:@"%@",[geteventH valueForKey:@"venue_name"]];
                NSString * getEventcity = [NSString stringWithFormat:@"%@",[geteventH valueForKey:@"city"]];
                NSString * getEventpost = [NSString stringWithFormat:@"%@",[geteventH valueForKey:@"post_code"]];
                
                
                
                NSString * getEventDate = [NSString stringWithFormat:@"%@",[geteventH valueForKey:@"start_date"]];
                NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
                [dateFormatter setDateFormat:@"yyyy-MM-dd"];
                NSDate *date = [dateFormatter dateFromString:getEventDate];
                
                NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
                [formatter setDateFormat:@"MMM dd"];
                NSLog(@"Current Date: %@", [formatter stringFromDate:date]);
                NSString * getdate = [formatter stringFromDate:date];
                
                
                str.getDate = getdate;
                str.getIduser = getuserid;
              NSString *getStandardTicket = [NSString stringWithFormat:@"%@",[getDataC valueForKey:@"total_tickets"]];
                
                
                
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
                //  objview.str_value = qrCode;
                
                if([[NSString stringWithFormat:@"%@",[getDataC valueForKey:@"total_tickets"]]  isEqual: @"0"])
                {
                    UIAlertController * alert = [UIAlertController
                                                 alertControllerWithTitle:@"UNiGHTS"
                                                 message:@"All tickets are sold"
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
                }
                else
                {
                     [self.navigationController pushViewController:str animated:YES];
                }
                });
                }
            
            else
            {
                
                UIAlertController * alert = [UIAlertController
                                             alertControllerWithTitle:@"UNiGHTS"
                                             message:@"Invalid Ticket"
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
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [SVProgressHUD dismiss];
            });
        }
        
        
        
        
        
    }];
    [task resume];
}
- (IBAction)onFront:(id)sender{
    NSArray *devices = [AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo];
    
    
    
    for (AVCaptureDevice *device in devices)
    {
        if ([device position] == AVCaptureDevicePositionFront)
        {
            NSError *error;
            captureDevice = device;
    input = [AVCaptureDeviceInput deviceInputWithDevice:device error:&error];
    _captureSession = [[AVCaptureSession alloc] init];
    // Set the input device on the capture session.
    [_captureSession addInput:input];
    // Initialize a AVCaptureMetadataOutput object and set it as the output device to the capture session.
    AVCaptureMetadataOutput *captureMetadataOutput = [[AVCaptureMetadataOutput alloc] init];
    [_captureSession addOutput:captureMetadataOutput];
    // Create a new serial dispatch queue.
    dispatch_queue_t dispatchQueue;
    dispatchQueue = dispatch_queue_create("myQueue", NULL);
    [captureMetadataOutput setMetadataObjectsDelegate:self queue:dispatchQueue];
    [captureMetadataOutput setMetadataObjectTypes:[NSArray arrayWithObject:AVMetadataObjectTypeQRCode]];
    // Initialize the video preview layer and add it as a sublayer to the viewPreview view's layer.
    _videoPreviewLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:_captureSession];
    [_videoPreviewLayer setVideoGravity:AVLayerVideoGravityResizeAspectFill];
    [_videoPreviewLayer setFrame:_viewPreview.layer.bounds];
    [_viewPreview.layer addSublayer:_videoPreviewLayer];
            
    // Start video capture.
    [_captureSession startRunning];
    NSLog(@"Front camera:-@");
        }
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onClose:(id)sender {
    [_captureSession stopRunning];
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - AVCaptureMetadataOutputObjectsDelegate method implementation
-(void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection{
    // Check if the metadataObjects array is not nil and it contains at least one object.
    if (metadataObjects != nil && [metadataObjects count] > 0) {
        // Get the metadata object.
        AVMetadataMachineReadableCodeObject *metadataObj = [metadataObjects objectAtIndex:0];
        if ([[metadataObj type] isEqualToString:AVMetadataObjectTypeQRCode])
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                [_captureSession stopRunning];
                qrCode = [metadataObj stringValue];
                qrCode = [qrCode stringByReplacingOccurrencesOfString:@" " withString:@""];
                NSLog(@"new string:%@",qrCode);
                
                NSRange subIndex = [qrCode rangeOfString:@"pin="];
                if (subIndex.location != NSNotFound) {
                    qrCode = [qrCode substringFromIndex:subIndex.location +4];
                }
                UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
              
                pasteboard.string = qrCode;
                [self scanEvent];
//                 [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://idp.appery.io/idp/"]];
                
                
               
            });
        }
    }
//[Global alertForTitle:@"Alert" message:@"this is not Safe2Meet QR Code"];
}
@end
