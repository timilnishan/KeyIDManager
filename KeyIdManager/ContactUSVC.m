//
//  ContactUSVC.m
//  KeyIdManager
//
//  Created by design_offshore on 3/31/14.
//  Copyright (c) 2014 Key_id_Manager. All rights reserved.
//

#import "ContactUSVC.h"

@interface ContactUSVC ()

@end

@implementation ContactUSVC
@synthesize contactRequest,Myimage,IsUserClick,user_id,userType;

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
    [super viewDidLoad];
    [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"navigation_menu.png"] forBarMetrics:UIBarStyleBlack];
       self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"ic_drawer.png"] landscapeImagePhone:[UIImage imageNamed:@"ic_drawer.png"]  style:UIBarButtonItemStyleBordered target:self action:@selector(showRightt:)];
    _MyScrollView.contentSize=CGSizeMake(320,700);

    _AddressTextField.placeholder=@"Address";
    _EmailTextField.placeholder=@"Email";
    _PhoneTextField.placeholder=@"Phone";
    
    //for keyboard
    _AddressTextField.delegate=self;
    _EmailTextField.delegate=self;
    _PhoneTextField.delegate=self;
    // Do any additional setup after loading the view from its nib.
    
    //for text view border
    [[self.MessageTextField layer] setBorderColor:[[UIColor grayColor] CGColor]];
    [[self.MessageTextField layer] setBorderWidth:1.3];
    [[self.MessageTextField layer] setCornerRadius:5];
    [[self.Myimage layer] setBorderWidth:1.3];
    [[self.Myimage layer] setCornerRadius:5];
    [[self.MessageTextField layer] setBackgroundColor:(__bridge CGColorRef)([UIColor redColor])];
}
- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
            HomeSettingVC *right = [[HomeSettingVC alloc]init];
    right.TYPE=userType;
    right.user_id=user_id;
        [self.revealSideViewController preloadViewController:right forSide:PPRevealSideDirectionRight];
    
    }

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}
- (void) showRightt:(id)sender

{
    [self.revealSideViewController pushOldViewControllerOnDirection:PPRevealSideDirectionRight animated:YES];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void) apicall{
    
    NSString *serverURL = [NSString stringWithFormat:@"%@",URL_CONTACT];
    //NSString *serverURL = [NSString stringWithFormat:@"%@",URL_LOGIN];
    NSURL *url = [NSURL URLWithString:serverURL];
    
    contactRequest =[ASIFormDataRequest requestWithURL:url];
    [contactRequest setDelegate:self];
    [contactRequest setTimeOutSeconds:120];
    [contactRequest setRequestMethod:@"POST"];
    
    //HHUserDetails  *user=[Helper getUserProfileDetail];
    contactRequest = [ASIFormDataRequest requestWithURL:url];
    [contactRequest setPostValue:_EmailTextField.text forKey:@"email"];
    [contactRequest setPostValue:_AddressTextField.text forKey:@"address_details"];
    [contactRequest setPostValue:_PhoneTextField.text forKey:@"telephone_number"];
    [contactRequest setPostValue:_MessageTextField.text forKey:@"contact_text"];
    [contactRequest setDelegate:self];
    [contactRequest startAsynchronous];
    
    
    
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
    if(request==contactRequest){
        NSLog(@"p response:%@",responseString);
        NSArray *result = [responseString JSONValue] ;
        
        int isSucess = [[result  valueForKey:@"success"] intValue];
        if(isSucess==0)
        {
            UIAlertView *Alert = [[UIAlertView alloc] initWithTitle:@"Error!" message:@"Sorry Message is Failed!" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
            [Alert show];
        }
        else
        {
            // [self parseAllCommentsList];
            
            UIAlertView *Alert = [[UIAlertView alloc] initWithTitle:@"Success!" message:@"We will response you as soon as possible!!!Thank you" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
            [Alert show];
            _MessageTextField.text=@"";
            _PhoneTextField.text=@"";
            _PhoneTextField.text=@"";
            _AddressTextField.text=@"";
            
        }
        
        
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


- (IBAction)FacebookLinkAction:(id)sender {
    NSURL *url=[NSURL URLWithString:@"http://www.facebook.com/damnhansy" ];
    [[UIApplication sharedApplication] openURL:url];
}

- (IBAction)linkdinLinkAction:(id)sender {
    NSURL *url=[NSURL URLWithString:@"http://www.linkin.com" ];
    [[UIApplication sharedApplication] openURL:url];
}

- (IBAction)TwitterLinksAction:(id)sender {
    NSURL *url=[NSURL URLWithString:@"http://www.twitter.com" ];
    [[UIApplication sharedApplication] openURL:url];
}


- (BOOL)textFieldShouldReturn:(UITextField *)theTextField {
    
    [theTextField resignFirstResponder];
    return YES;
    
}
- (IBAction)facebookAction:(id)sender {
    NSURL *url=[NSURL URLWithString:@"http://www.facebook.com/damnhansy" ];
    [[UIApplication sharedApplication] openURL:url];
}

- (IBAction)SubmitAction:(id)sender {
    if([_EmailTextField.text isEqualToString:@""]){
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Error!" message:@"Email Not Be Empty" delegate:Nil cancelButtonTitle:@"Ok" otherButtonTitles:@"Cancel", nil];
        [alert show];
    }
    else if([_AddressTextField.text isEqualToString:@""]){
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Error!" message:@"Address Not Be Empty" delegate:Nil cancelButtonTitle:@"Ok" otherButtonTitles:@"Cancel", nil];
        [alert show];
    }
    else if(![self isValidEmail:_EmailTextField.text]){
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Error!" message:@"Enter a valid email address." delegate:Nil cancelButtonTitle:@"Ok" otherButtonTitles:@"Cancel", nil];
        [alert show];
    }
    else if([_PhoneTextField.text isEqualToString:@""]){
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Error!" message:@"Phone Not Be Empty" delegate:Nil cancelButtonTitle:@"Ok" otherButtonTitles:@"Cancel", nil];
        [alert show];
    } else if([_MessageTextField.text isEqualToString:@""]){
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Error!" message:@"Message Not Be Empty" delegate:Nil cancelButtonTitle:@"Ok" otherButtonTitles:@"Cancel", nil];
        [alert show];
    }
    else{
        [self apicall];
    }
}

- (IBAction)twitterAction:(id)sender {
    NSURL *url=[NSURL URLWithString:@"http://www.facebook.com/damnhansy" ];
    [[UIApplication sharedApplication] openURL:url];
}

- (IBAction)linkinedAction:(id)sender {
    NSURL *url=[NSURL URLWithString:@"http://www.facebook.com/damnhansy" ];
    [[UIApplication sharedApplication] openURL:url];
}
@end
