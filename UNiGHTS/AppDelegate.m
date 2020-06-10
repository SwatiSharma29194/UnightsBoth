
//
//  AppDelegate.m
//  UNiGHTS
//
//  Created by user on 12/06/18.
//  Copyright © 2018 RVTechnologies Softwares PVT. LTD. All rights reserved.............................................
//

#import "AppDelegate.h"
#import <GoogleMaps/GoogleMaps.h>
#import <GooglePlaces/GooglePlaces.h>
#import <CoreLocation/CoreLocation.h>
#import "common.h"
#import "PayPalMobile.h"
#import <Stripe/Stripe.h>
#import <FirebaseAuth/FirebaseAuth.h>
#import <FirebaseAuth/FIROAuthProvider.h>
#import <FirebaseCore/FirebaseCore.h>
#import <UserNotifications/UserNotifications.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import "SWRevealViewController.h"
#import <MapKit/MapKit.h>
@interface AppDelegate ()<CLLocationManagerDelegate,FIRAuthUIDelegate,UNUserNotificationCenterDelegate>

@end
@import Firebase;
@import FirebaseInstanceID;
@import UserNotifications;

@implementation AppDelegate
CLLocationManager *  locationManagerApp;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    

//
//     [application registerForRemoteNotificationTypes:(UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound)];
//    [[UILabel appearance] setFont:[UIFont fontWithName:@"System" size:17.0]];
//       [[UIButton appearance] setFont:[UIFont fontWithName:@"System" size:17.0]];
//      [[UITextField appearance] setFont:[UIFont fontWithName:@"System" size:17.0]];

    [[STPPaymentConfiguration sharedConfiguration] setPublishableKey:@"pk_live_K81gQijx4kqxpJxvGO3r6za7"];
    [NSThread sleepForTimeInterval:3.0];
//    UIUserNotificationSettings* notificationSettings = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeAlert | UIUserNotificationTypeBadge | UIUserNotificationTypeSound categories:nil];
 
    {
        
        if(!([[NSUserDefaults standardUserDefaults]
            stringForKey:@"CounterValue"] == nil))
        {
    NSString *savedValue = [[NSUserDefaults standardUserDefaults]
                            stringForKey:@"CounterValue"];
//
    if ([savedValue isEqualToString:@"2"])
    {
      UserRole =@"1";
        
        SWRevealViewController *vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"SwRevelController"];
        UINavigationController *navController = [[UINavigationController alloc]initWithRootViewController:vc];
        
  
        UINavigationController *navigationController; navigationController=[[UINavigationController alloc] initWithRootViewController:vc];
        
        navigationController.navigationBarHidden = YES;
        
        self.window.rootViewController =nil;
        self.window.rootViewController = navigationController;
        [self.window makeKeyAndVisible];
//        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
//        SWRevealViewController *str=[storyboard instantiateViewControllerWithIdentifier:@"SwRevelController"];
//
//
//        UINavigationController *navigationController=[[UINavigationController alloc] initWithRootViewController:str];
//
//        self.window.rootViewController =nil;
//        self.window.rootViewController = navigationController;
     
    }
    else if ([savedValue isEqualToString:@"3"])
    {
        UserRole =@"0";
        SWRevealViewController *vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"SwRevelController"];
        UINavigationController *navController = [[UINavigationController alloc]initWithRootViewController:vc];
        
        
        UINavigationController *navigationController; navigationController=[[UINavigationController alloc] initWithRootViewController:vc];
        
        navigationController.navigationBarHidden = YES;
        
        self.window.rootViewController =nil;
        self.window.rootViewController = navigationController;
        [self.window makeKeyAndVisible];
        
       
        
    }
    }
    }
   // [[UIApplication sharedApplication] registerUserNotificationSettings:notificationSettings];
    locationManagerApp = [[CLLocationManager alloc] init];
    locationManagerApp.desiredAccuracy = kCLLocationAccuracyNearestTenMeters;
    locationManagerApp.delegate = self;
    [locationManagerApp requestAlwaysAuthorization];
    locationManagerApp.distanceFilter = kCLDistanceFilterNone;
    locationManagerApp.desiredAccuracy = kCLLocationAccuracyBest;
    locationManagerApp.delegate = self;
    [locationManagerApp startUpdatingLocation];
    NSString *const kAPIKey = @"AIzaSyBNKyixEriX4ZvxLHdhlun9YBjHlF_hgWk";
    if (kAPIKey.length == 0) {
        // Blow up if APIKey has not yet been set.
        NSString *bundleId = [[NSBundle mainBundle] bundleIdentifier];
        NSString *format = @"Configure APIKey inside SDKDemoAPIKey.h for your "
        @"bundle `%@`, see README.GoogleMapsDemos for more information";
        @throw [NSException exceptionWithName:@"DemoAppDelegate"
                                       reason:[NSString stringWithFormat:format, bundleId]
                                     userInfo:nil];
    }
    UIApplication.sharedApplication.statusBarStyle = UIStatusBarStyleLightContent;
    [GMSServices provideAPIKey:kAPIKey];
    [GMSPlacesClient provideAPIKey:kAPIKey];
        [PayPalMobile initializeWithClientIdsForEnvironments:@{PayPalEnvironmentProduction : @"AWQ8ou34dq2PLZhpLtBDCPmcSOHPow7KSnKSdLPtXxyxGcUWJ3bQXe-8M55Qc3WmuyAuJO4zWxXd2LCm",PayPalEnvironmentSandbox:@"AS6znXnA-IV6ZjQOcd_A--8X55MmPF9vcuRLOSCEyEjPN8PC-ktSCjqIsk_v5NtXrGQC1zBxyiaz-lYe"}];
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
    [[FBSDKApplicationDelegate sharedInstance] application:application
                             didFinishLaunchingWithOptions:launchOptions];
     [FIRApp configure];
    return YES;
}



- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"didFailWithError: %@", error);
    UIAlertView *errorAlert = [[UIAlertView alloc]
                               initWithTitle:@"Error" message:@"Failed to Get Your Location" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [errorAlert show];
}
- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
            options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options {
    
    BOOL handled = [[FBSDKApplicationDelegate sharedInstance] application:application
                                                                  openURL:url
                                                        sourceApplication:options[UIApplicationOpenURLOptionsSourceApplicationKey]
                                                               annotation:options[UIApplicationOpenURLOptionsAnnotationKey]
                    ];
    if ([[FIRAuth auth] canHandleURL:url]) {
        return YES;
    }
   
    // Add any custom logic here.
    return handled;
}
- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    NSLog(@"didUpdateToLocation: %@", newLocation);
    CLLocation *currentLocation = newLocation;
    
    if (currentLocation != nil) {
       NSString *getLong = [NSString stringWithFormat:@"%.8f", currentLocation.coordinate.longitude];
        NSString *getLat = [NSString stringWithFormat:@"%.8f", currentLocation.coordinate.latitude];
        [[NSUserDefaults standardUserDefaults]setValue:getLong forKey:@"getLong"];
           [[NSUserDefaults standardUserDefaults]setValue:getLat forKey:@"getLat"];
    }

}
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}
- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
     [FBSDKAppEvents activateApp];
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}
- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


- (void)application:(UIApplication *)application
didReceiveRemoteNotification:(NSDictionary *)notification
fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    // Pass notification to auth and check if they can handle it.
    if ([[FIRAuth auth] canHandleNotification:notification]) {
        completionHandler(UIBackgroundFetchResultNoData);
        return;
    }
    // This notification is not auth related, developer should handle it.
}

- (void)application:(UIApplication *)application
didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    // Pass device token to auth.
    NSString *token = [[FIRInstanceID instanceID] token];
    if(token != nil){
        NSLog(@"%@",token);
        NSData* fcmToken = [token dataUsingEncoding:NSUTF8StringEncoding];
        if(fcmToken != nil){
            //[SchoopUser registerDeviceToken:fcmToken isFromString:YES];
            //[SchoopUser registerDeviceToken:fcmToken isFromString:YES];
        }
        
        //[[FIRAuth auth] setAPNSToken:token type:FIRAuthAPNSTokenTypeSandbox];
    }
    // Further handling of the device token if needed by the app.
}
//- (void)application:(UIApplication *)application
//didReceiveRemoteNotification:(NSDictionary *)notification
//fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
//
//    // Pass notification to auth and check if they can handle it.
//    if ([[FIRAuth auth] canHandleNotification:notification]) {
//
//        completionHandler(UIBackgroundFetchResultNoData);
//
//        return;
//    }
//    completionHandler(UIBackgroundFetchResultNoData);
//
//    // This notification is not auth related, developer should handle it.
//}
//- (void)dismissViewControllerAnimated:(BOOL)flag completion:(void (^ _Nullable)(void))completion {
//
//}
//
//- (void)presentViewController:(nonnull UIViewController *)viewControllerToPresent animated:(BOOL)flag completion:(void (^ _Nullable)(void))completion {
//
//}

@end
