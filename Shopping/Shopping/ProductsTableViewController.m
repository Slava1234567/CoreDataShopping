//
//  ProductsTableViewController.m
//  Shopping
//
//  Created by Slava on 7/20/18.
//  Copyright © 2018 Slava. All rights reserved.
//

#import "ProductsTableViewController.h"
#import "ViewController.h"
#import "ProductsShop.h"
#import "Shop+CoreDataClass.h"
#import "Shopping+CoreDataClass.h"

static NSString* const kCellIdentifier2 = @"CellIdentifier2";

@interface ProductsTableViewController ()

@property(copy,nonatomic) NSArray* constantNameProducts;
@property(copy,nonatomic) NSArray* constantPriceProducts;
@property(strong,nonatomic) NSManagedObjectContext* context;

@end

@implementation ProductsTableViewController

- (ViewController*) getRootViewController {
    NSArray* controllers = self.navigationController.viewControllers;
    ViewController* vc;
    if ([controllers[0] isKindOfClass:[ViewController class]]) {
        vc =  controllers[0];
    }
    return vc;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    ViewController* rootVC = [self getRootViewController];
    self.context = rootVC.context;
    
    ProductsShop* productsShop = [[ProductsShop alloc] init];
    
    self.constantNameProducts = [NSArray arrayWithArray:productsShop.nameProducts];
    self.constantPriceProducts = [NSArray arrayWithArray:productsShop.priceProducts];
    
    UIBarButtonItem* chooseButton = [[UIBarButtonItem alloc] initWithTitle:@"Choose" style:UIBarButtonItemStylePlain target:self action:@selector(chooseShopping)];
    [self.navigationItem setRightBarButtonItem:chooseButton];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) chooseShopping {

  //  [self deleteAllObgect];
   [self.context save:nil];
 
    [self.navigationController popToRootViewControllerAnimated:true];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return [self.constantPriceProducts count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier2];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:kCellIdentifier2];
    }
    cell.textLabel.text = self.constantNameProducts[indexPath.row];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@",self.constantPriceProducts[indexPath.row]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSFetchRequest* fetchrequest = [self getFechRequest:@"Shop"];
    NSPredicate* predicate = [NSPredicate predicateWithFormat:@"name == %@",self.title];
    [fetchrequest setPredicate:predicate];
    NSArray* arraySort = [self.context executeFetchRequest:fetchrequest error:nil];
    
    UITableViewCell* cell = [tableView cellForRowAtIndexPath:indexPath];
    
    if (cell.accessoryType == UITableViewCellAccessoryNone) {
    cell.accessoryType = UITableViewCellAccessoryCheckmark;
        
        Shopping* shopping = [NSEntityDescription insertNewObjectForEntityForName:@"Shopping" inManagedObjectContext:self.context];
        shopping.name = cell.textLabel.text;
        shopping.price = [cell.detailTextLabel.text floatValue];
       
        if ([arraySort count] == 0) {
            Shop* newShop = [NSEntityDescription insertNewObjectForEntityForName:@"Shop" inManagedObjectContext:self.context];
                            newShop.name = self.title;
                           [newShop addShoppingObject:shopping];
        } else {
            Shop* shop = arraySort[0];
            [shop addShoppingObject:shopping];
        }
        
    } else {
        cell.accessoryType = UITableViewCellAccessoryNone;
        
        NSFetchRequest* fetchRequest1 = [self getFechRequest:@"Shopping"];
        NSPredicate* predicate1 = [NSPredicate predicateWithFormat:@"name == %@ AND shop.name == %@" ,cell.textLabel.text,self.title];
        [fetchRequest1 setPredicate:predicate1];
        NSArray* sortArrayShopping = [self.context executeFetchRequest:fetchRequest1 error:nil];
        
        Shop* shop = arraySort[0];
        Shopping* shopping = sortArrayShopping[0];
        [shop removeShoppingObject:shopping];
    }
}

- (NSArray*) getArrayObgect: (NSString*) entityName {
    NSEntityDescription* entity = [NSEntityDescription entityForName:entityName inManagedObjectContext:self.context];
    NSFetchRequest* fetchRequest = [[NSFetchRequest alloc] init];
    [fetchRequest setEntity:entity];
    NSArray* arrayShop = [self.context executeFetchRequest:fetchRequest error:nil];
    return  arrayShop;
}

//- (void) deleteAllObgect {
//
//    NSArray* shopArray = [self getArrayObgect:@"Shop"];
//    for (Shop* shop in shopArray) {
//        [self.context deleteObject:shop];
//    }
//    [self.context save:nil];
//}

- (NSFetchRequest*) getFechRequest: (NSString*) name {
    NSEntityDescription* entity = [NSEntityDescription entityForName:name inManagedObjectContext:self.context];
    NSFetchRequest* fetchRequest = [[NSFetchRequest alloc] init];
    [fetchRequest setEntity:entity];
    return  fetchRequest;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80.0;
}



@end
