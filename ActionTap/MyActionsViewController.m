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
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(20, 200, self.view.frame.size.width-40, self.view.frame.size.height - 250)];
    [tableView setDataSource:self];
    [tableView setDelegate:self];
    self.tableView = tableView;
    [self.view addSubview:tableView];
    
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table View

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell =[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"PatternCell"];
    
    
    
    [cell.textLabel setTextAlignment: NSTextAlignmentLeft];
    [cell setTag: indexPath.row];
    [cell.textLabel setTextColor:[UIColor blackColor]];
    

    
    [cell.layer setCornerRadius:10.0];
    [cell.layer setBorderWidth:2.0];
    [cell.layer setBorderColor:[UIColor colorWithRed:14/255.0 green:191/255.0 blue:233/255.0 alpha:1.0].CGColor];
    cell.layer.masksToBounds = YES;
    [cell setBackgroundColor:[UIColor whiteColor]];
    
    
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 90.0f;
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
