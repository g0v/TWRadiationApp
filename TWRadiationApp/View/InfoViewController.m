//
//  InfoViewController.m
//  TWRadiationApp
//
//  Created by Kent Huang on 2014/4/19.
//  Copyright (c) 2014年 g0v.tw. All rights reserved.
//

#import "InfoViewController.h"

@interface InfoViewController ()

@end

@implementation InfoViewController

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
    if (coreApi == nil) {
        AppDelegate *appDelegate = [[UIApplication sharedApplication]delegate];
        coreApi = [appDelegate coreApi];
    }
    // Do any additional setup after loading the view.
    self.edgesForExtendedLayout=UIRectEdgeNone;
    self.extendedLayoutIncludesOpaqueBars=NO;
    self.automaticallyAdjustsScrollViewInsets=NO;
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    locationInfoList = [coreApi getLocationInfoList];
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [locationInfoList count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"locationInfo"];
    
    if (cell == nil) {
         cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"locationInfo"];
    }
   
    NSDictionary *locationInfo = [locationInfoList objectAtIndex:indexPath.row];
    // Configure the cell...
    cell.textLabel.text = [locationInfo objectForKey:@"locationName"];
    cell.detailTextLabel.text = [locationInfo objectForKey:@"microSievert"];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"ShowDetailInfo"]) {
        UITableViewCell *selectedTableViewCell = (UITableViewCell*)sender;
        DetailInfoViewController *detailInfoViewController = [segue destinationViewController];
        NSIndexPath *indexPath = [self.tableView indexPathForCell:selectedTableViewCell];
        [detailInfoViewController setLocationDetailInfo:[locationInfoList objectAtIndex:indexPath.row]];
        NSLog(@"View detail information: %@",selectedTableViewCell.textLabel.text);
        
    }
}

@end
