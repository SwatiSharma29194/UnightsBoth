//
//  QRCodeScannerViewController.h

// Safe2Meet

//  Copyright © 2016 Amit Sharma. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol QRCodeDelegate <NSObject>

@optional

- (void) QRCodeDetected:(NSString*)qrCode;

@end

@interface QRCodeScannerViewController : UIViewController{
BOOL isUsingFrontFacingCamera;
  
}
@property (weak, nonatomic) IBOutlet UIView *viewPreview;
@property (nonatomic, assign) id<QRCodeDelegate> delegate;

@end
