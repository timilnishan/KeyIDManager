//
//  DashboardVC.m
//  KeyIdManager
//
//  Created by design_offshore on 5/8/14.
//  Copyright (c) 2014 Key_id_Manager. All rights reserved.
//

#import "DashboardVC.h"

@interface DashboardVC ()

@end

@implementation DashboardVC
@synthesize keysLebel,userLebel,adminLebel,user_type,user_id,testtextfield,compareRequest,uploadRequest,key_location,key_name,imagename,password,username,HUD;
@synthesize picker;
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
    _catVCDictionary=[[NSMutableDictionary alloc]init];
    NSLog(@"user_id****%@",user_id);
    [self apicall];
      self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"ic_drawer.png"] landscapeImagePhone:[UIImage imageNamed:@"ic_drawer.png"]  style:UIBarButtonItemStyleBordered target:self action:@selector(showRightt:)];
    // Do any additional setup after loading the view from its nib.
}
- (void)viewWillAppear:(BOOL)animated
{
    
    // self.navigationController.navigationBar.topItem.backBarButtonItem.h = NO;
    //hides naviagtion back button
    self.navigationItem.hidesBackButton=YES;
    if ([user_type isEqualToString:@"Free User"]) {
    HomeSettingVC *right = [[HomeSettingVC alloc]init];
        right.TYPE=user_type;
        right.user_id=user_id;
        [self.revealSideViewController preloadViewController:right forSide:PPRevealSideDirectionRight];

    }
    if ([user_type isEqualToString:@"Normal User"]) {
        HomeSettingVC *right = [[HomeSettingVC alloc]init];
        right.TYPE=user_type;
        right.user_id=user_id;
        [self.revealSideViewController preloadViewController:right forSide:PPRevealSideDirectionRight];
        
    }
    if ([user_type isEqualToString:@"User Admin"]) {
        HomeSettingVC *right = [[HomeSettingVC alloc]init];
        right.TYPE=user_type;
        right.user_id=user_id;
        [self.revealSideViewController preloadViewController:right forSide:PPRevealSideDirectionRight];
        
    }
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
    
    NSString *serverURL = [NSString stringWithFormat:@"http://54.85.70.181/?c=keyapi&m=user_remaining_values&user_id=%@",user_id];
   // NSString *serverURL = [NSString stringWithFormat:@"http://54.85.70.181/api/pages/%d",11];
    
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
    NSString *keys=[test valueForKey:@"key_limit"];
    NSString *users=[test valueForKey:@"user_limit"];
    NSString *admin=[test valueForKey:@"admin_limit"];
  
    _AccountLabel.text=user_type;
    if ([keys isEqual:@"-1"]) {
    keysLebel.text=@"unlimited";
    }
    else{
        [keysLebel setText:keys];
    }
    if ([users isEqualToString:@"-1"]) {
        userLebel.text=@"unlimited";
    }
    else{
        userLebel.text=users;
    }
    if ([users isEqualToString:@"-1"]) {
        adminLebel.text=@"unlimited";
    }
    else{
        adminLebel.text=admin;
    }
   

}

- (IBAction)ComparekeyAction:(id)sender {

    {
        
      /*  if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera])
        {
            UIImagePickerController *controller = [[UIImagePickerController alloc] init];
            controller.sourceType = UIImagePickerControllerSourceTypeCamera;
            controller.allowsEditing = NO;
            controller.mediaTypes = [UIImagePickerController availableMediaTypesForSourceType: UIImagePickerControllerSourceTypeCamera];
            controller.delegate = self;
            
            //[self.navigationController presentViewController: controller animated: YES completion: nil];
            [self presentViewController:controller animated:YES completion:nil];
            
        }*/
        self.picker = [[GKImagePicker alloc] init];
        self.picker.delegate = self;
        self.picker.cropper.cropSize = CGSizeMake(320.,200.);
        self.picker.Source=YES;
        // (Optional) Default: CGSizeMake(320., 320.)
        self.picker.cropper.rescaleImage = YES;                // (Optional) Default: YES
        self.picker.cropper.rescaleFactor = 2.0;               // (Optional) Default: 1.0
        self.picker.cropper.dismissAnimated = YES;              // (Optional) Default: YES
        self.picker.cropper.overlayColor = [UIColor colorWithRed:0/255. green:0/255. blue:0/255. alpha:0.7];  // (Optional) Default: [UIColor colorWithRed:0/255. green:0/255. blue:0/255. alpha:0.7]
        self.picker.cropper.innerBorderColor = [UIColor colorWithRed:255./255. green:255./255. blue:255./255. alpha:0.7];   // (Optional) Default: [UIColor colorWithRed:0/255. green:0/255. blue:0/255. alpha:0.7]
        [self.picker presentPicker];

        
    }
        

}
#pragma mark - GKImagePicker delegate methods

