//
//  AddUserVC.m
//  KeyIdManager
//
//  Created by design_offshore on 5/19/14.
//  Copyright (c) 2014 Key_id_Manager. All rights reserved.
//

#import "AddUserVC.h"

@interface AddUserVC ()

@end

@implementation AddUserVC
@synthesize mypickerView,firstnameTextField,lastnameTextField,emailTextField,passwordTextField,ConformpasswordTextfield,adduserTextField,usertype,dataRequest,user_id,scrollView,UserTypeArray;
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
- (void)viewDidLoad
{
    [super viewDidLoad];
    mypickerView.hidden=YES;
    self.usertype =[[NSMutableArray alloc] init];
    scrollView.contentSize=CGSizeMake(320,700);
    UserTypeArray=[[NSMutableArray alloc]init];
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"ic_drawer.png"] landscapeImagePhone:[UIImage imageNamed:@"ic_drawer.png"]  style:UIBarButtonItemStyleBordered target:self action:@selector(showRightt:)];
    

    firstnameTextField.delegate=self;
    lastnameTextField.delegate=self;
    emailTextField.delegate=self;
    passwordTextField.delegate=self;
    ConformpasswordTextfield.delegate=self;
    adduserTextField.delegate=self;
   // usertype=[NSMutableArray arrayWithObjects:@"User Admin",@"Normal User", nil];
    [self apicallForGetUserType];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfComponentsInPickerView:
(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView
numberOfRowsInComponent:(NSInteger)component
{
    return usertype.count;
}

- (NSString *)pickerView:(UIPickerView *)pickerView
             titleForRow:(NSInteger)row
            forComponent:(NSInteger)component
{
    return usertype[row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row   inComponent:(NSInteger)component{
    
    adduserTextField.text=usertype[row];
    NSLog(@"Selected Row %@", usertype[row]);
    NSLog(@"row::::::%d",row);
    AddUserUserTypeDataModel *model=[[AddUserUserTypeDataModel alloc] init];
    model = (AddUserUserTypeDataModel *)[self.UserTypeArray objectAtIndex:row];
    _code=[NSString stringWithFormat:@"%@",[model ID]];
    NSLog(@"_code%@",_code);
    // [categoryTextField resignFirstResponder];
    
}
- (BOOL)textFieldShouldReturn:(UITextField *)theTextField {
    
    [theTextField resignFirstResponder];
    return YES;
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
- (IBAction)addUserAction:(id)sender {
    if([firstnameTextField.text isEqualToString:@""]){
        UIAlertView *Alert = [[UIAlertView alloc] initWithTitle:@"Error!" message:@"First Name Must Be Fill" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [Alert show];
        [firstnameTextField becomeFirstResponder];
    }
   else if([lastnameTextField.text isEqualToString:@""]){
        UIAlertView *Alert = [[UIAlertView alloc] initWithTitle:@"Error!" message:@"Last Name Must Be Fill" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [Alert show];
       [lastnameTextField becomeFirstResponder];
    }
   else if([emailTextField.text isEqualToString:@""]){
       UIAlertView *Alert = [[UIAlertView alloc] initWithTitle:@"Error!" message:@"Email  Must Be Fill" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
       [Alert show];
       [emailTextField becomeFirstResponder];
   }
   else if(![self isValidEmail:emailTextField.text]){
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Error!" message:@"Enter a valid email address." delegate:Nil cancelButtonTitle:@"Ok" otherButtonTitles:@"Cancel", nil];
        [alert show];
       [emailTextField becomeFirstResponder];
    }
  
    else if([passwordTextField.text isEqualToString:@""]){
        UIAlertView *Alert = [[UIAlertView alloc] initWithTitle:@"Error!" message:@"Password Must Be Fill" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [Alert show];
        [passwordTextField becomeFirstResponder];
    }
    else if([ConformpasswordTextfield.text isEqualToString:@""]){
        UIAlertView *Alert = [[UIAlertView alloc] initWithTitle:@"Error!" message:@"Confirm Password Must Be Fill" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [Alert show];
        [ConformpasswordTextfield becomeFirstResponder];
    }
    else{
        [self apicall];
    }
}
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    
    //[JokesDetailTextView resignFirstResponder];
    
    return YES;
}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    //  responder = textField;
    
    if ([textField isEqual:self.adduserTextField]) {
        mypickerView.hidden=NO;
        adduserTextField.inputView = mypickerView;
        
    }
    
    return YES;
}

-(void) apicallForGetUserType{
    
    //NSString *serverURL = [NSString stringWithFormat:@"http://54.85.70.181/?c=keyapi&m=user_remaining_values&user_id=%d",42];
    NSString *serverURL = [NSString stringWithFormat:@"http://54.85.70.181/api/user-type"];
    
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
    
    NSArray *test=[result valueForKey:@"response"];
    for(int i=0;i<[test count];i++){
        AddUserUserTypeDataModel *model=[[AddUserUserTypeDataModel alloc]init];
        _catVCDictionary = [test objectAtIndex:i];
        NSString *name = [_catVCDictionary objectForKey:@"user_type_name"];
        NSString *id_ = [_catVCDictionary objectForKey:@"id"];

        NSLog(@"name:%@",name);
        model.ID=id_;
        [self.usertype addObject:name];
        [self.UserTypeArray addObject:model];
        
    }
    [self.mypickerView reloadAllComponents];
    NSLog(@"usertype:%@",usertype);
}

-(void) apicall{
    NSLog(@"code:****%@",_code);
    NSLog(@"user_id:****%@",user_id);
    NSLog(@"pass:****%@",passwordTextField.text);


    //NSString *test=[CategoryPicker s]
    NSString *serverURL = [NSString stringWithFormat:@"%@",URL_ADDUSER];
    NSURL *url = [NSURL URLWithString:serverURL];
    dataRequest =[ASIFormDataRequest requestWithURL:url];
    [dataRequest setDelegate:self];
    [dataRequest setTimeOutSeconds:120];
    [dataRequest setRequestMethod:@"POST"];
    [dataRequest setPostValue:passwordTextField.text forKey:@"user_password"];
    [dataRequest setPostValue:ConformpasswordTextfield.text forKey:@"user_confirm_password"];
    [dataRequest setPostValue:user_id forKey:@"user_id"];
    [dataRequest setPostValue:@"4" forKey:@"user_type"];
    [dataRequest setPostValue:firstnameTextField.text forKey:@"first_name"];
    [dataRequest setPostValue:lastnameTextField.text forKey:@"last_name"];
    [dataRequest setPostValue:emailTextField.text forKey:@"user_email"];
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
        //   NSString *error = [[result  valueForKey:@""];
        
        if(isSucess==0)
        {
            UIAlertView *Alert = [[UIAlertView alloc] initWithTitle:@"Error!" message:@"Sorry Could Not Post Your Jokes!" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
            [Alert show];
        }
        else
        {
            UIAlertView *Alert = [[UIAlertView alloc] initWithTitle:@"Success!" message:@"Thank you!!Your Post is submited." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
            [Alert show];
            firstnameTextField.text=@"";
            lastnameTextField.text=@"";
            emailTextField.text=@"";
            passwordTextField.text=@"";
            ConformpasswordTextfield.text=@"";
            adduserTextField.text=@"";
        }
        
        
    }
    
}

@end
