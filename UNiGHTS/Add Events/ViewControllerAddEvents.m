 //
//  ViewControllerAddEvents.m
//  UNiGHTS
//
//  Created by user on 22/06/18.
//  Copyright © 2018 RVTechnologies Softwares PVT. LTD. All rights reserved.
//

#import "ViewControllerAddEvents.h"
#import <Stripe/Stripe.h>
#import "SVProgressHUD.h"
#import "cityTableViewCell.h"
#import <GooglePlaces/GooglePlaces.h>
#import "UIImageView+WebCache.h"
#define kDefaultPageHeight 792
#define kDefaultPageWidth  612
#define kStartTag   @"--%@\r\n"
#define kEndTag     @"\r\n"
#define kContent    @"Content-Disposition: form-data; name=\"%@\"\r\n\r\n"
#define kBoundary   @"---------------------------14737809831466499882746641449"
#define kPayPalEnvironment PayPalEnvironmentSandbox

#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)


@interface ViewControllerAddEvents ()<UIPickerViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITableViewDelegate,UITableViewDataSource,GMSAutocompleteViewControllerDelegate>{
    
    NSMutableArray * QunatityArray;
    NSString * SelectedQuantity;
    NSString * Ticket_Name;
    UIDatePicker *myPickerView;
    UIToolbar *toolBar;
    UIView* selectView;
    NSString *getTypePicker;
    UIButton *btn_cancel;
    int sellTapBool;
    int freeTapBool;
    int ab;
    BOOL acceptTap;
    NSString *textWeeks;
    NSString *getFreeSell;
    cityTableViewCell *cell;
    BOOL getcity;
    NSArray * getdata;
    NSString *latitudeCity;
    NSString *longitudeCity;
    NSString *getTypeImg;
    NSMutableArray *ArrayChosenImagesData;
    int Va;
    NSString *getBD;
    NSString *getId1;
    NSString *getId2;
    NSString *getReplaceImageId1;
     NSString *getReplaceImageId2;
    NSString *getReplaceImageId3;
    NSString *pickImage;
    NSString *pickImage1;
     NSString *pickImage2;
    
}
@property (strong, nonatomic) IBOutlet UIButton *addeventBtn;
@property (weak, nonatomic) IBOutlet UIButton *acceptBtn;
@property (weak, nonatomic) IBOutlet UIImageView *imgEvent;

@property(nonatomic, strong, readwrite) IBOutlet UIButton *payNowButton1;

//@property(nonatomic, strong, readwrite) IBOutlet UIButton *payFutureButton;
@property(nonatomic, strong, readwrite) IBOutlet UIView *successView1;

@property(nonatomic, strong, readwrite) PayPalConfiguration *payPalConfig1;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView2;

@end

@implementation ViewControllerAddEvents{
    NSDecimalNumber *price;
    NSString *stringWithoutSpaces4;

}
- (void)paymentMethodsViewController:(STPPaymentMethodsViewController *)paymentMethodsViewController didFailToLoadWithError:(NSError *)error {
    
    // Dismiss payment methods view controller
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
    
    
    // Present error to user...
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return getdata.count;
    
}
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
//{
////  tableView.rowHeight = 44;
//
//    cell=[tableView dequeueReusableCellWithIdentifier:@"cityTableViewCell"];
//
//    if (!(cell == nil)) {
//
//        cell=[[cityTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cityTableViewCell"];
//        NSDictionary *getin = [getdata objectAtIndex:indexPath.row];
//
//      cell.cityName.text = @"hjjh";
//
//
//    }
//
//    return cell;
//}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
        static NSString *simpleTableIdentifier = @"cityTableViewCell";
        
        cityTableViewCell *cell = (cityTableViewCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
        if (cell == nil)
        {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"cityTableViewCell" owner:self options:nil];
            cell = [nib objectAtIndex:0];
        }
      NSDictionary *getin = [getdata objectAtIndex:indexPath.row];
    cell.cityName.text = [getin valueForKey:@"city"];
    
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
        
    }

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSDictionary *getin = [getdata objectAtIndex:indexPath.row];
    _cityTxt.text = [getin valueForKey:@"city"];
//    latitudeCity = [getin valueForKey:@"latitude"];
//      longitudeCity = [getin valueForKey:@"longitude"];
    tableView.hidden = YES;
    getcity = NO;
    
}
- (IBAction)cityBtnTap:(id)sender {
    
    if(getcity == NO)
    {
        getcity = YES;
        _tableView.hidden = NO;
    }
    
    else
    {
        getcity = NO;
         _tableView.hidden = YES;
    }
}
- (IBAction)uploadImage3:(id)sender {
    getTypeImg = @"3";
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
    
}
- (IBAction)uploadImage2:(id)sender {
    getTypeImg = @"2";
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
}
- (IBAction)uploadImage:(id)sender {
    getTypeImg = @"1";
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
    if([getTypeImg  isEqual: @"4"])
    {
        self.idProofImg.image = chosenImage;
       
    }
    else if([getTypeImg  isEqual: @"3"])
    {
         self.img3.image = chosenImage;
        _deleteImg2.hidden = NO;
         getReplaceImageId3 = _imageId2;
         pickImage2 = @"3";
        if(!(([getId2  isEqual: @""]) ||(getId2 == nil)))
        {
          //  _imageId2 = @"";
            getId2 = @"";
        }
    }
    else if ([getTypeImg  isEqual: @"2"])
    {
         self.img2.image = chosenImage;
          _deleteImg1.hidden = NO;
         getReplaceImageId2 = _imageId1;
        pickImage1 = @"2";
       
        if (!(([getId1  isEqual: @""]) ||(getId1 == nil)))
        {
            
          // _imageId1 = @"";
            getId1 = @"";
        }
    }
    else
    {
    self.imgEvent.image = chosenImage;
        getReplaceImageId1 = _imageId;
        pickImage = @"1";
        
    }
    
    [picker dismissViewControllerAnimated:YES completion:nil];
    
}
- (void)paymentMethodsViewControllerDidCancel:(STPPaymentMethodsViewController *)paymentMethodsViewController {
    
    // Dismiss payment methods view controller
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}



- (void)paymentMethodsViewControllerDidFinish:(STPPaymentMethodsViewController *)paymentMethodsViewController {
    
    // Dismiss payment methods view controller
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}




- (void)paymentMethodsViewController:(STPPaymentMethodsViewController *)paymentMethodsViewController didSelectPaymentMethod:(id<STPPaymentMethod>)paymentMethod {
    
    // Save selected payment method
    
    //self.selectedPaymentMethod = paymentMethod;
    
}



#pragma mark payment button

-(void)getCities{
    NSURLSession *session = [NSURLSession sharedSession];
    [SVProgressHUD showWithStatus:@"Please wait.." maskType:SVProgressHUDMaskTypeBlack];


    NSString *URL = @"http://18.188.52.230/unights/public/api/get-cities";
    

    
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
            
          getdata=[json objectForKey:@"data"];
            
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    _tableView.delegate = self;
                    _tableView.dataSource = self;
                    [_tableView reloadData];
                    
                    [SVProgressHUD dismiss];
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
            // no internet
            
        }
        
    }];
    
    [task resume];
    
  
   
    
}
- (IBAction)deleetimg2Tap:(id)sender {
      _img3.image = [UIImage imageNamed:@"2018-08-23.jpg"];
    _deleteImg2.hidden = YES;
}