- (void)imagePickerDidFinish:(GKImagePicker *)imagePicker withImage:(UIImage *)image {
    _imageData = UIImageJPEGRepresentation(image, 0.1);
    NSLog(@"data%@",_imageData);
    UIAlertView *errorAlert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Are u sure Want to Compare this pic" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:@"Cancel", nil];
    errorAlert.tag=7;
    [errorAlert show];

}

- (IBAction)KeyLibraryAction:(id)sender {
    
    
//    MyKeysVC *se=[[MyKeysVC alloc] init];
//    se.user_id=user_id;
//    UINavigationController *o=[[UINavigationController alloc] initWithRootViewController:se];
//    se.user_id=user_id;
//    NSLog(@"user_id***%@",user_id);
    /* if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypePhotoLibrary])
    {
        UIImagePickerController *controller = [[UIImagePickerController alloc] init];
        controller.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        controller.allowsEditing = NO;
        controller.mediaTypes = [UIImagePickerController availableMediaTypesForSourceType: UIImagePickerControllerSourceTypePhotoLibrary];
        controller.delegate = self;
        // [self.navigationController presentViewController: controller animated: YES completion: nil];
        [self presentViewController:controller animated:YES completion:nil];
        
    } */

    
    self.picker = [[GKImagePicker alloc] init];
    self.picker.delegate = self;
    self.picker.cropper.cropSize = CGSizeMake(320.,200.);
    // (Optional) Default: CGSizeMake(320., 320.)
    self.picker.cropper.rescaleImage = YES;                // (Optional) Default: YES
    self.picker.cropper.rescaleFactor = 2.0;               // (Optional) Default: 1.0
    self.picker.cropper.dismissAnimated = YES;              // (Optional) Default: YES
    self.picker.cropper.overlayColor = [UIColor colorWithRed:0/255. green:0/255. blue:0/255. alpha:0.7];  // (Optional) Default: [UIColor colorWithRed:0/255. green:0/255. blue:0/255. alpha:0.7]
    self.picker.cropper.innerBorderColor = [UIColor colorWithRed:255./255. green:255./255. blue:255./255. alpha:0.7];   // (Optional) Default: [UIColor colorWithRed:0/255. green:0/255. blue:0/255. alpha:0.7]
    [self.picker presentPicker];
}
/*
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [self.navigationController dismissViewControllerAnimated: YES completion: nil];
    UIImage *image = [info valueForKey: UIImagePickerControllerOriginalImage];
    _imageData = UIImageJPEGRepresentation(image, 0.1);
    NSLog(@"%@",_imageData);
    UIAlertView *errorAlert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Are u sure Want to upload this pic" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:@"Cancel", nil];
    errorAlert.tag=7;
    [errorAlert show];
    
    
}*/
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
   
    if(buttonIndex==0&& alertView.tag==7){
        UserDataModel *model=[[UserDataModel alloc] init];
       // NSString *status_=[model status];
        
        [self apicallForcompare];
        NSLog(@"iam okkkkk");
    }
    else if(buttonIndex==1&&alertView.tag==3){
      key_name=[alertView textFieldAtIndex:0].text;
      key_location= [alertView textFieldAtIndex:1].text;
        [self apiacallForUpload];
        NSLog(@"i am for upload");

    }
}
- (IBAction)ManageKeyAction:(id)sender {
    MyKeysVC *se=[[MyKeysVC alloc] init];
    se.user_id=user_id;
    [self.navigationController pushViewController:se animated:YES];
    NSLog(@"user_id***%@",user_id);
    
}

