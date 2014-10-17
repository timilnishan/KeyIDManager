//
//  HomeVC.m
//  KeyIdManager
//
//  Created by design_offshore on 3/31/14.
//  Copyright (c) 2014 Key_id_Manager. All rights reserved.
//

#import "HomeVC.h"

@interface HomeVC ()

@end

@implementation HomeVC
@synthesize indicator,overlayView,UserId;

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
    
    indicator.hidesWhenStopped=YES;
    
   // [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"navigation_menu.png"] forBarMetrics:UIBarMetricsDefault	];
//    
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"ic_drawer.png"] landscapeImagePhone:[UIImage imageNamed:@"ic_drawer.png"]  style:UIBarButtonItemStyleBordered target:self action:@selector(showRightt:)];
    //NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    
    // saving an NSString
//    NSString *pword = [prefs objectForKey:@"password"];
//    NSString *user = [prefs objectForKey:@"UserName"];
//    if(pword ==nil){
//        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Error!!" message:@"Please Login!!!" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"ok", nil];
//        alert.tag=1;
//        [alert show];
//     
//    }
//    if(user==nil){
//        if(pword ==nil){
//            UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Error!!" message:@"Please Login!!!" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"ok", nil];
//            alert.tag=5;
//            [alert show];
//            
//        }
//    }
    // Do any additional setup after loading the view from its nib.


}
- (void)viewWillAppear:(BOOL)animated
{

  // self.navigationController.navigationBar.topItem.backBarButtonItem.h = NO;
    //hides naviagtion back button
    self.navigationItem.hidesBackButton=YES;
   HomeSettingVC *right = [[HomeSettingVC alloc]init];
    [self.revealSideViewController preloadViewController:right forSide:PPRevealSideDirectionRight];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) showRightt:(id)sender
{
    // used to push a new controller, but we preloaded it !
      //  LeftViewController *left = [[LeftViewController alloc] initWithStyle:UITableViewStylePlain];
    //    [self.revealSideViewController pushViewController:left onDirection:PPRevealSideDirectionLeft animated:YES];
    
    [self.revealSideViewController pushOldViewControllerOnDirection:PPRevealSideDirectionRight animated:YES];
}
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    switch (buttonIndex) {
        case 0:
            [self takeNewPhotoFromCamera];
            break;
        case 1:
            [self choosePhotoFromExistingImages];
            break;
            
        default:
            break;
    }
    
}


- (void)takeNewPhotoFromCamera
{
    if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera])
    {
        UIImagePickerController *controller = [[UIImagePickerController alloc] init];
        controller.sourceType = UIImagePickerControllerSourceTypeCamera;
        controller.allowsEditing = NO;
        controller.mediaTypes = [UIImagePickerController availableMediaTypesForSourceType: UIImagePickerControllerSourceTypeCamera];
        controller.delegate = self;
        // [self.navigationController presentViewController: controller animated: YES completion: nil];
        [self presentViewController:controller animated:YES completion:nil];
        
    }
}
-(void)choosePhotoFromExistingImages
{
    
    if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypePhotoLibrary])
    {
        UIImagePickerController *controller = [[UIImagePickerController alloc] init];
        controller.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        controller.allowsEditing = NO;
        controller.mediaTypes = [UIImagePickerController availableMediaTypesForSourceType: UIImagePickerControllerSourceTypePhotoLibrary];
        controller.delegate = self;
        
        //[self.navigationController presentViewController: controller animated: YES completion: nil];
        [self presentViewController:controller animated:YES completion:nil];
        
    }
    
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [self.navigationController dismissViewControllerAnimated: YES completion: nil];
    UIImage *image = [info valueForKey: UIImagePickerControllerOriginalImage];
    _imageData = UIImageJPEGRepresentation(image, 0.1);
    NSLog(@"%@",_imageData);
    UIAlertView *errorAlert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Are u sure Want to upload this pic" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:@"Cancel", nil];
    errorAlert.tag=7;
    [errorAlert show];
    
    
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker;
{
    [self.navigationController dismissViewControllerAnimated: YES completion: nil];
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if(buttonIndex==0&& alertView.tag==7){
        [self Apicall];
        NSLog(@"iam ok");
    }
    else{
        NSLog(@"i am cancel");
    }
    if(buttonIndex==0&&alertView.tag==1){
        LoginVC *login=[[LoginVC alloc] init];
        [self.navigationController pushViewController:login animated:YES];
        
    }
    if(buttonIndex==0&&alertView.tag==6){
//           UserDataModel *model=[[UserDataModel alloc] init];
//        model.UserId=Nil;
//        model.username=Nil;
//        model.firstname=Nil;
//        model.password=Nil;
//        [FBSession.activeSession close];
//        NSString *appDomain = [[NSBundle mainBundle] bundleIdentifier];
//        [[NSUserDefaults standardUserDefaults] removePersistentDomainForName:appDomain];
      LoginVC *lg=[[LoginVC alloc] init];
//        [self presentViewController:lg animated:YES completion:nil];
//        NSLog(@"what the f..");
    [self.navigationController pushViewController:lg animated:YES];
    }
    
}

-(void) Apicall{
    
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
    
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    
    // saving an NSString
    NSString *userid = [prefs objectForKey:@"userid"];
    NSLog(@"userid=%@",userid);
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:URL_IMAGEUPLOAD]];
    request.delegate=self;
    [request setPostValue:UserId forKey:@"user_id"];
    [request setData:_imageData withFileName:@"thumb.jpg" andContentType:@"image/jpeg/png/jpg/gif" forKey:@"key_file"];
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
     if(isSucess==0)
     {
         [indicator performSelectorOnMainThread:@selector(stopAnimating) withObject:nil waitUntilDone:YES];
     UIAlertView *errorAlert = [[UIAlertView alloc] initWithTitle:@" Error!" message:@"Uploding Error!!!" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
     [errorAlert show];
     }
     if(isSucess==1) {
         overlayView.hidden=YES;
         [indicator performSelectorOnMainThread:@selector(stopAnimating) withObject:nil waitUntilDone:YES];
     UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@" Image " message:@"Your Image had been updated" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:Nil, nil];
         alert.tag=10;
     [alert show];
     //ProfileVC *t1=[[ProfileVC alloc] initWithNibName:@"ProfileVC" bundle:nil];
    // [ t1.refresh ];
     
    
     }
    
}




- (IBAction)CameraAction:(id)sender {
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle: nil
                                                             delegate: self
                                                    cancelButtonTitle: @"Cancel"
                                               destructiveButtonTitle: nil
                                                    otherButtonTitles: @"Take a new photo", @"Choose from existing", nil];
    
    [actionSheet showInView:self.view];

}

- (IBAction)LogoutAction:(id)sender {
    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@" Message " message:@"Are you sure want to Logout??" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:@"Cancel", nil];
   alert.tag=6;
    [alert show];
   
}
-(void) stopAnimating{
    [indicator stopAnimating];
}
@end
