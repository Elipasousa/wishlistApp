//
//  WishlistTableViewController.m
//  wishlistApp
//
//  Created by Elisabete Sousa on 09/11/15.
//  Copyright © 2015 Elisabete Bicho. All rights reserved.
//

#import "WishlistTableViewController.h"

@interface WishlistTableViewController () {
    NSInteger selectedBrandIndex;
}

@end

@implementation WishlistTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNavigationBar];
    [self setupNavigationButton];
    [self setupViews];
    [self registerNibs];
    
    selectedBrandIndex = 0;
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.items = [[Database sharedDatabase] getAllAddedItems];
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Setup Methods

-(void)setupViews {
    self.filterView.backgroundColor = AquaBlueColorWithTransparency;
}

-(void)setupNavigationBar {
    self.navigationItem.hidesBackButton = YES;
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [[UIImage alloc] init];
    self.navigationController.view.backgroundColor = AquaBlueColor;
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.barTintColor = AquaBlueColor;
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName : [UIColor whiteColor]};
    self.navigationController.navigationBar.opaque = YES;
    self.navigationController.navigationBar.translucent = NO;
    
    
    //self.navigationController.navigationBar.tintColor = [UIColor blackColor];
}

-(void)setupNavigationButton {
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"ic_add"]
                                                                     style:UIBarButtonItemStylePlain
                                                                    target:self
                                                                    action:@selector(addNewItem)];
    
    UIBarButtonItem *searchButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"ic_search"]
                                                                  style:UIBarButtonItemStylePlain
                                                                 target:self
                                                                 action:@selector(searchItem)];
    
    
    [self.navigationItem setRightBarButtonItems:[NSArray arrayWithObjects:addButton, searchButton, nil]];
    //self.navigationItem.rightBarButtonItem = addButton;

}

-(void)addNewItem {
    [self performSegueWithIdentifier:@"addNewItem" sender:self];
}

-(void)searchItem {
    [ActionSheetStringPicker showPickerWithTitle:@"Escolha a loja"
                                            rows:BRAND_NAMES
                                initialSelection:selectedBrandIndex
                                       doneBlock:^(ActionSheetStringPicker *picker, NSInteger selectedIndex, id selectedValue) {
                                           selectedBrandIndex = selectedIndex;
                                           NSString *tag_name = [BRAND_LOGOS objectForKey:selectedValue];
                                            self.filterImageView.image = [UIImage imageNamed:tag_name];
                                            self.filterViewHeightConstraint.constant = 44.0f;
                                            self.filterView.hidden = NO;
                                           
                                           self.items = [[Database sharedDatabase] getItemsWithTag:selectedValue];
                                           [self.tableView reloadData];
                                       }
                                     cancelBlock:^(ActionSheetStringPicker *picker) {
                                         NSLog(@"Block Picker Canceled");
                                     }
                                          origin:self.view];
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
    cell.rightUtilityButtons = [self rightButtons];
    cell.delegate = self;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    ItemDetailsViewController *target =  (ItemDetailsViewController*)[storyboard instantiateViewControllerWithIdentifier:@"ItemDetailsViewController"];
    target.item = [self.items objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:target animated:YES];
    
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return  100;
}

#pragma mark - Actions

- (IBAction)clearFilterTouched:(id)sender {
    selectedBrandIndex = 0;
    self.filterView.hidden = YES;
    self.filterViewHeightConstraint.constant = 0.0f;
    self.items = [[Database sharedDatabase] getAllAddedItems];
    [self.tableView reloadData];
}

#pragma mark - SWTableViewCell Methods

-(NSArray *)rightButtons {
    NSMutableArray *rightUtilityButtons = [NSMutableArray new];
    //[rightUtilityButtons sw_addUtilityButtonWithColor:OliveColor title:@"Comprado"];
    [rightUtilityButtons sw_addUtilityButtonWithColor:GoldColor title:@"Editar"];
    [rightUtilityButtons sw_addUtilityButtonWithColor:FireBrickColor title:@"Apagar"];
    
    return rightUtilityButtons;
}

-(void)swipeableTableViewCell:(SWTableViewCell *)cell didTriggerRightUtilityButtonWithIndex:(NSInteger)index {
    //NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    [cell hideUtilityButtonsAnimated:YES];
    
    switch (index) {
        case 0: { //Editar
            NSLog(@"0 touched");
            break;
        }
        case 1: { //Aagar
            NSLog(@"1 touched");
            break;
        }
    }
}

-(BOOL)swipeableTableViewCellShouldHideUtilityButtonsOnSwipe:(SWTableViewCell *)cell {
    return YES;
}

@end
