//
//  UploadKeysVC.m
//  KeyIdManager
//
//  Created by design_offshore on 5/14/14.
//  Copyright (c) 2014 Key_id_Manager. All rights reserved.
//

#import "UploadKeysVC.h"

@interface UploadKeysVC ()

@end

@implementation UploadKeysVC
@synthesize  KeysLocationTextField,KeysNameTextField,overlayView,indicator,user_id;
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
     self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"ic_drawer.png"] landscapeImagePhone:[UIImage imageNamed:@"ic_drawer.png"]  style:UIBarButtonItemStyleBordered target:self action:@selector(showRightt:)];
    KeysLocationTextField.delegate=self;
    KeysNameTextField.delegate=self;
    // Do any additional setup after loading the view from its nib.
}
- (void) showRightt:(id)sender
{
    
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
//LoginVC *login=[[LoginVC alloc] init];
      //  [self.navigationController pushViewController:login animated:YES];
        
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
//LoginVC *lg=[[LoginVC alloc] init];
        //        [self presentViewController:lg animated:YES completion:nil];
        //        NSLog(@"what the f..");
//[self.navigationController pushViewController:lg animated:YES];
    }
    
}

-(void) Apicall{
    
    //indicator
    self.indicator.hidden=NO;
    self.overlayView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.overlayView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    self.indicator.center = self.overlayView.center;
    [self.overlayView addSubview:self.indicator];
    [self.indicator startAnimating];
    [self.view addSubview:self.overlayView];
    [self.indicator startAnimating ];
    self.indicator.hidesWhenStopped=YES;
    
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    
    // saving an NSString
    NSString *userid = [prefs objectForKey:@"userid"];
    NSLog(@"userid=%@",userid);
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:@"http://54.85.70.181/api/upload-image/"]];
    request.delegate=self;
    [request setPostValue:KeysNameTextField.text forKey:@"key_name"];
    [request setPostValue:KeysLocationTextField.text forKey:@"key_location"];
    [request setPostValue:user_id forKey:@"user_id"];
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
    NSString *ERROR = [result  valueForKey:@"response"];

    if(isSucess==0)
    {
        [self.indicator performSelectorOnMainThread:@selector(stopAnimating) withObject:nil waitUntilDone:YES];
        UIAlertView *errorAlert = [[UIAlertView alloc] initWithTitle:@" Error!" message:ERROR delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [errorAlert show];
        self.overlayView.hidden=YES;

    }
    if(isSucess==1) {
        self.overlayView.hidden=YES;
        [self.indicator performSelectorOnMainThread:@selector(stopAnimating) withObject:nil waitUntilDone:YES];
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@" Image " message:@"Your Image had been updated" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:Nil, nil];
        alert.tag=10;
        [alert show];
        //ProfileVC *t1=[[ProfileVC alloc] initWithNibName:@"ProfileVC" bundle:nil];
        // [ t1.refresh ];
        
        
    }
    
}




- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)UploadImage:(id)sender {
    
    if([KeysNameTextField.text isEqualToString:@""]){
        UIAlertView *errorAlert = [[UIAlertView alloc] initWithTitle:@" Error!" message:@"Enter Keys Name!!!" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [errorAlert show];
        
    }
    else if([KeysLocationTextField.text isEqualToString:@""]){
        UIAlertView *errorAlert = [[UIAlertView alloc] initWithTitle:@" Error!" message:@"Enter Keys Location!!!" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [errorAlert show];
        
    }
    else{
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle: nil
                                                             delegate: self
                                                    cancelButtonTitle: @"Cancel"
                                               destructiveButtonTitle: nil
                                                    otherButtonTitles: @"Take a new photo", @"Choose from existing", nil];
    
    [actionSheet showInView:self.view];
    }

}
@end
