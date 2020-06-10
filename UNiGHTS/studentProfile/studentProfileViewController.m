//
//  studentProfileViewController.m
//  UNiGHTS
//
//  Created by user on 8/6/18.
//  Copyright © 2018 RVTechnologies Softwares PVT. LTD. All rights reserved.
//

#import "studentProfileViewController.h"
#import "SVProgressHUD.h"
#import "UIImageView+WebCache.h"
@interface studentProfileViewController ()

@end

@implementation studentProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self getProfileInfo];
    _imgStudent.layer.cornerRadius = self.imgStudent.frame.size.height / 2;
    _imgStudent.clipsToBounds = true;
    // Do any additional setup after loading the view.
}
- (IBAction)BACKBTN:(id)sender {
    [self.navigationController popViewControllerAnimated:true];
}
- (IBAction)saveBtnTap:(id)sender {
    
    if([_nameTxt.text  isEqual: @""])
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
    else if([_lastname.text  isEqual: @""])
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
    else if([_universityTxt.text  isEqual: @""])
    {
        UIAlertController * alert = [UIAlertController
                                     alertControllerWithTitle:@"UNiGHTS"
                                     message:@"Add the name of your university"
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
        [self editPromoterProfile];
    }
}

-(void) editPromoterProfile
{
    NSURLSession *session = [NSURLSession sharedSession];
    [SVProgressHUD showWithStatus:@"Please Wait..." maskType:SVProgressHUDMaskTypeBlack];
    
    NSMutableDictionary*aParametersDic;
    
    
    
    NSMutableDictionary*aImageDic;
    
    
    
    
    
    NSURL *url = [NSURL URLWithString:@"http://18.188.52.230/unights/public/api/update-profile"];
    
    
    
    NSMutableURLRequest *request= [[NSMutableURLRequest alloc] initWithURL:url] ;
    
    
    
    aParametersDic = [[NSMutableDictionary alloc] init];
    
    
    NSString * barrer_token=@"Bearer ";
    NSString * Token=  [[NSUserDefaults standardUserDefaults]objectForKey:@"acessToken"];
    
    
    
    
    if(Token.length>0)
        
        
        
    {
        
        
        
        NSString * barrer_token=@"Bearer ";
        
        
        
        barrer_token=[barrer_token stringByAppendingString:Token];
        
        
        
        [request setValue:barrer_token forHTTPHeaderField:@"Authorization"];
        
        
        
        NSString * barrer_token2=@"application/json";
        
        
        
        [request setValue:barrer_token2 forHTTPHeaderField:@"Accept"];
        
        
        
    }
    
    
    
    [aParametersDic setObject:_nameTxt.text forKey:@"name"];
    
    
      [aParametersDic setObject:_lastname.text forKey:@"last_name"];
    
    [aParametersDic setObject:_emailTxt.text forKey:@"email"];
    
        [aParametersDic setObject:_universityTxt.text forKey:@"university"];
    
    [request setURL:url];
    
    
    
    aImageDic = [[NSMutableDictionary alloc]init];
    
    
    CGFloat scaleSize = 0.2f;
    
    UIImage *smallImage = [UIImage imageWithCGImage:_imgStudent.image.CGImage
                           
                           
                           
                                              scale:scaleSize
                           
                           
                           
                                        orientation:_imgStudent.image.imageOrientation];
    
    
    
    
    
    
    
    NSData *imageData = UIImageJPEGRepresentation(smallImage, 0.035);
    
    
    
    
    
    
    
    if(imageData)
        
    {
        
        
        
        [aImageDic setObject:imageData forKey:[NSString stringWithFormat:@"image%d.jpg",0]];
        
        
        
    }
    
    
    
    [request setURL:url];
    
    
    
    [request setHTTPMethod:@"POST"];
    
    
    
    NSString *boundary = @"---------------------------14737809831466499882746641449";
    
    
    
    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@",boundary];
    
    
    
    [request addValue:contentType forHTTPHeaderField: @"Content-Type"];
    
    
    
    NSMutableData *postbody = [NSMutableData data];
    
    
    
    NSString *postData = [self getHTTPBodyParamsFromDictionary:aParametersDic boundary:boundary];
    
    
    
    [postbody appendData:[postData dataUsingEncoding:NSUTF8StringEncoding]];
    
    
    
    [aImageDic enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        
        
        
        if(obj != nil)
            
            
            
        {
            
            [postbody appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
            
            
            
            [postbody appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"profile_image\"; filetype=\"image/png\"; filename=\"%@\"\r\n", key] dataUsingEncoding:NSUTF8StringEncoding]];
            
            
            
            [postbody appendData:[@"Content-Type: image/jpeg\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
            
            
            
            [postbody appendData:[NSData dataWithData:obj]];
            
            
            
        }
        
        
        
    }];
    
    
    
    [postbody appendData:[[NSString stringWithFormat:@"\r\n--%@--\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    
    
    
    [request setHTTPBody:postbody];
    
    
     NSURLSessionDataTask * task=  [session dataTaskWithRequest:request completionHandler:^(NSData *  data, NSURLResponse * response, NSError *  error) {
                               
                               
                               
                               if(response != nil){
                                   
                                   
                                   
                                   NSHTTPURLResponse* httpResponse = (NSHTTPURLResponse*)response;
                                   
                                   if ([httpResponse statusCode] == 200) {
                                       
                                       
                                       
                                       dispatch_async(dispatch_get_main_queue(), ^{
                                           
                                           [SVProgressHUD dismiss];
                                       });
                                       
                                       
                                       
                                       
                                       
                                       
                                       
                                       NSDictionary *result = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
                                       
                                       NSLog(@"%@",result);
                                       
                                       NSString * getSuccess;
                                       
                                       getSuccess = [NSString stringWithFormat:@"%@",[result valueForKey:@"success"]];
                                       
                                       if([getSuccess  isEqual: @"1"])
                                       {
                                           
                                           NSDictionary *userData = [result valueForKey:@"user"];
                                           NSString *imageProfile = [NSString stringWithFormat:@"%@",[userData valueForKey:@"profile_image"]];
                                           
                                           [NSUserDefaults.standardUserDefaults setValue:imageProfile forKey:@"imageProfile"];
                                           NSString *nameMAn = [NSString stringWithFormat:@"%@",[userData valueForKey:@"name"]];
                                           
                                           [NSUserDefaults.standardUserDefaults setValue:nameMAn forKey:@"nameUser"];
                                           UIAlertController * alert=[UIAlertController
                                                                      
                                                                      alertControllerWithTitle:@"UNiGHTS" message:@"Profile Updated Successfully" preferredStyle:UIAlertControllerStyleAlert];
                                           
                                           UIAlertAction* yesButton = [UIAlertAction
                                                                       
                                                                       actionWithTitle:@"OK"
                                                                       
                                                                       style:UIAlertActionStyleDefault
                                                                       
                                                                       handler:^(UIAlertAction * action)
                                                                       
                                                                       {
                                                                           
                                                                           
                                                                           UIStoryboard *obj=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
                                                                           UIViewController *str=[obj instantiateViewControllerWithIdentifier:@"SwRevelController"];
                                                                           [self.navigationController pushViewController:str animated:true];
                                                                           
                                                                       }];
                                           
                                           
                                           
                                           [alert addAction:yesButton];
                                           
                                           [self presentViewController:alert animated:YES completion:nil];
                                       }
                                       else
                                       {
                                           
                                           NSString *getMsg = [result valueForKey:@"error"];
                                           UIAlertController * alert=[UIAlertController
                                                                      
                                                                      alertControllerWithTitle:@"UNiGHTS" message:getMsg preferredStyle:UIAlertControllerStyleAlert];
                                           
                                           UIAlertAction* yesButton = [UIAlertAction
                                                                       
                                                                       actionWithTitle:@"Ok"
                                                                       
                                                                       style:UIAlertActionStyleDefault
                                                                       
                                                                       handler:^(UIAlertAction * action)
                                                                       
                                                                       {
                                                                           
                                                                           
                                                                           
                                                                       }];
                                           
                                           
                                           
                                           [alert addAction:yesButton];
                                           
                                           [self presentViewController:alert animated:YES completion:nil];
                                       }
                                       
                                       
                                       
                                       
                                   }
                                   
                                   
                                   
                               }
                               
                               else
                                   
                               {
                                   
                                   UIAlertController * alert=[UIAlertController
                                                              
                                                              alertControllerWithTitle:@"Message!" message:@"Something went wrong" preferredStyle:UIAlertControllerStyleAlert];
                                   
                                   UIAlertAction* yesButton = [UIAlertAction
                                                               
                                                               actionWithTitle:@"Ok"
                                                               
                                                               style:UIAlertActionStyleDefault
                                                               
                                                               handler:^(UIAlertAction * action)
                                                               
                                                               {
                                                                   
                                                                   
                                                                   
                                                               }];
                                   
                                   
                                   
                                   [alert addAction:yesButton];
                                   
                                   [self presentViewController:alert animated:YES completion:nil];
                                   
                               }
                               
                               
                           }];
    [task resume];
}
-(NSString *) getHTTPBodyParamsFromDictionary: (NSDictionary *)params boundary:(NSString *)boundary

{
    
    NSMutableString *tempVal = [[NSMutableString alloc] init];
    
    for(NSString * key in params)
        
    {
        
        [tempVal appendFormat:@"\r\n--%@\r\n", boundary];
        
        [tempVal appendFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n%@",key,[params objectForKey:key]];
        
    }
    
    return [tempVal description];
    
}
-(void) getProfileInfo
{
    NSURLSession *session = [NSURLSession sharedSession];
    [SVProgressHUD showWithStatus:@"Please wait.." maskType:SVProgressHUDMaskTypeBlack];
    
    
    NSString *URL = @"http://18.188.52.230/unights/public/api/get-profile";
    
    
    
    NSURL *theURL = [NSURL URLWithString:URL];
    
    NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:theURL cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:30.0f];
    
    
    
    NSString *strBearer =@"Bearer ";
    NSString *strAccessToken =  [[NSUserDefaults standardUserDefaults]objectForKey:@"acessToken"];
    [theRequest setHTTPMethod:@"GET"];
    
    [theRequest setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    
    [theRequest setValue:[strBearer stringByAppendingString:strAccessToken] forHTTPHeaderField:@"Authorization"];
    
    [theRequest setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    
    
    
  NSURLSessionDataTask * task=  [session dataTaskWithRequest:theRequest completionHandler:^(NSData *  data, NSURLResponse * response, NSError *  error) {
        
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
                
                //  getdata=[json objectForKey:@"data"];
                NSDictionary *getData = [json valueForKey:@"data"];
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                   
                _nameTxt.text = [getData valueForKey:@"name"];
                if(!([[getData valueForKey:@"last_name"] isKindOfClass:[NSNull class]]))
                {
                      _lastname.text = [getData valueForKey:@"last_name"];
                }
             
                _emailTxt.text = [getData valueForKey:@"email"];
                if(!([[getData valueForKey:@"university"] isKindOfClass:[NSNull class]]))
                {
                     _universityTxt.text = [getData valueForKey:@"university"];
                }
                
                if(!([[getData valueForKey:@"profile_image"] isKindOfClass:[NSNull class]]))
                {
                    NSString *getProfileImg = [getData valueForKey:@"profile_image"];
                    NSString *getLinkImage = @"http://18.188.52.230/unights/public/profile/";
                    
                    NSString * getFInalImg = [getLinkImage stringByAppendingString:getProfileImg];
                    
                    
                    [_imgStudent sd_setImageWithURL:[NSURL URLWithString:getFInalImg]];
                    //                    _profileImg.image.sd_setImageWithURL:[NSURL URLWithString:getFInalImg]
                    
                }
                else
                {
                    _imgStudent.image = [UIImage imageNamed:@"Logo_Image.png"];
                    
                }
                
                
                
             
                    [SVProgressHUD dismiss];
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
- (IBAction)profileImBtnTap:(id)sender {
    
    UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:@"UNiGHTS" message:@"Choose one option" preferredStyle:UIAlertControllerStyleActionSheet];
    
    [actionSheet addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        
        // Cancel button tappped.
        [self dismissViewControllerAnimated:YES completion:^{
        }];
    }]];
    
    [actionSheet addAction:[UIAlertAction actionWithTitle:@"Photo" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        picker.allowsEditing = YES;
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        [self presentViewController:picker animated:YES completion:nil];
        // Distructive button tapped.
        
    }]];
    
    [actionSheet addAction:[UIAlertAction actionWithTitle:@"Camera" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        picker.allowsEditing = YES;
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        [self presentViewController:picker animated:YES completion:nil];
        // OK button tapped.
        
    }]];
    // Present action sheet.
    [self presentViewController:actionSheet animated:YES completion:nil];
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    // output image
    UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
    
    self.imgStudent.image = chosenImage;
    
    [picker dismissViewControllerAnimated:YES completion:nil];
    
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
