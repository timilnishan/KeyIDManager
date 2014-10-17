//
//  KeyTrackingLogsVc.m
//  KeyIdManager
//
//  Created by design_offshore on 6/9/14.
//  Copyright (c) 2014 Key_id_Manager. All rights reserved.
//

#import "KeyTrackingLogsVc.h"

@interface KeyTrackingLogsVc ()

@end

@implementation KeyTrackingLogsVc
@synthesize user_id,feedVCarray,logsRequest;
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
    NSLog(@"usr_id%@",user_id);
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"ic_drawer.png"] landscapeImagePhone:[UIImage imageNamed:@"ic_drawer.png"]  style:UIBarButtonItemStyleBordered target:self action:@selector(showRightt:)];
    
    feedVCarray=[[NSMutableArray alloc] init];
    [self Apicall];
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
    return 100;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [feedVCarray count];
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *simpleTableIdentifier = @"LogsCell";
    
    LogsCell *cell = (LogsCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"LogsCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
        
    }
        KeysLogsDataModel *model= [feedVCarray objectAtIndex:indexPath.row];
    NSLog(@"feedarray:%@",model.check_by);
    NSLog(@"status:%@",model.status);
    if([[model status] isEqualToString:@"IN"]){
        cell.Status.backgroundColor = [UIColor greenColor];

    }
    if([[model status] isEqualToString:@"OUT"]){
        cell.Status.backgroundColor = [UIColor redColor];
        
    }

    cell.name.text=[model key_name];
    cell.compare.text=[NSString stringWithFormat:@"Checked By:%@",[model check_by]];
    cell.Status.text=[model status];
    [cell.image setImageWithURL:[NSURL URLWithString:[model image]]
                  placeholderImage:[UIImage imageNamed:@"noimage.jpeg"]];
    return cell;


    
}
-(void) Apicall{
        logsRequest = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:@"http://54.85.70.181/api/key-tracking/"]];
    logsRequest.delegate=self;
   // [logsRequest setPostValue:@"96" forKey:@"key_id"];
    [logsRequest setPostValue:user_id forKey:@"user_id"];
  
    [logsRequest startAsynchronous];
    
}
- (void)requestFinished:(ASIHTTPRequest *)request

{
    if(request==logsRequest){
    
    NSString *responseString = [request responseString];
    NSLog(@"*****%@",responseString);
    NSArray *result = [responseString JSONValue] ;
    
    NSLog(@"%@",result);
    int isSucess = [[result  valueForKey:@"success"] intValue];
    NSString *ERROR = [result  valueForKey:@"response"];
        NSArray *responsevalue = [result  valueForKey:@"response"];

    
    if(isSucess==0)
    {
        
        UIAlertView *errorAlert = [[UIAlertView alloc] initWithTitle:@" Error!" message:ERROR delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [errorAlert show];
        
    }
    if(isSucess==1){
        for(int i=0;i<[responsevalue count];i++){
            KeysLogsDataModel *list = [[KeysLogsDataModel alloc] init];
            _catVCDictionary = [responsevalue objectAtIndex:i];
                    NSString *image= [_catVCDictionary objectForKey:@"image"];
            NSString *BY = [_catVCDictionary objectForKey:@"full_name"];
            NSString *status= [_catVCDictionary objectForKey:@"check_in_status"];
            NSString *name= [_catVCDictionary objectForKey:@"key_name"];

            list.image=image;
            list.check_by=BY;
            list.status=status;
            list.key_name=name;
            [self.feedVCarray addObject: list];
        }
        
        [self.tableView reloadData];

    }
    }
}
@end
