//
//  CreateViewController.m
//  ActionTap
//
//  Created by Joshua Liu on 3/29/15.
//  Copyright (c) 2015 Sebastian Cain. All rights reserved.
//

#import "CreateViewController.h"

@interface CreateViewController ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation CreateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.schemes = [[NSArray alloc] initWithObjects:@"Workflow",@"Music",@"Phone",@"SMS", nil];
    
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(20, 200, self.view.frame.size.width-40, self.view.frame.size.height - 250)];
    [tableView setDataSource:self];
    [tableView setDelegate:self];
    self.tableView = tableView;
    [self.view addSubview:tableView];
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    
    cell.textLabel.text = self.schemes[indexPath.row];
    
    return cell;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.schemes count];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
