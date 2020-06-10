//
//  ViewControllerVerify.m
//  UNiGHTS
//
//  Created by user on 03/07/18.
//  Copyright © 2018 RVTechnologies Softwares PVT. LTD. All rights reserved.
//

#import "ViewControllerVerify.h"
#import "PCCPViewController.h"
#import <FirebaseAuth/FirebaseAuth.h>
#import <FirebaseAuth/FIROAuthProvider.h>
#import <FirebaseCore/FirebaseCore.h>
#import "ViewControllerOTP.h"
#import "SVProgressHUD.h"
#import "Validation.h"
@interface ViewControllerVerify ()

@end
@import Firebase;


@implementation ViewControllerVerify

- (void)viewDidLoad {
    [super viewDidLoad];
    [self updateViewsWithCountryDic:[PCCPViewController infoFromSimCardAndiOSSettings]];
    NSMutableString * defalultInfo = [[_label text] mutableCopy];
    [_label setText:defalultInfo];
   //  [self ConfirmByPhoneCode];
    
}
-(void) getConfirmation
{
    NSURLSession *session = [NSURLSession sharedSession];
    NSString *URL = [NSString stringWithFormat:@"http://18.188.52.230/unights/public/api/check-user-registered"];
    NSURL *theURL = [NSURL URLWithString:URL];
    NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:theURL cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:30.0f];
    [theRequest setHTTPMethod:@"POST"];
    
    //NSString *access;
    //
    //
    //
    // access =   [[NSUserDefaults standardUserDefaults]objectForKey:@"acessToken"];
    
    //                NSString *str = [access stringByAppendingString:@"Bearer"];
    
    // NSString *strBearer = @"Bearer ";
    
    
    //[theRequest setValue:[strBearer stringByAppendingString:access] forHTTPHeaderField:@"Authorization"];
    // [theRequest setValue:[strBearer stringByAppendingString:access]];
    // [theRequest setValue:@"Accept" forHTTPHeaderField:@"application/json"];
    //  NSString *caption_id = @"caption_id=";
    
    
  
    
    NSString *param=[NSString stringWithFormat:@"phone=%@&email=%@",_phtext.text,_emailTxt.text];
    
    NSLog(@"%@",param);
    
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
                    
                  
                  
                    dispatch_async(dispatch_get_main_queue(), ^{
                       [self ConfirmByPhoneCode];
                        
                        
                    });
                }
                
                else
                {
                    NSString *textMessage;
                    NSDictionary *getM = [json valueForKey:@"message"];
                    if(!([getM valueForKey:@"email"] == nil))
                    {
//                        textMessage = [json valueForKey:@"message"];
                        UIAlertController * alert = [UIAlertController
                                                     alertControllerWithTitle:@"UNiGHTS"
                                                     message:@"Email is already registered"
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
                    
                    else
                    {
                        UIAlertController * alert = [UIAlertController
                                                     alertControllerWithTitle:@"UNiGHTS"
                                                     message:@"Phone number is already registered"
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
-(void) viewDidDisappear:(BOOL)animated
{
    dispatch_async(dispatch_get_main_queue(), ^{
        
        [SVProgressHUD dismiss];
    });
}
-(void)ConfirmByPhoneCode
{
//    NSString *plus = @"+";
    NSString *plusCode = @"+44";
    
   NSString *plusCodeNumber = [plusCode stringByAppendingString:_phtext.text];
    
      [SVProgressHUD showWithStatus:@"Please wait.." maskType:SVProgressHUDMaskTypeBlack];
    
// NSString *plusCodeNumber = @"+919988821772";
    
    [[NSUserDefaults standardUserDefaults]setObject:plusCodeNumber forKey:@"NumberVerify"];
    
       [[NSUserDefaults standardUserDefaults]setObject:_phtext.text forKey:@"phoneTxt"];
    
//    [[[NSUserDefaults standardUserDefaults]synchronize];
    
     [[FIRPhoneAuthProvider provider] verifyPhoneNumber:plusCodeNumber
                                             UIDelegate:nil
                                             completion:^(NSString * _Nullable verificationID, NSError * _Nullable error) {
            
        
        // Dispatch asynchronously on the main thread as a temporary workaround to a known issue.
        dispatch_async(dispatch_get_main_queue(), ^() {
            
            if (error) {
                
                NSLog(@"%@",error);
                
                [SVProgressHUD dismiss];
                
                return;
                
            }
            else
            {
                [SVProgressHUD dismiss];
                [[NSUserDefaults standardUserDefaults]setObject:verificationID forKey:@"verificationID"];
                [[NSUserDefaults standardUserDefaults]synchronize];
                ViewControllerOTP *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"ViewControllerOTP"];
                vc.nameStr = _nameTxt.text;
                vc.SurnameStr = _surnameTxt.text;
                vc.emailStr = _emailTxt.text;
                vc.passStr = _passwordTxt.text;
                vc.PhoneStr = _phtext.text;
                vc.confirmPasword = _confirmPasswordTxt.text;
                [self.navigationController pushViewController:vc animated:true];
                
            }
        });
    }];
}

- (void)updateViewsWithCountryDic:(NSDictionary*)countryDic{
    
    NSString * string_contact=@"+ ";
    string_contact=[string_contact stringByAppendingString:[NSString stringWithFormat:@"%@",[countryDic valueForKey:@"phone_code"]]];
    [_label setText:string_contact];
    [_imageView setImage:[PCCPViewController imageForCountryCode:countryDic[@"country_code"]]];
}
- (IBAction)nextBtnTaop:(id)sender {
    
    Validation *get = [[Validation alloc]init];
    
    if(!([get validateBlankField:_nameTxt.text]))
        
    {
        UIAlertController * alert = [UIAlertController
                                     alertControllerWithTitle:@"UNiGHTS"
                                     message:@"Add the name"
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
    
    else if(!([get validateBlankField:_surnameTxt.text]))
        
    {
        UIAlertController * alert = [UIAlertController
                                     alertControllerWithTitle:@"UNiGHTS"
                                     message:@"Add the last name"
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
    else if(!([get validateBlankField:_emailTxt.text]))
        
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
    
    else if(!([get validateBlankField:_passwordTxt.text]))
        
    {
        UIAlertController * alert = [UIAlertController
                                     alertControllerWithTitle:@"UNiGHTS"
                                     message:@"Enter the Password"
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
    else if(_passwordTxt.text.length < 6)
        
        
    {
        UIAlertController * alert = [UIAlertController
                                     alertControllerWithTitle:@"UNiGHTS"
                                     message:@"Password should be atleast 6 digits"
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
   
    else if(!([get validateBlankField:_confirmPasswordTxt.text]))
        
    {
        UIAlertController * alert = [UIAlertController
                                     alertControllerWithTitle:@"UNiGHTS"
                                     message:@"Add the confirm password"
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
    else if(!([_passwordTxt.text isEqualToString:_confirmPasswordTxt.text]))
        
    {
        UIAlertController * alert = [UIAlertController
                                     alertControllerWithTitle:@"UNiGHTS"
                                     message:@"Password does not match"
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
    else if(!([get validateBlankField:_phtext.text]))
        
    {
        UIAlertController * alert = [UIAlertController
                                     alertControllerWithTitle:@"UNiGHTS"
                                     message:@"Add the phone number to continue"
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
        [self getConfirmation];
    }
    
    
   
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

- (IBAction)GetCountryCode:(id)sender
{
    PCCPViewController * vc = [[PCCPViewController alloc] initWithCompletion:^(id countryDic) {
        [self updateViewsWithCountryDic:countryDic];
    }];
    UINavigationController *naviVC = [[UINavigationController alloc] initWithRootViewController:vc];
    [self presentViewController:naviVC animated:YES completion:NULL];
}
@end
