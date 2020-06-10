//
//  ViewController.m
//  UNiGHTS
//
//  Created by user on 12/06/18.
//  Copyright © 2018 RVTechnologies Softwares PVT. LTD. All rights reserved.
//


#import "ViewController.h"
#import "SVProgressHUD.h"
#import "Validation.h"
#import "common.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}
- (IBAction)signUpBtnTap:(id)sender
{
//  For Promoter => role = 2, name, email,password, company, address, post_code  For Student=> role = 3, name, email, password, latitude, longitude
    
    
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
    else if(!([get validateBlankField:_universityTxt.text]))
        
    {
        UIAlertController * alert = [UIAlertController
                                     alertControllerWithTitle:@"UNiGHTS"
                                     message:@"Add the name of the university"
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
        [self signUP];
    }
    
}
-(void) signUP
{
    NSURLSession *session = [NSURLSession sharedSession];
    NSString *URL = [NSString stringWithFormat:@"http://18.188.52.230/unights/public/api/register"];
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
    
    
   NSString *number =  [[NSUserDefaults standardUserDefaults]valueForKey:@"phoneTxt"];
   
    
    NSString *param=[NSString stringWithFormat:@"role=%@&name=%@&email=%@&password=%@&phone=%@&university=%@",@"3",_nameTxt.text,_emailTxt.text,_passwordTxt.text,number,_universityTxt.text];
    
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

@end
