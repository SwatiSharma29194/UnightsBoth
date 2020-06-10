//
//  ViewControllerAddEvents.h
//  UNiGHTS
//
//  Created by user on 22/06/18.
//  Copyright © 2018 RVTechnologies Softwares PVT. LTD. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PayPalMobile.h"


@interface ViewControllerAddEvents : UIViewController<PayPalPaymentDelegate, PayPalFuturePaymentDelegate, PayPalProfileSharingDelegate, UISplitViewControllerDelegate>
@property (weak, nonatomic) IBOutlet UITextField *eventTxt;
@property (weak, nonatomic) IBOutlet UITextField *venueNameTxt;
@property (weak, nonatomic) IBOutlet UIButton *sellBtn;
- (IBAction)EventdescriptionBackTapped:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *ticketBtn;
@property (weak, nonatomic) IBOutlet UITextField *endTime;
@property (weak, nonatomic) IBOutlet UIView *viewLast;
@property (weak, nonatomic) IBOutlet UIScrollView *AddEventScroll;
@property (weak, nonatomic) IBOutlet UIView *viewEnlarge;
- (IBAction)EarlyBirdQuantity:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *EarlyBirdText;
@property (weak, nonatomic) IBOutlet UITextField *StandardText;
- (IBAction)StandardQunatityTapped:(id)sender;
- (IBAction)VIPQuantityTapped:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *VIPQuantityText;
@property (weak, nonatomic) IBOutlet UIView *BlurryView;
@property (weak, nonatomic) IBOutlet UIView *QunatityPickerView;
@property (weak, nonatomic) IBOutlet UITextField *startTime;
@property (weak, nonatomic) IBOutlet UIPickerView *QuantityPicker;
- (IBAction)QunatityDoneTapped:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *startDate;

@property (weak, nonatomic) IBOutlet UITextField *endDate;
@property (weak, nonatomic) IBOutlet UIButton *QnttityBtnDone;
@property (weak, nonatomic) IBOutlet UIButton *QnttityBtnCancel;
- (IBAction)QuantityBtnCancelTaopped:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *payDoorBtn;

- (IBAction)UploadWeeklyTapped:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *UploadWeeklyBtn;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraintVwHeight;



@property (strong, nonatomic) IBOutlet UIView *viewPayment;

@property (strong, nonatomic) IBOutlet UIView *viewEditPop;

@property (strong, nonatomic) IBOutlet UITextField *textFieldQuantities;

@property (strong, nonatomic) IBOutlet UIButton *buttonContinue;

@property (strong, nonatomic) IBOutlet UIButton *buttonCheckOut;

@property (strong, nonatomic) IBOutlet UILabel *labelGrandTotal;

@property(nonatomic, strong, readwrite) NSString *environment1;
@property(nonatomic, assign, readwrite) BOOL acceptCreditCards1;

@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *indictorLiveCart;
@property (strong, nonatomic) IBOutlet UIButton *buttonCancel;

@property (nonatomic, retain) NSString* pdfFilePath;
@property (weak, nonatomic) IBOutlet UITextField *venueAddressTxt;
@property (weak, nonatomic) IBOutlet UITextField *venuePostcodeTxt;
@property (weak, nonatomic) IBOutlet UITextField *startDateTxt;
@property (weak, nonatomic) IBOutlet UITextField *endTimeTxt;
@property (weak, nonatomic) IBOutlet UITextField *priceTxt;
@property (weak, nonatomic) IBOutlet UITextField *price2Txt;

@property (weak, nonatomic) IBOutlet UITextView *descTxtView;
@property (weak, nonatomic) IBOutlet UITextField *price3Txt;

@property (weak, nonatomic) IBOutlet UITextField *endDateTxt;
@property (weak, nonatomic) IBOutlet UITextField *startTimeTxt;
@property (weak, nonatomic) IBOutlet UITextField *cityTxt;

