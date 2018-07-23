//
//  TableViewController.m
//  Shopping
//
//  Created by Slava on 7/20/18.
//  Copyright © 2018 Slava. All rights reserved.
//

#import "TableViewController.h"
#import "ProductsTableViewController.h"

static NSString* const kCellIdentirier1 = @"CellIdentifier1" ;

@interface TableViewController ()

@end

@implementation TableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.arrayNameShops = [NSArray arrayWithObjects:@"Алми",@"Корона", nil];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:kCellIdentirier1];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//MARK: - TableView DataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return  1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.arrayNameShops count];
}


- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentirier1];
    
    cell.textLabel.text = self.arrayNameShops[indexPath.row];
   
    return cell;
    
}

//MARK: - TableView Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ProductsTableViewController *tvc = [[ProductsTableViewController alloc] initWithStyle:UITableViewStylePlain];
    UITableViewCell* cell = [tableView cellForRowAtIndexPath:indexPath];
    tvc.title = cell.textLabel.text;
    [self.navigationController pushViewController:tvc animated:true];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80.0;
}

@end
