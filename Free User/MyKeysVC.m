//
//  MyKeysVC.m
//  KeyIdManager
//
//  Created by design_offshore on 5/14/14.
//  Copyright (c) 2014 Key_id_Manager. All rights reserved.
//

#import "MyKeysVC.h"

@interface MyKeysVC ()

@end

@implementation MyKeysVC
@synthesize mytable,feedVCArray,dataRequest,user_id,Deleterequest,keys_id,checkinRequest,checkoutRequest,HUD;
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
    [mytable reloadData];
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"ic_drawer.png"] landscapeImagePhone:[UIImage imageNamed:@"ic_drawer.png"]  style:UIBarButtonItemStyleBordered target:self action:@selector(showRightt:)];

    NSLog(@"key_id:%@",user_id);
    feedVCArray=[[NSMutableArray alloc] init];
    [self apicall];
   // [self addActivity];

    self.navigationItem.hidesBackButton=NO;

    // Do any additional setup after loading the view from its nib.
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
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [feedVCArray count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *simpleTableIdentifier = @"UserKeysCell";
    
     UserKeysCell *cell = (UserKeysCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"UserKeysCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
        
    }
    
    UserKeysListModel *model= [feedVCArray objectAtIndex:indexPath.row];
    
    //cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.titleLabel.text = [model title];
    cell.dateLabel.text=[model date];
    NSLog(@"img:%@",[model img]);
    [cell.keyimage setImageWithURL:[NSURL URLWithString:[model img]]
                 placeholderImage:[UIImage imageNamed:@"noimage.jpeg"]];
    
//    UITapGestureRecognizer *gestureFeed=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(ImageTapped:)];
//    [gestureFeed setDelaysTouchesBegan:YES];
//    [gestureFeed setNumberOfTapsRequired:1];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self              action:@selector(ImageTapped:)];
    cell.keyimage.userInteractionEnabled = YES;
    [cell.keyimage addGestureRecognizer:tap];
    cell.keyimage.tag = indexPath.row;
    
    [cell.CheckInButton addTarget:self action:@selector(checkinBtnTapped:) forControlEvents:UIControlEventTouchUpInside];
    cell.CheckInButton.tag=indexPath.row;
    cell.CheckInButton.titleLabel.textAlignment = NSTextAlignmentCenter; // if you want to

    [cell.CheckOutButton addTarget:self action:@selector(checkoutBtnTapped:) forControlEvents:UIControlEventTouchUpInside];
    cell.CheckOutButton.tag=indexPath.row;
    cell.CheckOutButton.titleLabel.textAlignment = NSTextAlignmentCenter; // if you want to

    [cell.viewButton addTarget:self action:@selector(ViewBtnTapped:) forControlEvents:UIControlEventTouchUpInside];
    cell.viewButton.tag=indexPath.row;
    
    return cell;
}


-(void)checkinBtnTapped:(id)sender{

    UIButton *selectedBtn = (UIButton *)sender;

    UserKeysListModel *model = (UserKeysListModel *)[self.feedVCArray objectAtIndex:selectedBtn.tag];

    checkinRequest = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:@"http://54.85.70.181/api/checkinout/"]];
    checkinRequest.delegate=self;
    [checkinRequest setPostValue:user_id forKey:@"compared_by"];
    [checkinRequest setPostValue:[model key_id] forKey:@"key_compared"];
[checkinRequest setPostValue:@"IN" forKey:@"check_in_status"];


    [checkinRequest startAsynchronous];



}
-(void)checkoutBtnTapped:(id)sender{
       UIButton *selectedBtn = (UIButton *)sender;

    UserKeysListModel *model = (UserKeysListModel *)[self.feedVCArray objectAtIndex:selectedBtn.tag];
    keys_id=[model key_id];
    NSLog(@"keys_id:%@",keys_id);
////    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Message" message:@"Are you sure Want to Delete Key" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:@"Cancel", nil];
////    alert.tag=1;
////    [alert show];
////    
   checkoutRequest = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:@"http://54.85.70.181/api/checkinout/"]];
   checkoutRequest.delegate=self;
   [checkoutRequest setPostValue:user_id forKey:@"compared_by"];
[checkoutRequest setPostValue:[model key_id] forKey:@"key_compared"];
    [checkoutRequest setPostValue:@"OUT" forKey:@"check_in_status"];
[checkoutRequest startAsynchronous];


}
-(void)ViewBtnTapped:(id)sender{
    
    UIButton *selectedBtn = (UIButton *)sender;
    
    UserKeysListModel *model = (UserKeysListModel *)[self.feedVCArray objectAtIndex:selectedBtn.tag];
    NSString *msg=[NSString stringWithFormat:@"keyname:%@ \n Location:%@ \n By:%@ \n Date:%@ \n",model.title,model.location,model.BY,model.date];
    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Info" message:msg delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
    [alert show];
    
//    MyKeysDetailVC *detail=[[MyKeysDetailVC alloc] init];
//    detail.keyname=[model title];
//    detail.date=[model date];
//    detail.img=[model img];
//    detail.bywho=[model BY];
//    detail.location=[model location];
//    detail.key_id=[model key_id];
//    detail.user_id=user_id;
//    [self.navigationController pushViewController:detail animated:YES];
}

