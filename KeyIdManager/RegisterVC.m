//
//  RegisterVC.m
//  KeyIdManager
//
//  Created by design_offshore on 3/30/14.
//  Copyright (c) 2014 Key_id_Manager. All rights reserved.
//

#import "RegisterVC.h"
@interface RegisterVC ()

@end

@implementation RegisterVC
@synthesize dataRequest,overlayView,indicator,statusRequest,settingArray,newsletterLabel,mySwitch,status;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad

{
    self.settingArray=[[NSMutableArray alloc]init];

    [self apicallForSetting];
    
    // [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"wal.png"]]];
    _MyScrollView.contentSize=CGSizeMake(320,650);
    //for placeholder
    _FirstnameTextField.placeholder=@"First Name";
    _LastnameTextField.placeholder=@"Last Name";
    _EmailTextField.placeholder=@"Email";
    _PasswordTextField.placeholder=@"Password";
    _ConformpasswordTextField.placeholder=@"Conform password";
    _PasswordTextField.secureTextEntry=YES;
    _ConformpasswordTextField.secureTextEntry=YES;
    
    //delgate textfield
    _FirstnameTextField.delegate=self;
    _LastnameTextField.delegate=self;
    _EmailTextField.delegate=self;
    _PasswordTextField.delegate=self;
    _ConformpasswordTextField.delegate=self;

    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"ic_drawer.png"] landscapeImagePhone:[UIImage imageNamed:@"ic_drawer.png"]  style:UIBarButtonItemStyleBordered target:self action:@selector(showRightt:)];
   // [[self navigationController] setNavigationBarHidden:YES animated:YES];
   // [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"logo.png"] forBarMetrics:UIBarMetricsDefault];

    // Do any additional setup after loading the view from its nib.
    
    SettingDataModel *model=[settingArray objectAtIndex:0];
    NSLog(@"settingarray:%@",settingArray);
    NSString *pass=[model newsletter];
    if([pass isEqualToString:@"OFF"]){
        newsletterLabel.hidden=YES;
        mySwitch.hidden=YES;
       // _PasswordTextField.hidden=YES;
    }
    else{
        newsletterLabel.hidden=NO;
        [mySwitch addTarget:self action:@selector(changeSwitch:) forControlEvents:UIControlEventValueChanged];
    }
}
- (void)changeSwitch:(id)sender{
    if([sender isOn]){
        // Execute any code when the switch is ON
        status=@"YES";
        NSLog(@"Switch is %@",status);
    } else{
        // Execute any code when the switch is OFF
        status=@"NO";
        NSLog(@"Switch is %@",status);
    }
}
- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    indicator.hidden=YES;
    //[[self navigationController] setNavigationBarHidden:YES animated:YES];
    
    RightSettingVC *right = [[RightSettingVC alloc]init];
    [self.revealSideViewController preloadViewController:right forSide:PPRevealSideDirectionRight];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}