- (IBAction)upgradeAction:(id)sender {
//    UIWebView *webview=[[UIWebView alloc]init];
//    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"https://http://54.85.70.181/upgrade/{/{user_email}/{user_password} "]];
//    
//    NSString *post = [NSString stringWithFormat:@"username=%@&password=%@", @"test", @"123"];
//    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
//    [request setHTTPMethod:@"POST"];
//    [request setValue:[NSString stringWithFormat:@"%d", [postData length]] forHTTPHeaderField:@"Content-Length"];
//    [request setHTTPBody:postData];
//    
//    [webview loadRequest:request];
    NSString *urlstr = [[NSString alloc] initWithFormat:@"http://54.85.70.181/upgrade/%@/%@/%@/",user_id,username,password];
    NSURL *url = [NSURL URLWithString:urlstr];
    [[UIApplication sharedApplication] openURL:url];
}
-(void) apicallForcompare{
    NSLog(@"user_id:%@",user_id);

    [self addActivity];
    compareRequest = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:@"http://54.85.70.181/api/compare-key/"]];
    compareRequest.delegate=self;
    [compareRequest setPostValue:user_id forKey:@"user_id"];
    
    [compareRequest setData:_imageData withFileName:@"thumb1.jpg" andContentType:@"image/jpeg/png/jpg/gif" forKey:@"key_file"];
    [compareRequest setTimeOutSeconds:60];
    [compareRequest startAsynchronous];
    
}
-(void)apiacallForUpload{
    [self addActivity];
    NSLog(@"key_name:%@",key_name);
    NSLog(@"key_location:%@",key_location);
    uploadRequest = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:@"http://54.85.70.181/api/upload-image/"]];
    uploadRequest.delegate=self;
    [uploadRequest setTimeOutSeconds:60];
     [uploadRequest setPostValue:key_location forKey:@"key_location"];
    [uploadRequest setPostValue:key_name forKey:@"key_name"];
    [uploadRequest setPostValue:imagename forKey:@"key_file"];
    [uploadRequest setPostValue:user_id forKey:@"user_id"];
    [uploadRequest startAsynchronous];
    
}
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
    if(request==compareRequest){
    NSString *responseString = [request responseString];
    NSLog(@"*****%@",responseString);
    NSArray *result = [responseString JSONValue];
        int isSucess = [[result  valueForKey:@"success"] intValue];
        NSDictionary *response = [result  valueForKey:@"response"];
        NSLog(@"responsearray:%@",response);
        NSString *keyname = [response objectForKey:@"key_name"];
        imagename=keyname;
        NSLog(@"key_name:%@",keyname);
        imagename=keyname;
        
        if(isSucess==0){
            UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"No KeyId'd!" message:@"This key doest not seem to match any of your current keys.\n if you have uploaded this key before check the following: \n 1.You taking a picture against a plain backgroud,white is best! \n 2.Make sure you only take a picture of the key,keep your fingers out of picture! \n 3.Make sure you are taking the picture of a key." delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK", nil];
        [av setAlertViewStyle:UIAlertViewStyleLoginAndPasswordInput];
        
        // Alert style customization
        [[av textFieldAtIndex:1] setSecureTextEntry:NO];
        [[av textFieldAtIndex:0] setPlaceholder:@"Enter Key Name:"];
        [[av textFieldAtIndex:1] setPlaceholder:@"Enter Key Location:"];
            av.tag=3;
        [av show];
                    }
        else{
            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Success" message:@"Your image is found!!" delegate:nil cancelButtonTitle:@"ok" otherButtonTitles: nil];
            [alert show];
        }

    
    NSLog(@"%@",result);
    }
    if(request==uploadRequest){
        [self removeActivity];
        NSString *responseString = [request responseString];
        NSLog(@"*****%@",responseString);
        NSArray *result = [responseString JSONValue];

        int isSucess = [[result  valueForKey:@"success"] intValue];
        NSDictionary *response = [result  valueForKey:@"response"];
        NSLog(@"responsearray:%@",response);
        if(isSucess==1){
            UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"Alert!" message:@"Image successfully uploaded" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK", nil];
            av.tag=7;
            [av show];
           
        
    }
    }
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
