//
//  HomeSettingVC.m
//  KeyIdManager
//
//  Created by design_offshore on 4/9/14.
//  Copyright (c) 2014 Key_id_Manager. All rights reserved.
//

#import "HomeSettingVC.h"

@interface HomeSettingVC ()

@end

@implementation HomeSettingVC
@synthesize MyTableView;
@synthesize menuArray,submenuArray,TYPE,user_id;

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
  //  UserDataModel *model=[[UserDataModel alloc] init];
    NSLog(@"user_tye:%@",TYPE);
    if([TYPE isEqualToString:@"Free User"]){
      //  self.menuArray=[[NSMutableArray alloc]initWithObjects:@"Dashboard",@"Manage",@"Compare Keys",@"Access Logs",@"Duplicate Logs",@"Log Out",nil];
        self.menuArray=[[NSMutableArray alloc]initWithObjects:@"Dashboard",@"Identify Keys",@"My Keys",@"Log Out",nil] ;
    }
    
    if([TYPE isEqualToString:@"Normal User"]){
    self.menuArray=[[NSMutableArray alloc]initWithObjects:@"Dashboard",@"Compare Keys",@"My Keys",@"Log Out",nil] ;
    }
    if([TYPE isEqualToString:@"User Admin"]){
        self.menuArray=[[NSMutableArray alloc]initWithObjects:@"KeyID",@"KeyID Manager",@"Manage User",@"Contact Us",@"Log out",nil] ;
    }

    }
    
