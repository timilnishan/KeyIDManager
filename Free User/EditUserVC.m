//
//  EditUserVC.m
//  KeyIdManager
//
//  Created by design_offshore on 5/20/14.
//  Copyright (c) 2014 Key_id_Manager. All rights reserved.
//

#import "EditUserVC.h"

@interface EditUserVC ()

@end

@implementation EditUserVC
@synthesize FullNameTextField,LastNameTextField,passwordTextField,confirmPasswordTextField,user_id,id_,first_name,last_name;

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
    NSArray * arr = [first_name componentsSeparatedByString:@" "];
    NSLog(@"Array values are : %@",arr);
    NSLog(@"id:%@",id_);
    NSLog(@"user_id:%@",user_id);
    NSLog(@"name:%@",first_name);
    FullNameTextField.text=arr[0];
    LastNameTextField.text=arr[1];

    FullNameTextField.delegate=self;
    LastNameTextField.delegate=self;
    passwordTextField.delegate=self;
    confirmPasswordTextField.delegate=self;
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void) Apicall{
    
    NSLog(@"id:%@",id_);
    NSLog(@"user_id:%@",user_id);
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:@"http://54.85.70.181/api/edit-user"]];
    request.delegate=self;
    [request setPostValue:FullNameTextField.text forKey:@"first_name"];
    [request setPostValue:LastNameTextField.text forKey:@"last_name"];
    [request setPostValue:passwordTextField.text forKey:@"user_password"];
    [request setPostValue:confirmPasswordTextField.text forKey:@"user_confirm_password"];
    [request setPostValue:user_id forKey:@"user_id"];
    [request setPostValue:id_ forKey:@"id"];
   
    //[request setData:_imageData forKey:@"key_file"];
    [request startAsynchronous];
    
}


- (void)requestFinished:(ASIHTTPRequest *)request

{
    
    NSString *responseString = [request responseString];
    NSLog(@"*****%@",responseString);
    NSArray *result = [responseString JSONValue] ;
    
    NSLog(@"%@",result);
    int isSucess = [[result  valueForKey:@"success"] intValue];
    NSString *ERROR = [result  valueForKey:@"response"];
    
    if(isSucess==0)
    {
        UIAlertView *errorAlert = [[UIAlertView alloc] initWithTitle:@" Error!" message:ERROR delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [errorAlert show];
        
    }
    if(isSucess==1) {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@" Image " message:@"Your Data had been updated" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:Nil, nil];
        alert.tag=10;
        [alert show];
        FullNameTextField.text=@"";
        LastNameTextField.text=@"";
        passwordTextField.text=@"";
        confirmPasswordTextField.text=@"";
        //ProfileVC *t1=[[ProfileVC alloc] initWithNibName:@"ProfileVC" bundle:nil];
        // [ t1.refresh ];
        
        
    }
    
}


- (IBAction)RegisterAction:(id)sender {
    [self Apicall];
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}
// called when 'return' key pressed. return NO to ignore.

@end