- (IBAction)deleteimg1Tap:(id)sender {
      _img2.image = [UIImage imageNamed:@"2018-08-23.jpg"];
    _deleteImg1.hidden = YES;
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



- (void)addCardViewController:(STPAddCardViewController *)addCardViewController

               didCreateToken:(STPToken *)token

                   completion:(STPErrorBlock)completion

{
    
  
}


- (IBAction)acceptTermsCionditions:(id)sender {
    
    if (acceptTap == 0)
    {
        acceptTap=1;
        [_acceptBtn setBackgroundImage:[UIImage imageNamed:@"PurpleSelected.png"] forState:UIControlStateNormal];
        
        //        _viewLast.frame = CGRectMake(0, self.ticketBtn.frame.origin.y + self.ticketBtn.frame.size.height , self.view.frame.size.width , 280);
        //         [_AddEventScroll setContentSize:CGSizeMake(_AddEventScroll.frame.size.width, 950)];
        
        
    }
    else
    {
       
        [_acceptBtn setBackgroundImage:[UIImage imageNamed:@"PurpleRadio.png"] forState:UIControlStateNormal];
        acceptTap=0;
        
        
       
        
    }
}

- (IBAction)imagePrrof:(id)sender {
    getTypeImg = @"4";
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
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self getCities];
    _eventTxt.text = _eventName;
    _cityTxt.text = _cityName;
    _venueNameTxt.text = _venueName;
    _venueAddressTxt.text = _venueAddressName;
    _venuePostcodeTxt.text = _venuePostcodeName;
    pickImage = @"0";
    pickImage2 =  @"0";
    pickImage1 =  @"0";
    _descTxtView.text = _descriptionName;
    _EarlyBirdText.text = _earlyBirdQuantityName;
    _StandardText.text = _standardQuantityName;
    _VIPQuantityText.text = _vipQuantityName;
    _priceTxt.text = _earlyBirdPriceName;
    _price2Txt.text = _standardPriceName;
    _price3Txt.text = _vipPriceName;
    _pricePayonDoorTxt.text = _PricePayonDoor;
    _descTxtView.text = _descriptionName;
    
    if(([_eventbnName  isEqual: @""]) ||(_eventbnName == nil))
{
    
    [_addeventBtn setTitle:@"ADD EVENT" forState:UIControlStateNormal];
}
    else
    {
         [_addeventBtn setTitle:@"EDIT EVENT" forState:UIControlStateNormal];
    }
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *date = [dateFormatter dateFromString:_startDateName];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"dd-MM-yyyy"];
    NSLog(@"Current Date: %@", [formatter stringFromDate:date]);
    NSString * getdate = [formatter stringFromDate:date];
    _startDateTxt.text = getdate;
    
    NSDateFormatter *dateFormatter2 = [[NSDateFormatter alloc] init];
    [dateFormatter2 setDateFormat:@"yyyy-MM-dd"];
    NSDate *date2 = [dateFormatter2 dateFromString:_endDateName];
    
    NSDateFormatter *formatter2 = [[NSDateFormatter alloc] init];
    [formatter2 setDateFormat:@"dd-MM-yyyy"];
    NSLog(@"Current Date: %@", [formatter2 stringFromDate:date2]);
    NSString * getdate2 = [formatter2 stringFromDate:date2];
    _endDateTxt.text = getdate2;
    
    NSDateFormatter *dateFormatter3 = [[NSDateFormatter alloc] init];
    [dateFormatter3 setDateFormat:@"HH:mm:ss"];
    NSDate *date3 = [dateFormatter3 dateFromString:_eventStartTimeName];
    
    NSDateFormatter *formatter3 = [[NSDateFormatter alloc] init];
    [formatter3 setDateFormat:@"hh:mm a"];
    NSLog(@"Current Date: %@", [formatter3 stringFromDate:date3]);
    NSString * getdate3 = [formatter3 stringFromDate:date3];
    _startTime.text = getdate3;
    
    NSDateFormatter *dateFormatter4 = [[NSDateFormatter alloc] init];
    [dateFormatter4 setDateFormat:@"HH:mm:ss"];
    NSDate *date4 = [dateFormatter4 dateFromString:_eventendTimeName];
    
    NSDateFormatter *formatter4 = [[NSDateFormatter alloc] init];
    [formatter4 setDateFormat:@"hh:mm a"];
    NSLog(@"Current Date: %@", [formatter3 stringFromDate:date4]);
    NSString * getdate4 = [formatter3 stringFromDate:date4];
    _endTime.text = getdate4;
    
    if(!([_image1Name  isEqual: @""]))
    {
        if(!(_image1Name == nil))
        {
         NSString * getEventImg = [NSString stringWithFormat:@"%@",_image1Name];
     
        
        [_imgEvent sd_setImageWithURL:[NSURL URLWithString:getEventImg]];
        }
        else
        {
               _imgEvent.image = [UIImage imageNamed:@"UploadDummy.jpg"];
        }
    }
    else
    {
        _imgEvent.image = [UIImage imageNamed:@"UploadDummy.jpg"];
    }
    
    if(!([_image2Name  isEqual: @""]))
    {
        if(!(_image2Name == nil))
        {
        NSString * getEventImg = [NSString stringWithFormat:@"%@",_image2Name];
       
            _deleteImg1.hidden = NO;
        [_img2 sd_setImageWithURL:[NSURL URLWithString:getEventImg]];
        }
        else
        {
            _img2.image = [UIImage imageNamed:@"2018-08-23.jpg"];
        }
    }
    else
    {
            _img2.image = [UIImage imageNamed:@"2018-08-23.jpg"];
    }
    if(!([_image3Name  isEqual: @""]))
    {
        if(!(_image3Name == nil))
        {
             _deleteImg2.hidden = NO;
        NSString * getEventImg = [NSString stringWithFormat:@"%@",_image3Name];
        
        
        [_img3 sd_setImageWithURL:[NSURL URLWithString:getEventImg]];
        }
        else
        {
            _img3.image = [UIImage imageNamed:@"2018-08-23.jpg"];
        }
    }
    else
    {
        _img3.image = [UIImage imageNamed:@"2018-08-23.jpg"];
    }
    if([_statusTicketName  isEqual: @"2"])
    {
        freeTapBool=1;
        getFreeSell = @"2";
        [_payDoorBtn setBackgroundImage:[UIImage imageNamed:@"PurpleSelected.png"] forState:UIControlStateNormal];
        [_sellBtn setBackgroundImage:[UIImage  imageNamed:@"PurpleRadio.png"] forState:UIControlStateNormal];
        [_ticketBtn setBackgroundImage:[UIImage imageNamed:@"PurpleRadio.png"] forState:UIControlStateNormal];
        _viewEnlarge.hidden = NO;
        _constraintVwHeight.constant = 50;
        _payonDorViewPrice.hidden = NO;
        _viewEnlarge.hidden = YES;
        _EarlyBirdText.userInteractionEnabled = NO;
        _StandardText.userInteractionEnabled = NO;
        _VIPQuantityText.userInteractionEnabled = NO;
        _btn1.userInteractionEnabled = NO;
        _btn2.userInteractionEnabled = NO;
        _btn3.userInteractionEnabled = NO;
        _EarlyBirdText.text = @"";
        _StandardText.text = @"";
        _VIPQuantityText.text = @"";
        _priceTxt.text = @"";
        _price2Txt.text = @"";
        _price3Txt.text = @"";
        _discountPrice1.hidden = YES;
        _discountPrice2.hidden = YES;
        _discountPrice3.hidden = YES;
        
    }
    else if ([_statusTicketName  isEqual: @"1"])
    {
        _EarlyBirdText.userInteractionEnabled = YES;
        _StandardText.userInteractionEnabled = YES;
        _VIPQuantityText.userInteractionEnabled = YES;
        _viewEnlarge.hidden = NO;
        _btn1.userInteractionEnabled = YES;
        _btn2.userInteractionEnabled = YES;
        _btn3.userInteractionEnabled = YES;
        [_sellBtn setBackgroundImage:[UIImage imageNamed:@"PurpleSelected.png"] forState:UIControlStateNormal];
        [_ticketBtn setBackgroundImage:[UIImage imageNamed:@"PurpleRadio.png"] forState:UIControlStateNormal];
        [_payDoorBtn setBackgroundImage:[UIImage imageNamed:@"PurpleRadio.png"] forState:UIControlStateNormal];
        
        _viewEnlarge.hidden = NO;
        sellTapBool=1;
        getFreeSell = @"1";
        _constraintVwHeight.constant = 284;
        _payonDorViewPrice.hidden = YES;
        _discountPrice1.hidden = NO;
        _discountPrice2.hidden = NO;
        _discountPrice3.hidden = NO;
    }
    
    else if([_statusTicketName  isEqual: @"0"])
    {
        freeTapBool=1;
        getFreeSell = @"0";
        [_ticketBtn setBackgroundImage:[UIImage imageNamed:@"PurpleSelected.png"] forState:UIControlStateNormal];
        [_sellBtn setBackgroundImage:[UIImage imageNamed:@"PurpleRadio.png"] forState:UIControlStateNormal];
        [_payDoorBtn setBackgroundImage:[UIImage imageNamed:@"PurpleRadio.png"] forState:UIControlStateNormal];
        _viewEnlarge.hidden = YES;
        _EarlyBirdText.text = @"";
        _StandardText.text = @"";
        _VIPQuantityText.text = @"";
        _priceTxt.text = @"";
        _price2Txt.text = @"";
        _price3Txt.text = @"";
        
        //        _viewLast.frame = CGRectMake(0, self.ticketBtn.frame.origin.y + self.ticketBtn.frame.size.height , self.view.frame.size.width , 280);
        //         [_AddEventScroll setContentSize:CGSizeMake(_AddEventScroll.frame.size.width, 950)];
        _constraintVwHeight.constant = 0;
        _payonDorViewPrice.hidden = YES;
        
    }
    else
    {
        _EarlyBirdText.userInteractionEnabled = YES;
        _StandardText.userInteractionEnabled = YES;
        _VIPQuantityText.userInteractionEnabled = YES;
        _btn1.userInteractionEnabled = YES;
        _btn2.userInteractionEnabled = YES;
        _btn3.userInteractionEnabled = YES;
        [_sellBtn setBackgroundImage:[UIImage imageNamed:@"PurpleSelected.png"] forState:UIControlStateNormal];
        [_ticketBtn setBackgroundImage:[UIImage imageNamed:@"PurpleRadio.png"] forState:UIControlStateNormal];
        [_payDoorBtn setBackgroundImage:[UIImage imageNamed:@"PurpleRadio.png"] forState:UIControlStateNormal];
        
        _viewEnlarge.hidden = NO;
        sellTapBool=1;
        getFreeSell = @"1";
        _constraintVwHeight.constant = 284;
        _discountPrice1.hidden = NO;
        _discountPrice2.hidden = NO;
        _discountPrice3.hidden = NO;
    }
    _viewBank.frame = CGRectMake(0, 0, self.view.frame.size.width, 850);
    
      _scrollView2.contentSize = CGSizeMake(self.view.frame.size.width, 1200);
     _BlurryView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
     _QunatityPickerView.frame = CGRectMake(self.BlurryView.center.x - 300/2, self.BlurryView.center.y - 235/2, 300, 200);
    _idProofImg.image = [UIImage imageNamed:@"idproof.png"];
    ArrayChosenImagesData=[[NSMutableArray alloc]init];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    //  myPickerView = [[UIPickerView alloc] init];
    getcity = NO;
     SelectedQuantity = @"50";
    acceptTap = false;
    textWeeks = @"";
    self.title = @"Fashion Mania Online Store";

  //  getdata = [[NSMutableArray alloc]init];
  
    // Set up payPalConfig
    _payPalConfig1 = [[PayPalConfiguration alloc] init];
#if HAS_CARDIO
    // You should use the PayPal-iOS-SDK+card-Sample-App target to enable this setting.
    // For your apps, you will need to link to the libCardIO and dependent libraries. Please read the README.md
    // for more details.
    _payPalConfig.acceptCreditCards = YES;
#else
    _payPalConfig1.acceptCreditCards = NO;
#endif
    _payPalConfig1.merchantName = @"Fashion Mnaia";
    _payPalConfig1.merchantPrivacyPolicyURL = [NSURL URLWithString:@"https://www.paypal.com/webapps/mpp/ua/privacy-full"];
    _payPalConfig1.merchantUserAgreementURL = [NSURL URLWithString:@"https://www.paypal.com/webapps/mpp/ua/useragreement-full"];
    
    // Setting the languageOrLocale property is optional.
    //
    // If you do not set languageOrLocale, then the PayPalPaymentViewController will present
    // its user interface according to the device's current language setting.
    //
    // Setting languageOrLocale to a particular language (e.g., @"es" for Spanish) or
    // locale (e.g., @"es_MX" for Mexican Spanish) forces the PayPalPaymentViewController
    // to use that language/locale.
    //
    // For full details, including a list of available languages and locales, see PayPalPaymentViewController.h.
    
    _payPalConfig1.languageOrLocale = [NSLocale preferredLanguages][0];
    
    
    // Setting the payPalShippingAddressOption property is optional.
    //
    // See PayPalConfiguration.h for details.
    
    _payPalConfig1.payPalShippingAddressOption = PayPalShippingAddressOptionPayPal;
    
    // Do any additional setup after loading the view, typically from a nib.
    
    self.successView1.hidden = YES;
    
    // use default environment, should be Production in real life
    self.environment1 = kPayPalEnvironment;
    
    
    
 
   // sellTapBool = 0;
   // freeTapBool = 0;
   // getFreeSell = @"1";
    
    ab=0;
    QunatityArray =[[NSMutableArray alloc]init];
    [QunatityArray addObject:@"50"];
    for (int x=1; x<=5; x++)
    {
        int xy =100;
        xy = xy*x;
        NSString * val =[NSString stringWithFormat:@"%d",xy];
        [QunatityArray addObject:val];
    }
    
//    [_AddEventScroll setContentSize:CGSizeMake(_AddEventScroll.frame.size.width, 1200)];
    
    
    _payPalConfig1 = [[PayPalConfiguration alloc] init];
#if HAS_CARDIO
    // You should use the PayPal-iOS-SDK+card-Sample-App target to enable this setting.
    // For your apps, you will need to link to the libCardIO and dependent libraries. Please read the README.md
    // for more details.
    _payPalConfig.acceptCreditCards = YES;
#else
    _payPalConfig1.acceptCreditCards = NO;
#endif
    _payPalConfig1.merchantName = @"Fashion Mnaia";
    _payPalConfig1.merchantPrivacyPolicyURL = [NSURL URLWithString:@"https://www.paypal.com/webapps/mpp/ua/privacy-full"];
    _payPalConfig1.merchantUserAgreementURL = [NSURL URLWithString:@"https://www.paypal.com/webapps/mpp/ua/useragreement-full"];
    
    // Setting the languageOrLocale property is optional.
    //
    // If you do not set languageOrLocale, then the PayPalPaymentViewController will present
    // its user interface according to the device's current language setting.
    //
    // Setting languageOrLocale to a particular language (e.g., @"es" for Spanish) or
    // locale (e.g., @"es_MX" for Mexican Spanish) forces the PayPalPaymentViewController
    // to use that language/locale.
    //
    // For full details, including a list of available languages and locales, see PayPalPaymentViewController.h.
    
    _payPalConfig1.languageOrLocale = [NSLocale preferredLanguages][0];
    
    
    // Setting the payPalShippingAddressOption property is optional.
    //
    // See PayPalConfiguration.h for details.
    
    _payPalConfig1.payPalShippingAddressOption = PayPalShippingAddressOptionPayPal;
}


