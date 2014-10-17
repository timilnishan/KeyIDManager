//
//  LoginVC.m
//  KeyIdManager
//
//  Created by design_offshore on 3/30/14.
//  Copyright (c) 2014 Key_id_Manager. All rights reserved.
//

#import "LoginVC.h"
#import "AppDelegate.h"



@interface LoginVC ()

@end

@implementation LoginVC
@synthesize feedRequest,MyScrollView,indicator,overlayView,myArray,LoginfacebookRequest,facebookArray,passwordIconImageView,HUD;
@synthesize signInButton,friendsDetailsArray,mynav,settingArray;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (void) showRightt:(id)sender
{
    [self.revealSideViewController pushOldViewControllerOnDirection:PPRevealSideDirectionRight animated:YES];
}
- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.settingArray=[[NSMutableArray alloc] init];
    [self LoadFirst];
//    [self apicallForSetting];
//    SettingDataModel *model=[settingArray objectAtIndex:0];
//    NSString *pass=[model password_require];
//    if([pass isEqualToString:@"OFF"]){
//        passwordIconImageView.hidden=YES;
//        _PasswordTextField.hidden=YES;
//    }

     self.navigationItem.hidesBackButton=YES;
    
}
-(void) LoadFirst{
    
    [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"navigation_menu.png"] forBarMetrics:UIBarMetricsDefault	];
    
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"ic_drawer.png"]  style:UIBarButtonItemStyleBordered target:self action:@selector(showRightt:)];
    
    RightSettingVC *right = [[RightSettingVC alloc]init];
    [self.revealSideViewController preloadViewController:right forSide:PPRevealSideDirectionRight];
    indicator.hidden=YES;
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    
    // saving an NSString
    NSString *pword = [prefs objectForKey:@"password"];
    NSString *user = [prefs objectForKey:@"UserName"];
    [_EmailTextField setText:user];
    [_PasswordTextField setText:pword];
    self.facebookArray=[[NSMutableArray alloc] init];
    MyScrollView.contentSize=CGSizeMake(320,400);
    self.myArray=[[NSMutableArray alloc] init];
    
    _EmailTextField.delegate=self;
    _PasswordTextField.delegate=self;
    _PasswordTextField.secureTextEntry=YES;
    _EmailTextField.placeholder=@"Email";
    _PasswordTextField.placeholder=@"Password";
    // [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"wal.png"]]];
    
    
    
    static NSString * const kClientId = @"648108521633-lff65n17usvhft9l1daeuah5a74t2rf6.apps.googleusercontent.com";
    
    GPPSignIn *signIn = [GPPSignIn sharedInstance];
    signIn.shouldFetchGooglePlusUser = YES;
    signIn.shouldFetchGoogleUserEmail = YES;  // Uncomment to get the user's email
    signIn.shouldGroupAccessibilityChildren=YES;
    
    // You previously set kClientId in the "Initialize the Google+ client" step
    signIn.clientID = kClientId;
    
    
    // Uncomment one of these two statements for the scope you chose in the previous step
    //signIn.scopes = @[ kGTLAuthScopePlusLogin ];  // "https://www.googleapis.com/auth/plus.login" scope
    //signIn.scopes = @[ @"profile" ];            // "profile" scope
    
    // Optional: declare signIn.actions, see "app activities"
    signIn.delegate = self;

}
- (void)viewWillDisappear:(BOOL)animated{
   

}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.settingArray=[[NSMutableArray alloc] init];
    [self LoadFirst];
//    [self apicallForSetting];
//    SettingDataModel *model=[settingArray objectAtIndex:0];
//    NSString *pass=[model password_require];
//    if([pass isEqualToString:@"OFF"]){
//        passwordIconImageView.hidden=YES;
//        _PasswordTextField.hidden=YES;
//    }
//
   }



- (void)finishedWithAuth: (GTMOAuth2Authentication *)auth
                   error: (NSError *) error {
    NSLog(@"Received error %@ and auth object %@",error, auth);
    if (error) {
        // Do some error handling here.
    } else {
        [self refreshInterfaceBasedOnSignIn];
           }
}


