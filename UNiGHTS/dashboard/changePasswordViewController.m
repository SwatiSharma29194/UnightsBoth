//
//  changePasswordViewController.m
//  UNiGHTS
//
//  Created by user on 8/9/18.
//  Copyright © 2018 RVTechnologies Softwares PVT. LTD. All rights reserved.
//

#import "changePasswordViewController.h"
#import "SVProgressHUD.h"
@interface changePasswordViewController ()

@end

@implementation changePasswordViewController
{
    NSString *param;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (IBAction)changePasswordTxt:(id)sender {
    if([_oldPasswordTxt.text  isEqual: @""])
    {
        UIAlertController * alert = [UIAlertController
                                     alertControllerWithTitle:@"UNiGHTS"
                                     message:@"Enter the old Password"
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
     else if([_passWordTxt.text  isEqual: @""])
     {
         UIAlertController * alert = [UIAlertController
                                      alertControllerWithTitle:@"UNiGHTS"
                                      message:@"Enter the new Password"
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
    
     else if(_passWordTxt.text.length < 6)
     {
         UIAlertController * alert = [UIAlertController
                                      alertControllerWithTitle:@"UNiGHTS"
                                      message:@"The password should be atleast 6 characters"
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
     else if([_confirmPasswordTxt.text  isEqual: @""])
     {
         UIAlertController * alert = [UIAlertController
                                      alertControllerWithTitle:@"UNiGHTS"
                                      message:@"Enter the Password to confirm"
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
     else if(!([_passWordTxt.text isEqualToString:  _confirmPasswordTxt.text]))
     {
         UIAlertController * alert = [UIAlertController
                                      alertControllerWithTitle:@"UNiGHTS"
                                      message:@"Confirm password is not same to old password"
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
         [self ChangePassword];
    }
   
}
- (IBAction)backBtnTap:(id)sender {
    
    [self.navigationController popViewControllerAnimated:true];
}
-(void) ChangePassword{
    NSURLSession *session = [NSURLSession sharedSession];
    NSString *strtoken  =[[NSUserDefaults standardUserDefaults]objectForKey:@"acessToken"];
    
    NSString *strBearer = @"Bearer ";
    
    NSString *URL = @"http://18.188.52.230/unights/public/api/change-password";
    
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
    
    // 1 eventWeek empty , eventMonth empty
    // 2 eventWeek 1   , eventMonth empty
    // 3 eventWeek empty , eventMonth 1
 
    param=[NSString stringWithFormat:@"old_password=%@&new_password=%@&confirm_password=%@",_oldPasswordTxt.text,_passWordTxt.text,_confirmPasswordTxt.text];
    
    NSLog(@"%@",param);
    NSData *postData = [param dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    
    [theRequest setHTTPBody:postData];
    
    
    
     NSURLSessionDataTask * task=  [session dataTaskWithRequest:theRequest completionHandler:^(NSData *  data, NSURLResponse * response, NSError *  error) {
        
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
              
                UIAlertController * alert = [UIAlertController
                                             alertControllerWithTitle:@"UNiGHTS"
                                             message:@"Password updated successfully"
                                             preferredStyle:UIAlertControllerStyleAlert];
                
                //Add Buttons
                
                
                
                UIAlertAction* noButton = [UIAlertAction
                                           actionWithTitle:@"OK"
                                           style:UIAlertActionStyleDefault
                                           handler:^(UIAlertAction * action) {
                                               UIStoryboard *obj=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
                                               UIViewController *str=[obj instantiateViewControllerWithIdentifier:@"ViewControllerLogin"];
                                               [self.navigationController pushViewController:str animated:true];              //Handle no, thanks button
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
                                             message:@"The specified password does not match the database password"
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
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    [SVProgressHUD dismiss];
                });
            }
            
            
            //                NSArray *arrdata =[json objectForKey:@"day"];
            
            //
            
            //                NSDictionary *dict =[arrdata objectAtIndex:0];
            
            
            
            
            
        }
     
        
        
        
        
        
    }];
    [task resume];
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