- (IBAction)Button_Cancel:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *btn1;
@property (strong, nonatomic) IBOutlet UIView *viewBank;
@property (strong, nonatomic) IBOutlet UIButton *btn2;
@property (strong, nonatomic) IBOutlet UIButton *btn3;

@property (strong, nonatomic) IBOutlet UIImageView *img2;
@property (strong, nonatomic) IBOutlet UIImageView *img3;
@property (strong, nonatomic) IBOutlet UIImageView *idProofImg;
@property (strong, nonatomic) IBOutlet UIButton *idPrrofBtn;

@property (strong, nonatomic) IBOutlet UITextField *bankEmail;
@property (strong, nonatomic) IBOutlet UITextField *bankFirstName;
@property (strong, nonatomic) IBOutlet UITextField *bankLastName;
@property (strong, nonatomic) IBOutlet UITextField *bankaccountholdername;
@property (strong, nonatomic) IBOutlet UITextField *bankaccountNumber;
@property (strong, nonatomic) IBOutlet UITextField *bankRoutingNumber;
@property (strong, nonatomic) IBOutlet UITextField *bankDob;
@property (strong, nonatomic) IBOutlet UITextField *addressTxt;
@property (strong, nonatomic) IBOutlet UITextField *bankSSn;
@property (strong, nonatomic) IBOutlet UIButton *addBtn;
@property (strong, nonatomic) IBOutlet UITextField *bankline1;
@property (strong, nonatomic) IBOutlet UITextField *bankline2;
@property (strong, nonatomic) IBOutlet UITextField *bankCity;

@property (strong, nonatomic) IBOutlet UITextField *statetxt;
@property (strong, nonatomic) IBOutlet UITextField *postalcodetxt;

@property (strong, nonatomic) IBOutlet UIButton *dobBtn;
@property (strong, nonatomic) IBOutlet UIButton *deleteBtn;
@property (weak, nonatomic) IBOutlet UILabel *discountPrice1;
@property (weak, nonatomic) IBOutlet UILabel *discountPrice3;

@property (weak, nonatomic) IBOutlet UILabel *discountPrice2;
@property (weak,nonatomic) NSString * eventName;
@property (weak,nonatomic) NSString * cityName;
@property (weak,nonatomic) NSString * venueName;
@property (weak,nonatomic) NSString * venuePostcodeName;
@property (weak,nonatomic) NSString * startDateName;
@property (weak,nonatomic) NSString * endDateName;
@property (weak,nonatomic) NSString * statusTicketName;
@property (weak,nonatomic) NSString * earlyBirdPriceName;
@property (weak,nonatomic) NSString * earlyBirdQuantityName;
@property (weak,nonatomic) NSString * standardPriceName;
@property (weak,nonatomic) NSString * standardQuantityName;
@property (weak,nonatomic) NSString * vipPriceName;
@property (weak,nonatomic) NSString * vipQuantityName;
@property (weak,nonatomic) NSString * descriptionName;
@property (weak,nonatomic) NSString * image1Name;
@property (weak,nonatomic) NSString * image2Name;
@property (weak,nonatomic) NSString * image3Name;
@property (weak,nonatomic) NSString * eventbnName;
@property (weak,nonatomic) NSString * venueAddressName;
@property (weak,nonatomic) NSString * eventStartTimeName;
@property (weak,nonatomic) NSString * imageId1;
@property (weak,nonatomic) NSString * imageId;
@property (weak,nonatomic) NSString * eventIdEdit;
@property (weak,nonatomic) NSString * PricePayonDoor;
@property (weak,nonatomic) NSString * imageId2;
@property (weak,nonatomic) NSString * eventendTimeName;
@property (strong, nonatomic) IBOutlet UIButton *deleteImg2;
@property (strong, nonatomic) IBOutlet UIButton *deleteImg1;
@property (nonatomic) double latitudeEdit;
@property (nonatomic) double longitudeEdit;

@property (strong, nonatomic) IBOutlet UITextField *pricePayonDoorTxt;
@property (strong, nonatomic) IBOutlet UIView *payonDorViewPrice;

@end