-(void)refreshInterfaceBasedOnSignIn {
    if ([[GPPSignIn sharedInstance] authentication]) {
        // The user is signed in.
        //self.signInButton.hidden = YES;
        NSLog(@"success");
        GPPSignIn *signIn = [GPPSignIn sharedInstance];

    }
//fetch friend circle form google plus
        

      //  GTLServicePlus* plusService = [[GTLServicePlus alloc] init];
      //  plusService.retryEnabled = YES;
//[plusService setAuthorizer:[GPPSignIn sharedInstance].authentication];
        
       // GTLQueryPlus *query =
        //[GTLQueryPlus queryForPeopleListWithUserId:@"me"
                                        //collection:kGTLPlusCollectionVisible];
      //  GTLQueryPlus *query = [GTLQueryPlus queryForPeopleGetWithUserId:@"me"];
      //  [plusService executeQuery:query
        //        completionHandler:^(GTLServiceTicket *ticket,
                            
          //                          GTLPlusPerson *peopleFeed,
          //                          NSError *error) {
           //         if (error) {
            //            GTMLoggerError(@"Error: %@", error);
            //        } else {
                        // Get an array of people from GTLPlusPeopleFeed
                     /*  NSString *description = [NSString stringWithFormat:
                                                 @"Name:%@\n sex:%@ \n Email:%@ \n UserId:%@", peopleFeed.displayName,
                                                 peopleFeed.gender,signIn.authentication.userEmail,signIn.authentication.userID];*/
                       // NSArray* peopleList = peopleFeed.items;
                   //     NSLog(@"peopleList=%@",description );
             //       }
             //   }];


        // Perform other actions here, such as showing a sign-out button
//    } else {
//        self.signInButton.hidden = NO;
//        // Perform other actions here
//    }
//}
    // Do any additional setup after loading the view from its nib.
 
//    
//    //self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] in:@"Left"
//                                                                             style:[UIBarButtonItemStyleBordered
//                                                                            target:self
//                                                                            action:@selector(showLeft:)];
}
   - (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}
- (BOOL)textFieldShouldReturn:(UITextField *)theTextField {
    [theTextField resignFirstResponder];
    return YES;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)GPlusAction:(id)sender {
    //g+

  
}

- (IBAction)SingUpAction:(id)sender {
    RegisterVC *rg=[[RegisterVC alloc] initWithNibName:@"RegisterVC" bundle:nil];
    [self.navigationController pushViewController:rg animated:NO];
}
-(BOOL) isValidEmail:(NSString *)checkString
{
    checkString = [checkString lowercaseString];
    BOOL stricterFilter = YES;
    NSString *stricterFilterString = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSString *laxString = @".+@.+\\.[A-Za-z]{2}[A-Za-z]*";
    
    NSString *emailRegex = stricterFilter ? stricterFilterString : laxString;
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    
    return [emailTest evaluateWithObject:checkString];
}
- (IBAction)SingInAction:(id)sender {
    if([_EmailTextField.text isEqualToString:@""]){
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Error!" message:@"Email Not Be Empty" delegate:Nil cancelButtonTitle:@"Ok" otherButtonTitles:@"Cancel", nil];
        [alert show];
    }
    else if([_PasswordTextField.text isEqualToString:@""]){
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Error!" message:@"Password Not Be Empty" delegate:Nil cancelButtonTitle:@"Ok" otherButtonTitles:@"Cancel", nil];
        [alert show];
    }
    else if(![self isValidEmail:_EmailTextField.text]){
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Error!" message:@"Enter a valid email address." delegate:Nil cancelButtonTitle:@"Ok" otherButtonTitles:@"Cancel", nil];
        [alert show];
}
    else{
        [self apicall];
        //DashboardVC *home=[[DashboardVC alloc] initWithNibName:@"DashboardVC" bundle:nil];
        //[self.navigationController pushViewController:home animated:YES];
    }
    
}

