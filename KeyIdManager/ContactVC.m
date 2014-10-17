//
//  ContactVC.m
//  KeyIdManager
//
//  Created by design_offshore on 3/30/14.
//  Copyright (c) 2014 Key_id_Manager. All rights reserved.
//

#import "ContactVC.h"
#import "PKRevealControllerContainerView.h"

@interface ContactVC ()

@end

@implementation ContactVC

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
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"menu-icon.png"] landscapeImagePhone:[UIImage imageNamed:@"menu-icon.png"]  style:UIBarButtonItemStyleBordered target:self action:@selector(showRightt:)];

    // Do any additional setup after loading the view from its nib.
}
- (void) showRightt:(id)sender
{
    // used to push a new controller, but we preloaded it !
    //    LeftViewController *left = [[LeftViewController alloc] initWithStyle:UITableViewStylePlain];
    //    [self.revealSideViewController pushViewController:left onDirection:PPRevealSideDirectionLeft animated:YES];
    
    [self.revealSideViewController pushOldViewControllerOnDirection:PPRevealSideDirectionRight animated:YES];
}
- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //[[self navigationController] setNavigationBarHidden:YES animated:YES];
    
    RightSettingVC *right = [[RightSettingVC alloc]init];
    [self.revealSideViewController preloadViewController:right forSide:PPRevealSideDirectionRight];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

@end
