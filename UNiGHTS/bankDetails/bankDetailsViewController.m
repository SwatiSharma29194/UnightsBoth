//
//  bankDetailsViewController.m
//  UNiGHTS
//
//  Created by user on 8/20/18.
//  Copyright © 2018 RVTechnologies Softwares PVT. LTD. All rights reserved.
//

#import "bankDetailsViewController.h"
#import "SVProgressHUD.h"
#import "ViewControllerAddEvents.h"
#import "UIImageView+WebCache.h"
@interface bankDetailsViewController ()
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView2;

@end

@implementation bankDetailsViewController
{
    UIDatePicker *myPickerView;
    UIView *selectView;
    UIButton *btn_cancel;
    NSString *getBD;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    _scrollView.contentSize = CGSizeMake(self.view.frame.size.width, 1200);
    [self getbankDetails];
    
    // Do any additional setup after loading the view.
}
- (IBAction)backBtn:(id)sender {
    
    [self.navigationController popViewControllerAnimated:true];
}

-(void) showPicker
{
    
    [myPickerView removeFromSuperview];
    [selectView removeFromSuperview];
    myPickerView = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height-200, self.view.frame.size.width,200)];
    NSDate *currentDate = [NSDate date];
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *comps = [[NSDateComponents alloc] init];

   myPickerView.maximumDate = [calendar dateByAddingComponents:comps toDate:currentDate options:0];

        myPickerView.datePickerMode = UIDatePickerModeDate;
    
    
   
    
    myPickerView.backgroundColor = [UIColor whiteColor];
    [myPickerView addTarget:self action:@selector(pickerChanged:) forControlEvents:UIControlEventValueChanged];
    
    [self.view addSubview:myPickerView];
    
    selectView = [[UIView alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height-220, self.view.frame.size.width, 44)];
    selectView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.view addSubview:selectView];
    
    btn_cancel = [[UIButton alloc] initWithFrame:CGRectMake(10, 0, 70, 45)];
    [btn_cancel setTitle:@"Cancel" forState:UIControlStateNormal];
    [btn_cancel setTitleColor:[UIColor colorWithRed:(46/255.0f) green:(123/255.0f) blue:(185/255.0f) alpha:(1.0f)] forState:UIControlStateNormal];
    [btn_cancel addTarget:self action:@selector(canceldate) forControlEvents:UIControlEventTouchUpInside];
    [selectView addSubview:btn_cancel];
    
    UIButton *btn_save = [[UIButton alloc] initWithFrame:CGRectMake(self.view.frame.size.width - 70, 0, 50, 45)];
    [btn_save setTitle:@"Done" forState:UIControlStateNormal];
    [btn_save setTitleColor:[UIColor colorWithRed:(46/255.0f) green:(123/255.0f) blue:(185/255.0f) alpha:(1.0f)] forState:UIControlStateNormal];
    [btn_save addTarget:self action:@selector(ShowSelectedDate) forControlEvents:UIControlEventTouchUpInside];
    [selectView addSubview:btn_save];
   
}

- (void)pickerChanged:(id)sender
{
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    UILabel *myLabel = [[UILabel alloc]initWithFrame:CGRectMake(50, 300, 200, 200)];
        df.dateFormat = @"yyyy-MM-dd";
        self.bankDob.text = [df stringFromDate:[sender date]];
    
}


- (void)ShowSelectedDate
{
    [myPickerView removeFromSuperview];
    [selectView removeFromSuperview];
    NSLog(@"print");
}
- (void)canceldate
{
    [myPickerView removeFromSuperview];
    [selectView removeFromSuperview];
    
    
        self.bankDob.text = @"";
        
    
}
- (IBAction)uploadImage:(id)sender {
   
    UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:@"UNiGHTS" message:@"Choose one option" preferredStyle:UIAlertControllerStyleActionSheet];
    
    [actionSheet addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        
        // Cancel button tappped.
        [self dismissViewControllerAnimated:YES completion:^{
        }];
    }]];
    
    [actionSheet addAction:[UIAlertAction actionWithTitle:@"Library" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
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
    //    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    //    picker.delegate = self;
    //    picker.allowsEditing = YES;
    //    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    //    [self presentViewController:picker animated:YES completion:nil];
}


- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    // output image
    UIImage *chosenImage = info[UIImagePickerControllerEditedImage];

        self.idProofImg.image = chosenImage;
    
    
    [picker dismissViewControllerAnimated:YES completion:nil];
    
}