- (IBAction)FacebookLoginAction:(id)sender {
//    // If the session state is any of the two "open" states when the button is clicked
//    if (FBSession.activeSession.state == FBSessionStateOpen
//        || FBSession.activeSession.state == FBSessionStateOpenTokenExtended) {
//        
//        // Close the session and remove the access token from the cache
//        // The session state handler (in the app delegate) will be called automatically
//        [FBSession.activeSession closeAndClearTokenInformation];
//        
//        // If the session state is not any of the two "open" states when the button is clicked
//    } else {
//        // Open a session showing the user the login UI
//        // You must ALWAYS ask for basic_info permissions when opening a session
//        [FBSession openActiveSessionWithReadPermissions:@[@"basic_info"]
//                                           allowLoginUI:YES
//                                      completionHandler:
//         ^(FBSession *session, FBSessionState state, NSError *error) {
//             
//             // Retrieve the app delegate
//             AppDelegate* appDelegate = [UIApplication sharedApplication].delegate;
//             // Call the app delegate's sessionStateChanged:state:error method to handle session state changes
//             [appDelegate sessionStateChanged:session state:state error:error];
//         }];
//    }
    //[self fetchSaveUserFriendDetails];
    
    
   
   
        


    NSArray* permissions = [NSArray arrayWithObjects:@"basic_info",@"email",@"user_location",nil];
    [FBSession openActiveSessionWithReadPermissions:permissions
                                       allowLoginUI:YES
                                  completionHandler:^(FBSession *session, FBSessionState status, NSError *error) {
                                      // This is called when the state changes
                                      if( status == FBSessionStateOpen ) {
                                          // The session is open and we can read now
                                      
                                                                                  [FBRequestConnection startForMeWithCompletionHandler:^(FBRequestConnection *connection, id<FBGraphUser> result, NSError *error) {
                                              if( !error ) {
                                                 
                                                  NSLog(@"id:%@",result);
                                                 indicator.hidden=NO;
                                                 self.overlayView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
                                                  self.overlayView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
                                                  self.indicator.center = self.overlayView.center;
                                                 [self.overlayView addSubview:self.indicator];
                                                 [self.indicator startAnimating];
                                                 [self.view addSubview:self.overlayView];
                                                 [indicator startAnimating ];
                                                 indicator.hidesWhenStopped=YES;
                                                 NSString *serverURL = [NSString stringWithFormat:@"%@",URL_FB_LOGIN];
                                                 NSURL *url = [NSURL URLWithString:serverURL];
                                                 LoginfacebookRequest =[ASIFormDataRequest requestWithURL:url];
                                                 [LoginfacebookRequest setDelegate:self];
                                                 [LoginfacebookRequest setTimeOutSeconds:120];
                                                 [LoginfacebookRequest setRequestMethod:@"POST"];
                                                 
                                                 LoginfacebookRequest = [ASIFormDataRequest requestWithURL:url];
                                                  [LoginfacebookRequest setPostValue:result.id forKey:@"fb_id"];
                                                  [LoginfacebookRequest setPostValue:result.first_name forKey:@"first_name"];
                                                  [LoginfacebookRequest setPostValue:result.last_name forKey:@"last_name"];
                                                  [LoginfacebookRequest setPostValue:@"ktm" forKey:@"address"];
                                                  [LoginfacebookRequest setPostValue:[result objectForKey:@"email"] forKey:@"user_email"];
                                                  [LoginfacebookRequest setDelegate:self];
                                                 [LoginfacebookRequest startAsynchronous];
                                                  
                                              } else {
                                                  NSLog(@"An error occured while requesting the GraphUser: %@", error);
                                              }
                                          }];
                                 
                                          
                                      } else {
                                          // We were not allowed to login or it didn't work
                                          NSLog(@"Did not finish authorisation. Error: %@", error);
                                      }
                                  }];
    
//    NSString *fql = [NSString stringWithFormat:@"SELECT name, uid, contact_email  FROM user WHERE uid IN (SELECT uid2 FROM friend WHERE uid1=me())"];
//    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObject:fql forKey:@"q"];
//    [FBRequestConnection startWithGraphPath:@"/fql"
//                                 parameters:params
//                                 HTTPMethod:@"GET"
//                          completionHandler:^(FBRequestConnection *connection,
//                                              id result,
//                                              NSError *error) {
//                              if (error) {
//                                  NSLog(@"Error: %@", [error localizedDescription]);
//                              } else {
//                                  NSLog(@"Result: %@", result);
//                              }
//                          }];
    

    
   }




