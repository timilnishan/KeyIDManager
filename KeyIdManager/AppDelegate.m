//
//  AppDelegate.m
//  KeyIdManager
//
//  Created by design_offshore on 3/30/14.
//  Copyright (c) 2014 Key_id_Manager. All rights reserved.
//

#import "AppDelegate.h"


@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    

    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    LoginVC *login=[[LoginVC alloc] init];
   UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:login];
    self.revealSideViewController = [[PPRevealSideViewController alloc] initWithRootViewController:nav];

    [self.revealSideViewController setDirectionsToShowBounce:PPRevealSideDirectionRight];
    [self.revealSideViewController setPanInteractionsWhenClosed:PPRevealSideInteractionContentView | PPRevealSideInteractionNavigationBar];
    
    self.window.rootViewController = self.revealSideViewController;

    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    //if (FBSession.activeSession.state == FBSessionStateCreatedTokenLoaded) {
//        NSLog(@"Found a cached session");
//        // If there's one, just open the session silently, without showing the user the login UI
//        [FBSession openActiveSessionWithReadPermissions:@[@"basic_info"]
//                                           allowLoginUI:NO
//                                      completionHandler:^(FBSession *session, FBSessionState state, NSError *error) {
//                                          // Handler for session state changes
//                                          // This method will be called EACH time the session state changes,
//                                          // also for intermediate states and NOT just when the session open
//                                          [self sessionStateChanged:session state:state error:error];
//                                      }];
//        
//        // If there's no cached session, we will show a login button
//    } else {
//       // UIButton *loginButton = [self.customLoginViewController loginButton];
//        //[loginButton setTitle:@"Log in with Facebook" forState:UIControlStateNormal];
//    }

  
    return YES;
}


- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    BOOL wasHandled = [FBAppCall handleOpenURL:url sourceApplication:sourceApplication];
    
    return [GPPURLHandler handleURL:url
                  sourceApplication:sourceApplication
                         annotation:annotation];
    // add any app-specific handling code here
    return wasHandled;
}

- (void)sessionStateChanged:(FBSession *)session state:(FBSessionState) state error:(NSError *)error
{
    // If the session was opened successfully
    if (!error && state == FBSessionStateOpen){
        NSLog(@"Session opened");
        // Show the user the logged-in UI
       // [self userLoggedIn];
        return;
   }
if (state == FBSessionStateClosed || state == FBSessionStateClosedLoginFailed){
    // If the session is closed
       NSLog(@"Session closed");
      // Show the user the logged-out UI
       // [self userLoggedOut];
   }
}
////

//    }
//    - (void) userLoggedOut
//    {
//           }
//    - (void)userLoggedIn
//    {
//        

        // Welcome message
       // [self showMessage:@"You're now logged in" withTitle:@"Welcome!"];
        




- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
