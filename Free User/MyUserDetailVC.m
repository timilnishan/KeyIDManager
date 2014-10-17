//
//  MyUserDetailVC.m
//  KeyIdManager
//
//  Created by design_offshore on 5/20/14.
//  Copyright (c) 2014 Key_id_Manager. All rights reserved.
//

#import "MyUserDetailVC.h"

@interface MyUserDetailVC ()

@end

@implementation MyUserDetailVC
@synthesize key_id,full_name,date,location,user_id,total_img,TotalImgLevel,ByWhoLevel,dateLabel,id_,FullNameLebel;
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
    [FullNameLebel setText:[NSString stringWithFormat:@"Full Name:%@",full_name]];
    [TotalImgLevel setText:[NSString stringWithFormat:@"Total Image Uploaded:%@",total_img]];
    [dateLabel setText:date];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)EditUserAction:(id)sender {
    EditUserVC *editkeys=[[EditUserVC alloc] init];
    editkeys.id_=id_;
    editkeys.user_id=user_id;
    editkeys.first_name=full_name;
    [self.navigationController pushViewController:editkeys animated:YES];

}
- (IBAction)DeleteUserAction:(id)sender {
    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Message" message:@"Are you sure Want to Delete User" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:@"Cancel", nil];
    alert.tag=1;
    [alert show];

}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 0 && alertView.tag == 1){
        [self DeletekeyApi];

    }

}

-(void) DeletekeyApi{
    NSLog(@"user_id%@",user_id);
    NSLog(@"id:%@",id_);
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:@"http://54.85.70.181/api/delete-user"]];
    request.delegate=self;
    [request setPostValue:id_ forKey:@"id"];
    [request setPostValue:user_id forKey:@"user_id"];
    
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
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Success" message:@"Your User had been Deleted" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:Nil, nil];
        alert.tag=10;
        [alert show];
        //ProfileVC *t1=[[ProfileVC alloc] initWithNibName:@"ProfileVC" bundle:nil];
        // [ t1.refresh ];
        
        
    }
    
}

@end