//self.submenuArray=[[NSMutableArray alloc]initWithObjects:@"Power Users",@"Users",@"Keys",nil];    // Do any additional setup after loading the view from its nib.


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1 ;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
	
        return [menuArray count];
    }
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"HomeSettingCell";
    
    HomeSettingCell *cell = (HomeSettingCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    if (cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"HomeSettingCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    //self.cell.backgroundColor=[UIColor colorWithRed:240.0f/255.0f green:240.0f/255.0f blue:240.0f/255.0f alpha:1.0];
    // cell.label.font=FONT_ROBOTO(15);
    
    cell.myLabel.text = [self.menuArray objectAtIndex:indexPath.row];
    switch (indexPath.row) {
        case 0:
            cell.myImage.image=[UIImage imageNamed:@"menu-icon-home.png"];
            break;
            
        case 1:
            cell.myImage.image=[UIImage imageNamed:@"icon-manage(menu).png"];
            break;
        case 2:
            cell.myImage.image=[UIImage imageNamed:@"icon-compare_keys(menu).png"];
            break;
        case 3:
            cell.myImage.image=[UIImage imageNamed:@"icon-access_logs(menu).png"];

            break;
        case 4:
            cell.myImage.image=[UIImage imageNamed:@"icon-duplicate_logs(menu).png"];
            
            break;
        case 5:
            cell.myImage.image=[UIImage imageNamed:@"icon-logout(menu).png"];
            
            break;
        default:
            break;
    }
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   // NSLog(@"test");
    if([TYPE isEqualToString:@"Free User"]) {
    if(indexPath.row==0){
//        CompareKeysVC *se=[[CompareKeysVC alloc] init];
//        UINavigationController *o=[[UINavigationController alloc] initWithRootViewController:se];
//        se.user_id=user_id;
        DashboardVC *se=[[DashboardVC alloc] init];
        UINavigationController *o=[[UINavigationController alloc] initWithRootViewController:se];
        se.user_id=user_id;

        [self.revealSideViewController popViewControllerWithNewCenterController:o animated:YES];
    }
//    if(indexPath.row==1){
//        
//        UploadKeysVC *se=[[UploadKeysVC alloc] init];
//        UINavigationController *o=[[UINavigationController alloc] initWithRootViewController:se];
//        se.user_id=user_id;
//
//        [self.revealSideViewController popViewControllerWithNewCenterController:o animated:YES];
//        
//    }
    if(indexPath.row==1){
        
        MyKeysVC *se=[[MyKeysVC alloc] init];
        se.user_id=user_id;
        UINavigationController *o=[[UINavigationController alloc] initWithRootViewController:se];
        se.user_id=user_id;
        NSLog(@"user_id***%@",user_id);

        [self.revealSideViewController popViewControllerWithNewCenterController:o animated:YES];
        
        
    }
    if(indexPath.row==3){
         LoginVC *se=[[LoginVC alloc] init];
        UINavigationController *o=[[UINavigationController alloc] initWithRootViewController:se];
        [self.revealSideViewController popViewControllerWithNewCenterController:o animated:YES];
        
    }
        
    }

    if([TYPE isEqualToString:@"Normal User"]) {
        if(indexPath.row==0){
//            CompareKeysVC *se=[[CompareKeysVC alloc] init];
//            UINavigationController *o=[[UINavigationController alloc] initWithRootViewController:se];
//            se.user_id=user_id;
//            [self.revealSideViewController popViewControllerWithNewCenterController:o animated:YES];
            DashboardVC *se=[[DashboardVC alloc] init];
            UINavigationController *o=[[UINavigationController alloc] initWithRootViewController:se];
            se.user_id=user_id;
            
            [self.revealSideViewController popViewControllerWithNewCenterController:o animated:YES];
        }
        if(indexPath.row==1){
            
            UploadKeysVC *se=[[UploadKeysVC alloc] init];
            UINavigationController *o=[[UINavigationController alloc] initWithRootViewController:se];
            se.user_id=user_id;

            [self.revealSideViewController popViewControllerWithNewCenterController:o animated:YES];
            
        }
        if(indexPath.row==2){
            
            MyKeysVC *se=[[MyKeysVC alloc] init];
            se.user_id=user_id;
            UINavigationController *o=[[UINavigationController alloc] initWithRootViewController:se];
            se.user_id=user_id;
            NSLog(@"user_id***%@",user_id);
            
            [self.revealSideViewController popViewControllerWithNewCenterController:o animated:YES];
            
        }
        if(indexPath.row==3){
            LoginVC *se=[[LoginVC alloc] init];
            UINavigationController *o=[[UINavigationController alloc] initWithRootViewController:se];
            [self.revealSideViewController popViewControllerWithNewCenterController:o animated:YES];
            
        }

        
    }
    if([TYPE isEqualToString:@"User Admin"]) {
        
        if(indexPath.row==0){
//            CompareKeysVC *se=[[CompareKeysVC alloc] init];
//            UINavigationController *o=[[UINavigationController alloc] initWithRootViewController:se];
//            se.user_id=user_id;
//            [self.revealSideViewController popViewControllerWithNewCenterController:o animated:YES];
            DashboardVC *se=[[DashboardVC alloc] init];
            UINavigationController *o=[[UINavigationController alloc] initWithRootViewController:se];
            se.user_id=user_id;
            
            [self.revealSideViewController popViewControllerWithNewCenterController:o animated:YES];
        }
        if(indexPath.row==1){
            MyKeysVC *se=[[MyKeysVC alloc] init];

           // UploadKeysVC *se=[[UploadKeysVC alloc] init];
            se.user_id=user_id;

            UINavigationController *o=[[UINavigationController alloc] initWithRootViewController:se];
            [self.revealSideViewController popViewControllerWithNewCenterController:o animated:YES];
            
        }
        if(indexPath.row==2){
            
            MyUsersVC *se=[[MyUsersVC alloc] init];
            NSLog(@"user_id:%@",user_id);
            se.user_id=user_id;
            UINavigationController *o=[[UINavigationController alloc] initWithRootViewController:se];
            se.user_id=user_id;
            NSLog(@"user_id***%@",user_id);
            
            [self.revealSideViewController popViewControllerWithNewCenterController:o animated:YES];
            
        }
        if(indexPath.row==3){
            ContactUSVC *se=[[ContactUSVC alloc]init];
            //KeyTrackingLogsVc *se=[[KeyTrackingLogsVc alloc] init];
            UINavigationController *o=[[UINavigationController alloc] initWithRootViewController:se];
            se.user_id=user_id;
            se.IsUserClick=YES;
            se.userType=TYPE;
            [self.revealSideViewController popViewControllerWithNewCenterController:o animated:YES];
            
        }
        if(indexPath.row==4){
            
            LoginVC *se=[[LoginVC alloc] init];
            [FBSession.activeSession closeAndClearTokenInformation];
            NSHTTPCookie *cookie;
            NSHTTPCookieStorage *storage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
            for (cookie in [storage cookies])
            {
                NSString* domainName = [cookie domain];
                NSRange domainRange = [domainName rangeOfString:@"facebook"];
                if(domainRange.length > 0)
                {
                    [storage deleteCookie:cookie];
                }
            }
            UINavigationController *o=[[UINavigationController alloc] initWithRootViewController:se];
            [self.revealSideViewController popViewControllerWithNewCenterController:o animated:YES];
            

          
        
        }
       /* if(indexPath.row==5){
            MyUsersVC *se=[[MyUsersVC alloc] init];
            UINavigationController *o=[[UINavigationController alloc] initWithRootViewController:se];
            se.user_id=user_id;
            [self.revealSideViewController popViewControllerWithNewCenterController:o animated:YES];
            
        }
        if(indexPath.row==6){
            AddUserVC *se=[[AddUserVC alloc] init];
            UINavigationController *o=[[UINavigationController alloc] initWithRootViewController:se];
            se.user_id=user_id;
            [self.revealSideViewController popViewControllerWithNewCenterController:o animated:YES];
            
        }
        if(indexPath.row==7){
            LoginVC *se=[[LoginVC alloc] init];
            [FBSession.activeSession closeAndClearTokenInformation];
            NSHTTPCookie *cookie;
            NSHTTPCookieStorage *storage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
            for (cookie in [storage cookies])
            {
                NSString* domainName = [cookie domain];
                NSRange domainRange = [domainName rangeOfString:@"facebook"];
                if(domainRange.length > 0)
                {
                    [storage deleteCookie:cookie];
                }
            }
            UINavigationController *o=[[UINavigationController alloc] initWithRootViewController:se];
            [self.revealSideViewController popViewControllerWithNewCenterController:o animated:YES];
            
        }

    }
        */
    }
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if(buttonIndex==0&&alertView.tag==6){
        
        [FBSession.activeSession close];
          LoginVC *lg=[[LoginVC alloc] initWithNibName:@"LoginVC" bundle:nil];
        //UINavigationController *nav=[[UINavigationController alloc] initWithRootViewController:lg];
        //[self presentViewController:nav animated:YES completion:Nil];
       // lg.Mynav=self.navigationController;
       // [self presentViewController:lg animated:YES completion:nil];
        [self.navigationController pushViewController:lg animated:NO];
       // [self.revealSideViewController pushViewController:lg onDirection:PPRevealSideDirectionRight animated:YES];
        
    }
    
}
@end
