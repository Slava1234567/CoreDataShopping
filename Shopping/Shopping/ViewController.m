//
//  ViewController.m
//  Shopping
//
//  Created by Slava on 7/20/18.
//  Copyright © 2018 Slava. All rights reserved.
//

#import "ViewController.h"
#import "TableViewController.h"
#import "AppDelegate.h"
#import "Shopping+CoreDataClass.h"
#import "Shop+CoreDataClass.h"

static NSString* const kCellIdentirier = @"CellIdentifier" ;

@interface ViewController ()<UITableViewDataSource, UITableViewDelegate>

@property(strong,nonatomic) UITableView* tableView;
@property(copy,nonatomic) NSString* personName;
@property(assign,nonatomic) float personCash;

@end


@implementation ViewController

- (UITableView*) tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    }
    return _tableView;
}

//MARK: - Funcs
- (void) addTableView {
   // self.arrayShopping = @[@"aaa",@"bbb"];
    
    [self.view addSubview:self.tableView];
    self.tableView.translatesAutoresizingMaskIntoConstraints = NO;
    
    NSLayoutConstraint *topAnchor = [self.tableView.topAnchor constraintEqualToAnchor:self.view.topAnchor constant:(20)];
    NSLayoutConstraint *leadingAnchor = [self.tableView.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor];
    NSLayoutConstraint *trailingAnchor = [self.tableView.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor];
    NSLayoutConstraint *bottomAnchor = [self.tableView.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor];
    
    [NSLayoutConstraint activateConstraints:@[topAnchor,leadingAnchor,trailingAnchor,bottomAnchor]];
    
}

- (NSArray*) arrayObjects: (NSString*) entityName {
    
    NSEntityDescription* entityDescription = [NSEntityDescription entityForName:entityName inManagedObjectContext:self.context];
    NSFetchRequest* fetchReqest = [[NSFetchRequest alloc] initWithEntityName:entityName];
    [fetchReqest setEntity:entityDescription];
    NSArray* requests = [self.context executeFetchRequest:fetchReqest error:nil];
    
    return requests ;
}



//MARK: - Actions

- (void) addShopping {
    
    TableViewController* tvc = [[TableViewController alloc] initWithStyle:UITableViewStyleGrouped];
    [self.navigationController pushViewController:tvc animated:true];
}

//MARK LifeCycle ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    AppDelegate* delegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    self.context = delegate.persistentContainer.viewContext;
  
    [self addTableView];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    self.personName = @"Person";
    self.personCash = 100.f;
    
    UIBarButtonItem* addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addShopping)];
    UIBarButtonItem* delAll = [[UIBarButtonItem alloc] initWithTitle:@"DeleteAll" style:UIBarButtonItemStylePlain target:self action:@selector(deleteAllObject)];
    [self.navigationItem setRightBarButtonItems:@[addButton, delAll]];
    
}

- (void) deleteAllObject {
    
        
    NSArray* shopArray = [self arrayObjects:@"Shop"];
        for (Shop* shop in shopArray) {
            [self.context deleteObject:shop];
        }
        [self.context save:nil];
    [self.tableView reloadData];
    
}

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

//MARK: - TableView DataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    NSLog(@"shop count - %lu",(unsigned long)[[self arrayObjects:@"Shop"] count]);
    return [[self arrayObjects:@"Shop"] count];
    
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    Shop* shop = [self arrayObjects:@"Shop"][section];
    NSLog(@"CountSHopping - %lu in section %ld",[shop.shopping count],(long)section);
    return [shop.shopping count];
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentirier];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:kCellIdentirier];
    }
    
    Shop* shop = [self arrayObjects:@"Shop" ][indexPath.section];
    NSArray* shoppingArrayForAllShops = [self arrayObjects:@"Shopping"];
    NSMutableArray* necessaryShoppingArray = [NSMutableArray array];
    for (Shopping* shopping in shoppingArrayForAllShops) {
        if ([shopping.shop.name isEqualToString:shop.name]) {
            [necessaryShoppingArray addObject:shopping];
        }
    }
    Shopping* shopping = necessaryShoppingArray[indexPath.row];
    cell.textLabel.text = shopping.name;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%1.2f",shopping.price];
    
    return  cell;
}

- (nullable NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    
    Shop* shop = [self arrayObjects:@"Shop"][section];
    return shop.name;
    
}

//MARK: - TableView Delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80.0;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        Shop* shop = [self arrayObjects:@"Shop"][indexPath.section];
        NSEntityDescription* entityName = [NSEntityDescription entityForName:@"Shopping" inManagedObjectContext:self.context];
        NSFetchRequest* fetchREquest = [[NSFetchRequest alloc] init];
        [fetchREquest setEntity:entityName];
        NSPredicate* predicate = [NSPredicate predicateWithFormat:@"shop.name == %@",shop.name];
        [fetchREquest setPredicate:predicate];
        NSArray* arrayShopping = [self.context executeFetchRequest:fetchREquest error:nil];
        
        if ([shop.shopping count] == 1) {
           [self.context deleteObject:shop];
    
        } else {
            Shopping* shopping = arrayShopping[indexPath.row];
            [self.context deleteObject:shopping];
        }
        
        [self.tableView beginUpdates];
        
        if ([shop.shopping count] == 1) {
            NSIndexSet* indexSet = [NSIndexSet indexSetWithIndex:indexPath.section];
            [self.tableView deleteSections:indexSet withRowAnimation:UITableViewRowAnimationFade];
        } else {
            [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        }

        [self.tableView endUpdates];
        [self.context save:nil];
    }
}
@end







