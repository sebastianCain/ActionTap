//
//  MyActionsViewController.m
//  ActionTap
//
//  Created by Sebastian Cain on 3/28/15.
//  Copyright (c) 2015 Sebastian Cain. All rights reserved.
//

#import "MyActionsViewController.h"

@interface MyActionsViewController ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation MyActionsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 200, self.view.frame.size.width, self.view.frame.size.height - 250)];
    [tableView setDataSource:self];
    [tableView setDelegate:self];
    
    
    
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table View

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell;
    
    
    
    return cell;
}




/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
