//
//  forgotPasswordViewController.m
//  UNiGHTS
//
//  Created by user on 9/4/18.
//  Copyright © 2018 RVTechnologies Softwares PVT. LTD. All rights reserved.
//

#import "forgotPasswordViewController.h"
#import "SVProgressHUD.h"
#import "Validation.h"
@interface forgotPasswordViewController ()

@end

@implementation forgotPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
}
- (IBAction)submitBtnTap:(id)sender {
    Validation *get = [[Validation alloc]init];
    if([_emailTxt.text isEqualToString: @""])
    {
        UIAlertController * alert = [UIAlertController
                                     alertControllerWithTitle:@"UNiGHTS"
                                     message:@"Add the email"
                                     preferredStyle:UIAlertControllerStyleAlert];
        
        //Add Buttons
        
        
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
    else if(!([get validateEmail:_emailTxt.text]))
        
    {
        UIAlertController * alert = [UIAlertController
                                     alertControllerWithTitle:@"UNiGHTS"
                                     message:@"Invalid Email"
                                     preferredStyle:UIAlertControllerStyleAlert];
        
        //Add Buttons
        
        
        
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
    
    else
    {
    [self forgotPassword];
    }
}
-(void) forgotPassword
{
NSURLSession *session = [NSURLSession sharedSession];
NSString *URL = [NSString stringWithFormat:@"http://18.188.52.230/unights/public/api/forgot"];
NSURL *theURL = [NSURL URLWithString:URL];
NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:theURL cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:30.0f];
[theRequest setHTTPMethod:@"POST"];


NSString *param=[NSString stringWithFormat:@"email=%@",self.emailTxt.text];



dispatch_async(dispatch_get_main_queue(), ^{
    [SVProgressHUD showWithStatus:@"Please wait.." maskType:SVProgressHUDMaskTypeBlack];
    
    
    
    NSData *postData = [param dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    [theRequest setHTTPBody:postData];
    NSURLSessionDataTask * task=  [session dataTaskWithRequest:theRequest completionHandler:^(NSData *  data, NSURLResponse * response, NSError *  error) {
        //    [NSURLConnection sendAsynchronousRequest:theRequest queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        // if(data != nil){
        
        NSString *noti = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        
        
        
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
            
            getSuccess = [NSString stringWithFormat:@"%@",[json valueForKey:@"success"]];
            
            if([getSuccess  isEqual: @"1"])
            {
              
                UIAlertController * alert = [UIAlertController
                                             alertControllerWithTitle:@"UNiGHTS"
                                             message:@"Check your email for further steps"
                                             preferredStyle:UIAlertControllerStyleAlert];
                
                //Add Buttons
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    [SVProgressHUD dismiss];
               
                
                
                UIAlertAction* noButton = [UIAlertAction
                                           actionWithTitle:@"OK"
                                           style:UIAlertActionStyleDefault
                                           handler:^(UIAlertAction * action) {
                                               //Handle no, thanks button
                                           }];
                
                //Add your buttons to alert controller
                
                
                [alert addAction:noButton];
                
                [self presentViewController:alert animated:YES completion:nil];
                     });
             
            }
            
            else
            {
                NSString *textMessage;
                textMessage = [json valueForKey:@"message"];
                UIAlertController * alert = [UIAlertController
                                             alertControllerWithTitle:@"UNiGHTS"
                                             message:textMessage
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
});



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
