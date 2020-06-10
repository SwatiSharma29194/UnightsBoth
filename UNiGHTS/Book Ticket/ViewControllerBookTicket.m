//
//  ViewControllerBookTicket.m
//  UNiGHTS
//
//  Created by user on 20/06/18.
//  Copyright © 2018 RVTechnologies Softwares PVT. LTD. All rights reserved.
//

#import "ViewControllerBookTicket.h"
#import "paymentViewController.h"
#import "UIImageView+WebCache.h"
@interface ViewControllerBookTicket ()

@end

@implementation ViewControllerBookTicket
int getTotalCalculate;
int getTotalVip;
int getTotalStandard;
int getTotalEarly;
int geterlyPint ;
int getvippoint;
int getstandardpoint;
int pointTotal;
- (void)viewDidLoad {
    [super viewDidLoad];
    if([_getpriceVip  isEqual: @"N/A"])
    {
        _stepper3.hidden = YES;
        _vipTicketPrice.text = @"N/A";
    }
    else
    {
        _stepper3.hidden = NO;
        
        int getd = _remainingTicketsvip.integerValue;
        
        _stepper3.maximumValue = getd;
        _vipTicketPrice.text = @"0";
    }
    if([_getpriceStandard  isEqual: @"N/A"])
    {
        _stepper2.hidden = YES;
        _standardTicketQuantity.text = @"N/A";
    }
    else
    {
        _stepper2.hidden = NO;
        int getd = _remainingTicketsstandard.integerValue;
        
        _stepper2.maximumValue = getd;
        _standardTicketQuantity.text = @"0";
    }
    if([_getPriceEarlyBird  isEqual: @"N/A"])
    {
        _stepper1.hidden = YES;
        _earlyBirdTicketQuantity.text = @"N/A";
    }
    else
    {
        _stepper1.hidden = NO;
            int getd = _remainingTicketsEarly.integerValue;
        _stepper1.maximumValue = getd;
        _earlyBirdTicketQuantity.text = @"0";
    }
    
     NSString *getEventDate = [[NSUserDefaults standardUserDefaults]valueForKey:@"getEventDate"];
    _dateTicket.text = getEventDate;
    

//
    
    NSArray * getEventArr = [[NSUserDefaults standardUserDefaults]valueForKey:@"ImgbaseUrl"];
    
    for(int i = 0;i<getEventArr.count;i++)
    {
        //                    let imageviewdata = UIImageView()
        //                    imageviewdata.frame = CGRect(x: CGFloat(self.to_scroll.frame.size.width * CGFloat(x)), y: 0, width: self.to_scroll.frame.size.width, height: self.to_scroll.frame.size.height)
        
        UIImageView *getl;
        getl = [[UIImageView alloc]init];
        getl.frame = CGRectMake(self.carscrollview.frame.size.width * i, 0, self.carscrollview.frame.size.width, self.carscrollview.frame.size.width);
        
        NSDictionary *getDictImage = [getEventArr objectAtIndex:i];
        
        NSString * getEventImg = [NSString stringWithFormat:@"%@",[getDictImage valueForKey:@"image"]];
        
        NSString * ImgbaseUrl = @"http://18.188.52.230/unights/public/events/";
        if(!([[ImgbaseUrl stringByAppendingString:getEventImg] isKindOfClass:[NSNull class]])){
            
            
            
            ImgbaseUrl= [ImgbaseUrl stringByAppendingString:getEventImg];
            
            [getl sd_setImageWithURL:[NSURL URLWithString:ImgbaseUrl]];
            
            
        }
        
        [self.carscrollview addSubview:getl];
        
        
    }
    _carscrollview.contentSize = CGSizeMake(self.carscrollview.frame.size.width * getEventArr.count, self.carscrollview.frame.size.height);
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)stepper3Tap:(id)sender {
    
    int vl=_stepper3.value;
    _vipTicketPrice.text = [NSString stringWithFormat:@"%d",vl];
    
    NSArray *sep = [_getpriceVip componentsSeparatedByString:@"£"];

    NSInteger getPriceVIP = [sep[1] integerValue];
    getTotalVip = (getPriceVIP * vl);
    getTotalCalculate =getTotalVip +getTotalEarly +getTotalStandard ;
    
    NSInteger getPriceVIP2 = [_vipPoints integerValue];
    getvippoint = (getPriceVIP2 * vl);
    pointTotal =getvippoint +getstandardpoint +geterlyPint ;
    _pointsTxt.text = [NSString stringWithFormat:@"%d",pointTotal];
    _subtotalPrice.text = [NSString stringWithFormat:@"%@%d",@"£",getTotalCalculate];
    
    _totalPrice.text = [NSString stringWithFormat:@"%@%d",@"£",getTotalCalculate];
    _pomits.text = [NSString stringWithFormat:@"%s%d","Points:",pointTotal];
    
    

   
}
- (IBAction)stepper2Tap:(id)sender {
     int vl=_stepper2.value;
    _standardTicketQuantity.text = [NSString stringWithFormat:@"%d",vl];
    NSArray *sep = [_getpriceStandard componentsSeparatedByString:@"£"];
    NSInteger getPriceVIP = [sep[1] integerValue];
    
    getTotalStandard = (getPriceVIP * vl);
    getTotalCalculate =getTotalVip +getTotalEarly +getTotalStandard ;
    _subtotalPrice.text = [NSString stringWithFormat:@"%@%d",@"£",getTotalCalculate];
    
    _totalPrice.text = [NSString stringWithFormat:@"%@%d",@"£",getTotalCalculate];
    
    NSInteger getPriceVIP2 = [_standardPoints integerValue];
    getstandardpoint = (getPriceVIP2 * vl);
    pointTotal =getvippoint +getstandardpoint +geterlyPint ;
    _pointsTxt.text = [NSString stringWithFormat:@"%d",pointTotal];
        _pomits.text = [NSString stringWithFormat:@"%s%d","Points:",pointTotal];
}
- (IBAction)stepper1Tap:(id)sender {
    int vl=_stepper1.value;
    _earlyBirdTicketQuantity.text = [NSString stringWithFormat:@"%d",vl];
    NSArray *sep = [_getPriceEarlyBird componentsSeparatedByString:@"£"];
    NSInteger getPriceVIP = [sep[1] integerValue];
    getTotalEarly = (getPriceVIP * vl);
    getTotalCalculate =getTotalVip +getTotalEarly +getTotalStandard ;
    //getTotalCalculate = (getPriceVIP * vl);
    _subtotalPrice.text = [NSString stringWithFormat:@"%@%d",@"£",getTotalCalculate];
    
      _totalPrice.text = [NSString stringWithFormat:@"%@%d",@"£",getTotalCalculate];
    NSInteger getPriceVIP2 = [_earlyPoints integerValue];
    geterlyPint = (getPriceVIP2 * vl);
    pointTotal =getvippoint +getstandardpoint +geterlyPint ;
    _pointsTxt.text = [NSString stringWithFormat:@"%d",pointTotal];
      _pomits.text = [NSString stringWithFormat:@"%s%d","Points:",pointTotal];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (IBAction)confirmBookingTap:(id)sender {
    UIStoryboard *obj=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
    paymentViewController *str=[obj instantiateViewControllerWithIdentifier:@"payment"];
    str.FromBooking = @"Book";
    if([_vipTicketPrice.text  isEqual: @"0"] && [_standardTicketQuantity.text  isEqual: @"0"] && [_earlyBirdTicketQuantity.text  isEqual: @"0"])
    {
        
        UIAlertController * alert = [UIAlertController
                                     alertControllerWithTitle:@"UNiGHTS"
                                     message:@"Add atleast one ticket"
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
    else if([_vipTicketPrice.text  isEqual: @"0"] && [_standardTicketQuantity.text  isEqual: @"N/A"] && [_earlyBirdTicketQuantity.text  isEqual: @"N/A"])
    {
        UIAlertController * alert = [UIAlertController
                                     alertControllerWithTitle:@"UNiGHTS"
                                     message:@"Add atleast one ticket"
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
    
    else if([_vipTicketPrice.text  isEqual: @"N/A"] && [_standardTicketQuantity.text  isEqual: @"0"] && [_earlyBirdTicketQuantity.text  isEqual: @"N/A"])
    {
        UIAlertController * alert = [UIAlertController
                                     alertControllerWithTitle:@"UNiGHTS"
                                     message:@"Add atleast one ticket"
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
    
    else if([_vipTicketPrice.text  isEqual: @"N/A"] && [_standardTicketQuantity.text  isEqual: @"N/A"] && [_earlyBirdTicketQuantity.text  isEqual: @"0"])
    {
        
        UIAlertController * alert = [UIAlertController
                                     alertControllerWithTitle:@"UNiGHTS"
                                     message:@"Add atleast one ticket"
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
    if(([_vipTicketPrice.text  isEqual: @"0"]) || ([_vipTicketPrice.text  isEqual: @"N/A"]))
    {
        
        str.priceVIP = @"0";
        str.ticketsVIP = @"0";
    }
    
    else
    {
        NSArray *getAr = [_getpriceVip componentsSeparatedByString:@"£"];
        str.priceVIP = getAr[1];
        str.ticketsVIP = _vipTicketPrice.text;
    }
    if([_standardTicketQuantity.text  isEqual: @"0"] || [_standardTicketQuantity.text  isEqual: @"N/A"])
    {
        str.priceStandard = @"0";
        str.ticketsStandard = @"0";
    }
    else
    {
        NSArray *getAr = [_getpriceStandard componentsSeparatedByString:@"£"];
        str.priceStandard = getAr[1];
        str.ticketsStandard = _standardTicketQuantity.text;
    }
    if([_earlyBirdTicketQuantity.text  isEqual: @"0"] || [_earlyBirdTicketQuantity.text  isEqual: @"N/A"])
    {
        str.priceEarly = @"0";
        str.ticketsEarly = @"0";
    }
    else
    {
        NSArray *getAr = [_getPriceEarlyBird componentsSeparatedByString:@"£"];
        str.priceEarly = getAr[1];
        str.ticketsEarly = _earlyBirdTicketQuantity.text;
    }
        
        str.geTotalAmount = [NSString stringWithFormat:@"%d",getTotalCalculate];
        str.pointsTotal =  [NSString stringWithFormat:@"%d",pointTotal];
        [self.navigationController pushViewController:str animated:true];
    }
   
}

- (IBAction)BookTicketTapped:(id)sender
{
     [self.navigationController popViewControllerAnimated:YES];
}
@end