- (void) showRightt:(id)sender
{
    // used to push a new controller, but we preloaded it !
    //    LeftViewController *left = [[LeftViewController alloc] initWithStyle:UITableViewStylePlain];
    //    [self.revealSideViewController pushViewController:left onDirection:PPRevealSideDirectionLeft animated:YES];
    
    [self.revealSideViewController pushOldViewControllerOnDirection:PPRevealSideDirectionRight animated:YES];
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


-(void) apicall{
    //indicator
    indicator.hidden=NO;
    overlayView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.overlayView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    self.indicator.center = self.overlayView.center;
    [self.overlayView addSubview:self.indicator];
    [self.indicator startAnimating];
    [self.view addSubview:self.overlayView];
    [indicator startAnimating ];
    indicator.hidesWhenStopped=YES;
    NSString *serverURL = [NSString stringWithFormat:@"%@",URL_SINGUP];
    //NSString *serverURL = [NSString stringWithFormat:@"%@",URL_LOGIN];
    NSURL *url = [NSURL URLWithString:serverURL];
    dataRequest =[ASIFormDataRequest requestWithURL:url];
    [dataRequest setDelegate:self];
    [dataRequest setTimeOutSeconds:120];
    [dataRequest setRequestMethod:@"POST"];
    
    //HHUserDetails  *user=[Helper getUserProfileDetail];
    dataRequest = [ASIFormDataRequest requestWithURL:url];
    [dataRequest setPostValue:_FirstnameTextField.text forKey:@"first_name"];
    [dataRequest setPostValue:_LastnameTextField.text forKey:@"last_name"];
    [dataRequest setPostValue:_EmailTextField.text forKey:@"user_email"];
    [dataRequest setPostValue:_PasswordTextField.text forKey:@"user_password"];
    [dataRequest setPostValue:status forKey:@"news_sub"];

    [dataRequest setPostValue:_ConformpasswordTextField.text forKey:@"user_confirm_password"];
    [dataRequest setDelegate:self];
    [dataRequest startAsynchronous];
    
    
    
}
- (void)requestFailed:(ASIHTTPRequest *)request
{
    // [self hidehud];
	NSError *error = [request error];
    
    UIAlertView *alert = [[UIAlertView alloc]
                          initWithTitle:@"Error!" message:error.localizedDescription delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
    [alert show];
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
	
}
- (void)requestFinished:(ASIHTTPRequest *)request
{
	NSString  *responseString = [request responseString];
    NSLog(@"response:%@",responseString);
    if(request==dataRequest){
        NSLog(@"p response:%@",responseString);
        NSArray *result = [responseString JSONValue] ;
        
        int isSucess = [[result  valueForKey:@"success"] intValue];
        if(isSucess==0)
        {
            [indicator performSelectorOnMainThread:@selector(stopAnimating) withObject:nil waitUntilDone:YES];
            overlayView.hidden=YES;
            UIAlertView *Alert = [[UIAlertView alloc] initWithTitle:@"Error!" message:@"Sorry Email is already Taken!" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
            [Alert show];
        }
        else
        {
            // [self parseAllCommentsList];
            [indicator performSelectorOnMainThread:@selector(stopAnimating) withObject:nil waitUntilDone:YES];
            overlayView.hidden=YES;
            UIAlertView *Alert = [[UIAlertView alloc] initWithTitle:@"Success!" message:@"Please,activate your account.!!Thank you" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
            [Alert show];
            _LastnameTextField.text=@"";
            _FirstnameTextField.text=@"";
            _EmailTextField.text=@"";
            _PasswordTextField.text=@"";
            _ConformpasswordTextField.text=@"";
        }
        
        
    }
    if(request==statusRequest){
        
        NSString  *responseString = [request responseString];
        NSLog(@"status response:%@",responseString);
    }
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

- (BOOL)textFieldShouldReturn:(UITextField *)theTextField {
    
    [theTextField resignFirstResponder];
    return YES;
    
}
- (IBAction)SingUpAction:(id)sender {
    if([_EmailTextField.text isEqualToString:@""]){
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Error!" message:@"Email Not Be Empty" delegate:Nil cancelButtonTitle:@"Ok" otherButtonTitles:@"Cancel", nil];
        [alert show];
    }
    else if([_FirstnameTextField.text isEqualToString:@""]){
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Error!" message:@"FirstName Not Be Empty" delegate:Nil cancelButtonTitle:@"Ok" otherButtonTitles:@"Cancel", nil];
        [alert show];
    }
    else if(![self isValidEmail:_EmailTextField.text]){
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Error!" message:@"Enter a valid email address." delegate:Nil cancelButtonTitle:@"Ok" otherButtonTitles:@"Cancel", nil];
        [alert show];
    }
    else if([_LastnameTextField.text isEqualToString:@""]){
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Error!" message:@"LastName Not Be Empty" delegate:Nil cancelButtonTitle:@"Ok" otherButtonTitles:@"Cancel", nil];
        [alert show];
    } else if([_PasswordTextField.text isEqualToString:@""]){
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Error!" message:@"Password Not Be Empty" delegate:Nil cancelButtonTitle:@"Ok" otherButtonTitles:@"Cancel", nil];
        [alert show];
    }
    else if([_ConformpasswordTextField.text isEqualToString:@""]){
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Error!" message:@"Conform Password Not Be Empty" delegate:Nil cancelButtonTitle:@"Ok" otherButtonTitles:@"Cancel", nil];
        [alert show];
    }
    else if(![_ConformpasswordTextField.text isEqualToString:_PasswordTextField.text]){
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Error!" message:@" Password Not Matched" delegate:Nil cancelButtonTitle:@"Ok" otherButtonTitles:@"Cancel", nil];
        [alert show];
    }
    
    else{
        [self apicall];
    }
}
-(void) stopAnimating{
    [indicator stopAnimating];
}
@end
