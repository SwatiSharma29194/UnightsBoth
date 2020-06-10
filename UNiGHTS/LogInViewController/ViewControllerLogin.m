//
//  ViewControllerLogin.m
//  UNiGHTS
//
//  Created by user on 29/06/18.
//  Copyright © 2018 RVTechnologies Softwares PVT. LTD. All rights reserved.
//

#import "ViewControllerLogin.h"
#import "SVProgressHUD.h"
#import "Validation.h"
#import <FirebaseAuth/FirebaseAuth.h>
#import <FirebaseAuth/FIROAuthProvider.h>
#import "common.h"
#import <FirebaseCore/FirebaseCore.h>
 #import <FBSDKCoreKit/FBSDKCoreKit.h>
 #import <FBSDKLoginKit/FBSDKLoginKit.h>
@interface ViewControllerLogin ()<FBSDKLoginButtonDelegate>
@property (strong, nonatomic) IBOutlet UILabel *loginWithBTn;
@property (strong, nonatomic) IBOutlet UIButton *facebookLoginBTn;

@end
@import Firebase;
@implementation ViewControllerLogin
{
   // Validation * getValidate;
    NSString *nameFb;
    NSString *emailFb;
    NSString *facebook_id;
   
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _ChooseRoleView.layer.cornerRadius=5;
    _ChooseRoleView.clipsToBounds=YES;
    _loginBtn.layer.cornerRadius = _loginBtn.frame.size.height / 2;
    _loginBtn.clipsToBounds = YES;
    
    _facebookLoginBTn.layer.cornerRadius = _loginBtn.frame.size.height / 2;
    _facebookLoginBTn.clipsToBounds = YES;

//    _facebookLoginBTn.readPermissions = @[@"public_profile", @"email"];
//    _facebookLoginBTn.delegate = self;
    
    if([UserRole isEqualToString:@"0"])
    {
        _facebookLoginBTn.hidden = NO;
        _loginWithBTn.hidden = NO;
    }
    else
    {
        _facebookLoginBTn.hidden = YES;
        _loginWithBTn.hidden = YES;
        
        }
    if ([FBSDKAccessToken currentAccessToken]) {
        // User is logged in, do work such as go to next view controller.
    }
}
- (IBAction)backBtn:(id)sender {
    
    [self.navigationController popViewControllerAnimated:true];
}
- (IBAction)btnTap:(id)sender {
    FBSDKLoginManager *login = [[FBSDKLoginManager alloc] init];
    
    if ([UIApplication.sharedApplication canOpenURL:[NSURL URLWithString:@"fb://"]])
        
    {
        
        login.loginBehavior = FBSDKLoginBehaviorSystemAccount;
        
    }
    
    
    
    [login logInWithReadPermissions:@[@"public_profile", @"email"] handler:^(FBSDKLoginManagerLoginResult *result, NSError *error) {
        
        if (error)
            
        {
            
            NSLog(@"Unexpected login error: %@", error);
            
            NSString *alertMessage = error.userInfo[FBSDKErrorLocalizedDescriptionKey] ?: @"There was a problem logging in. Please try again later.";
            
            NSString *alertTitle = error.userInfo[FBSDKErrorLocalizedTitleKey] ?: @"Oops";
            
            [[[UIAlertView alloc] initWithTitle:alertTitle
              
                                        message:alertMessage
              
                                       delegate:nil
              
                              cancelButtonTitle:@"OK"
              
                              otherButtonTitles:nil] show];
            
        }
        
        else
            
        {
            
            if(result.token)   // This means if There is current access token.
                
            {
                
                
                
                [[[FBSDKGraphRequest alloc] initWithGraphPath:@"me"
                  
                                                   parameters:@{@"fields": @"picture, name, email"}]
                 
                 startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id userinfo, NSError *error) {
                     
                     if (!error) {
                         
                         
                         
                         
                         
                         dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0ul);
                         
                         dispatch_async(queue, ^(void) {
                             
                             
                             
                             dispatch_async(dispatch_get_main_queue(), ^{
                                 
                                 
                                 
                                 NSArray *name = [userinfo valueForKey:@"name"];
                                 
                                 NSString *email = [userinfo valueForKey:@"email"];
                                 
                                 NSString *fbId= [ userinfo valueForKey:@"id"];
                                 
                                 NSString *picture=[userinfo valueForKey:@"picture"];
                                 
                                 NSArray *data=[picture valueForKey:@"data"];
                                 
                                 
                                 
                                 NSString *url=[data valueForKey:@"url"];
                                 
                                 
                                 
                                 NSLog(@"url %@",url);
                                 
                                 
                                 
                                 NSLog(@"fbid %@",fbId);
                                 
                                 nameFb = [userinfo valueForKey:@"name"];
                                 emailFb = email;
                                 facebook_id = fbId;
                                 
                                 
                                 [[NSUserDefaults standardUserDefaults]setObject:name forKey:@"facebookName"];
                                 
                                 
                                 
                                 [[NSUserDefaults standardUserDefaults]setObject:email forKey:@"email"];
                                 
                                 
                                 
                                 [[NSUserDefaults standardUserDefaults]setObject:fbId forKey:@"fbid"];
                                 
                                 
                                 
                                 [[NSUserDefaults standardUserDefaults]setObject:url forKey:@"fbUrl"];
                                 
                                 
                                 
                                 [[NSUserDefaults standardUserDefaults]synchronize];
                                 
                                 
                                 
                                 
                                 //
                                 //                                 [self callFbLoginAthleteApi];
                                 //
                                 
                                 
                                 
                                 
                                 
                                 
                                     [self loginFb];
                                 
                                 
                                 
                             });
                             
                         });
                         
                         
                         
                     }
                     
                     else{
                         
                         
                         
                         NSLog(@"%@", [error localizedDescription]);
                         
                     }
                     
                 }];
                
            }
            
            NSLog(@"Login Cancel");
            
            
            
            
            
        }
        
    }];
}
-(void)loginButtonDidLogOut:(FBSDKLoginButton*)loginButton
{
    
}
//- (void)
//loginButton:    (FBSDKLoginButton *)loginButton
//didCompleteWithResult:    (FBSDKLoginManagerLoginResult *)result
//error:    (NSError *)error
//{
//    FBSDKLoginManager *login = [[FBSDKLoginManager alloc] init];
//
//    if ([UIApplication.sharedApplication canOpenURL:[NSURL URLWithString:@"fb://"]])
//
//    {
//
//        login.loginBehavior = FBSDKLoginBehaviorSystemAccount;
//
//    }
//
//
//
//    [login logInWithReadPermissions:@[@"public_profile", @"email"] handler:^(FBSDKLoginManagerLoginResult *result, NSError *error) {
//
//        if (error)
//
//        {
//
//            NSLog(@"Unexpected login error: %@", error);
//
//            NSString *alertMessage = error.userInfo[FBSDKErrorLocalizedDescriptionKey] ?: @"There was a problem logging in. Please try again later.";
//
//            NSString *alertTitle = error.userInfo[FBSDKErrorLocalizedTitleKey] ?: @"Oops";
//
//            [[[UIAlertView alloc] initWithTitle:alertTitle
//
//                                        message:alertMessage
//
//                                       delegate:nil
//
//                              cancelButtonTitle:@"OK"
//
//                              otherButtonTitles:nil] show];
//
//        }
//
//        else
//
//        {
//
//            if(result.token)   // This means if There is current access token.
//
//            {
//
//
//
//                [[[FBSDKGraphRequest alloc] initWithGraphPath:@"me"
//
//                                                   parameters:@{@"fields": @"picture, name, email"}]
//
//                 startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id userinfo, NSError *error) {
//
//                     if (!error) {
//
//
//
//
//
//                         dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0ul);
//
//                         dispatch_async(queue, ^(void) {
//
//
//
//                             dispatch_async(dispatch_get_main_queue(), ^{
//
//
//
//                                 NSArray *name = [userinfo valueForKey:@"name"];
//
//                                 NSString *email = [userinfo valueForKey:@"email"];
//
//                                 NSString *fbId= [ userinfo valueForKey:@"id"];
//
//                                 NSString *picture=[userinfo valueForKey:@"picture"];
//
//                                 NSArray *data=[picture valueForKey:@"data"];
//
//
//
//                                 NSString *url=[data valueForKey:@"url"];
//
//
//
//                                 NSLog(@"url %@",url);
//
//
//
//                                 NSLog(@"fbid %@",fbId);
//
//
//
//                                 [[NSUserDefaults standardUserDefaults]setObject:name forKey:@"facebookName"];
//
//
//
//                                 [[NSUserDefaults standardUserDefaults]setObject:email forKey:@"email"];
//
//
//
//                                 [[NSUserDefaults standardUserDefaults]setObject:fbId forKey:@"fbid"];
//
//
//
//                                 [[NSUserDefaults standardUserDefaults]setObject:url forKey:@"fbUrl"];
//
//
//
//                                 [[NSUserDefaults standardUserDefaults]synchronize];
//
//
//
//
////
////                                 [self callFbLoginAthleteApi];
////
//
//
//
//
//
//
//                                 //    [self callFbLoginApi];
//
//
//
//                             });
//
//                         });
//
//
//
//                     }
//
//                     else{
//
//
//
//                         NSLog(@"%@", [error localizedDescription]);
//
//                     }
//
//                 }];
//
//            }
//
//            NSLog(@"Login Cancel");
//
//
//
//
//
//        }
//
//    }];
//}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)studentBtnTap:(id)sender {
    
     UserRole =@"0";
    UIStoryboard *obj=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *str=[obj instantiateViewControllerWithIdentifier:@"ViewControllerVerify"];
    [self.navigationController pushViewController:str animated:true];
    
}
- (IBAction)promoterBtnTap:(id)sender {
    
    UserRole =@"1";
    
    UIStoryboard *obj=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *str=[obj instantiateViewControllerWithIdentifier:@"ViewControllerVerify"];
    [self.navigationController pushViewController:str animated:true];
}

