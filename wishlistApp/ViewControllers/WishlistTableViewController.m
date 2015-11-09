//
//  WishlistTableViewController.m
//  wishlistApp
//
//  Created by Elisabete Sousa on 09/11/15.
//  Copyright © 2015 Elisabete Bicho. All rights reserved.
//

#import "WishlistTableViewController.h"

@interface WishlistTableViewController ()

@end

@implementation WishlistTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNavigationBar];
    [self setupNavigationButton];
    [self registerNibs];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.items = [[Database sharedDatabase] getAllItems];
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Setup Methods

-(void)setupNavigationBar {
    self.navigationController.navigationBar.tintColor = [UIColor blackColor];
}

-(void)setupNavigationButton {
    UIBarButtonItem *customButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"ic_add"]
                                                                     style:UIBarButtonItemStylePlain
                                                                    target:self
                                                                    action:@selector(addNewItem)];
    
    self.navigationItem.rightBarButtonItem = customButton;
}

-(void)addNewItem {
    [self performSegueWithIdentifier:@"addNewItem" sender:self];
}

#pragma mark - Table View Methods

-(void)registerNibs {
    UINib *nib1 = [UINib nibWithNibName:@"WishlistInfoTableViewCell" bundle:nil];
    [self.tableView registerNib:nib1 forCellReuseIdentifier:@"WishlistInfoTableViewCell"];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return  1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.items count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString * CellIdentifier0 = @"WishlistInfoTableViewCell";
    
    
    WishlistInfoTableViewCell * cell = (WishlistInfoTableViewCell *) [tableView dequeueReusableCellWithIdentifier:CellIdentifier0 forIndexPath:indexPath];
    if (cell == nil) {
        NSArray * nib = [[NSBundle mainBundle] loadNibNamed:CellIdentifier0 owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    cell.item = [self.items objectAtIndex:indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return  100;
}


@end
