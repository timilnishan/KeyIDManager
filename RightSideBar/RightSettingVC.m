//
//  RightSettingVC.m
//  KeyIdManager
//
//  Created by design_offshore on 3/30/14.
//  Copyright (c) 2014 Key_id_Manager. All rights reserved.
//

#import "RightSettingVC.h"
#import "RightSettingCell.h"
#import "SettingCell.h"

@interface RightSettingVC ()

@end

@implementation RightSettingVC
@synthesize menuArray;
@synthesize tableView1,loginvc1;
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
  //  NSArray *aar=[NSArray arrayWithObjects:@"home",@"Sign Up",@"About Us",@"Contact" nil ];
    
     self.menuArray=[[NSMutableArray alloc]initWithObjects:@"Home",@"Sign Up",@"About Us",nil];
   // self.list=[[NSMutableArray alloc] initWithObjects:@"Home",@"Sign Up",@"About Us",@"Contact" nil];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return 3;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
   static NSString *simpleTableIdentifier = @"SettingCell";
    
   SettingCell *cell = (SettingCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    if (cell == nil)
   {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"SettingCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
  }
    
    //self.cell.backgroundColor=[UIColor colorWithRed:240.0f/255.0f green:240.0f/255.0f blue:240.0f/255.0f alpha:1.0];
   // cell.label.font=FONT_ROBOTO(15);
    
    cell.mylabel.text = [self.menuArray objectAtIndex:indexPath.row];
    switch (indexPath.row) {
        case 0:
            cell.myImage.image=[UIImage imageNamed:@"menu-icon-home.png"];
            break;
            
        case 1:
            cell.myImage.image=[UIImage imageNamed:@"menu-icon-signup.png"];
            break;
        case 2:
            cell.myImage.image=[UIImage imageNamed:@"menu-icon-about.png"];
            break;
            
        /*case 3:
            cell.myImage.image=[UIImage imageNamed:@"menu-icon-contact.png"];
            break;
          */
        default:
            break;
    }
   return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    if(indexPath.row==0){
        LoginVC *login = [[LoginVC alloc] init];
             UINavigationController *o=[[UINavigationController alloc] initWithRootViewController:login];
    [self.revealSideViewController popViewControllerWithNewCenterController:o animated:YES];
    

   }
     else if (indexPath.row==1){
   
        RegisterVC *reg = [[RegisterVC alloc] init];
         UINavigationController *n=[[UINavigationController alloc] initWithRootViewController:reg];
         [self.revealSideViewController popViewControllerWithNewCenterController:n animated:YES];

        
    }
    else if (indexPath.row==2) {
        
        AboutusVC *about = [[AboutusVC alloc] init];
        UINavigationController *q=[[UINavigationController alloc] initWithRootViewController:about];
        [self.revealSideViewController popViewControllerWithNewCenterController:q animated:YES];
        
        
    }/*
    else if (indexPath.row==3){
        ContactUSVC *contact = [[ContactUSVC alloc] init];
        UINavigationController *p=[[UINavigationController alloc] initWithRootViewController:contact];
        [self.revealSideViewController popViewControllerWithNewCenterController:p animated:YES];


        
    }*/
       }
@end