- (BOOL)acceptCreditCards {
    return self.payPalConfig1.acceptCreditCards;
}

- (void)setAcceptCreditCards:(BOOL)acceptCreditCards {
    self.payPalConfig1.acceptCreditCards = acceptCreditCards;
}


//- (void)viewWillAppear:(BOOL)animated {
//    [super viewWillAppear:YES];
//    // Preconnect to PayPal early
//    [self setPayPalEnvironment:self.environment1];
//}

- (void)setPayPalEnvironment:(NSString *)environment {
    self.environment1 = environment;
    [PayPalMobile preconnectWithEnvironment:environment];
}


#pragma mark PayPalPaymentDelegate methods

- (void)payPalPaymentViewController:(PayPalPaymentViewController *)paymentViewController didCompletePayment:(PayPalPayment *)completedPayment {
    NSLog(@"PayPal Payment Success!");
    [self showSuccess];
    
    [self sendCompletedPaymentToServer:completedPayment]; // Payment was processed successfully; send to server for verification and fulfillment
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)payPalPaymentDidCancel:(PayPalPaymentViewController *)paymentViewController {
    NSLog(@"PayPal Payment Canceled");
    self.successView1.hidden = YES;
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark Proof of payment validation

- (void)sendCompletedPaymentToServer:(PayPalPayment *)completedPayment {
    // TODO: Send completedPayment.confirmation to server
    NSLog(@"Here is your proof of payment:\n\n%@\n\nSend this to your server for confirmation and fulfillment.", completedPayment.confirmation);
    
    NSString *pay=[completedPayment.confirmation valueForKey:@"response"];
    
    
    NSString *paypalid=[NSString stringWithFormat:@"%@",[pay valueForKey:@"id"]];
    NSLog(@"%@",paypalid);
    
    [[NSUserDefaults standardUserDefaults]setObject:paypalid forKey:@"paypalid"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
  //  [self PypalApi];
    
    
}

#pragma mark - Authorize Future Payments

- (IBAction)getUserAuthorizationForFuturePayments:(id)sender {
    
    PayPalFuturePaymentViewController *futurePaymentViewController = [[PayPalFuturePaymentViewController alloc] initWithConfiguration:self.payPalConfig1 delegate:self];
    [self presentViewController:futurePaymentViewController animated:YES completion:nil];
}


#pragma mark PayPalFuturePaymentDelegate methods

- (void)payPalFuturePaymentViewController:(PayPalFuturePaymentViewController *)futurePaymentViewController
                didAuthorizeFuturePayment:(NSDictionary *)futurePaymentAuthorization {
    NSLog(@"PayPal Future Payment Authorization Success!");
    [self showSuccess];
    
    [self sendFuturePaymentAuthorizationToServer:futurePaymentAuthorization];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)payPalFuturePaymentDidCancel:(PayPalFuturePaymentViewController *)futurePaymentViewController {
    NSLog(@"PayPal Future Payment Authorization Canceled");
    self.successView1.hidden = YES;
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)sendFuturePaymentAuthorizationToServer:(NSDictionary *)authorization {
    // TODO: Send authorization to server
    NSLog(@"Here is your authorization:\n\n%@\n\nSend this to your server to complete future payment setup.", authorization);
}


#pragma mark - Authorize Profile Sharing

- (IBAction)getUserAuthorizationForProfileSharing:(id)sender {
    
    NSSet *scopeValues = [NSSet setWithArray:@[kPayPalOAuth2ScopeOpenId, kPayPalOAuth2ScopeEmail, kPayPalOAuth2ScopeAddress, kPayPalOAuth2ScopePhone]];
    
    PayPalProfileSharingViewController *profileSharingPaymentViewController = [[PayPalProfileSharingViewController alloc] initWithScopeValues:scopeValues configuration:self.payPalConfig1 delegate:self];
    [self presentViewController:profileSharingPaymentViewController animated:YES completion:nil];
}


#pragma mark PayPalProfileSharingDelegate methods

- (void)payPalProfileSharingViewController:(PayPalProfileSharingViewController *)profileSharingViewController
             userDidLogInWithAuthorization:(NSDictionary *)profileSharingAuthorization {
    NSLog(@"PayPal Profile Sharing Authorization Success!");
    
    [self showSuccess];
    
    [self sendProfileSharingAuthorizationToServer:profileSharingAuthorization];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)userDidCancelPayPalProfileSharingViewController:(PayPalProfileSharingViewController *)profileSharingViewController {
    NSLog(@"PayPal Profile Sharing Authorization Canceled");
    self.successView1.hidden = YES;
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)sendProfileSharingAuthorizationToServer:(NSDictionary *)authorization {
    // TODO: Send authorization to server
    NSLog(@"Here is your authorization:\n\n%@\n\nSend this to your server to complete profile sharing setup.", authorization);
}


#pragma mark - Helpers

- (void)showSuccess {
    self.successView1.hidden = NO;
    self.successView1.alpha = 1.0f;
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.5];
    [UIView setAnimationDelay:2.0];
    self.successView1.alpha = 0.0f;
    [UIView commitAnimations];
}

#pragma mark - Flipside View Controller

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"pushSettings"]) {
        [[segue destinationViewController] setDelegate:(id)self];
    }
}



- (IBAction)datedob:(id)sender {
    
     getTypePicker = @"dateDOB";
     [self showPicker];
}


- (IBAction)endDateBtnTap:(id)sender {
    getTypePicker = @"endDate";
       [self showPicker];
}
- (IBAction)startDateTap:(id)sender {
    getTypePicker = @"startDate";
       [self showPicker];
}
- (IBAction)startTimeTap:(id)sender {
    getTypePicker = @"startTime";
       [self showPicker];
}
- (IBAction)endTimeTap:(id)sender {
    getTypePicker = @"endTime";
    [self showPicker];
}

-(void) showPicker
{
    
    [myPickerView removeFromSuperview];
    [selectView removeFromSuperview];
    myPickerView = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height-200, self.view.frame.size.width,200)];

    
    if([getTypePicker  isEqual: @"endDate"] || [getTypePicker isEqual: @"startDate"] || [getTypePicker  isEqual: @"dateDOB"])
    {
       myPickerView.datePickerMode = UIDatePickerModeDate;
        NSDate *currentDate = [NSDate date];
        NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
        NSDateComponents *comps = [[NSDateComponents alloc] init];
        

         if([getTypePicker  isEqual: @"dateDOB"])
         {
             NSDate *currentDate = [NSDate date];
             NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
             NSDateComponents *comps = [[NSDateComponents alloc] init];
                     myPickerView.maximumDate = [calendar dateByAddingComponents:comps toDate:currentDate options:0];
             myPickerView.maximumDate = [calendar dateByAddingComponents:comps toDate:currentDate options:0];
             myPickerView.minimumDate = nil;
         }
        
        else
        {
            NSDate *currentDate = [NSDate date];
            NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
            NSDateComponents *comps = [[NSDateComponents alloc] init];
            
            myPickerView.minimumDate = [calendar dateByAddingComponents:comps toDate:currentDate options:0];
            myPickerView.maximumDate = nil;
        }
    }
    
    
    else{
          myPickerView.datePickerMode = UIDatePickerModeTime;
    }
  
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
    NSDate *currentDate = [NSDate date];
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    if([getTypePicker  isEqual: @"endDate"])
    {
        df.dateFormat = @"dd-MM-yyyy";
        self.endDate.text = [df stringFromDate:currentDate];
        
    }
    else if( [getTypePicker isEqual: @"startDate"])
    {
        df.dateFormat = @"dd-MM-yyyy";
        self.startDate.text = [df stringFromDate:currentDate];
    }
    else if( [getTypePicker isEqual: @"startTime"])
    {
        df.dateFormat = @"hh:mm a";
        self.startTime.text = [df stringFromDate:currentDate];
        
    }
    
    else if([getTypePicker  isEqual: @"dateDOB"])
    {
        df.dateFormat = @"yyyy-MM-dd";
        self.bankDob.text = [df stringFromDate:currentDate];
    }
    
    else{
        df.dateFormat = @"hh:mm a";
        self.endTime.text = [df stringFromDate:currentDate];
    }
//
//    toolBar=[[UIToolbar alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height-220, self.view.frame.size.width, 44)];
//
//    toolBar.barStyle = UIBarStyleDefault;
//
//    toolBar.translucent = YES;
//
//    toolBar.tintColor = [UIColor blueColor];
//
//    //    toolBar.barStyle = UIBarStyle.default;
//    //
//    //    toolBar.isTranslucent = YES;
//    //
//    //    toolBar.tintColor = UIColor.blue
//
//
//    UIBarButtonItem *doneBtn=[[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStylePlain target:self action:@selector(ShowSelectedDate)];
//
//    UIBarButtonItem *cancel=[[UIBarButtonItem alloc]initWithTitle:@"Cancel" style:UIBarButtonItemStylePlain target:self action:@selector(canceldate)];
//
//    [toolBar setItems:[NSArray arrayWithObjects:cancel,doneBtn, nil]];
//
//
//    [self.view addSubview:toolBar];
}

- (void)pickerChanged:(id)sender
{
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    UILabel *myLabel = [[UILabel alloc]initWithFrame:CGRectMake(50, 300, 200, 200)];
    if([getTypePicker  isEqual: @"endDate"])
    {
        df.dateFormat = @"dd-MM-yyyy";
        self.endDate.text = [df stringFromDate:[sender date]];
        
    }
    else if( [getTypePicker isEqual: @"startDate"])
    {
        df.dateFormat = @"dd-MM-yyyy";
        self.startDate.text = [df stringFromDate:[sender date]];
    }
    else if( [getTypePicker isEqual: @"startTime"])
    {
        df.dateFormat = @"hh:mm a";
        self.startTime.text = [df stringFromDate:[sender date]];
        
    }
    
    else if([getTypePicker  isEqual: @"dateDOB"])
    {
        df.dateFormat = @"yyyy-MM-dd";
        self.bankDob.text = [df stringFromDate:[sender date]];
    }
    
    else{
        df.dateFormat = @"hh:mm a";
        self.endTime.text = [df stringFromDate:[sender date]];
    }
    
   
  
}


