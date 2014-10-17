//
//  AboutusVC.m
//  KeyIdManager
//
//  Created by design_offshore on 3/31/14.
//  Copyright (c) 2014 Key_id_Manager. All rights reserved.
//

#import "AboutusVC.h"

@interface AboutusVC ()

@end

@implementation AboutusVC
@synthesize titleLabel,DescriptionLabel,aboutUsRequest,MyTextView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
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
- (void)viewDidLoad
{
    [super viewDidLoad];

    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"ic_drawer.png"] landscapeImagePhone:[UIImage imageNamed:@"ic_drawer.png"]  style:UIBarButtonItemStyleBordered target:self action:@selector(showRightt:)];
    [self apicall];

    // Do any additional setup after loading the view from its nib.
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
-(void) apicall{

//NSString *serverURL = [NSString stringWithFormat:@"http://54.85.70.181/?c=keyapi&m=user_remaining_values&user_id=%d",42];
    NSString *serverURL = [NSString stringWithFormat:@"http://54.85.70.181/?c=keyapi&m=pages&page_id=%d",11];

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
    NSString *title=[test valueForKey:@"page_name"];
    NSString *des=[test valueForKey:@"page_content"];
    [titleLabel setText:title];
    [MyTextView setText:des];
    NSLog(@"dfaaf :%@",title);
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
	NSString  *responseString = [request responseString];
    NSLog(@"response:%@",responseString);
    if(request==aboutUsRequest){
        NSLog(@"p response:%@",responseString);
        NSArray *result = [responseString JSONValue] ;
        NSString *test=[result valueForKey:@"title"];
        NSLog(@"%@",test);
        
//        int isSucess = [[result  valueForKey:@"success"] intValue];
//        if(isSucess==0)
//        {
//            UIAlertView *Alert = [[UIAlertView alloc] initWithTitle:@"Error!" message:@"Sorry Somthing is wrong!" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
//            [Alert show];
//        }
//        else
//        {
//            // [self parseAllCommentsList];
//            
//            UIAlertView *Alert = [[UIAlertView alloc] initWithTitle:@"Success!" message:@"We will response you as soon as possible!!!Thank you" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
//            [Alert show];
//      
//            
//        }
        
        
    }
}


@end