- (IBAction)datedob:(id)sender {
    
   
    [self showPicker];
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
- (IBAction)deleteBtnTap:(id)sender {
    [self deleteBankDetail];
}

-(void) getbankDetails
{
    NSURLSession *session = [NSURLSession sharedSession];
    dispatch_async(dispatch_get_main_queue(), ^{
        
        [SVProgressHUD showWithStatus:@"Please wait.." maskType:SVProgressHUDMaskTypeBlack];
    });
    
    
    
    NSString *URL = @"http://18.188.52.230/unights/public/api/get-account-details";
    
    
    
    NSURL *theURL = [NSURL URLWithString:URL];
    
    NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:theURL cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:30.0f];
    
    
    
    NSString *strBearer =@"Bearer ";
    NSString *strAccessToken =  [[NSUserDefaults standardUserDefaults]objectForKey:@"acessToken"];
    [theRequest setHTTPMethod:@"GET"];
    
    [theRequest setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    
    [theRequest setValue:[strBearer stringByAppendingString:strAccessToken] forHTTPHeaderField:@"Authorization"];
    
    [theRequest setValue:@"application/json" forHTTPHeaderField:@"Accept"];
      NSURLSessionDataTask * task=  [session dataTaskWithRequest:theRequest completionHandler:^(NSData *  data, NSURLResponse * response, NSError *  error) {
    
    
    //[NSURLConnection sendAsynchronousRequest:theRequest queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        
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
                
            
                _deleteBtn.hidden = NO;
                getBD = @"1";
                _bankEmail.userInteractionEnabled = NO;
                _bankFirstName.userInteractionEnabled = NO;
                _bankLastName.userInteractionEnabled = NO;
                _bankaccountholdername.userInteractionEnabled = NO;
                _bankaccountNumber.userInteractionEnabled = NO;
                _bankRoutingNumber.userInteractionEnabled = NO;
                _bankDob.userInteractionEnabled = NO;
                
                _bankline1.userInteractionEnabled = NO;
                
               
                _postalcodetxt.userInteractionEnabled = NO;
                _idPrrofBtn.userInteractionEnabled = NO;
                _dobBtn.userInteractionEnabled = NO;
                
                NSLog(@"%@",json);
                
                
                NSDictionary *getData = [json valueForKey:@"data"];
                
                
                
                if(!([[getData valueForKey:@"email"] isKindOfClass:[NSNull class]]))
                {
                    NSString *name = [getData valueForKey:@"email"];
                    _bankEmail.text = name;
                    
                    
                }
                else
                {
                    _bankEmail.text = @"";
                    
                }
                NSString *getIdPrrof = [NSString stringWithFormat:@"%@",[json valueForKey:@"idproof"]];
                [_idProofImg sd_setImageWithURL:[NSURL URLWithString:getIdPrrof]];
                
                NSDictionary *getN = [json valueForKey:@"data"];
                NSDictionary *legal_entity = [getN valueForKey:@"legal_entity"];
                NSDictionary *verification = [legal_entity valueForKey:@"verification"];
                NSDictionary *personal_address = [legal_entity valueForKey:@"address"];
                NSDictionary *dob = [legal_entity valueForKey:@"dob"];
                NSString *status = [verification valueForKey:@"status"];
                
                if(!([[legal_entity valueForKey:@"first_name"] isKindOfClass:[NSNull class]]))
                {
                    NSString *name = [legal_entity valueForKey:@"first_name"];
                    _bankFirstName.text = name;
                    
                    
                }
                else
                {
                    _bankFirstName.text = @"";
                    
                }
                
                if(!([[legal_entity valueForKey:@"last_name"] isKindOfClass:[NSNull class]]))
                {
                    NSString *name = [legal_entity valueForKey:@"last_name"];
                    _bankLastName.text = name;
                    
                    
                }
                else
                {
                    _bankLastName.text = @"";
                    
                }
                
                if(!([[personal_address valueForKey:@"line1"] isKindOfClass:[NSNull class]]))
                {
                    NSString *name = [personal_address valueForKey:@"line1"];
                    _bankline1.text = name;
                    
                    
                }
                else
                {
                    _bankline1.text = @"";
                    
                }
                
                if(!([[personal_address valueForKey:@"postal_code"] isKindOfClass:[NSNull class]]))
                {
                    NSString *name = [personal_address valueForKey:@"postal_code"];
                    _postalcodetxt.text = name;
                    
                    
                }
                else
                {
                    _postalcodetxt.text = @"";
                    
                }
                
                NSString *getDate;
                NSString *getmonth;
                NSString *getyear;
                if(!([[dob valueForKey:@"day"] isKindOfClass:[NSNull class]]))
                {
                    getDate = [dob valueForKey:@"day"];
                    
                    
                    
                }
                else
                {
                    getDate = @"";
                    
                }
                if(!([[dob valueForKey:@"month"] isKindOfClass:[NSNull class]]))
                {
                    getmonth = [dob valueForKey:@"month"];
                    
                    
                    
                }
                else
                {
                    getmonth = @"";
                    
                }
                if(!([[dob valueForKey:@"year"] isKindOfClass:[NSNull class]]))
                {
                    getyear = [dob valueForKey:@"year"];
                    
                    
                    
                }
                else
                {
                    getyear = @"";
                    
                }
                NSString *getDOB = [NSString stringWithFormat:@"%@%@%@%@%@",getyear,@"-",getmonth,@"-",getDate];
                _bankDob.text = getDOB;
                
                
                //                if([status  isEqual: @"verified"])
                //                {
                //                    self.viewBank.hidden = NO;
                //                }
                //                else
                //                {
                //                    UIAlertController * alert=[UIAlertController
                //
                //                                               alertControllerWithTitle:@"Message!" message:@"Your bank account is not verified . Please wait until it is verified" preferredStyle:UIAlertControllerStyleAlert];
                //
                //                    UIAlertAction* yesButton = [UIAlertAction
                //
                //                                                actionWithTitle:@"Ok"
                //
                //                                                style:UIAlertActionStyleDefault
                //
                //                                                handler:^(UIAlertAction * action)
                //
                //                                                {
                //
                //
                //
                //                                                }];
                //
                //
                //
                //                    [alert addAction:yesButton];
                //
                //                    [self presentViewController:alert animated:YES completion:nil];
                //                }
                NSDictionary *external_accounts = [getN valueForKey:@"external_accounts"];
                NSArray *getAccount = [external_accounts valueForKey:@"data"];
                NSDictionary * getDict = [getAccount objectAtIndex:0];
                _bankaccountholdername.text = [getDict valueForKey:@"account_holder_name"];
                _bankRoutingNumber.text = [getDict valueForKey:@"routing_number"];
                _bankaccountNumber.text = @"*************";
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    [SVProgressHUD dismiss];
                });
                
            }
            
            else
            {
                getBD = @"2";
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    [SVProgressHUD dismiss];
               
                _deleteBtn.hidden = YES;
              
                _bankEmail.userInteractionEnabled = YES;
                _bankFirstName.userInteractionEnabled = YES;
                _bankLastName.userInteractionEnabled = YES;
                _bankaccountholdername.userInteractionEnabled = YES;
                _bankaccountNumber.userInteractionEnabled = YES;
                _bankRoutingNumber.userInteractionEnabled = YES;
                _bankDob.userInteractionEnabled = YES;
                
                _bankline1.userInteractionEnabled = YES;
                
              
                _postalcodetxt.userInteractionEnabled = YES;
                _idPrrofBtn.userInteractionEnabled = YES;
                _dobBtn.userInteractionEnabled = YES;
                     });
            }
            
            //  NSLog(@"%@",user_name_array_mymatches);
            
            //   NSLog(@"%@",user_phone_array_mymatches);
            
            
            
            
            
            
        }
        else
            
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [SVProgressHUD dismiss];
            });
            
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
            
            // no internet
            
        }
        
    }];
    [task resume];
}

