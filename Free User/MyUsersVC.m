//
//  MyUsersVC.m
//  KeyIdManager
//
//  Created by design_offshore on 5/20/14.
//  Copyright (c) 2014 Key_id_Manager. All rights reserved.
//

#import "MyUsersVC.h"

@interface MyUsersVC ()

@end

@implementation MyUsersVC
@synthesize mytable,feedVCArray,user_id,dataRequest;
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
    
   // NSLog(@"key_id:%@",user_id);
    feedVCArray=[[NSMutableArray alloc] init];
    [self apicall];
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
    return 50;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [feedVCArray count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *simpleTableIdentifier = @"ListuserCell";
    
    ListuserCell *cell = (ListuserCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"ListuserCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
        
    }
    
    UserLisitingModel *model= [feedVCArray objectAtIndex:indexPath.row];
    
   // cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.imageView.image=[UIImage imageNamed:@"users.png"];
    cell.nameLabel.text = [model full_name];
   // cell.dateLabel.text=[model date];
//    NSLog(@"img:%@",[model img]);
//    [cell.keyimage setImageWithURL:[NSURL URLWithString:[model img]]
//                  placeholderImage:[UIImage imageNamed:@"noimage.jpeg"]];
    // NSData* imageData = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString: [model img]]];
    //UIImage* image = [[UIImage alloc] initWithData:imageData];
    //cell.keyimage.image =image;
    // cell.myimage.image=[UIImage imageNamed:[model img]];
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UserLisitingModel *model = (UserLisitingModel *)[self.feedVCArray objectAtIndex:indexPath.row];
    MyUserDetailVC *detail=[[MyUserDetailVC alloc] init];
    detail.full_name=[model full_name];
    detail.date=[model date];
    detail.total_img=[model total_img];
    detail.id_=[model id_];
    detail.user_id=user_id;
//    detail.keyname=[model title];
//    detail.date=[model date];
//    detail.img=[model img];
//    detail.bywho=[model BY];
//    detail.location=[model location];
//    detail.key_id=[model key_id];
//    detail.user_id=user_id;
    //    RecectTabVC *gallery=[[RecectTabVC alloc] init];
    //  gallery.cat_id=[model cat_id];
    // gallery.title=[tableData objectAtIndex:indexPath.row];
    //gallery.des=[tableDetail objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:detail animated:YES];
    
}
-(void) apicall{
    NSString *serverURL = [NSString stringWithFormat:@"%@",URL_USERLIST];
    //NSString *serverURL = [NSString stringWithFormat:@"%@",URL_LOGIN];
    NSURL *url = [NSURL URLWithString:serverURL];
    dataRequest =[ASIFormDataRequest requestWithURL:url];
    [dataRequest setDelegate:self];
    [dataRequest setTimeOutSeconds:120];
    [dataRequest setRequestMethod:@"POST"];
    dataRequest = [ASIFormDataRequest requestWithURL:url];
    [dataRequest setPostValue:user_id forKey:@"user_id"];
    [dataRequest setDelegate:self];
    [dataRequest startAsynchronous];
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
    // Do something because all other tests failed
    NSDictionary *jsonData = [responseString JSONValue] ;
    NSLog(@"json data****** %@",jsonData);
    NSArray *result=[jsonData objectForKey:@"response"];
    for(int i=0;i<[result count];i++){
                UserLisitingModel *list = [[UserLisitingModel alloc] init];
                _catVCDictionary = [result objectAtIndex:i];
                NSString *full_name = [_catVCDictionary objectForKey:@"full_name"];
        NSString *image = [_catVCDictionary objectForKey:@"total_image"];
                NSString *id_ = [_catVCDictionary objectForKey:@"id"];
        NSString *date = [_catVCDictionary objectForKey:@"registration_date"];

                       list.full_name=full_name;
        list.total_img=image;
        list.date=date;
        list.id_=id_;
                [self.feedVCArray addObject: list];
    }
    
    [self.mytable reloadData];
}


@end
