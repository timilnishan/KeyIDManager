//
//  EditKeysVC.m
//  KeyIdManager
//
//  Created by design_offshore on 5/19/14.
//  Copyright (c) 2014 Key_id_Manager. All rights reserved.
//

#import "EditKeysVC.h"

@interface EditKeysVC ()

@end

@implementation EditKeysVC
@synthesize bywho,location,img,title,key_id,keyname,keyLocationTextField,user_id,keynameTextField;

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
    keynameTextField.text=keyname;
    keyLocationTextField.text=location;
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
      
    }
    
}

-(void) Apicall{
    
    NSLog(@"keys_id:%@",key_id);
    NSLog(@"user_id:%@",user_id);
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:@"http://54.85.70.181/api/edit-image/"]];
    request.delegate=self;
    [request setPostValue:keynameTextField.text forKey:@"key_name"];
    [request setPostValue:keyLocationTextField.text forKey:@"key_location"];
    [request setPostValue:user_id forKey:@"user_id"];
    [request setPostValue:key_id forKey:@"id"];
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
        UIAlertView *errorAlert = [[UIAlertView alloc] initWithTitle:@" Error!" message:ERROR delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [errorAlert show];
        
    }
    if(isSucess==1) {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@" Image " message:@"Your Image had been updated" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:Nil, nil];
        alert.tag=10;
        [alert show];
        //ProfileVC *t1=[[ProfileVC alloc] initWithNibName:@"ProfileVC" bundle:nil];
        // [ t1.refresh ];
        
        
    }
    
}

- (IBAction)uploadImageAction:(id)sender {
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle: nil
                                                             delegate: self
                                                    cancelButtonTitle: @"Cancel"
                                               destructiveButtonTitle: nil
                                                    otherButtonTitles: @"Take a new photo", @"Choose from existing", nil];
    
    [actionSheet showInView:self.view];

}
- (IBAction)saveAction:(id)sender {
     if([keynameTextField.text isEqualToString:@""]){
        [keynameTextField becomeFirstResponder];
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Error!" message:@"Enter Key Name" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil];
        [alert show];
        
    }

    else if([keyLocationTextField.text isEqualToString:@""]){
        [keyLocationTextField becomeFirstResponder];
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Error!" message:@"Enter Key Location" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil];
        [alert show];
    }
    
    else{
        [self Apicall];
    }
}
@end
