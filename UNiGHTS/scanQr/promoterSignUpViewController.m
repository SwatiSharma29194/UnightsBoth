//
//  promoterSignUpViewController.m
//  UNiGHTS
//
//  Created by user on 7/10/18.
//  Copyright © 2018 RVTechnologies Softwares PVT. LTD. All rights reserved.
//

#import "promoterSignUpViewController.h"
#import "SVProgressHUD.h"
#import "Validation.h"
#import "common.h"
@interface promoterSignUpViewController ()

@end

@implementation promoterSignUpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)signupBtnTap:(id)sender {

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
    else if(!([get validateBlankField:_companyNameTxt.text]))
        
    {
        UIAlertController * alert = [UIAlertController
                                     alertControllerWithTitle:@"UNiGHTS"
                                     message:@"Add the name of company"
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
    else if(!([get validateBlankField:_addressTxt.text]))
        
    {
        UIAlertController * alert = [UIAlertController
                                     alertControllerWithTitle:@"UNiGHTS"
                                     message:@"Enter the Address"
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
    else if(!([get validateBlankField:_postCodeTxt.text]))
        
    {
        UIAlertController * alert = [UIAlertController
                                     alertControllerWithTitle:@"UNiGHTS"
                                     message:@"Add the Post Code"
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
    

    NSString *param=[NSString stringWithFormat:@"role=%@&name=%@&email=%@&password=%@&phone=%@&company=%@&address=%@&post_code=%@",@"2",_nameTxt.text,_emailTxt.text,_passwordTxt.text,number,_companyNameTxt.text,_addressTxt.text,_postCodeTxt.text];
    
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
                        NSString *ID = [NSString stringWithFormat:@"%@",[getUserInfo valueForKey:@"id"]];
                        
                        [NSUserDefaults.standardUserDefaults setValue:ID forKey:@"ID"];
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
                        
                        
                        
                        if(!([[getUserInfo valueForKey:@"stripe_account"] isKindOfClass:[NSNull class]] || [[getUserInfo valueForKey:@"stripe_account"] isEqualToString: @""]))
                        {
                            NSString *points = [NSString stringWithFormat:@"%@",[getUserInfo valueForKey:@"stripe_account"]];
                            
                            [NSUserDefaults.standardUserDefaults setValue:points forKey:@"stripe_account"];
                        }
                        
                        else
                        {
                            [NSUserDefaults.standardUserDefaults setValue:@"" forKey:@"stripe_account"];
                        }
                        if(!([[getUserInfo valueForKey:@"points"] isKindOfClass:[NSNull class]]))
                        {
                            NSString *points = [NSString stringWithFormat:@"%@",[getUserInfo valueForKey:@"points"]];
                            
                            [NSUserDefaults.standardUserDefaults setValue:points forKey:@"pointsEarn"];
                        }
                        
                        else
                        {
                            [NSUserDefaults.standardUserDefaults setValue:@"0" forKey:@"pointsEarn"];
                        }
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
                    textMessage = [json valueForKey:@"message"];
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
