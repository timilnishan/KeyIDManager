//
//  MyKeysDetailVC.m
//  KeyIdManager
//
//  Created by design_offshore on 5/18/14.
//  Copyright (c) 2014 Key_id_Manager. All rights reserved.
//

#import "MyKeysDetailVC.h"

@interface MyKeysDetailVC ()

@end

@implementation MyKeysDetailVC
@synthesize keyname,img,date,BYlabel,bywho,DateLabel,DisplayImage,keynameLabel,location,keylocation,key_id,dataRequest,user_id,Deleterequest,checkinRequest,checkoutRequest,HUD;

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
    NSLog(@"user_id%@",user_id);
    NSLog(@"key_id%@",key_id);

     [keynameLabel setText:[NSString stringWithFormat:@"%@",keyname]];
    [keylocation setText:[NSString stringWithFormat:@"Key Location:%@",location]];

    [DateLabel setText:date];
    [BYlabel setText:[NSString stringWithFormat:@"By:%@",bywho]];
    
   
    [DisplayImage setImageWithURL:[NSURL URLWithString:img]
                 placeholderImage:[UIImage imageNamed:@"noimage.jpeg"]];

   // DisplayImage.image=img;
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex ==0 && alertView.tag==1){
        [self DeletekeyApi];
        
    }
    
}
- (IBAction)DeleteKeyAction:(id)sender {
    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Message" message:@"Are you sure Want to Delete Key" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:@"Cancel", nil];
    alert.tag=1;
    [alert show];}

- (IBAction)EditKeysAction:(id)sender {
    EditKeysVC *editkeys=[[EditKeysVC alloc] init];
    editkeys.keyname=keyname;
    editkeys.location=location;
    editkeys.user_id=user_id;
    editkeys.key_id=key_id;
    [self.navigationController pushViewController:editkeys animated:YES];
}
-(void) DeletekeyApi{
    [self addActivity];
    Deleterequest = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:@"http://54.85.70.181/api/delete-image/"]];
    Deleterequest.delegate=self;
    [Deleterequest setPostValue:user_id forKey:@"user_id"];
    [Deleterequest setPostValue:key_id forKey:@"key_id"];
    
    [Deleterequest startAsynchronous];
     
}


- (void)requestFinished:(ASIHTTPRequest *)request

{
    if(request==checkinRequest){
        [self removeActivity];
        
        NSString  *responseString = [request responseString];
        // Do something because all other tests failed
        NSDictionary *jsonData = [responseString JSONValue] ;
        NSLog(@"checkin data****** %@",jsonData);
        NSArray *result = [responseString JSONValue] ;
        NSString *ERROR = [result  valueForKey:@"response"];
        int isSucess = [[result  valueForKey:@"success"] intValue];
        if(isSucess==1)
        {
            UIAlertView *errorAlert = [[UIAlertView alloc] initWithTitle:@" Success!" message:ERROR delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
            [errorAlert show];
            
        }
        
    }
    if(request==checkoutRequest){
        [self removeActivity];
        
        NSString  *responseString = [request responseString];
        // Do something because all other tests failed
        NSDictionary *jsonData = [responseString JSONValue] ;
        NSLog(@"checkout data****** %@",jsonData);
        NSArray *result = [responseString JSONValue] ;
        NSString *ERROR = [result  valueForKey:@"response"];
        int isSucess = [[result  valueForKey:@"success"] intValue];
        if(isSucess==1)
        {
            UIAlertView *errorAlert = [[UIAlertView alloc] initWithTitle:@" Success!" message:ERROR delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
            [errorAlert show];
            
        }
        
    }
    if(request==Deleterequest){
        [self removeActivity];
   
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
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Success" message:@"Your Key had been Deleted" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:Nil, nil];
        alert.tag=10;
        [alert show];
        //ProfileVC *t1=[[ProfileVC alloc] initWithNibName:@"ProfileVC" bundle:nil];
        // [ t1.refresh ];
        
        
    }
    }
    
}


- (IBAction)CheckInAction:(id)sender {
    [self addActivity];
    
    checkinRequest = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:@"http://54.85.70.181/api/checkinout/"]];
    checkinRequest.delegate=self;
    [checkinRequest setPostValue:user_id forKey:@"compared_by"];
    [checkinRequest setPostValue:key_id forKey:@"key_compared"];
    [checkinRequest setPostValue:@"IN" forKey:@"check_in_status"];
    
    
    [checkinRequest startAsynchronous];
}

- (IBAction)ViewLogAction:(id)sender {
}

- (IBAction)DuplicateLogAction:(id)sender {
}

- (IBAction)checkOutAction:(id)sender {
    [self addActivity];
    
    checkoutRequest = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:@"http://54.85.70.181/api/checkinout/"]];
    checkoutRequest.delegate=self;
    [checkoutRequest setPostValue:user_id forKey:@"compared_by"];
    [checkoutRequest setPostValue:key_id forKey:@"key_compared"];
    [checkoutRequest setPostValue:@"OUT" forKey:@"check_in_status"];
    [checkoutRequest startAsynchronous];
}

- (IBAction)EditAction:(id)sender {
    EditKeysVC *editkeys=[[EditKeysVC alloc] init];
    editkeys.keyname=keyname;
    editkeys.location=location;
    editkeys.user_id=user_id;
    editkeys.key_id=key_id;
    [self.navigationController pushViewController:editkeys animated:YES];

}

- (IBAction)DeleteAction:(id)sender {
    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Message" message:@"Are you sure Want to Delete Key" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:@"Cancel", nil];
    alert.tag=1;
    [alert show];
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