- (IBAction)OpenRoleView:(id)sender
{
  
        UIStoryboard *obj=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
        UIViewController *str=[obj instantiateViewControllerWithIdentifier:@"ViewControllerVerify"];
        [self.navigationController pushViewController:str animated:true];
   
}
-(void)viewWillDisappear:(BOOL)animated
{
    _ChooseRoleView.hidden=YES;
    _PurpLeBlurView.hidden=YES;
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event  {
    NSLog(@"touches began");
    UITouch *touch = [touches anyObject];
    if(touch.view==_PurpLeBlurView)
    {
        _ChooseRoleView.hidden=YES;
        _PurpLeBlurView.hidden=YES;
    }
}

- (IBAction)LoginBtTapped:(id)sender
{
    Validation *get = [[Validation alloc]init];
    
//      let validation:Validation = Validation.validationManager() as! Validation
    
if(!([get validateBlankField:_emailTxt.text]))
    
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
                                     message:@"Add the Password"
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
         [self loginBtnTapped];
    }
   
  
}

-(void) loginBtnTapped
{
    
     NSURLSession *session = [NSURLSession sharedSession];
    NSString *URL = [NSString stringWithFormat:@"http://18.188.52.230/unights/public/api/login"];
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
    NSString *getRole;
    if ([UserRole  isEqual: @"0"]) {
        getRole = @"3";
    }
    else
    {
        getRole = @"2";
    }

    NSString *param=[NSString stringWithFormat:@"email=%@&password=%@&role=%@",self.emailTxt.text,_passwordTxt.text,getRole];
    
    

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

-(void) loginFb
{
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSString *URL = [NSString stringWithFormat:@"http://18.188.52.230/unights/public/api/facebook-login"];
    NSURL *theURL = [NSURL URLWithString:URL];
    NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:theURL cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:30.0f];
    [theRequest setHTTPMethod:@"POST"];
   
//    name, email, facebook_id, role (latitude, longitude not mandatory)
    
    NSString *param=[NSString stringWithFormat:@"name=%@&email=%@&facebook_id=%@&role=%@",nameFb,emailFb,facebook_id,@"3"];
    
    
    
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



@end