-(void) deleteBankDetail
{
    NSURLSession *session = [NSURLSession sharedSession];
    dispatch_async(dispatch_get_main_queue(), ^{
        
      [SVProgressHUD showWithStatus:@"Please wait.." maskType:SVProgressHUDMaskTypeBlack];
    });
    
    
    
    NSString *URL = @"http://18.188.52.230/unights/public/api/delete-account";
    
    
    
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
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                   [SVProgressHUD dismiss];
                });
                UIAlertController * alert=[UIAlertController
                                           
                                           alertControllerWithTitle:@"Message!" message:@"Account deleted successfully" preferredStyle:UIAlertControllerStyleAlert];
                
                UIAlertAction* yesButton = [UIAlertAction
                                            
                                            actionWithTitle:@"Ok"
                                            
                                            style:UIAlertActionStyleDefault
                                            
                                            handler:^(UIAlertAction * action)
                                            
                                            {
                                                 getBD = @"2";
                                                _bankFirstName.text = @"";
                                                _bankLastName.text = @"";
                                                _bankaccountholdername.text = @"";
                                                _bankaccountNumber.text = @"";
                                                _bankRoutingNumber.text = @"";
                                                _bankDob.text = @"";
                          
                                                _bankline1.text = @"";
                                                
                                                _postalcodetxt.text = @"";
                                                _bankEmail.text = @"";
                                                
                                                _idProofImg.image = [UIImage imageNamed:@"idproof.png"];
                                                _bankEmail.userInteractionEnabled = YES;
                                                _bankFirstName.userInteractionEnabled = YES;
                                                _bankLastName.userInteractionEnabled = YES;
                                                _bankaccountholdername.userInteractionEnabled = YES;
                                                _bankaccountNumber.userInteractionEnabled = YES;
                                                _bankRoutingNumber.userInteractionEnabled = YES;
                                                _bankDob.userInteractionEnabled = YES;
                                                
                                                _bankline1.userInteractionEnabled = YES;
                               
                                   _postalcodetxt.userInteractionEnabled = YES;
                                                _idPrrofBtn.userInteractionEnabled = YES;
                                                _dobBtn.userInteractionEnabled = YES;
                                                
                                                
                                                
                                                
                                                
                                            }];
                
                
                
                [alert addAction:yesButton];
                
                [self presentViewController:alert animated:YES completion:nil];
            }
            
            else
            {
                
            }
            
            //  NSLog(@"%@",user_name_array_mymatches);
            
            //   NSLog(@"%@",user_phone_array_mymatches);
            
            
            
            
            
            
        }
        else
            
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [SVProgressHUD dismiss];
            });
            
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
            
            // no internet
            
        }
        
    }];
    
    [task resume];
}

