//
//  ticketDetailsViewController.m
//  UNiGHTS
//
//  Created by user on 7/5/18.
//  Copyright © 2018 RVTechnologies Softwares PVT. LTD. All rights reserved.
//

#import "ticketDetailsViewController.h"
#import "UIImageView+WebCache.h"
@interface ticketDetailsViewController ()

@end

@implementation ticketDetailsViewController
{
    UIImage *qrImageShare;
    CIImage *output;
}
- (NSString *)encodeToBase64String:(UIImage *)image {
    return [UIImagePNGRepresentation(image) base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    _refNumber.text = _getRef;
    _ticketNumber.text = [NSString stringWithFormat:@"%@%@",@"AMOUNT OF TICKETS: ",_getCountTickets];
    _paidAmount.text = _getpaidAmount;
    _name.text = _getUsername;
    _dateCheck.text = _getDate;
    _addressTxt.text = _addressget;
    _timeStart.text = _getStartTime;
    _eventNameT.text = _eventNamed;
    NSString *info = _QRCode;
    NSData *stringData = [info dataUsingEncoding:NSISOLatin1StringEncoding];
    
    CIFilter *qrFilter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    
    [qrFilter setValue:stringData forKey:@"inputMessage"];
    
    CGAffineTransform transform = CGAffineTransformMakeScale(5.0f, 5.0f);
    
    [_eventImg sd_setImageWithURL:[NSURL URLWithString:_getImgEvent]];
  
    
    // Scale by 5 times along both dimensions
    if([_usedTicket  isEqual: @"used"])
    {
        _shareTicket.hidden = YES;
        _qrImage.image = [UIImage imageNamed:@"2018-10-11 (1).png"];
        
    }
    else
    {
          _shareTicket.hidden = NO;
  output = [qrFilter.outputImage imageByApplyingTransform: transform];
    
    CIImage *ciImage = output;
    UIImage *uiImage = [[UIImage alloc] initWithCIImage:ciImage];
    NSData* data = UIImagePNGRepresentation(uiImage);

    _qrImage.image = [UIImage imageWithCIImage:output];
    
    qrImageShare = _qrImage.image;
//    qrImageShare = [[UIImage alloc] initWithCIImage:_qrImage.image];
    
   
    }
    
 
    // Do any additional setup after loading the view.
}

- (IBAction)shareTicket:(id)sender {


    UIGraphicsBeginImageContextWithOptions(self.viewShare.bounds.size, self.viewShare.opaque, 0.0);
    [self.viewShare.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage * img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    NSData *newPNG=UIImagePNGRepresentation(img);
    NSArray * objectsToShare = @[newPNG];
    
 
  
    
    UIActivityViewController *activityVC = [[UIActivityViewController alloc] initWithActivityItems:objectsToShare applicationActivities:nil];
    
    NSArray *excludeActivities = @[UIActivityTypeAirDrop,
                                   UIActivityTypePrint,
                                   UIActivityTypeAssignToContact,
                                   UIActivityTypeSaveToCameraRoll,
                                   UIActivityTypeAddToReadingList,
                                   UIActivityTypePostToFlickr,
                                   UIActivityTypePostToVimeo];
    
    activityVC.excludedActivityTypes = excludeActivities;
    
    [self presentViewController:activityVC animated:YES completion:nil];
}
- (IBAction)backBtnTap:(id)sender {
    
    [self.navigationController popViewControllerAnimated:true];
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