-(void) apicall{
    [self addActivity];
    NSString *serverURL = [NSString stringWithFormat:@"%@",URL_LOGIN];
    //NSString *serverURL = [NSString stringWithFormat:@"%@",URL_LOGIN];
    NSURL *url = [NSURL URLWithString:serverURL];
    
    feedRequest =[ASIFormDataRequest requestWithURL:url];
    [feedRequest setDelegate:self];
    [feedRequest setTimeOutSeconds:120];
    [feedRequest setRequestMethod:@"POST"];
    
    //HHUserDetails  *user=[Helper getUserProfileDetail];
    feedRequest = [ASIFormDataRequest requestWithURL:url];
    [feedRequest setPostValue:_EmailTextField.text forKey:@"user_name"];
    [feedRequest setPostValue:_PasswordTextField.text forKey:@"user_password"];
    [feedRequest setDelegate:self];
    [feedRequest startAsynchronous];
    
    
    
}
//-(void)fetchSaveUserFriendDetails
//{
//    NSString* query = [NSString stringWithFormat:@"SELECT uid,name,birthday_date,email FROM user WHERE uid IN (SELECT uid2 FROM friend WHERE uid1 = me())"];
//    
//    // Set up the query parameter
//    NSDictionary *queryParam = [NSDictionary dictionaryWithObjectsAndKeys:
//                                query, @"q", nil];
//    // Make the API request that uses FQL
//    [FBRequestConnection startWithGraphPath:@"/fql"
//                                 parameters:queryParam
//                                 HTTPMethod:@"GET"
//                          completionHandler:^(FBRequestConnection *connection,
//                                              id result,
//                                              NSError *error) {
//                              if (!error)
//                              {
//                                  NSLog(@"result is %@",result);
//                                  
//                                  NSArray *resultData = [result objectForKey:@"data"];
//                                  if ([resultData count] > 0) {
//                                      for (NSUInteger i=0; i<[resultData count] ; i++) {
//                                          [self.friendsDetailsArray addObject:[resultData objectAtIndex:i]];
//                                          NSLog(@"friend details are %@",friendsDetailsArray);
//                                      }
//                                  }
//                              }
//                              
//                          }];
//}
- (void)requestFailed:(ASIHTTPRequest *)request
{
    // [self hidehud];
    [self removeActivity];
	NSError *error = [request error];
    
    UIAlertView *alert = [[UIAlertView alloc]
                          initWithTitle:@"Error!" message:error.localizedDescription delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
    [alert show];
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
	
}
- (void)requestFinished:(ASIHTTPRequest *)request
{
    [self removeActivity];
    NSString  *responseString = [request responseString];
    if(request==LoginfacebookRequest){
        NSLog(@"p response:%@",responseString);
        NSArray *result = [responseString JSONValue] ;
        NSLog(@"response:%@",result);

        int isSucess = [[result  valueForKey:@"success"] intValue];
        NSString *Error = [result  valueForKey:@"response"];

        if(isSucess==0)
        {
            
            UIAlertView *Alert = [[UIAlertView alloc] initWithTitle:@"Error!" message:Error delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
            [Alert show];
        }
        else
        {
            // [self parseAllCommentsList];
            NSArray *result1 = [[responseString JSONValue]objectForKey:@"response"] ;
            UserDataModel *model=[[UserDataModel alloc] init];
            NSString *userid=[result1 valueForKey:@"user_id"];
            NSString *username=[result1 valueForKey:@"user_email"];
            NSString *password=[result1 valueForKey:@"user_password"];
            NSString *firstname=[result1 valueForKey:@"first_name"];
            NSString *usertype=[result1 valueForKey:@"user_type_name"];
            
            
            
            model.UserId=userid;
            model.username=username;
            model.firstname=firstname;
            model.password=password;
            model.user_type_name=usertype;
            NSLog(@"usertype:%@",usertype);
            [self.myArray addObject:model];
            HomeSettingVC *HOME=[[HomeSettingVC alloc] init];
            HOME.TYPE=usertype;
            NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
            [prefs setObject:_PasswordTextField.text forKey:@"password"];
            [prefs setObject:_EmailTextField.text forKey:@"UserName"];
            // [prefs setObject:userid forKey:@"userid"];
            [prefs synchronize];
            NSLog(@"username:%@",model.username);
            
            DashboardVC *home=[[DashboardVC alloc] initWithNibName:@"DashboardVC" bundle:nil];
            home.user_type=usertype;
            home.username=username;
            home.password=password;
            home.user_id=userid;
            NSLog(@"user_id:%@",userid);
            [self.navigationController pushViewController:home animated:YES];

        }

        
    }
    if(request==feedRequest){
        NSLog(@"p response:%@",responseString);
        NSArray *result = [responseString JSONValue] ;
        
        int isSucess = [[result  valueForKey:@"success"] intValue];
        if(isSucess==0)
        {
                        UIAlertView *Alert = [[UIAlertView alloc] initWithTitle:@"Error!" message:@"Sorry Username or Password is Wrong!" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
            [Alert show];
        }
        else
        {
            // [self parseAllCommentsList];
            NSArray *result1 = [[responseString JSONValue]objectForKey:@"response"] ;

            UserDataModel *model=[[UserDataModel alloc] init];
            NSString *userid=[result1 valueForKey:@"user_id"];
            NSString *username=[result1 valueForKey:@"user_email"];
            NSString *password=[result1 valueForKey:@"user_password"];
            NSString *firstname=[result1 valueForKey:@"first_name"];
            NSString *usertype=[result1 valueForKey:@"user_type_name"];

      
    
            model.UserId=userid;
            model.username=username;
            model.firstname=firstname;
            model.password=password;
            model.user_type_name=usertype;
            NSLog(@"usertype:%@",usertype);
             [self.myArray addObject:model];
            HomeSettingVC *HOME=[[HomeSettingVC alloc] init];
            HOME.TYPE=usertype;
            NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
            [prefs setObject:_PasswordTextField.text forKey:@"password"];
            [prefs setObject:_EmailTextField.text forKey:@"UserName"];
             // [prefs setObject:userid forKey:@"userid"];
            [prefs synchronize];
            NSLog(@"username:%@",model.username);
                                                 
            DashboardVC *home=[[DashboardVC alloc] initWithNibName:@"DashboardVC" bundle:nil];
            home.user_type=usertype;
            home.user_id=userid;
            NSLog(@"user_id:%@",userid);
           // home.UserId=userid;
            overlayView.hidden=YES;
            [self.navigationController pushViewController:home animated:YES];
           
            
          
        }
        
        
    }

}


- (IBAction)ForgotpasswordAction:(id)sender {
   // UserDataModel *model=(UserDataModel *)[self.myArray objectAtIndex:1];
    //NSLog(@"username:%@",model.username);

    ForgotPasswordVC *pass=[[ForgotPasswordVC alloc] initWithNibName:@"ForgotPasswordVC" bundle:nil];
    [self.navigationController pushViewController:pass animated:YES];
}
- (IBAction)g:(id)sender {
}
-(void) apicallForSetting{
    NSString *serverURL = [NSString stringWithFormat:@"http://54.85.70.181/api/get-site-setting"];
    
    //    NSURL *url = [NSURL URLWithString:serverURL];
    //    aboutUsRequest =[ASIFormDataRequest requestWithURL:url];
    //    [aboutUsRequest setRequestMethod:@"GET"];
    //    [aboutUsRequest setDelegate:self];
    //    [aboutUsRequest startAsynchronous];
    //
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:serverURL]
                                                           cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData
                                                       timeoutInterval:10];
    
    [request setHTTPMethod: @"GET"];
    
    NSError *requestError;
    NSURLResponse *urlResponse = nil;
    
    
    NSData *response1 = [NSURLConnection sendSynchronousRequest:request returningResponse:&urlResponse error:&requestError];
    NSString* newStr = [[NSString alloc] initWithData:response1 encoding:NSUTF8StringEncoding];
    NSArray *result = [newStr JSONValue] ;
    NSLog(@"%@",result);
    NSString *isSuccess;
    NSArray *test=[result valueForKey:@"response"];
    NSLog(@"test:%@",test);
    
    NSString *test1=[result valueForKey:@"response"];
    
    isSuccess=[result valueForKey:@"success"];
    int value = [isSuccess intValue];
    if(value==0){
        
        UIAlertView *alert1 = [[UIAlertView alloc]
                               initWithTitle:@"Error!" message:test1 delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [alert1 show];
    }
    else{
        
        SettingDataModel *model=[[SettingDataModel alloc] init];
        NSString *newsletter=[test valueForKey:@"newsletter"];
        NSString *password_re=[test valueForKey:@"password_required"];
        NSString *three_failed_pass=[test valueForKey:@"three_failed_attempt"];
        NSLog(@"news:%@",newsletter);
        NSLog(@"news:%@",password_re);
        NSLog(@"news:%@",three_failed_pass);
        model.newsletter=newsletter;
        model.password_require=password_re;
        model.three_faild_password=three_failed_pass;
        [self.settingArray addObject:model];

    }
    NSLog(@"array:%@",settingArray);
}
-(void)addActivity{
    
    HUD = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:HUD];
    
    HUD.delegate = self;
    HUD.labelText = @"Processing";
    self.view.userInteractionEnabled=FALSE;
    
    [HUD show:YES];
}
-(void)removeActivity{
    
    self.view.userInteractionEnabled=TRUE;
    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
}

@end