#pragma mark - FeedCell Action Methods

- (void)ImageTapped:(UITapGestureRecognizer*)gesture
{
    NSLog(@"testgfgf");
    UIImageView *hottieImageView = (UIImageView*)gesture.view;
    UserKeysListModel *model = (UserKeysListModel *)[self.feedVCArray objectAtIndex:hottieImageView.tag];
    
    MyKeysDetailVC *detail=[[MyKeysDetailVC alloc] init];
    detail.keyname=[model title];
    detail.date=[model date];
    detail.img=[model img];
    detail.bywho=[model BY];
    detail.location=[model location];
    detail.key_id=[model key_id];
    detail.user_id=user_id;
    [self.navigationController pushViewController:detail animated:YES];
    
}

/*- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UserKeysListModel *model = (UserKeysListModel *)[self.feedVCArray objectAtIndex:indexPath.row];
    
    MyKeysDetailVC *detail=[[MyKeysDetailVC alloc] init];
    detail.keyname=[model title];
    detail.date=[model date];
    detail.img=[model img];
    detail.bywho=[model BY];
    detail.location=[model location];
    detail.key_id=[model key_id];
    detail.user_id=user_id;
    [self.navigationController pushViewController:detail animated:YES];

}*/
-(void) apicall{
    NSLog(@"user_id***%@",user_id);
    //NSString *serverURL = [NSString stringWithFormat:@"http://54.85.70.181/?c=keyapi&m=user_remaining_values&user_id=%d",42];
    NSString *serverURL = [NSString stringWithFormat:@"http://54.85.70.181/key?c=keyapi&m=key_list&user_id=%d",[user_id intValue]];
    
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
        mytable.hidden=YES;
    }
    else{
        

    for(int i=0;i<[test count];i++){
                UserKeysListModel *list = [[UserKeysListModel alloc] init];
        _catVCDictionary = [test objectAtIndex:i];
                NSString *key_name = [_catVCDictionary objectForKey:@"key_name"];
                NSString *key_location = [_catVCDictionary objectForKey:@"key_location"];
        NSString *date = [_catVCDictionary objectForKey:@"created_time"];
        NSString *image= [_catVCDictionary objectForKey:@"image"];
NSString *BY = [_catVCDictionary objectForKey:@"uploaded_by"];
        NSString *key_id= [_catVCDictionary objectForKey:@"id"];



                list.title=key_name;
                list.date=date;
        list.img=image;
        list.location=key_location;
        list.BY=BY;
        list.key_id=key_id;
                [self.feedVCArray addObject: list];
    }
    
    [self.mytable reloadData];

}
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
    if(request==checkinRequest){
        
        NSString  *responseString = [request responseString];
        // Do something because all other tests failed
        NSDictionary *jsonData = [responseString JSONValue] ;
        NSLog(@"checkin data****** %@",jsonData);
        NSArray *result = [responseString JSONValue] ;
       // NSString *ERROR = [result  valueForKey:@"response"];
        NSString *ERROR = @"Successfully Checked In.";

        int isSucess = [[result  valueForKey:@"success"] intValue];
        if(isSucess==1)
        {
            UIAlertView *errorAlert = [[UIAlertView alloc] initWithTitle:@" Success!" message:ERROR delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
            [errorAlert show];
            
        }

    }
    if(request==checkoutRequest){
        
        NSString  *responseString = [request responseString];
        // Do something because all other tests failed
        NSDictionary *jsonData = [responseString JSONValue] ;
        NSLog(@"checkout data****** %@",jsonData);
        NSArray *result = [responseString JSONValue] ;
       // NSString *ERROR = [result  valueForKey:@"response"];
        NSString *ERROR = @"Successfully Checked Out.";

        int isSucess = [[result  valueForKey:@"success"] intValue];
        if(isSucess==1)
        {
            UIAlertView *errorAlert = [[UIAlertView alloc] initWithTitle:@" Success!" message:ERROR delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
            [errorAlert show];
            
        }

    }
    [self removeActivity];
    NSString  *responseString = [request responseString];
    // Do something because all other tests failed
    NSDictionary *jsonData = [responseString JSONValue] ;
    NSLog(@"json data****** %@",jsonData);
    NSArray *result=[jsonData objectForKey:@"data"];
    for(int i=0;i<[result count];i++){
    }
    if(request==Deleterequest){
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
        
    }
    
    [self.mytable reloadData];
}
}

- (IBAction)UploadNewAction:(id)sender {
    UploadKeysVC *vc=[[UploadKeysVC alloc]init];
    vc.user_id=user_id;
    [self.navigationController pushViewController:vc animated:YES];
}
- (IBAction)SearchAction:(id)sender {
}
-(void) DeletekeyApi{
    
    Deleterequest = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:@"http://54.85.70.181/api/delete-image/"]];
    Deleterequest.delegate=self;
    [Deleterequest setPostValue:user_id forKey:@"user_id"];
    [Deleterequest setPostValue:keys_id forKey:@"key_id"];
    
    [Deleterequest startAsynchronous];
    
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