-(void) addBankDetails
{
    NSURLSession *session = [NSURLSession sharedSession];
    dispatch_async(dispatch_get_main_queue(), ^{
        
        [SVProgressHUD showWithStatus:@"Please Wait..." maskType:SVProgressHUDMaskTypeBlack];
    });
   
    
    NSMutableDictionary*aParametersDic;
    
    
    
    NSMutableDictionary*aImageDic;
    
    
    
    
    
    NSURL *url = [NSURL URLWithString:@"http://18.188.52.230/unights/public/api/add-account"];
    
    
    
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
    
    
    
    [aParametersDic setObject:_bankFirstName.text forKey:@"first_name"];
    
    
    [aParametersDic setObject:_bankLastName.text forKey:@"last_name"];
    [aParametersDic setObject:_bankEmail.text forKey:@"email"];
    
    
    [aParametersDic setObject:_bankaccountholdername.text forKey:@"account_holder_name"];
    
    [aParametersDic setObject:_bankaccountNumber.text forKey:@"account_number"];
    
    
    
    [aParametersDic setObject:_bankRoutingNumber.text forKey:@"routing_number"];
    
    
    
    [aParametersDic setObject:_bankDob.text forKey:@"dob"];
    
    
    
    [aParametersDic setObject:@"" forKey:@"address"];
    
    
    
    [aParametersDic setObject:@"" forKey:@"ssn"];
    
    
    
    [aParametersDic setObject:@"" forKey:@"city"];
    
    
    [aParametersDic setObject:_bankline1.text forKey:@"line1"];
    
    
    
    [aParametersDic setObject:_postalcodetxt.text forKey:@"postal_code"];
    
    
    
    [aParametersDic setObject:@"" forKey:@"state"];
    
    
    
    [aParametersDic setObject:@"" forKey:@"line2"];
    
    [request setURL:url];
    
    
    
    aImageDic = [[NSMutableDictionary alloc]init];
    
    
    CGFloat scaleSize = 0.2f;
    
    UIImage *smallImage = [UIImage imageWithCGImage:_idProofImg.image.CGImage
                           
                           
                           
                                              scale:scaleSize
                           
                           
                           
                                        orientation:_idProofImg.image.imageOrientation];
    
    
    
    
    
    
    
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
            
            
            
            [postbody appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"idproof\"; filetype=\"image/png\"; filename=\"%@\"\r\n", key] dataUsingEncoding:NSUTF8StringEncoding]];
            
            
            
            [postbody appendData:[@"Content-Type: image/jpeg\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
            
            
            
            [postbody appendData:[NSData dataWithData:obj]];
            
            
            
        }
        
        
        
    }];
    
    
    
    [postbody appendData:[[NSString stringWithFormat:@"\r\n--%@--\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    
    
    
    [request setHTTPBody:postbody];
    
    
      NSURLSessionDataTask * task=  [session dataTaskWithRequest:request completionHandler:^(NSData *  data, NSURLResponse * response, NSError *  error) {
//    [NSURLConnection sendAsynchronousRequest:request
//
//
//
//                                       queue:[NSOperationQueue mainQueue]
//
//
//
//                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
          
                               
                               
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
                                     
                                           //                                           [NSUserDefaults.standardUserDefaults setValue:@"pints" forKey:@"stripe_account"];
                                           
                                        
                                           
                                           UIAlertController * alert=[UIAlertController
                                                                      
                                                                      alertControllerWithTitle:@"Message!" message:@"Bank is added" preferredStyle:UIAlertControllerStyleAlert];
                                           
                                           UIAlertAction* yesButton = [UIAlertAction
                                                                       
                                                                       actionWithTitle:@"Ok"
                                                                       
                                                                       style:UIAlertActionStyleDefault
                                                                       
                                                                       handler:^(UIAlertAction * action)
                                                                       
                                                                       {
                                                                     [self.navigationController popViewControllerAnimated:true];
                                                                           
                                                                           
                                                                       }];
                                           
                                           
                                           
                                           [alert addAction:yesButton];
                                           
                                           [self presentViewController:alert animated:YES completion:nil];
                                           
                                           
                                           
                                       }
                                       else
                                       {
                                           NSString *getS = [result valueForKey:@"error"];
                                           UIAlertController * alert=[UIAlertController
                                                                      
                                                                      alertControllerWithTitle:@"Message!" message:getS preferredStyle:UIAlertControllerStyleAlert];
                                           
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
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)addevent2:(id)sender {
    
    if (!([getBD  isEqual: @"1"]))
     {
         
     
    if([_bankFirstName.text  isEqual: @""])
    {
        UIAlertController * alert=[UIAlertController
                                   
                                   alertControllerWithTitle:@"Message!" message:@"Write your first name" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* yesButton = [UIAlertAction
                                    
                                    actionWithTitle:@"Ok"
                                    
                                    style:UIAlertActionStyleDefault
                                    
                                    handler:^(UIAlertAction * action)
                                    
                                    {
                                        
                                        
                                        
                                    }];
        
        
        
        [alert addAction:yesButton];
        
        [self presentViewController:alert animated:YES completion:nil];
        
    }
    else if([_bankLastName.text  isEqual: @""])
    {
        UIAlertController * alert=[UIAlertController
                                   
                                   alertControllerWithTitle:@"Message!" message:@"Add the last name" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* yesButton = [UIAlertAction
                                    
                                    actionWithTitle:@"Ok"
                                    
                                    style:UIAlertActionStyleDefault
                                    
                                    handler:^(UIAlertAction * action)
                                    
                                    {
                                        
                                        
                                        
                                    }];
        
        
        
        [alert addAction:yesButton];
        
        [self presentViewController:alert animated:YES completion:nil];
    }
    else if([_bankEmail.text  isEqual: @""])
    {
        UIAlertController * alert=[UIAlertController
                                   
                                   alertControllerWithTitle:@"Message!" message:@"Add the email" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* yesButton = [UIAlertAction
                                    
                                    actionWithTitle:@"Ok"
                                    
                                    style:UIAlertActionStyleDefault
                                    
                                    handler:^(UIAlertAction * action)
                                    
                                    {
                                        
                                        
                                        
                                    }];
        
        
        
        [alert addAction:yesButton];
        
        [self presentViewController:alert animated:YES completion:nil];
    }
    
    else if([_bankaccountholdername.text  isEqual: @""])
    {
        UIAlertController * alert=[UIAlertController
                                   
                                   alertControllerWithTitle:@"Message!" message:@"Add the name of account holder" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* yesButton = [UIAlertAction
                                    
                                    actionWithTitle:@"Ok"
                                    
                                    style:UIAlertActionStyleDefault
                                    
                                    handler:^(UIAlertAction * action)
                                    
                                    {
                                        
                                        
                                        
                                    }];
        
        
        
        [alert addAction:yesButton];
        
        [self presentViewController:alert animated:YES completion:nil];
    }
    
    else if([_bankaccountNumber.text  isEqual: @""])
    {
        UIAlertController * alert=[UIAlertController
                                   
                                   alertControllerWithTitle:@"Message!" message:@"Add the account number" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* yesButton = [UIAlertAction
                                    
                                    actionWithTitle:@"Ok"
                                    
                                    style:UIAlertActionStyleDefault
                                    
                                    handler:^(UIAlertAction * action)
                                    
                                    {
                                        
                                        
                                        
                                    }];
        
        
        
        [alert addAction:yesButton];
        
        [self presentViewController:alert animated:YES completion:nil];
    }
    
    else if([_bankRoutingNumber.text  isEqual: @""])
    {
        UIAlertController * alert=[UIAlertController
                                   
                                   alertControllerWithTitle:@"Message!" message:@"Add the routing number" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* yesButton = [UIAlertAction
                                    
                                    actionWithTitle:@"Ok"
                                    
                                    style:UIAlertActionStyleDefault
                                    
                                    handler:^(UIAlertAction * action)
                                    
                                    {
                                        
                                        
                                        
                                    }];
        
        
        
        [alert addAction:yesButton];
        
        [self presentViewController:alert animated:YES completion:nil];
    }
    
 
    else if([_bankline1.text  isEqual: @""])
    {
        UIAlertController * alert=[UIAlertController
                                   
                                   alertControllerWithTitle:@"Message!" message:@"Add the line1 of your address" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* yesButton = [UIAlertAction
                                    
                                    actionWithTitle:@"Ok"
                                    
                                    style:UIAlertActionStyleDefault
                                    
                                    handler:^(UIAlertAction * action)
                                    
                                    {
                                        
                                        
                                        
                                    }];
        
        
        
        [alert addAction:yesButton];
        
        [self presentViewController:alert animated:YES completion:nil];
    }
    
 
    else if([_postalcodetxt.text  isEqual: @""])
    {
        UIAlertController * alert=[UIAlertController
                                   
                                   alertControllerWithTitle:@"Message!" message:@"Add the postal code" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* yesButton = [UIAlertAction
                                    
                                    actionWithTitle:@"Ok"
                                    
                                    style:UIAlertActionStyleDefault
                                    
                                    handler:^(UIAlertAction * action)
                                    
                                    {
                                        
                                        
                                        
                                    }];
        
        
        
        [alert addAction:yesButton];
        
        [self presentViewController:alert animated:YES completion:nil];
    }
    
  
    else
    {
        //[self addEvent];
        [self addBankDetails];
    }
    
}
    
    else
    {
        UIAlertController * alert=[UIAlertController
                                   
                                   alertControllerWithTitle:@"Message!" message:@"Delete the previous bank detail first" preferredStyle:UIAlertControllerStyleAlert];
        
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
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
