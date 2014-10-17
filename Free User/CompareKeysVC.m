//
//  CompareKeysVC.m
//  KeyIdManager
//
//  Created by design_offshore on 5/14/14.
//  Copyright (c) 2014 Key_id_Manager. All rights reserved.
//

#import "CompareKeysVC.h"

@interface CompareKeysVC ()

@end

@implementation CompareKeysVC
@synthesize status,overlayView,indicator,statusTextField,pickerView,user_id,firstImage,secondimage,detailButton,resultLabel,MyUIView,DateLabel,UploadByLebel,KeyLocationLebel,KeynameLabel;
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
    MyUIView.hidden=YES;
    DateLabel.hidden=YES;
    KeyLocationLebel.hidden=YES;
    KeynameLabel.hidden=YES;
    UploadByLebel.hidden=YES;
    indicator.hidden=YES;
    [firstImage setHidden:YES];
    [secondimage setHidden:YES];
    detailButton.hidden=YES;
    resultLabel.hidden=YES;
        self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"ic_drawer.png"] landscapeImagePhone:[UIImage imageNamed:@"ic_drawer.png"]  style:UIBarButtonItemStyleBordered target:self action:@selector(showRightt:)];
    pickerView.hidden=YES;
    statusTextField.delegate=self;
    //status=[NSMutableArray arrayWithObjects:@"in",@"out",nil];
    status =[NSArray arrayWithObjects:@"IN",@"OUT", nil];
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
- (NSInteger)numberOfComponentsInPickerView:
(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView
numberOfRowsInComponent:(NSInteger)component
{
    return status.count;
}

- (NSString *)pickerView:(UIPickerView *)pickerView
             titleForRow:(NSInteger)row
            forComponent:(NSInteger)component
{
    return status[row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row   inComponent:(NSInteger)component{
    
    NSLog(@"Selected Row %@", status[row]);
    statusTextField.text=status[row];
    _status_check=[NSString stringWithFormat:@"%@",status[row]];
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
- (IBAction)uploadKeysAction:(id)sender {
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle: nil
                                                             delegate: self
                                                    cancelButtonTitle: @"Cancel"
                                               destructiveButtonTitle: nil
                                                    otherButtonTitles: @"Take a new photo", @"Choose from existing", nil];
    
    [actionSheet showInView:self.view];

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
        UserDataModel *model=[[UserDataModel alloc] init];
        NSString *status_=[model status];

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
    NSLog(@"staus=%@",_status_check);
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
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:@"http://54.85.70.181/api/compare-key/"]];
    request.delegate=self;
    [request setPostValue:_status_check forKey:@"check_in_status"];
    [request setPostValue:user_id forKey:@"user_id"];

    [request setData:_imageData withFileName:@"thumb.jpg" andContentType:@"image/jpeg/png/jpg/gif" forKey:@"key_file"];
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
    NSArray *test=[result valueForKey:@"response"];

    
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
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Success" message:@"Key Found!!!!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:Nil, nil];
        alert.tag=10;
        [firstImage setHidden:NO];
        [secondimage setHidden:NO];
        detailButton.hidden=NO;
        resultLabel.hidden=NO;
        for(int i=0;i<[test count];i++){
           // UserKeysListModel *list = [[UserKeysListModel alloc] init];
            _catVCDictionary = [test objectAtIndex:i];
            NSString *key_name = [_catVCDictionary objectForKey:@"key_name"];
            NSString *key_location = [_catVCDictionary objectForKey:@"key_location"];
            NSString *date = [_catVCDictionary objectForKey:@"created_time"];
            NSString *image= [_catVCDictionary objectForKey:@"key_image"];
            NSString *BY = [_catVCDictionary objectForKey:@"uploaded_by"];
            NSString *key_id= [_catVCDictionary objectForKey:@"id"];
            
            
            
            firstImage.layer.masksToBounds = YES;
            firstImage.layer.cornerRadius = 5.0;
            firstImage.layer.borderWidth = 1.0;
            firstImage.layer.borderColor = [[UIColor grayColor] CGColor];
            
            secondimage.layer.masksToBounds = YES;
            secondimage.layer.cornerRadius = 5.0;
            secondimage.layer.borderWidth = 1.0;
            secondimage.layer.borderColor = [[UIColor grayColor] CGColor];
            
            [secondimage setImageWithURL:[NSURL URLWithString:image]
                         placeholderImage:[UIImage imageNamed:@"noimage.jpeg"]];
            
              UIImage *image1 = [UIImage imageWithData:_imageData];
            firstImage.image=image1;
            MyUIView.hidden=NO;
            UploadByLebel.text=[NSString stringWithFormat:@"Upload By:%@",BY];
            DateLabel.text=[NSString stringWithFormat:@"Date:%@",date];
            KeynameLabel.text=[NSString stringWithFormat:@"Key Name:%@",key_name];
            KeyLocationLebel.text=[NSString stringWithFormat:@"Key Location:%@",key_location];
            [alert show];
            
          //  UIImage *image1 = [UIImage imageWithData:_imageData];
           // [firstImage setImageWithURL:[NSURL URLWithString:image1]
                      //  placeholderImage:[UIImage imageNamed:@"noimage.jpeg"]];

        }
        //ProfileVC *t1=[[ProfileVC alloc] initWithNibName:@"ProfileVC" bundle:nil];
        // [ t1.refresh ];
        
        
    }
    
}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    //  responder = textField;
    
    if ([textField isEqual:self.statusTextField]) {
        pickerView.hidden=NO;
        statusTextField.inputView = pickerView;
        
    }
    
    return YES;
}
- (IBAction)DetailAction:(id)sender {
}
@end