- (void)ShowSelectedDate
{
    [myPickerView removeFromSuperview];
    [selectView removeFromSuperview];
    
    UILabel *myLabel = [[UILabel alloc]initWithFrame:CGRectMake(50, 300, 200, 200)];
  

    
    NSLog(@"print");
}
- (void)canceldate
{
    [myPickerView removeFromSuperview];
    [selectView removeFromSuperview];
    
    if([getTypePicker  isEqual: @"endDate"])
    {
        
        self.endDate.text = @"";
        
    }
    else if( [getTypePicker isEqual: @"startDate"])
    {
       
        self.startDate.text = @"";
    }
    else if( [getTypePicker isEqual: @"startTime"])
    {
       
        self.startTime.text = @"";
        
    }
    else{
       
        self.endTime.text = @"";
    }
    
    
    

}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)EventdescriptionBackTapped:(id)sender
    {
        [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)EarlyBirdQuantity:(id)sender
{
    [_QuantityPicker selectRow:0 inComponent:0 animated:YES];
    Ticket_Name =@"Early";
    _BlurryView.hidden=NO;
    _QunatityPickerView.hidden=NO;
    [_QuantityPicker reloadAllComponents];
    
}
- (IBAction)StandardQunatityTapped:(id)sender
{
    [_QuantityPicker selectRow:0 inComponent:0 animated:YES];
    _BlurryView.hidden=NO;
    Ticket_Name =@"Standrad";
    _QunatityPickerView.hidden=NO;
    [_QuantityPicker reloadAllComponents];
    
}
- (IBAction)VIPQuantityTapped:(id)sender
{
     [_QuantityPicker selectRow:0 inComponent:0 animated:YES];
    _BlurryView.hidden=NO;
    Ticket_Name =@"VIP";
    _QunatityPickerView.hidden=NO;
    [_QuantityPicker reloadAllComponents];
   
}
- (IBAction)QunatityDoneTapped:(id)sender

{
    if ([Ticket_Name isEqualToString:@"Early"])
    {
        _EarlyBirdText.text=SelectedQuantity;
    }
    else  if ([Ticket_Name isEqualToString:@"Standrad"])
    {
        _StandardText.text=SelectedQuantity;
    }
    else  if ([Ticket_Name isEqualToString:@"VIP"])
    {
        _VIPQuantityText.text=SelectedQuantity;
    }
    _BlurryView.hidden=YES;
    _QunatityPickerView.hidden=YES;
}
// Picker view

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return QunatityArray.count;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return [QunatityArray objectAtIndex:row];
}
- (void)pickerView:(UIPickerView *)thePickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    SelectedQuantity = @"50";
    

        SelectedQuantity=[QunatityArray objectAtIndex:row];
    
    
    
}
- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    //[ProgressHUD dismiss];
    UILabel *tView = (UILabel*)view;
    if (QunatityArray.count>0) {
        if (!tView)
        {
            tView = [[UILabel alloc] init];
            [tView setTextColor:[UIColor blackColor]];
            [tView setFont:[UIFont fontWithName:@"Loto-regular" size:12]];
            tView.text=[QunatityArray objectAtIndex:row];
            [tView setTextAlignment:NSTextAlignmentCenter];
            return tView;
        }
    }
    return tView;
}
- (IBAction)QuantityBtnCancelTaopped:(id)sender
{
    _BlurryView.hidden=YES;
    _QunatityPickerView.hidden=YES;
}
- (IBAction)freeTickertBtnTap:(id)sender {
    freeTapBool=1;
    getFreeSell = @"0";
    [_ticketBtn setBackgroundImage:[UIImage imageNamed:@"PurpleSelected.png"] forState:UIControlStateNormal];
    [_sellBtn setBackgroundImage:[UIImage imageNamed:@"PurpleRadio.png"] forState:UIControlStateNormal];
     [_payDoorBtn setBackgroundImage:[UIImage imageNamed:@"PurpleRadio.png"] forState:UIControlStateNormal];
    _viewEnlarge.hidden = YES;
    _EarlyBirdText.text = @"";
    _StandardText.text = @"";
    _VIPQuantityText.text = @"";
    _priceTxt.text = @"";
    _price2Txt.text = @"";
    _price3Txt.text = @"";
    _pricePayonDoorTxt.text = @"";
    
    //        _viewLast.frame = CGRectMake(0, self.ticketBtn.frame.origin.y + self.ticketBtn.frame.size.height , self.view.frame.size.width , 280);
    //         [_AddEventScroll setContentSize:CGSizeMake(_AddEventScroll.frame.size.width, 950)];
    _constraintVwHeight.constant = 0;
    _payonDorViewPrice.hidden = YES;
//    if (freeTapBool == 0)
//    {
//         freeTapBool=1;
//        getFreeSell = @"0";
//        [_ticketBtn setBackgroundImage:[UIImage imageNamed:@"PurpleSelected.png"] forState:UIControlStateNormal];
//            [_sellBtn setBackgroundImage:[UIImage imageNamed:@"PurpleRadio.png"] forState:UIControlStateNormal];
//        _viewEnlarge.hidden = YES;
//
////        _viewLast.frame = CGRectMake(0, self.ticketBtn.frame.origin.y + self.ticketBtn.frame.size.height , self.view.frame.size.width , 280);
////         [_AddEventScroll setContentSize:CGSizeMake(_AddEventScroll.frame.size.width, 950)];
//        _constraintVwHeight.constant = 0;
//    }
//    else
//    {
//        [_ticketBtn setBackgroundImage:[UIImage imageNamed:@"PurpleRadio.png"] forState:UIControlStateNormal];
//         [_sellBtn setBackgroundImage:[UIImage imageNamed:@"PurpleSelected.png"] forState:UIControlStateNormal];
//        freeTapBool=0;
//    getFreeSell = @"1";
//
//        _viewEnlarge.hidden = NO;
//        _constraintVwHeight.constant = 284;
////        _viewLast.frame = CGRectMake(0, self.viewEnlarge.frame.origin.y + self.viewEnlarge.frame.size.height , self.view.frame.size.width , 280);
////         [_AddEventScroll setContentSize:CGSizeMake(_AddEventScroll.frame.size.width, 1200)];
//
//    }
}
- (IBAction)backBtnTap:(id)sender {
     self.viewBank.hidden = YES;
}
- (IBAction)addevent2:(id)sender {
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
    
//    else if([_addressTxt.text  isEqual: @""])
//    {
//        UIAlertController * alert=[UIAlertController
//
//                                   alertControllerWithTitle:@"Message!" message:@"Add the address" preferredStyle:UIAlertControllerStyleAlert];
//
//        UIAlertAction* yesButton = [UIAlertAction
//
//                                    actionWithTitle:@"Ok"
//
//                                    style:UIAlertActionStyleDefault
//
//                                    handler:^(UIAlertAction * action)
//
//                                    {
//
//
//
//                                    }];
//
//
//
//        [alert addAction:yesButton];
//
//        [self presentViewController:alert animated:YES completion:nil];
//    }
    
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
    
//    else if([_bankCity.text  isEqual: @""])
//    {
//        UIAlertController * alert=[UIAlertController
//
//                                   alertControllerWithTitle:@"Message!" message:@"Add the city" preferredStyle:UIAlertControllerStyleAlert];
//
//        UIAlertAction* yesButton = [UIAlertAction
//
//                                    actionWithTitle:@"Ok"
//
//                                    style:UIAlertActionStyleDefault
//
//                                    handler:^(UIAlertAction * action)
//
//                                    {
//
//
//
//                                    }];
//
//
//
//        [alert addAction:yesButton];
//
//        [self presentViewController:alert animated:YES completion:nil];
//    }
    else if([_bankDob.text  isEqual: @""])
    {
        UIAlertController * alert=[UIAlertController

                                   alertControllerWithTitle:@"Message!" message:@"Add the state" preferredStyle:UIAlertControllerStyleAlert];

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
    
    else if ([_idProofImg.image isEqual:[UIImage imageNamed:@"idproof.png"]]|| _idProofImg.image == nil ||[_idProofImg.image isEqual:@""])
    {
        UIAlertController * alert=[UIAlertController
                                   
                                   alertControllerWithTitle:@"Message!" message:@"Add some id proof" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* yesButton = [UIAlertAction
                                    
                                    actionWithTitle:@"Ok"
                                    
                                    style:UIAlertActionStyleDefault
                                    
                                    handler:^(UIAlertAction * action)
                                    
                                    {
                                        
                                        
                                        
                                    }];
        
        
        
        [alert addAction:yesButton];
        
        [self presentViewController:alert animated:YES completion:nil];
        
    }
    
//    else if([_bankSSn.text  isEqual: @""])
//    {
//        UIAlertController * alert=[UIAlertController
//
//                                   alertControllerWithTitle:@"Message!" message:@"Add the SSN" preferredStyle:UIAlertControllerStyleAlert];
//
//        UIAlertAction* yesButton = [UIAlertAction
//
//                                    actionWithTitle:@"Ok"
//
//                                    style:UIAlertActionStyleDefault
//
//                                    handler:^(UIAlertAction * action)
//
//                                    {
//
//
//
//                                    }];
//
//
//
//        [alert addAction:yesButton];
//
//        [self presentViewController:alert animated:YES completion:nil];
//    }
    
    else
    {
        //[self addEvent];
        if (([getBD  isEqual: @"1"]))
        {
             [self addEvent];
//            UIAlertController * alert=[UIAlertController
//
//                                       alertControllerWithTitle:@"Message!" message:@"Are you sure to move forward with this bank detail" preferredStyle:UIAlertControllerStyleAlert];
//
//            UIAlertAction* yesButton = [UIAlertAction
//
//                                        actionWithTitle:@"YES"
//
//                                        style:UIAlertActionStyleDefault
//
//                                        handler:^(UIAlertAction * action)
//
//                                        {
//
//                                           [self addEvent];
//
//                                        }];
//
//
//
//            [alert addAction:yesButton];
//            UIAlertAction* noButton = [UIAlertAction
//
//                                        actionWithTitle:@"NO"
//
//                                        style:UIAlertActionStyleDefault
//
//                                        handler:^(UIAlertAction * action)
//
//                                        {
//
//
//
//                                        }];
//
//
//
//            [alert addAction:noButton];
//
//            [self presentViewController:alert animated:YES completion:nil];
        }
        else
        {
            
            [self addBankDetails];
//            UIAlertController * alert=[UIAlertController
//
//                                       alertControllerWithTitle:@"Message!" message:@"Are you sure to move forward with this bank detail" preferredStyle:UIAlertControllerStyleAlert];
//
//            UIAlertAction* yesButton = [UIAlertAction
//
//                                        actionWithTitle:@"YES"
//
//                                        style:UIAlertActionStyleDefault
//
//                                        handler:^(UIAlertAction * action)
//
//                                        {
//
//
//
//                                        }];
//
//
//
//            [alert addAction:yesButton];
//            UIAlertAction* noButton = [UIAlertAction
//
//                                       actionWithTitle:@"NO"
//
//                                       style:UIAlertActionStyleDefault
//
//                                       handler:^(UIAlertAction * action)
//
//                                       {
//
//
//
//                                       }];
//
//
//
//            [alert addAction:noButton];
//
//            [self presentViewController:alert animated:YES completion:nil];
       
        }
    }

}
  // [self addEvent];
    
   // [self addEventK];
    


- (IBAction)addEvent:(id)sender {
    
    if([_eventTxt.text  isEqual: @""])
    {
        UIAlertController * alert=[UIAlertController
                                   
                                   alertControllerWithTitle:@"Message!" message:@"Add the name of event" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* yesButton = [UIAlertAction
                                    
                                    actionWithTitle:@"Ok"
                                    
                                    style:UIAlertActionStyleDefault
                                    
                                    handler:^(UIAlertAction * action)
                                    
                                    {
                                        
                                        
                                        
                                    }];
        
        
        
        [alert addAction:yesButton];
        
        [self presentViewController:alert animated:YES completion:nil];
        
    }
    else if([_cityTxt.text  isEqual: @""])
    {
        UIAlertController * alert=[UIAlertController
                                   
                                   alertControllerWithTitle:@"Message!" message:@"Choose the name of city" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* yesButton = [UIAlertAction
                                    
                                    actionWithTitle:@"Ok"
                                    
                                    style:UIAlertActionStyleDefault
                                    
                                    handler:^(UIAlertAction * action)
                                    
                                    {
                                        
                                        
                                        
                                    }];
        
        
        
        [alert addAction:yesButton];
        
        [self presentViewController:alert animated:YES completion:nil];
    }
   else if([_venueNameTxt.text  isEqual: @""])
    {
        UIAlertController * alert=[UIAlertController
                                   
                                   alertControllerWithTitle:@"Message!" message:@"Add the name of venue" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* yesButton = [UIAlertAction
                                    
                                    actionWithTitle:@"Ok"
                                    
                                    style:UIAlertActionStyleDefault
                                    
                                    handler:^(UIAlertAction * action)
                                    
                                    {
                                        
                                        
                                        
                                    }];
        
        
        
        [alert addAction:yesButton];
        
        [self presentViewController:alert animated:YES completion:nil];
    }
    
    else if([_venueAddressTxt.text  isEqual: @""])
    {
        UIAlertController * alert=[UIAlertController
                                   
                                   alertControllerWithTitle:@"Message!" message:@"Add the address of venue" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* yesButton = [UIAlertAction
                                    
                                    actionWithTitle:@"Ok"
                                    
                                    style:UIAlertActionStyleDefault
                                    
                                    handler:^(UIAlertAction * action)
                                    
                                    {
                                        
                                        
                                        
                                    }];
        
        
        
        [alert addAction:yesButton];
        
        [self presentViewController:alert animated:YES completion:nil];
    }
    
   else if([_venuePostcodeTxt.text  isEqual: @""])
    {
        UIAlertController * alert=[UIAlertController
                                   
                                   alertControllerWithTitle:@"Message!" message:@"Add the Postcode of venue" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* yesButton = [UIAlertAction
                                    
                                    actionWithTitle:@"Ok"
                                    
                                    style:UIAlertActionStyleDefault
                                    
                                    handler:^(UIAlertAction * action)
                                    
                                    {
                                        
                                        
                                        
                                    }];
        
        
        
        [alert addAction:yesButton];
        
        [self presentViewController:alert animated:YES completion:nil];
    }
    
   else if([_startDateTxt.text  isEqual: @""])
    {
        UIAlertController * alert=[UIAlertController
                                   
                                   alertControllerWithTitle:@"Message!" message:@"Add the start date" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* yesButton = [UIAlertAction
                                    
                                    actionWithTitle:@"Ok"
                                    
                                    style:UIAlertActionStyleDefault
                                    
                                    handler:^(UIAlertAction * action)
                                    
                                    {
                                        
                                        
                                        
                                    }];
        
        
        
        [alert addAction:yesButton];
        
        [self presentViewController:alert animated:YES completion:nil];
    }
    
   else if([_endDateTxt.text  isEqual: @""])
   {
       UIAlertController * alert=[UIAlertController
                                  
                                  alertControllerWithTitle:@"Message!" message:@"Add the end date" preferredStyle:UIAlertControllerStyleAlert];
       
       UIAlertAction* yesButton = [UIAlertAction
                                   
                                   actionWithTitle:@"Ok"
                                   
                                   style:UIAlertActionStyleDefault
                                   
                                   handler:^(UIAlertAction * action)
                                   
                                   {
                                       
                                       
                                       
                                   }];
       
       
       
       [alert addAction:yesButton];
       
       [self presentViewController:alert animated:YES completion:nil];
   }
    
   else if([_startTimeTxt.text  isEqual: @""])
   {
       UIAlertController * alert=[UIAlertController
                                  
                                  alertControllerWithTitle:@"Message!" message:@"Add the start time" preferredStyle:UIAlertControllerStyleAlert];
       
       UIAlertAction* yesButton = [UIAlertAction
                                   
                                   actionWithTitle:@"Ok"
                                   
                                   style:UIAlertActionStyleDefault
                                   
                                   handler:^(UIAlertAction * action)
                                   
                                   {
                                       
                                       
                                       
                                   }];
       
       
       
       [alert addAction:yesButton];
       
       [self presentViewController:alert animated:YES completion:nil];
   }
    
   else if([_endTimeTxt.text  isEqual: @""])
   {
       UIAlertController * alert=[UIAlertController
                                  
                                  alertControllerWithTitle:@"Message!" message:@"Add the end time" preferredStyle:UIAlertControllerStyleAlert];
       
       UIAlertAction* yesButton = [UIAlertAction
                                   
                                   actionWithTitle:@"Ok"
                                   
                                   style:UIAlertActionStyleDefault
                                   
                                   handler:^(UIAlertAction * action)
                                   
                                   {
                                       
                                       
                                       
                                   }];
       
       
       
       [alert addAction:yesButton];
       
       [self presentViewController:alert animated:YES completion:nil];
   }
    
   else if([getFreeSell isEqual:@"1"])
    {
        if([_EarlyBirdText.text  isEqual: @""] && [_StandardText.text  isEqual: @""] && [_VIPQuantityText.text  isEqual: @""])
        {
            UIAlertController * alert=[UIAlertController
                                       
                                       alertControllerWithTitle:@"Message!" message:@"Add the Early Bird or Standard Ticket or VIP Quantity" preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction* yesButton = [UIAlertAction
                                        
                                        actionWithTitle:@"Ok"
                                        
                                        style:UIAlertActionStyleDefault
                                        
                                        handler:^(UIAlertAction * action)
                                        
                                        {
                                            
                                            
                                            
                                        }];
            
            
            
            [alert addAction:yesButton];
            
            [self presentViewController:alert animated:YES completion:nil];
        }
        
        
        else if(!([_EarlyBirdText.text  isEqual: @""]) && [_priceTxt.text  isEqual: @""])
        {
            UIAlertController * alert=[UIAlertController
                                       
                                       alertControllerWithTitle:@"Message!" message:@"Add price of Early Bird" preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction* yesButton = [UIAlertAction
                                        
                                        actionWithTitle:@"Ok"
                                        
                                        style:UIAlertActionStyleDefault
                                        
                                        handler:^(UIAlertAction * action)
                                        
                                        {
                                            
                                            
                                            
                                        }];
            
            
            
            [alert addAction:yesButton];
            
            [self presentViewController:alert animated:YES completion:nil];
        }
        
        else if(!([_StandardText.text  isEqual: @""]) && [_price2Txt.text  isEqual: @""])
        {
            UIAlertController * alert=[UIAlertController
                                       
                                       alertControllerWithTitle:@"Message!" message:@"Add price of Standard Bird" preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction* yesButton = [UIAlertAction
                                        
                                        actionWithTitle:@"Ok"
                                        
                                        style:UIAlertActionStyleDefault
                                        
                                        handler:^(UIAlertAction * action)
                                        
                                        {
                                            
                                            
                                            
                                        }];
            
            
            
            [alert addAction:yesButton];
            
            [self presentViewController:alert animated:YES completion:nil];
        }
        else if(!([_VIPQuantityText.text  isEqual: @""]) && [_price3Txt.text  isEqual: @""])
        {
            UIAlertController * alert=[UIAlertController
                                       
                                       alertControllerWithTitle:@"Message!" message:@"Add price of VIP" preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction* yesButton = [UIAlertAction
                                        
                                        actionWithTitle:@"Ok"
                                        
                                        style:UIAlertActionStyleDefault
                                        
                                        handler:^(UIAlertAction * action)
                                        
                                        {
                                            
                                            
                                            
                                        }];
            
            
            
            [alert addAction:yesButton];
            
            [self presentViewController:alert animated:YES completion:nil];
        }
        if(([_EarlyBirdText.text  isEqual: @""]) && !([_priceTxt.text  isEqual: @""]))
        {
            UIAlertController * alert=[UIAlertController
                                       
                                       alertControllerWithTitle:@"Message!" message:@"Add quantity of Early Bird" preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction* yesButton = [UIAlertAction
                                        
                                        actionWithTitle:@"Ok"
                                        
                                        style:UIAlertActionStyleDefault
                                        
                                        handler:^(UIAlertAction * action)
                                        
                                        {
                                            
                                            
                                            
                                        }];
            
            
            
            [alert addAction:yesButton];
            
            [self presentViewController:alert animated:YES completion:nil];
        }
        
        if(([_StandardText.text  isEqual: @""]) && !([_price2Txt.text  isEqual: @""]))
        {
            UIAlertController * alert=[UIAlertController
                                       
                                       alertControllerWithTitle:@"Message!" message:@"Add quantity of Standard Bird" preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction* yesButton = [UIAlertAction
                                        
                                        actionWithTitle:@"Ok"
                                        
                                        style:UIAlertActionStyleDefault
                                        
                                        handler:^(UIAlertAction * action)
                                        
                                        {
                                            
                                            
                                            
                                        }];
            
            
            
            [alert addAction:yesButton];
            
            [self presentViewController:alert animated:YES completion:nil];
        }
        if(([_VIPQuantityText.text  isEqual: @""]) && !([_price3Txt.text  isEqual: @""]))
        {
            UIAlertController * alert=[UIAlertController
                                       
                                       alertControllerWithTitle:@"Message!" message:@"Add quantity of VIP" preferredStyle:UIAlertControllerStyleAlert];
            
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
          if([_descTxtView.text  isEqual: @""])
         {
             UIAlertController * alert=[UIAlertController
                                        
                                        alertControllerWithTitle:@"Message!" message:@"Enter some description" preferredStyle:UIAlertControllerStyleAlert];
             
             UIAlertAction* yesButton = [UIAlertAction
                                         
                                         actionWithTitle:@"Ok"
                                         
                                         style:UIAlertActionStyleDefault
                                         
                                         handler:^(UIAlertAction * action)
                                         
                                         {
                                             
                                             
                                             
                                         }];
             
             
             
             [alert addAction:yesButton];
             
             [self presentViewController:alert animated:YES completion:nil];
         }
      
             else if ([_imgEvent.image isEqual:[UIImage imageNamed:@"UploadDummy.jpg"]]|| _imgEvent.image == nil ||[_imgEvent.image isEqual:@""])
             {
             UIAlertController * alert=[UIAlertController
                                        
                                        alertControllerWithTitle:@"Message!" message:@"Enter the banner image" preferredStyle:UIAlertControllerStyleAlert];
             
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
             if([getFreeSell  isEqual: @"1"])
             {
//                 if(([_eventbnName  isEqual: @""]) ||(_eventbnName == nil))
//                 {
//
//                     [self editEvent];
//                 }
                 [self getbankDetails];
             }
             else
             {
                 if(([_eventbnName  isEqual: @"edit"]))
                 {
                     
                      [self editEvent];
                 }
                 
                 else
                 {
                 [self addEvent];
                 }
                 
                 
             }
         }
     }
    }
    else if ([getFreeSell isEqualToString:@"2"])
    {
        if([_pricePayonDoorTxt.text  isEqual: @""])
        {
            UIAlertController * alert=[UIAlertController
                                       
                                       alertControllerWithTitle:@"Message!" message:@"Add the price" preferredStyle:UIAlertControllerStyleAlert];
            
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
            if([_descTxtView.text  isEqual: @""])
            {
                UIAlertController * alert=[UIAlertController
                                           
                                           alertControllerWithTitle:@"Message!" message:@"Enter some description" preferredStyle:UIAlertControllerStyleAlert];
                
                UIAlertAction* yesButton = [UIAlertAction
                                            
                                            actionWithTitle:@"Ok"
                                            
                                            style:UIAlertActionStyleDefault
                                            
                                            handler:^(UIAlertAction * action)
                                            
                                            {
                                                
                                                
                                                
                                            }];
                
                
                
                [alert addAction:yesButton];
                
                [self presentViewController:alert animated:YES completion:nil];
            }
            
            else if ([_imgEvent.image isEqual:[UIImage imageNamed:@"UploadDummy.jpg"]]|| _imgEvent.image == nil ||[_imgEvent.image isEqual:@""])
            {
                UIAlertController * alert=[UIAlertController
                                           
                                           alertControllerWithTitle:@"Message!" message:@"Enter the banner image" preferredStyle:UIAlertControllerStyleAlert];
                
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
                if([getFreeSell  isEqual: @"1"])
                {
                    //                 if(([_eventbnName  isEqual: @""]) ||(_eventbnName == nil))
                    //                 {
                    //
                    //                     [self editEvent];
                    //                 }
                    [self getbankDetails];
                }
                else
                {
                    if(([_eventbnName  isEqual: @"edit"]))
                    {
                        
                        [self editEvent];
                    }
                    
                    else
                    {
                        [self addEvent];
                    }
                    
                    
                }
            }
        }
    }
    else if([_descTxtView.text  isEqual: @""])
    {
        UIAlertController * alert=[UIAlertController
                                   
                                   alertControllerWithTitle:@"Message!" message:@"Enter some description" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* yesButton = [UIAlertAction
                                    
                                    actionWithTitle:@"Ok"
                                    
                                    style:UIAlertActionStyleDefault
                                    
                                    handler:^(UIAlertAction * action)
                                    
                                    {
                                        
                                        
                                        
                                    }];
        
        
        
        [alert addAction:yesButton];
        
        [self presentViewController:alert animated:YES completion:nil];
    }
    else if ([_imgEvent.image isEqual:[UIImage imageNamed:@"UploadDummy.jpg"]]|| _imgEvent.image == nil ||[_imgEvent.image isEqual:@""])
    {
        UIAlertController * alert=[UIAlertController
                                   
                                   alertControllerWithTitle:@"Message!" message:@"Enter the banner image" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* yesButton = [UIAlertAction
                                    
                                    actionWithTitle:@"Ok"
                                    
                                    style:UIAlertActionStyleDefault
                                    
                                    handler:^(UIAlertAction * action)
                                    
                                    {
                                        
                                        
                                        
                                    }];
        
        
        
        [alert addAction:yesButton];
        
        [self presentViewController:alert animated:YES completion:nil];
    }
   else if (acceptTap==0)
   {
       UIAlertController * alert=[UIAlertController
                                  
                                  alertControllerWithTitle:@"Message!" message:@"Accept the terms and conditions" preferredStyle:UIAlertControllerStyleAlert];
       
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
        if([getFreeSell  isEqual: @"1"])
        {
            //                 if(([_eventbnName  isEqual: @""]) ||(_eventbnName == nil))
            //                 {
            //
            //                     [self editEvent];
            //                 }
            [self getbankDetails];
        }
        else
        {
            if(([_eventbnName  isEqual: @"edit"]))
            {
                 [self editEvent];
               
            }
            
            else
            {
                [self addEvent];
            }
            
            
        }
    }

//        if([getFreeSell  isEqual: @"1"])
//        {
//         [self getbankDetails];
//        }
//        else
//        {
//
//            [self addEvent];
//        }
       // [self addEvent];
        
    //}
//    float valu = 0.23;
//
//
//    NSString *jj=[NSString stringWithFormat:@"%.2f",valu];
//
//
//    PayPalPayment *payment = [[PayPalPayment alloc] init];
//
//
//    price = [NSDecimalNumber decimalNumberWithString:jj];
//    payment.amount = price;
//    payment.currencyCode = @"USD";
//    payment.shortDescription = @"UNiGHTS";
//    if (!payment.processable) {
//    }
//    self.payPalConfig1.acceptCreditCards = self.acceptCreditCards;
//
//    PayPalPaymentViewController *paymentViewController = [[PayPalPaymentViewController alloc] initWithPayment:payment
//                                                                                                configuration:self.payPalConfig1
//                                                                                                     delegate:self];
//    [self presentViewController:paymentViewController animated:NO completion:nil];
    
}

- (IBAction)payonDoor:(id)sender {
    
    freeTapBool=1;
    getFreeSell = @"2";
    [_payDoorBtn setBackgroundImage:[UIImage imageNamed:@"PurpleSelected.png"] forState:UIControlStateNormal];
    [_sellBtn setBackgroundImage:[UIImage  imageNamed:@"PurpleRadio.png"] forState:UIControlStateNormal];
    [_ticketBtn setBackgroundImage:[UIImage imageNamed:@"PurpleRadio.png"] forState:UIControlStateNormal];
    _viewEnlarge.hidden = NO;
      _constraintVwHeight.constant = 50;
    _payonDorViewPrice.hidden = NO;
    _viewEnlarge.hidden = YES;
    _EarlyBirdText.userInteractionEnabled = NO;
    _StandardText.userInteractionEnabled = NO;
    _VIPQuantityText.userInteractionEnabled = NO;
    _btn1.userInteractionEnabled = NO;
    _btn2.userInteractionEnabled = NO;
    _btn3.userInteractionEnabled = NO;
    _EarlyBirdText.text = @"";
    _StandardText.text = @"";
    _VIPQuantityText.text = @"";
    _priceTxt.text = @"";
    _price2Txt.text = @"";
    _price3Txt.text = @"";
    _discountPrice1.hidden = YES;
    _discountPrice2.hidden = YES;
    _discountPrice3.hidden = YES;
   
    
    
    //        _viewLast.frame = CGRectMake(0, self.ticketBtn.frame.origin.y + self.ticketBtn.frame.size.height , self.view.frame.size.width , 280);
    //         [_AddEventScroll setContentSize:CGSizeMake(_AddEventScroll.frame.size.width, 950)];
   
}

- (IBAction)sellBtnTap:(id)sender {
    _EarlyBirdText.userInteractionEnabled = YES;
    _StandardText.userInteractionEnabled = YES;
    _VIPQuantityText.userInteractionEnabled = YES;
     _viewEnlarge.hidden = NO;
    _btn1.userInteractionEnabled = YES;
    _btn2.userInteractionEnabled = YES;
    _btn3.userInteractionEnabled = YES;
            [_sellBtn setBackgroundImage:[UIImage imageNamed:@"PurpleSelected.png"] forState:UIControlStateNormal];
         [_ticketBtn setBackgroundImage:[UIImage imageNamed:@"PurpleRadio.png"] forState:UIControlStateNormal];
             [_payDoorBtn setBackgroundImage:[UIImage imageNamed:@"PurpleRadio.png"] forState:UIControlStateNormal];
    
            _viewEnlarge.hidden = NO;
            sellTapBool=1;
            getFreeSell = @"1";
        _pricePayonDoorTxt.text = @"";
            _constraintVwHeight.constant = 284;
    _payonDorViewPrice.hidden = YES;
    _discountPrice1.hidden = NO;
    _discountPrice2.hidden = NO;
    _discountPrice3.hidden = NO;
    //        _viewLast.frame = CGRectMake(0, self.viewEnlarge.frame.origin.y + self.viewEnlarge.frame.size.height , self.view.frame.size.width , 280);
    //
    //         [_AddEventScroll setContentSize:CGSizeMake(_AddEventScroll.frame.size.width, 1200)];
//    if (sellTapBool == 0)
//    {
//        [_sellBtn setBackgroundImage:[UIImage imageNamed:@"PurpleSelected.png"] forState:UIControlStateNormal];
//     [_ticketBtn setBackgroundImage:[UIImage imageNamed:@"PurpleRadio.png"] forState:UIControlStateNormal];
//         [_payDoorBtn setBackgroundImage:[UIImage imageNamed:@"PurpleRadio.png"] forState:UIControlStateNormal];
//
//        _viewEnlarge.hidden = NO;
//        sellTapBool=1;
//        getFreeSell = @"1";
//        _constraintVwHeight.constant = 284;
////        _viewLast.frame = CGRectMake(0, self.viewEnlarge.frame.origin.y + self.viewEnlarge.frame.size.height , self.view.frame.size.width , 280);
////
////         [_AddEventScroll setContentSize:CGSizeMake(_AddEventScroll.frame.size.width, 1200)];
//    }
//    else
//    {
//        [_sellBtn setBackgroundImage:[UIImage imageNamed:@"PurpleRadio.png"] forState:UIControlStateNormal];
//              [_ticketBtn setBackgroundImage:[UIImage imageNamed:@"PurpleSelected.png"] forState:UIControlStateNormal];
//        sellTapBool=0;
//        //_viewEnlarge.hidden = NO;
//      _viewEnlarge.hidden = YES;
//        getFreeSell = @"0";
//        _constraintVwHeight.constant = 0;
////        _viewLast.frame = CGRectMake(0, self.ticketBtn.frame.origin.y + self.ticketBtn.frame.size.height , self.view.frame.size.width , 280);
////         [_AddEventScroll setContentSize:CGSizeMake(_AddEventScroll.frame.size.width, 950)];
//    }
//
}

- (IBAction)UploadWeeklyTapped:(id)sender
{
    if (ab == 0)
    {
        [_UploadWeeklyBtn setBackgroundImage:[UIImage imageNamed:@"PurpleSelected.png"] forState:UIControlStateNormal];
        [self DisplayAlertview];
        ab=1;
    }
    else
    {
        [_UploadWeeklyBtn setBackgroundImage:[UIImage imageNamed:@"PurpleRadio.png"] forState:UIControlStateNormal];
        ab=0;
    }
}




- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    // Make sure the button they clicked wasn't Cancel
    if (buttonIndex == alertView.firstOtherButtonIndex) {
        UITextField *textField = [alertView textFieldAtIndex:0];
        
        NSLog(@"%@", textField.text);
    }
}
-(void)DisplayAlertview
{
    UIAlertController * alert=   [UIAlertController
                                  alertControllerWithTitle:@"Event availability"
                                  message:@"Please enter number of weeks."
                                  preferredStyle:UIAlertControllerStyleAlert];

    [alert addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.placeholder = @"Number of weeks.";
        
        textField.keyboardType= UIKeyboardTypeNumberPad;
    }];
    UIAlertAction* ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                               handler:^(UIAlertAction * action)
                         {
                             if ([alert.textFields objectAtIndex:0].text.length<1)
                             {
                                 [_UploadWeeklyBtn setBackgroundImage:[UIImage imageNamed:@"PurpleRadio.png"] forState:UIControlStateNormal];
                                 ab=0;
                                 
                             }
                             else
                             {
                                 textWeeks = [alert.textFields objectAtIndex:0].text;
                             }
                             
                         
                         }];
    
    [alert addAction:ok];
    
    UIAlertAction* Cancel = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDefault
                                                   handler:^(UIAlertAction * action) {
                                                       [_UploadWeeklyBtn setBackgroundImage:[UIImage imageNamed:@"PurpleRadio.png"] forState:UIControlStateNormal];
                                                       ab=0;
                                                   }];
    
    [alert addAction:Cancel];
    [self presentViewController:alert animated:YES completion:nil];
}

-(void)viewWillAppear:(BOOL)animated
{
    _QunatityPickerView.layer.cornerRadius=5;
    _QunatityPickerView.clipsToBounds=YES;
    
    _QnttityBtnDone.layer.cornerRadius=5;
    _QnttityBtnDone.clipsToBounds=YES;
    
    _QnttityBtnCancel.layer.cornerRadius=5;
    _QnttityBtnCancel.clipsToBounds=YES;
    
    _BlurryView.hidden=YES;
    _QunatityPickerView.hidden=YES;
   
    
     [self setPayPalEnvironment:self.environment1];
    
}
-(void) addEvent
{
    NSURLSession *session = [NSURLSession sharedSession];
    [ArrayChosenImagesData removeAllObjects];
    [SVProgressHUD showWithStatus:@"Please Wait..." maskType:SVProgressHUDMaskTypeBlack];

    NSMutableDictionary*aParametersDic;
    
    
    
    NSMutableDictionary*aImageDic;
    
    
    
    
    
    NSURL *url = [NSURL URLWithString:@"http://18.188.52.230/unights/public/api/add-event"];
    
    
    
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
    
    

    
    [aParametersDic setObject:getFreeSell forKey:@"ticket_type"];
    
    
      [aParametersDic setObject:_cityTxt.text forKey:@"city"];
    [aParametersDic setObject:_eventTxt.text forKey:@"event_name"];
    
    
    [aParametersDic setObject:_venueAddressTxt.text forKey:@"venue_address"];
    
    [aParametersDic setObject:_venueNameTxt.text forKey:@"venue_name"];
    
    
    
    [aParametersDic setObject:_venuePostcodeTxt.text forKey:@"post_code"];
    
    
    
    [aParametersDic setObject:_startDate.text forKey:@"start_date"];
    
    
    
    [aParametersDic setObject:_endDateTxt.text forKey:@"end_date"];
    
    
    
    [aParametersDic setObject:_startTimeTxt.text forKey:@"start_time"];
    
    
    
    [aParametersDic setObject:_endTimeTxt.text forKey:@"end_time"];

    
    [aParametersDic setObject:_descTxtView.text forKey:@"description"];
    
    
    
    [aParametersDic setObject:[NSString stringWithFormat:@"%d",ab] forKey:@"is_weekly_event"];
    
    
    
    [aParametersDic setObject:textWeeks forKey:@"number_of_weeks"];
    
    
    
    [aParametersDic setObject:_EarlyBirdText.text forKey:@"early_bird_quantity"];
    
    
    
    [aParametersDic setObject:_priceTxt.text forKey:@"early_bird_price"];
    
       [aParametersDic setObject:_pricePayonDoorTxt.text forKey:@"price"];
    

    
    
    [aParametersDic setObject:longitudeCity forKey:@"longitude"];
    
    [aParametersDic setObject:latitudeCity forKey:@"latitude"];
   
    [aParametersDic setObject:_EarlyBirdText.text forKey:@"early_bird_quantity"];
    
[aParametersDic setObject:_priceTxt.text forKey:@"early_bird_price"];
    
    
        [aParametersDic setObject:_StandardText.text forKey:@"standard_quantity"];
        
        [aParametersDic setObject:_price2Txt.text forKey:@"standard_price"];
    
    
      [aParametersDic setObject:_VIPQuantityText.text forKey:@"vip_quantity"];
        
        [aParametersDic setObject:_price3Txt.text forKey:@"vip_price"];
   
    [request setURL:url];
    
    
    
    aImageDic = [[NSMutableDictionary alloc]init];
    
    
    CGFloat scaleSize = 0.2f;
    
    UIImage *smallImage = [UIImage imageWithCGImage:_imgEvent.image.CGImage
                           
                           
                           
                                              scale:scaleSize
                           
                           
                           
                                        orientation:_imgEvent.image.imageOrientation];
    
    
    
    
    
    [request setURL:url];
    
    
    
    [request setHTTPMethod:@"POST"];
    
    
    
    NSString *boundary = @"---------------------------14737809831466499882746641449";
    
    
    
    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@",boundary];
    
    
    
    [request addValue:contentType forHTTPHeaderField: @"Content-Type"];
    
    
    
    NSMutableData *postbody = [NSMutableData data];
    
    
    
    NSString *postData = [self getHTTPBodyParamsFromDictionary:aParametersDic boundary:boundary];
    
    
    
    [postbody appendData:[postData dataUsingEncoding:NSUTF8StringEncoding]];
    
    
    
//   [aParametersDic enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
    
        
       
        NSData *imageData = UIImageJPEGRepresentation(_imgEvent.image, 0.035);
        NSData *imageData2 = UIImageJPEGRepresentation(_img2.image, 0.035);
        NSData *imageData3 = UIImageJPEGRepresentation(_img3.image, 0.035);
    
         if (!([_imgEvent.image isEqual:[UIImage imageNamed:@"UploadDummy.jpg"]]|| _imgEvent.image == nil ||[_imgEvent.image isEqual:@""]))
        {
          [ArrayChosenImagesData addObject:imageData];
       }
        if (!([_img2.image isEqual:[UIImage imageNamed:@"2018-08-23.jpg"]]|| _img2.image == nil ||[_img2.image isEqual:@""]))
       {
         [ArrayChosenImagesData addObject:imageData2];
       }
       if (!([_img3.image isEqual:[UIImage imageNamed:@"2018-08-23.jpg"]]|| _img3.image == nil ||[_img3.image isEqual:@""]))
       
       {
           [ArrayChosenImagesData addObject:imageData3];
       }
       

    
    
   
    [postbody appendData:[[NSString stringWithFormat:kEndTag] dataUsingEncoding:NSUTF8StringEncoding]];
    
  
    
    
    for (int i=0; i<ArrayChosenImagesData.count;i++ )
  
        
    {
        
  
        
        NSData *image_videoData;
  
        
        image_videoData=[ArrayChosenImagesData objectAtIndex:i];
        
  
        if (image_videoData)
            
     
            
        {
 
            [postbody appendData:[[NSString stringWithFormat:kStartTag, kBoundary] dataUsingEncoding:NSUTF8StringEncoding]];
            
       
            [postbody appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=%@; filename=imageName.jpeg\r\n", @"images[]"] dataUsingEncoding:NSUTF8StringEncoding]];
            
   
            
            [postbody appendData:[@"Content-Type: image/jpeg\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
            
   
            [postbody appendData:image_videoData];
            
      
            [postbody appendData:[[NSString stringWithFormat:kEndTag] dataUsingEncoding:NSUTF8StringEncoding]];
           
            
        }
      
        
        else
            
    
            
            
        {
            
    
            
            [postbody appendData:[[NSString stringWithFormat:kStartTag, kBoundary] dataUsingEncoding:NSUTF8StringEncoding]];
            
         
            
            
        }
        
       
        
    }
 
    
    [postbody appendData:[[NSString stringWithFormat:@"--%@--\r\n", kBoundary] dataUsingEncoding:NSUTF8StringEncoding]];
    
    
    
    NSString *postLength = [NSString stringWithFormat:@"%lu", (unsigned long)[postbody length]];
    
     [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
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
                                           
                                           UIAlertController * alert=[UIAlertController
                                                                      
                                                                      alertControllerWithTitle:@"UNiGHTS" message:@"Event Added Successfully" preferredStyle:UIAlertControllerStyleAlert];
                                           
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
- (IBAction)deleteImg1Tap:(id)sender {
    pickImage1 = @"0";
    getId1 = _imageId1;
}
- (IBAction)deleteImg2Tap:(id)sender {
    getId2 = _imageId2;
       pickImage2 = @"0";
}


-(void) editEvent
{
    NSURLSession *session = [NSURLSession sharedSession];
    [ArrayChosenImagesData removeAllObjects];
    [SVProgressHUD showWithStatus:@"Please Wait..." maskType:SVProgressHUDMaskTypeBlack];
    
    NSMutableDictionary*aParametersDic;
    
    
    
    NSMutableDictionary*aImageDic;
    
    
    
    
    
    NSURL *url = [NSURL URLWithString:@"http://18.188.52.230/unights/public/api/add-event"];
    
    
    
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
    
  
    
    
    [aParametersDic setObject:getFreeSell forKey:@"ticket_type"];
    [aParametersDic setObject:_eventIdEdit forKey:@"event_id"];
    
    
    [aParametersDic setObject:_cityTxt.text forKey:@"city"];
    [aParametersDic setObject:_eventTxt.text forKey:@"event_name"];
    
    
    [aParametersDic setObject:_venueAddressTxt.text forKey:@"venue_address"];
    
    [aParametersDic setObject:_venueNameTxt.text forKey:@"venue_name"];
    
    
    
    [aParametersDic setObject:_venuePostcodeTxt.text forKey:@"post_code"];
    
    
    
    [aParametersDic setObject:_startDate.text forKey:@"start_date"];
    
    
    
    [aParametersDic setObject:_endDateTxt.text forKey:@"end_date"];
    
    
    
    [aParametersDic setObject:_startTimeTxt.text forKey:@"start_time"];
    
    
    
    [aParametersDic setObject:_endTimeTxt.text forKey:@"end_time"];
    
    
    [aParametersDic setObject:_descTxtView.text forKey:@"description"];
    
    
    
    [aParametersDic setObject:[NSString stringWithFormat:@"%d",ab] forKey:@"is_weekly_event"];
    
    
    
    [aParametersDic setObject:textWeeks forKey:@"number_of_weeks"];
    
    
    
    [aParametersDic setObject:_EarlyBirdText.text forKey:@"early_bird_quantity"];
    
    
    
    [aParametersDic setObject:_priceTxt.text forKey:@"early_bird_price"];
    
    
    
    
    
    [aParametersDic setObject:[NSString stringWithFormat:@"%f",_longitudeEdit] forKey:@"longitude"];
    
    [aParametersDic setObject:[NSString stringWithFormat:@"%f",_latitudeEdit] forKey:@"latitude"];
    
    [aParametersDic setObject:_EarlyBirdText.text forKey:@"early_bird_quantity"];
    
    [aParametersDic setObject:_priceTxt.text forKey:@"early_bird_price"];
    
    
    [aParametersDic setObject:_StandardText.text forKey:@"standard_quantity"];
    
    [aParametersDic setObject:_price2Txt.text forKey:@"standard_price"];
    [aParametersDic setObject:_pricePayonDoorTxt.text forKey:@"price"];
    
    [aParametersDic setObject:_VIPQuantityText.text forKey:@"vip_quantity"];
    
    [aParametersDic setObject:_price3Txt.text forKey:@"vip_price"];
    
    NSMutableArray *getIds = [[NSMutableArray alloc]init];
    if(!(([getId1  isEqual: @""]) ||(getId1 == nil)))
    {
    [getIds addObject:getId1];
    }
    if (!(([getId2  isEqual: @""]) ||(getId2 == nil)))
    {
    
    [getIds addObject:getId2];
    }
    NSMutableArray *getimagesA = [[NSMutableArray alloc]init];
    if (!(([getReplaceImageId1  isEqual: @""]) ||(getReplaceImageId1 == nil)))
    {
    [getimagesA addObject:_imageId];
    }
    if (!(([getReplaceImageId2  isEqual: @""]) ||(getReplaceImageId2 == nil)))
    {
    [getimagesA addObject:_imageId1];
    }
    if (!(( [getReplaceImageId3  isEqual: @""]) ||(getReplaceImageId3 == nil)))
    {
    [getimagesA addObject:_imageId2];
    }
    int i;
    for (i=0;i<getIds.count;i++)
    {
        
        [aParametersDic setObject:getIds[i] forKey:[NSString stringWithFormat:@"%@%s%d%s",@"delete_ids","[",i,"]"]];
    }
if(getIds.count == 0)
         {
        //      [aParametersDic setObject:@"" forKey:[NSString stringWithFormat:@"%@%s%s",@"delete_ids","[","]"]];
         }
       int j;
    for (j=0;j<getimagesA.count;j++)
    {
        [aParametersDic setObject:getimagesA[j] forKey:[NSString stringWithFormat:@"%@%s%d%s",@"img_ids","[",j,"]"]];
        
    }
    if(getimagesA.count == 0)
    {
      //  [aParametersDic setObject:@"" forKey:[NSString stringWithFormat:@"%@%s%s",@"img_ids","[","]"]];
        
    }
//        [aParametersDic setObject:getIds forKey:@"delete_ids"];
//        [aParametersDic setObject:getimagesA forKey:@"img_ids"];
    NSLog(@"%@",aParametersDic);
    [request setURL:url];
    

    
    aImageDic = [[NSMutableDictionary alloc]init];
    
    
    CGFloat scaleSize = 0.2f;
    
    UIImage *smallImage = [UIImage imageWithCGImage:_imgEvent.image.CGImage
                           
                           
                           
                                              scale:scaleSize
                           
                           
                           
                                        orientation:_imgEvent.image.imageOrientation];
    
    
    
    
    
    [request setURL:url];
    
    
    
    [request setHTTPMethod:@"POST"];
    
    
    
    NSString *boundary = @"---------------------------14737809831466499882746641449";
    
    
    
    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@",boundary];
    
    
    
    [request addValue:contentType forHTTPHeaderField: @"Content-Type"];
    
    
    
    NSMutableData *postbody = [NSMutableData data];
    
    
    
    NSString *postData = [self getHTTPBodyParamsFromDictionary:aParametersDic boundary:boundary];
    
    
    
    [postbody appendData:[postData dataUsingEncoding:NSUTF8StringEncoding]];
    
    
    
    //   [aParametersDic enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
    
    
    
    NSData *imageData = UIImageJPEGRepresentation(_imgEvent.image, 0.035);
    NSData *imageData2 = UIImageJPEGRepresentation(_img2.image, 0.035);
    NSData *imageData3 = UIImageJPEGRepresentation(_img3.image, 0.035);
    
    if (!([_imgEvent.image isEqual:[UIImage imageNamed:@"UploadDummy.jpg"]]|| _imgEvent.image == nil ||[_imgEvent.image isEqual:@""]))
    {
        if([pickImage  isEqual: @"1"])
        {
        [ArrayChosenImagesData addObject:imageData];
        }
    }
    if (!([_img2.image isEqual:[UIImage imageNamed:@"2018-08-23.jpg"]]|| _img2.image == nil ||[_img2.image isEqual:@""]))
    {
        if([pickImage1  isEqual: @"2"])
        {
        [ArrayChosenImagesData addObject:imageData2];
        }
    }
    if (!([_img3.image isEqual:[UIImage imageNamed:@"2018-08-23.jpg"]]|| _img3.image == nil ||[_img3.image isEqual:@""]))
        
    {
        if([pickImage2  isEqual: @"3"])
        {
        [ArrayChosenImagesData addObject:imageData3];
        }
    }
    
    
    
    
    
    [postbody appendData:[[NSString stringWithFormat:kEndTag] dataUsingEncoding:NSUTF8StringEncoding]];
    
    
    
    
    for (int i=0; i<ArrayChosenImagesData.count;i++ )
        
        
    {
        
        
        
        NSData *image_videoData;
        
        
        image_videoData=[ArrayChosenImagesData objectAtIndex:i];
        
        
        if (image_videoData)
            
            
            
        {
            
            [postbody appendData:[[NSString stringWithFormat:kStartTag, kBoundary] dataUsingEncoding:NSUTF8StringEncoding]];
            
            
            [postbody appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=%@; filename=imageName.jpeg\r\n", @"images[]"] dataUsingEncoding:NSUTF8StringEncoding]];
            
            
            
            [postbody appendData:[@"Content-Type: image/jpeg\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
            
            
            [postbody appendData:image_videoData];
            
            
            [postbody appendData:[[NSString stringWithFormat:kEndTag] dataUsingEncoding:NSUTF8StringEncoding]];
            
            
        }
        
        
        else
            
            
            
            
        {
            
            
            
            [postbody appendData:[[NSString stringWithFormat:kStartTag, kBoundary] dataUsingEncoding:NSUTF8StringEncoding]];
            
            
            
            
        }
        
        
        
    }
    
    
    [postbody appendData:[[NSString stringWithFormat:@"--%@--\r\n", kBoundary] dataUsingEncoding:NSUTF8StringEncoding]];
    
    
    
    NSString *postLength = [NSString stringWithFormat:@"%lu", (unsigned long)[postbody length]];
    
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
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
                    
                    UIAlertController * alert=[UIAlertController
                                               
                                               alertControllerWithTitle:@"UNiGHTS" message:@"Event updated Successfully" preferredStyle:UIAlertControllerStyleAlert];
                    
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

- (void)placeAutocomplete {
    
    GMSAutocompleteFilter *filter = [[GMSAutocompleteFilter alloc] init];
    GMSPlacesClient *placesClient = [[GMSPlacesClient alloc] init];
    filter.type = kGMSPlacesAutocompleteTypeFilterEstablishment;
    
    [placesClient autocompleteQuery:@"UK"
                              bounds:nil
                              filter:filter
                            callback:^(NSArray *results, NSError *error) {
                                if (error != nil) {
                                    NSLog(@"Autocomplete error %@", [error localizedDescription]);
                                    return;
                                }
                                
                                for (GMSAutocompletePrediction* result in results) {
                                    NSLog(@"Result '%@' with placeID %@", result.attributedFullText.string, result.placeID);
                                }
                            }];
}
- (IBAction)addAdressBtnTap:(id)sender {
//    let filter = GMSAutocompleteFilter()
 
//    filter.country = "UK"
//
    
    [self placeAutocomplete];
    GMSAutocompleteViewController *acController = [[GMSAutocompleteViewController alloc] init];
   GMSAutocompleteFilter *filterss = [[GMSAutocompleteFilter alloc] init];

   filterss.country = @"UK";

    filterss.type = kGMSPlacesAutocompleteTypeFilterEstablishment;
    acController.delegate = self;
    acController.autocompleteFilter = filterss;
    [self presentViewController:acController animated:YES completion:nil];
}


- (void)viewController:(GMSAutocompleteViewController *)viewController
didAutocompleteWithPlace:(GMSPlace *)place {
    [self dismissViewControllerAnimated:YES completion:nil];
    // Do something with the selected place.
    NSLog(@"Place name %@", place.name);
    NSLog(@"Place address %@", place.formattedAddress);
    NSLog(@"Place attributions %@", place.attributions.string);
    NSLog(@"Place attributions %f", place.coordinate.latitude);
   
    _venueAddressTxt.text = place.formattedAddress;
    latitudeCity = [NSString stringWithFormat:@"%f",place.coordinate.latitude];
    longitudeCity = [NSString stringWithFormat:@"%f",place.coordinate.longitude];

}

- (void)viewController:(GMSAutocompleteViewController *)viewController
didFailAutocompleteWithError:(NSError *)error {
    [self dismissViewControllerAnimated:YES completion:nil];
    // TODO: handle the error.
    NSLog(@"Error: %@", [error description]);
}

// User canceled the operation.
- (void)wasCancelled:(GMSAutocompleteViewController *)viewController {
    [self dismissViewControllerAnimated:YES completion:nil];
}

// Turn the network activity indicator on and off again.
- (void)didRequestAutocompletePredictions:(GMSAutocompleteViewController *)viewController {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
}

- (void)didUpdateAutocompletePredictions:(GMSAutocompleteViewController *)viewController {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}
- (IBAction)deleteBtnTap:(id)sender {
    [self deleteBankDetail];
}

-(void) getbankDetails
{
    NSURLSession *session = [NSURLSession sharedSession];
    [SVProgressHUD showWithStatus:@"Please wait.." maskType:SVProgressHUDMaskTypeBlack];
    
    
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
                
                dispatch_async(dispatch_get_main_queue(), ^{
                _deleteBtn.hidden = NO;
                getBD = @"1";
                _bankEmail.userInteractionEnabled = NO;
                _bankFirstName.userInteractionEnabled = NO;
                _bankLastName.userInteractionEnabled = NO;
                _bankaccountholdername.userInteractionEnabled = NO;
                _bankaccountNumber.userInteractionEnabled = NO;
                _bankRoutingNumber.userInteractionEnabled = NO;
                _bankDob.userInteractionEnabled = NO;
                _addressTxt.userInteractionEnabled = NO;
                _bankline1.userInteractionEnabled = NO;
                _bankline2.userInteractionEnabled = NO;
                _bankCity.userInteractionEnabled = NO;
                _statetxt.userInteractionEnabled = NO;
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
                
                self.viewBank.hidden = NO;
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
                
                
                    
                    
                    
                    [SVProgressHUD dismiss];
                });
                
            }
            
            else
            {
                getBD = @"2";
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    
                    [SVProgressHUD dismiss];
                    _deleteBtn.hidden = YES;
                
                
                self.viewBank.hidden = NO;
                 _bankEmail.userInteractionEnabled = YES;
                _bankFirstName.userInteractionEnabled = YES;
                _bankLastName.userInteractionEnabled = YES;
                _bankaccountholdername.userInteractionEnabled = YES;
                _bankaccountNumber.userInteractionEnabled = YES;
                _bankRoutingNumber.userInteractionEnabled = YES;
                _bankDob.userInteractionEnabled = YES;
                _addressTxt.userInteractionEnabled = YES;
                _bankline1.userInteractionEnabled = YES;
                _bankline2.userInteractionEnabled = YES;
                _bankCity.userInteractionEnabled = YES;
                _statetxt.userInteractionEnabled = YES;
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
    [SVProgressHUD showWithStatus:@"Please wait.." maskType:SVProgressHUDMaskTypeBlack];
    
    
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
                                                _bankFirstName.text = @"";
                                                _bankLastName.text = @"";
                                                _bankaccountholdername.text = @"";
                                                _bankaccountNumber.text = @"";
                                                _bankRoutingNumber.text = @"";
                                                _bankDob.text = @"";
                                                _bankCity.text = @"";
                                                _statetxt.text = @"";
                                                _bankline1.text = @"";
                                                _bankline2.text = @"";
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
                                                _addressTxt.userInteractionEnabled = YES;
                                                _bankline1.userInteractionEnabled = YES;
                                                _bankline2.userInteractionEnabled = YES;
                                                _bankCity.userInteractionEnabled = YES;
                                                _statetxt.userInteractionEnabled = YES;
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
    [SVProgressHUD showWithStatus:@"Please Wait..." maskType:SVProgressHUDMaskTypeBlack];
    
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
    
    
    
    [aParametersDic setObject:_addressTxt.text forKey:@"address"];
    
    
    
    [aParametersDic setObject:_bankSSn.text forKey:@"ssn"];
    
    
    
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
                                           [self addEvent];
//                                           [NSUserDefaults.standardUserDefaults setValue:@"pints" forKey:@"stripe_account"];
                                           
                                           
                                           
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
@end
