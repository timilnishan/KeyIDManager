//
//  ForgotPasswordVC.m
//  KeyIdManager
//
//  Created by design_offshore on 4/1/14.
//  Copyright (c) 2014 Key_id_Manager. All rights reserved.
//

#import "ForgotPasswordVC.h"

@interface ForgotPasswordVC ()

@end

@implementation ForgotPasswordVC
@synthesize MyScroolView,emailRequest;

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
    [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"navigation_menu.png"] forBarMetrics:UIBarMetricsDefault];
    //[self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"wal.png"]]];

    MyScroolView.contentSize=CGSizeMake(320,550);

    _EmailTextField.placeholder=@"Enter Your Email";
    _EmailTextField.delegate=self;
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void) apicall{
    
    NSString *serverURL = [NSString stringWithFormat:@"%@",URL_FORGOTPASSWORD];
    //NSString *serverURL = [NSString stringWithFormat:@"%@",URL_LOGIN];
    NSURL *url = [NSURL URLWithString:serverURL];
    emailRequest =[ASIFormDataRequest requestWithURL:url];
    [emailRequest setDelegate:self];
    [emailRequest setTimeOutSeconds:120];
    [emailRequest setRequestMethod:@"POST"];
    
    //HHUserDetails  *user=[Helper getUserProfileDetail];
    emailRequest = [ASIFormDataRequest requestWithURL:url];
    [emailRequest setPostValue:_EmailTextField.text forKey:@"user_email"];
    [emailRequest setDelegate:self];
    [emailRequest startAsynchronous];
    
    
    
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
    if(request==emailRequest){
        NSLog(@"p response:%@",responseString);
        NSArray *result = [responseString JSONValue] ;
        
        int isSucess = [[result  valueForKey:@"success"] intValue];
        if(isSucess==0)
        {
            UIAlertView *Alert = [[UIAlertView alloc] initWithTitle:@"Error!" message:@"Sorry!somthing is wrong" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
            [Alert show];
        }
        else
        {
            // [self parseAllCommentsList];
            
            UIAlertView *Alert = [[UIAlertView alloc] initWithTitle:@"Success!" message:@"Your password is send!!" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
            [Alert show];
            _EmailTextField.text=@"";
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

- (IBAction)SubmitAction:(id)sender {
     if(![self isValidEmail:_EmailTextField.text]){
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Error!" message:@"Enter a valid email address." delegate:Nil cancelButtonTitle:@"Ok" otherButtonTitles:@"Cancel", nil];
        [alert show];
    }
   else if([_EmailTextField.text isEqualToString:@""]){
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Error!" message:@"Email Not Be Empty" delegate:Nil cancelButtonTitle:@"Ok" otherButtonTitles:@"Cancel", nil];
        [alert show];
    }
   else{
       [self apicall];
   }
}

- (BOOL)textFieldShouldReturn:(UITextField *)theTextField {
    
    [theTextField resignFirstResponder];
    return YES;
    
}
@end
