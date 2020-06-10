//
//  ViewControllerOTP.m
//  UNiGHTS
//
//  Created by user on 03/07/18.
//  Copyright © 2018 RVTechnologies Softwares PVT. LTD. All rights reserved.
//

#import "ViewControllerOTP.h"
#import "common.h"
#import <FirebaseAuth/FirebaseAuth.h>
#import <FirebaseAuth/FIROAuthProvider.h>
#import <FirebaseCore/FirebaseCore.h>
#import "SVProgressHUD.h"
@interface ViewControllerOTP ()

@end

@implementation ViewControllerOTP

- (void)viewDidLoad {
    [super viewDidLoad];
     [SVProgressHUD dismiss];
    NSString *number =  [[NSUserDefaults standardUserDefaults]valueForKey:@"phoneTxt"];
    NSString *code = [number substringFromIndex: [number length] - 4];
    NSString * str = @"One Time password (OTP) has been sent to your mobile number.******";
    NSString *str2 = @"Please enter the same here to continue.";
    NSString *str3 = [str stringByAppendingString:code];
    NSString *str4 = [str3 stringByAppendingString:str2];
    _otpTxt.text = str4;
    
    // Do any additional setup after loading the view.
}
- (IBAction)verifyBtnTap:(id)sender {
    
    
    
//    NSString *code = [self.txtCode.text stringByTrimmingCharactersInSet:
//                      [NSCharacterSet whitespaceAndNewlineCharacterSet]];
   
   NSString *code = [NSString stringWithFormat: @"%@%@%@%@%@%@",_text1.text,_text2.text,_text3.text,_text4.text,_text5.text, _text6.text];
    NSLog(@"%@",code);
    if([_text1.text  isEqual: @"_"] || [_text2.text  isEqual: @"_"] || [_text3.text  isEqual: @"_"] || [_text4.text  isEqual: @"_"] || [_text5.text  isEqual: @"_"]|| [_text6.text  isEqual: @"_"]){
   
        UIAlertController * alert = [UIAlertController
                                     alertControllerWithTitle:@"UNiGHTS"
                                     message:@"Incomplete OTP"
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
        return;
    }
    dispatch_async(dispatch_get_main_queue(), ^{
        [SVProgressHUD showWithStatus:@"Please wait.." maskType:SVProgressHUDMaskTypeBlack];
    });
    
    NSString *verificationID = [[NSUserDefaults standardUserDefaults]objectForKey:@"verificationID"];
    
    FIRAuthCredential *credential = [[FIRPhoneAuthProvider provider]
                                     credentialWithVerificationID:verificationID
                                     verificationCode:code];
   
    
    [[FIRAuth auth] signInWithCredential:credential
                              completion:^(FIRUser *user, NSError *error) {
                                  if (error) {
                                      dispatch_async(dispatch_get_main_queue(), ^{
                                          
                                          [SVProgressHUD dismiss];
                                      });
                                      UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Unights"
                                                                                      message:@"Invalid OTP"
                                                                                     delegate:self
                                                                            cancelButtonTitle:@"OK"
                                                                            otherButtonTitles:nil];
                                      [alert show];
//                                      [self dismissViewControllerAnimated:true completion:^{
//                                          [[NSNotificationCenter defaultCenter]
//                                           postNotificationName:@"Fail"
//                                           object:self];
//                                      }];
                                  }else{
                                      
                                      if([UserRole isEqualToString:@"0"])
                                      {
                                          dispatch_async(dispatch_get_main_queue(), ^{
                                              
                                              [SVProgressHUD dismiss];
                                          });
                                          
                                          [self signUP];
//                                          UIStoryboard *obj=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
//                                          UIViewController *str=[obj instantiateViewControllerWithIdentifier:@"view1"];
//                                          [self.navigationController pushViewController:str animated:true];
                                      }
                                      else
                                      {
                                           [self signUP];
//                                          UIStoryboard *obj=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
//                                          UIViewController *str=[obj instantiateViewControllerWithIdentifier:@"view2"];
//                                          [self.navigationController pushViewController:str animated:true];
                                      }
//                                      [self dismissViewControllerAnimated:true completion:^{
//                                          [[NSNotificationCenter defaultCenter]
//                                           postNotificationName:@"success"
//                                           object:self];
//                                      }];
                                  }
                              }];
    //    [self dismissViewControllerAnimated:true completion:^{
    //        [[NSNotificationCenter defaultCenter]
    //         postNotificationName:@"check"
    //         object:self];
    //    }];
    
   
    
}
-(void) signUP
{
    NSURLSession *session = [NSURLSession sharedSession];
    NSString *URL = [NSString stringWithFormat:@"http://18.188.52.230/unights/public/api/register"];
    NSURL *theURL = [NSURL URLWithString:URL];
    NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:theURL cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:30.0f];
    [theRequest setHTTPMethod:@"POST"];

    
    
    NSString *number =  [[NSUserDefaults standardUserDefaults]valueForKey:@"phoneTxt"];
    NSString *getS;
    if ([UserRole  isEqual: @"0"]) {
        getS = @"3";
    }
    else
    {
        getS = @"2";
    }
    
    NSString *param=[NSString stringWithFormat:@"role=%@&name=%@&email=%@&password=%@&phone=%@&cpassword=%@&last_name=%@",getS,_nameStr,_emailStr,_passStr,_PhoneStr,_confirmPasword,_SurnameStr];
    
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
                    
                    NSString *tokenGet = [json valueForKey:@"access_token"];
                    [[NSUserDefaults standardUserDefaults]setObject:tokenGet forKey:@"acessToken"];
                    dispatch_async(dispatch_get_main_queue(), ^{
                        NSDictionary * getUserInfo = [json valueForKey:@"user"];
                        
                        NSString *role = [NSString stringWithFormat:@"%@",[getUserInfo valueForKey:@"role"]];
                        if(!([[getUserInfo valueForKey:@"profile_image"] isKindOfClass:[NSNull class]]))
                        {
                            NSString *imageProfile = [NSString stringWithFormat:@"%@",[getUserInfo valueForKey:@"profile_image"]];
                            
                            [NSUserDefaults.standardUserDefaults setValue:imageProfile forKey:@"imageProfile"];
                        }
                        
                        else
                        {
                            [NSUserDefaults.standardUserDefaults setValue:@"" forKey:@"imageProfile"];
                        }
                        NSString *nameUser = [NSString stringWithFormat:@"%@",[getUserInfo valueForKey:@"name"]];
                        
                        [NSUserDefaults.standardUserDefaults setValue:nameUser forKey:@"nameUser"];
                        [NSUserDefaults.standardUserDefaults setValue:role forKey:@"CounterValue"];
                        if ([role  isEqual: @"3"]) {
                            UserRole = @"0";
                        }
                        else
                        {
                            UserRole = @"1";
                        }
                        UIStoryboard *obj=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
                        UIViewController *str=[obj instantiateViewControllerWithIdentifier:@"SwRevelController"];
                        [self.navigationController pushViewController:str animated:true];
                        
                        
                    });
                }
                
                else
                {
                    NSString *textMessage;
                    // textMessage = [json valueForKey:@"message"];
                    UIAlertController * alert = [UIAlertController
                                                 alertControllerWithTitle:@"UNiGHTS"
                                                 message:@"Number is already registered"
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

- (BOOL)textFieldShouldReturn:(UITextField *)txtField
{
    [txtField resignFirstResponder];
    return NO;
}

-(void)textFieldDidBeginEditing:(UITextField *)textField {
    if (textField.tag == 2) {
        //this is textfield 2, so call your method here
    }
}


- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if (string.length > 0) {
        //
        if (textField == self.text1)
        {
            if (![self.text1.text isEqualToString:@""])
            {
                self.text2.text=string;
            }
            else
            {
                textField.text = [string substringToIndex:1];
            }
            [self.text2 becomeFirstResponder];
        } else if (textField == self.text2)
        {
            if (![self.text2.text isEqualToString:@""])
            {
                self.text3.text=string;
            }
            else
            {
                textField.text = [string substringToIndex:1];
            }
            [self.text3 becomeFirstResponder];
        } else if (textField == self.text3)
        {
            if (![self.text3.text isEqualToString:@""])
            {
                self.text4.text=string;
            }
            else
            {
                textField.text = [string substringToIndex:1];
            }
            [self.text4 becomeFirstResponder];
        }
        else if (textField == self.text4)
        {
            if (![self.text4.text isEqualToString:@""])
            {
                self.text5.text=string;
            }
            else
            {
                textField.text = [string substringToIndex:1];
            }
            [self.text5 becomeFirstResponder];
        }
        else
        {
            textField.text = [string substringToIndex:1];
            [self.text6 becomeFirstResponder];
        }
        
        return NO;
    }
    else
    {
        if (textField == self.text6) {
            [self.text6 resignFirstResponder];
            self.text6.text =@"";
            [self.text5 becomeFirstResponder];
        }
        else if (textField == self.text5) {
            [self.text5 resignFirstResponder];
            self.text5.text =@"";
            [self.text4 becomeFirstResponder];
        }
       else if (textField == self.text4) {
            [self.text4 resignFirstResponder];
            self.text4.text =@"";
            [self.text3 becomeFirstResponder];
        }
       else if (textField == self.text3) {
            [self.text3 resignFirstResponder];
            self.text3.text =@"";
            [self.text2 becomeFirstResponder];
        } else if (textField == self.text2)
        {
            [self.text2 resignFirstResponder];
            self.text2.text =@"";
            [self.text1 becomeFirstResponder];
        } else {
            [self.text1 resignFirstResponder];
            self.text1.text =@"";
            [textField resignFirstResponder];
        }
        return NO;
    }
    
    return YES;
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)confirmPasswordTxt:(id)sender {
}
@end
