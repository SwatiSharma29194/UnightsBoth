//
//  paymentViewController.m
//  UNiGHTS
//
//  Created by user on 7/18/18.
//  Copyright © 2018 RVTechnologies Softwares PVT. LTD. All rights reserved.
//

#import "paymentViewController.h"
#import "paymentTableViewCell.h"
#import <Stripe/Stripe.h>
#import "common.h"
#import "SVProgressHUD.h"
#import "webopenViewController.h"
#import <MessageUI/MessageUI.h>

@interface paymentViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    paymentTableViewCell * cell;
    BOOL * paymentbool;
    NSString *tokenValue;
    NSArray *getdata;
    NSString *getcardid;
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation paymentViewController
- (IBAction)changePasswordTap:(id)sender {
    
    UIStoryboard *obj=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *str=[obj instantiateViewControllerWithIdentifier:@"changePassword"];
    [self.navigationController pushViewController:str animated:true];
 
}
-(void) getProfile
{
    if([UserRole isEqualToString:@"0"])
    {
        
        UIStoryboard *obj=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
        UIViewController *str=[obj instantiateViewControllerWithIdentifier:@"studentProfile"];
        [self.navigationController pushViewController:str animated:true];
    }
    else
    {
        
        UIStoryboard *obj=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
        UIViewController *str=[obj instantiateViewControllerWithIdentifier:@"promoterProfile"];
        [self.navigationController pushViewController:str animated:true];
    }
    
}
- (IBAction)editProfileTap:(id)sender {
    
    [self getProfile];
}
- (IBAction)paymentSettingsTap:(id)sender {
    
    _paymentView.hidden = NO;
}
- (IBAction)myDataTap:(id)sender {
    UIStoryboard *obj=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
    webopenViewController *str=[obj instantiateViewControllerWithIdentifier:@"webOpen"];
    [self.navigationController pushViewController:str animated:true];
}
- (IBAction)refundTap:(id)sender {
    
    UIStoryboard *obj=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
    webopenViewController *str=[obj instantiateViewControllerWithIdentifier:@"webOpen"];
    str.getUrl = @"http://unights.co.uk/refunds";
    [self.navigationController pushViewController:str animated:true];
}
- (IBAction)contact:(id)sender {
    
    UIStoryboard *obj=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
    webopenViewController *str=[obj instantiateViewControllerWithIdentifier:@"webOpen"];
    str.getUrl = @"http://unights.co.uk/contact-us";
    [self.navigationController pushViewController:str animated:true];
}
- (IBAction)termsandconditionstap:(id)sender {
    UIStoryboard *obj=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
    webopenViewController *str=[obj instantiateViewControllerWithIdentifier:@"webOpen"];
    str.getUrl = @"http://unights.co.uk/terms-and-conditions";
    [self.navigationController pushViewController:str animated:true];
}
- (IBAction)privacypolicytap:(id)sender {
    UIStoryboard *obj=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
    webopenViewController *str=[obj instantiateViewControllerWithIdentifier:@"webOpen"];
     str.getUrl = @"http://unights.co.uk/privacy-policy";
    [self.navigationController pushViewController:str animated:true];
}
- (IBAction)rateonappstore:(id)sender {
    
  
//        NSString *str = @"itms-apps://ax.itunes.apple.com/WebObjects/MZStore.woa";
//        str = [NSString stringWithFormat:@"%@/wa/viewContentsUserReviews?", str];
//        str = [NSString stringWithFormat:@"%@type=Purple+Software&id=", str];
//
//        // Here is the app id from itunesconnect
//        str = [NSString stringWithFormat:@"%@1434506374", str];
//
    
  [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://itunes.apple.com/us/app/unights/id1435990517?ls=1&mt=8"]];
//       [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"comgooglemaps://?saddr=&daddr=32.3232,23.323&directionsmode=driving"]];
  
}
- (IBAction)instagramtap:(id)sender {
    UIStoryboard *obj=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
    webopenViewController *str=[obj instantiateViewControllerWithIdentifier:@"webOpen"];
     str.getUrl = @"https://www.instagram.com/unightsapp";
    [self.navigationController pushViewController:str animated:true];
}
- (IBAction)facebooklike:(id)sender {
    UIStoryboard *obj=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
    webopenViewController *str=[obj instantiateViewControllerWithIdentifier:@"webOpen"];
     str.getUrl = @"https://m.facebook.com/UnightsApp/";
    [self.navigationController pushViewController:str animated:true];
}
- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error

{
    [self dismissViewControllerAnimated:YES completion:NULL];
}
- (IBAction)foundabug:(id)sender {
    if ([MFMailComposeViewController canSendMail])
    {
        MFMailComposeViewController *mail = [[MFMailComposeViewController alloc] init];
        mail.mailComposeDelegate = self;
        [mail setSubject:@"UNiGHTS"];
        [mail setMessageBody:@"Report a bug" isHTML:NO];
        [mail setToRecipients:@[@"ozdirik2017@gmail.com"]];
        
        [self presentViewController:mail animated:YES completion:NULL];
    }
    else
    {
        NSLog(@"This device cannot send email");
    }
}
- (IBAction)aboutTap:(id)sender {
    UIStoryboard *obj=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
    webopenViewController *str=[obj instantiateViewControllerWithIdentifier:@"webOpen"];
     str.getUrl = @"http://unights.co.uk/";
    [self.navigationController pushViewController:str animated:true];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    if([_FromBooking  isEqual: @"Book"])
    {
        _paymentView.hidden = NO;
         _existBtn.hidden = NO;
        [_addNewCard setTitle:@"  Add new card" forState:UIControlStateNormal];
        
         [_existBtn setTitle:@"  Use Existing cards" forState:UIControlStateNormal];
    }
    else
    {
        _paymentView.hidden = YES;
        if([UserRole isEqualToString:@"0"])
        {
            [_existBtn setTitle:@"  My cards" forState:UIControlStateNormal];
        
            [_addNewCard setTitle:@"  Add new card" forState:UIControlStateNormal];
            _existBtn.hidden = NO;
        }
        else
        {
            _existBtn.hidden = YES;
            [_addNewCard setTitle:@"  Add new bank" forState:UIControlStateNormal];
         
        }

    }
    _tableView.delegate = self;
    _tableView.dataSource = self;
    paymentbool = NO;
//    _paymentSettingsBtn.layer.cornerRadius = _paymentSettingsBtn.frame.size.height / 2;
//    _paymentSettingsBtn.clipsToBounds = true;
//    _paymentSettingsBtn.layer.borderColor = [UIColor whiteColor].CGColor;
//    _paymentSettingsBtn.layer.borderWidth = 2;
//    _changePasswordBtn.layer.cornerRadius = _changePasswordBtn.frame.size.height / 2;
//    _changePasswordBtn.layer.borderColor = [UIColor whiteColor].CGColor;
//    _changePasswordBtn.layer.borderWidth = 2;
//    _changePasswordBtn.clipsToBounds = true;
//    _editProfileBtn.layer.cornerRadius = _editProfileBtn.frame.size.height / 2;
//    _editProfileBtn.layer.borderColor = [UIColor whiteColor].CGColor;
//    _editProfileBtn.layer.borderWidth = 2;
//    _editProfileBtn.clipsToBounds = true;
    // Do any additional setup after loading the view.

//    NSMutableDictionary *getDict;
//    getDict = [[NSMutableDictionary alloc] init];
//    [getDict setObject:@"1" forKey:@"sds"];
//     [getDict setObject:@"2" forKey:@"sds2"];
//    [getDict setObject:@"3" forKey:@"sds3"];
//    NSLog(@"%@",getDict);
    //NSLog(@"%@",ShowArr);
}
- (IBAction)previousCardBtnTap:(id)sender {
    

    if([UserRole isEqualToString:@"0"])
    {
        [self getcards];
    }
    else
    {
        
    }
    
    if(paymentbool == NO)
        
    {
        paymentbool = YES;
        _tableView.hidden = NO;
        
        
    }
    else
    {
        paymentbool = NO;
        _tableView.hidden = YES;
        
    }
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    return getdata.count;
   
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
 
        
        cell=[tableView dequeueReusableCellWithIdentifier:@"paymentCell"];
        if (cell == nil) {
            
            cell=[[paymentTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"paymentCell"];
        }
            NSDictionary *getCardDetails = [getdata objectAtIndex:indexPath.row];
            NSString *getcarddots = @"**********";
            NSString *getcardNumber = [NSString stringWithFormat:@"%@",[getCardDetails valueForKey:@"last4"]];
            NSString *getC = [getcarddots stringByAppendingString:getcardNumber];
            cell.cardNo.text = getC;
            
            NSString *getcardbrand = [NSString stringWithFormat:@"%@",[getCardDetails valueForKey:@"brand"]];
            
            cell.cardType.text = getcardbrand;
    
    
    return cell;
}
-(void) viewWillAppear:(BOOL)animated

{
    //[self getcards];
}
- (IBAction)addnewCardBtnTap:(id)sender {
    if([UserRole isEqualToString:@"0"])
    {
        [self StipepayButton];
    }
    else
    {
        UIStoryboard *obj=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
                            UIViewController *str=[obj instantiateViewControllerWithIdentifier:@"bankDetails"];
                            [self.navigationController pushViewController:str animated:true];
    }
    
    
}

- (IBAction)backBtnTap:(id)sender {
    if(_paymentView.hidden == NO)
    {
        if([_FromBooking  isEqual: @"Book"])
        {
           
            [self.navigationController popViewControllerAnimated:true];
        }
        else
        {
            _paymentView.hidden = YES;
        }
        
     
    }

    else
    {
    [self.navigationController popViewControllerAnimated:true];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if([_FromBooking  isEqual: @"Book"])
    {
    UIAlertController * alert = [UIAlertController
                                 alertControllerWithTitle:@"UNiGHTS"
                                 message:@"Are you sure to use this card"
                                 preferredStyle:UIAlertControllerStyleAlert];
    
    //Add Buttons
    dispatch_async(dispatch_get_main_queue(), ^{
        
        [SVProgressHUD dismiss];
    });
    
    
    UIAlertAction* noButton = [UIAlertAction
                               actionWithTitle:@"NO"
                               style:UIAlertActionStyleDefault
                               handler:^(UIAlertAction * action) {
                                   
                                     [tableView reloadData];
                                   //Handle no, thanks button
                               }];
    
    //Add your buttons to alert controller
    
    
    [alert addAction:noButton];
    
    UIAlertAction* YesButton = [UIAlertAction
                               actionWithTitle:@"YES"
                               style:UIAlertActionStyleDefault
                               handler:^(UIAlertAction * action) {
                                   
                                   NSDictionary *getCardDetails = [getdata objectAtIndex:indexPath.row];
                                   
                                   getcardid = [NSString stringWithFormat:@"%@",[getCardDetails valueForKey:@"id"]];
                                   [[NSUserDefaults standardUserDefaults]setValue:@"" forKey:@"exp_month"];
                                   [[NSUserDefaults standardUserDefaults]setValue:@"" forKey:@"numberCard"];
                                   [[NSUserDefaults standardUserDefaults]setValue:@"" forKey:@"exp_year"];
                                 
                                   [self bookTicketPayment];
                                   //Handle no, thanks button
                               }];
    
    //Add your buttons to alert controller
    
    
    [alert addAction:YesButton];
    
    [self presentViewController:alert animated:YES completion:nil];
    }
    
    else
    {
        
    }
  
    
 
}

-(void) tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)StipepayButton

{
    
    STPAddCardViewController *addCardViewController = [[STPAddCardViewController alloc] init];
    
    addCardViewController.delegate = self;
    
    // STPAddCardViewController must be shown inside a UINavigationController.
    
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:addCardViewController];
    
    
    
    
    
    
    
    [self presentViewController:navigationController animated:YES completion:nil];
    
    
    
}



- (void)addCardViewControllerDidCancel:(STPAddCardViewController *)addCardViewController {
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}



#pragma mark did create token stripe

-(void) getcards
{
    NSURLSession *session = [NSURLSession sharedSession];
    [SVProgressHUD showWithStatus:@"Please wait.." maskType:SVProgressHUDMaskTypeBlack];
    
    
    NSString *URL = @"http://18.188.52.230/unights/public/api/get-card";
    
    
    
    NSURL *theURL = [NSURL URLWithString:URL];
    
    NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:theURL cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:30.0f];
    
    
    
    NSString *strBearer =@"Bearer ";
    NSString *strAccessToken =  [[NSUserDefaults standardUserDefaults]objectForKey:@"acessToken"];
    [theRequest setHTTPMethod:@"GET"];
    
    [theRequest setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    
    [theRequest setValue:[strBearer stringByAppendingString:strAccessToken] forHTTPHeaderField:@"Authorization"];
    
    [theRequest setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    
    NSURLSessionDataTask * task=  [session dataTaskWithRequest:theRequest completionHandler:^(NSData *  data, NSURLResponse * response, NSError *  error) {
    
//    [NSURLConnection sendAsynchronousRequest:theRequest queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
    
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
                
                
              NSDictionary *getDatas = [json valueForKey:@"data"];
                     NSDictionary *getDatas2 = [getDatas valueForKey:@"sources"];
                 getdata=[getDatas2 objectForKey:@"data"];
                
              
                
                
                
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    [_tableView reloadData];
                    
                    [SVProgressHUD dismiss];
                });
            }
            else
            {
                UIAlertController * alert = [UIAlertController
                                             alertControllerWithTitle:@"UNiGHTS"
                                             message:@"No card added. Try it by adding new card"
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
}
- (void)addCardViewController:(STPAddCardViewController *)addCardViewController
              didCreateSource:(STPSource *)source
                   completion:(STPErrorBlock)completion;
{
    NSLog(@"%@",source);
}
- (void)addCardViewController:(STPAddCardViewController *)addCardViewController

               didCreateToken:(STPToken *)token

                   completion:(STPErrorBlock)completion

{
    
    NSLog(@"%@",token);
    
//    tokenValue = token;
    
    NSString *tokenString = [NSString stringWithFormat:@"%@",token];
    tokenValue = tokenString;
    //[[NSString alloc]initWithData:newDeviceToken encoding:NSUTF8StringEncoding];
    if([_FromBooking  isEqual: @"Book"])
    {
         [self  bookTicketPayment];
    }
    
    else
    {
        [self addNewCard];
    }
   
    //[self dismissViewControllerAnimated:YES completion:nil];
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
-(void) bookTicketPayment{
    
    NSURLSession *session = [NSURLSession sharedSession];

    NSString *strtoken  =[[NSUserDefaults standardUserDefaults]objectForKey:@"acessToken"];

    NSString *strBearer = @"Bearer ";

    NSString *URL = @"http://18.188.52.230/unights/public/api/make-payment";

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
//    token, user_id, event_id, qr_code, no_of_ticket, ticket_type(1=> early_bird, 2=>standard, 3=>vip), amount, points
    
    NSString *param;
    NSString *getUserId = [[NSUserDefaults standardUserDefaults]valueForKey:@"ID"];
    NSString *getEventID = [[NSUserDefaults standardUserDefaults]valueForKey:@"getID"];
    
        NSMutableDictionary *getDict;
        getDict = [[NSMutableDictionary alloc] init];
    
        [getDict setObject:_ticketsEarly forKey:@"early_bird_quantity"];
         [getDict setObject:_ticketsStandard forKey:@"standard_equantity"];
        [getDict setObject:_ticketsVIP forKey:@"vip_equantity"];
        NSLog(@"%@",getDict);
    NSInteger a = [_ticketsEarly integerValue];
    NSInteger b = [_ticketsStandard integerValue];
     NSInteger c = [_ticketsVIP integerValue];
    NSInteger getTotal;
    getTotal = a+ b+ c;
//token, user_id, event_id, ticket_quantity(array(0=>early_quantity, 1=> standard_quantity, 2=> vip_quantity)), amount, points, early_bird_tickets,standard_tickets,vip_tickets,total_tickets
    NSDictionary *jsonBodyDict = @{@"early_bird_tickets":_ticketsEarly, @"standard_tickets":_ticketsStandard,@"vip_tickets":_ticketsVIP};
    
    NSError *err;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:jsonBodyDict options:NSJSONWritingPrettyPrinted error:&err];
    
    NSLog(@"JSON = %@", [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding]);
    
    NSString *str = [[NSString alloc]initWithData:jsonData encoding:(NSStringEncoding)NSUTF8StringEncoding];
    NSString *getMonth;
    NSString *getYae;
    NSString *code;
    if(([getcardid isEqualToString:@""] || getcardid == nil))
    {
        
    
    NSString *getcardNo = [[NSUserDefaults standardUserDefaults]valueForKey:@"numberCard"];
    code = [getcardNo substringFromIndex: [getcardNo length] - 4];
    
       NSString *getexpY = [[NSUserDefaults standardUserDefaults]valueForKey:@"exp_year"];
    NSString *getyeard = @"20";
  getYae = [getyeard stringByAppendingString:[NSString stringWithFormat:@"%@",getexpY]];
    NSString *getexpM = [[NSUserDefaults standardUserDefaults]valueForKey:@"exp_month"];
    
    
    if(getexpM.length == 1)
    {
        NSString *getmnthd = @"0";
        getMonth = [getmnthd stringByAppendingString:getexpM];

       
    }
    else
    {
        getMonth = getexpM;
    }
    }
    
    else
    {
        getMonth = @"";
        getYae = @"";
        code = @"";
        tokenValue = @"";
    }
    param = [NSString stringWithFormat:@"token=%@&user_id=%@&event_id=%@&ticket_quantity=%@&amount=%@&points=%@&early_bird_tickets=%@&standard_tickets=%@&vip_tickets=%@&total_tickets=%ld,&last4_card_no=%@,&exp_month=%@,&exp_year=%@,&card_id=%@",tokenValue,getUserId,getEventID,str,_geTotalAmount,_pointsTotal,_ticketsEarly,_ticketsStandard,_ticketsVIP,(long)getTotal,code,getMonth,getYae,getcardid];
//    param=[NSString stringWithFormat:@"token=%@&user_id=%@&event_id=%@&ticket_quantity=%@&amount=%@%@&early_bird_tickets=%@&standard_tickets=%@&vip_tickets=%@&points=%ld&total_tickets=",tokenValue,getUserId,getEventID,[NSString stringWithFormat:@"%@",getDict],_geTotalAmount,_ticketsEarly,_ticketsStandard,_ticketsVIP,@"10",(long)getTotal];

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
                
                
                
             
                // [self.navigationController popViewControllerAnimated:true];
                
                if(([getcardid isEqualToString:@""] || getcardid == nil))
                {

                    [self dismissViewControllerAnimated:YES completion:nil];
//                    UIStoryboard *obj=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
//                    UIViewController *str=[obj instantiateViewControllerWithIdentifier:@"ViewControllerMyTickets"];
//                    [self.navigationController pushViewController:str animated:true];
                    UIAlertController * alert = [UIAlertController
                                                 alertControllerWithTitle:@"UNiGHTS"
                                                 message:@"Payment has been done successfully."
                                                 preferredStyle:UIAlertControllerStyleAlert];

                    //Add Buttons
                    dispatch_async(dispatch_get_main_queue(), ^{

                        [SVProgressHUD dismiss];
                    });


                    UIAlertAction* noButton = [UIAlertAction
                                               actionWithTitle:@"OK"
                                               style:UIAlertActionStyleDefault
                                               handler:^(UIAlertAction * action) {

                                                   UIStoryboard *obj=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
                                                   UIViewController *str=[obj instantiateViewControllerWithIdentifier:@"ViewControllerMyTickets"];
                                                   [self.navigationController pushViewController:str animated:true];
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
                                             message:@"Payment has been done successfully."
                                             preferredStyle:UIAlertControllerStyleAlert];

                //Add Buttons
                dispatch_async(dispatch_get_main_queue(), ^{

                    [SVProgressHUD dismiss];
                });


                UIAlertAction* noButton = [UIAlertAction
                                           actionWithTitle:@"OK"
                                           style:UIAlertActionStyleDefault
                                           handler:^(UIAlertAction * action) {
                                               UIStoryboard *obj=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
                                               UIViewController *str=[obj instantiateViewControllerWithIdentifier:@"ViewControllerMyTickets"];
                                               [self.navigationController pushViewController:str animated:true];
                                              //[self.navigationController popViewControllerAnimated:true];
                                               //Handle no, thanks button
                                           }];

                //Add your buttons to alert controller


                [alert addAction:noButton];

                [self presentViewController:alert animated:YES completion:nil];
                }
                
//
        

            }
            else
            {
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    [SVProgressHUD dismiss];
                });
            }


            //                NSArray *arrdata =[json objectForKey:@"day"];

            //

            //                NSDictionary *dict =[arrdata objectAtIndex:0];





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
-(void) addNewCard
{
    NSURLSession *session = [NSURLSession sharedSession];
    
    NSString *strtoken  =[[NSUserDefaults standardUserDefaults]objectForKey:@"acessToken"];
    
    NSString *strBearer = @"Bearer ";
    
    NSString *URL = @"http://18.188.52.230/unights/public/api/add-card";
    
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
    param = [NSString stringWithFormat:@"stripe_token=%@",tokenValue];
    //    param=[NSString stringWithFormat:@"token=%@&user_id=%@&event_id=%@&ticket_quantity=%@&amount=%@%@&early_bird_tickets=%@&standard_tickets=%@&vip_tickets=%@&points=%ld&total_tickets=",tokenValue,getUserId,getEventID,[NSString stringWithFormat:@"%@",getDict],_geTotalAmount,_ticketsEarly,_ticketsStandard,_ticketsVIP,@"10",(long)getTotal];
    
    NSLog(@"%@",param);
    NSData *postData = [param dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    
    [theRequest setHTTPBody:postData];
    NSURLSessionDataTask * task=  [session dataTaskWithRequest:theRequest completionHandler:^(NSData *  data, NSURLResponse * response, NSError *  error) {
    
//
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
                
              
              
               [self dismissViewControllerAnimated:YES completion:nil];
                
                    UIAlertController * alert = [UIAlertController
                                                 alertControllerWithTitle:@"UNiGHTS"
                                                 message:@"New card is added"
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
                                                 message:@"Invalid card."
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
                
            
               
                //
                
                
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
@end
