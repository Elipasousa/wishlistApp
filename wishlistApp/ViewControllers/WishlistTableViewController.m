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
    NSInteger selectedIemIndex;
    BOOL filterIsActive;
    BOOL willReturnFromAddingNewItem;
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
    filterIsActive = NO;
    willReturnFromAddingNewItem = YES; //to force update on first launch
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (!filterIsActive && willReturnFromAddingNewItem) {
        [self showAllItems];
    }
    willReturnFromAddingNewItem = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)showAllItems {
    self.items = [[Database sharedDatabase] getAllAddedItems];
    [self reloadTableView];
}

-(void)setTotalAndPriceLabels {
    self.totalItemsLabel.text = [NSString stringWithFormat:@"%ld artigos", (long) [self.items count]];
    
    float total_price = 0.0;
    for (Item *i in self.items) {
        NSString *value = [i.price stringByReplacingOccurrencesOfString:@"," withString:@"."];
        total_price += [value floatValue];
    }
    self.totalPriceLabel.text = [NSString stringWithFormat:@"%.02f €", total_price];
}

-(void)reloadTableView {
    [self setTotalAndPriceLabels];

    if ([self.items count] == 0) {
        self.tableView.hidden = YES;
    } else {
        self.tableView.hidden = NO;
        [self.tableView reloadData];
    }
}

#pragma mark - Setup Methods

-(void)setupViews {
    self.filterView.backgroundColor = AppMainColorWithTransparency(0.4);
    [self.tableView setSeparatorColor:AppMainColor];
}

-(void)setupNavigationBar {
    self.navigationItem.hidesBackButton = YES;
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [[UIImage alloc] init];
    self.navigationController.view.backgroundColor = AppMainColor;
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.barTintColor = AppMainColor;
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
                                                                 action:@selector(resizeSearchView)];
    
    UIBarButtonItem *settingsButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"ic_settings"]
                                                                     style:UIBarButtonItemStylePlain
                                                                    target:self
                                                                    action:@selector(settings)];
    
    
    [self.navigationItem setRightBarButtonItems:[NSArray arrayWithObjects:addButton, searchButton, nil]];
    self.navigationItem.leftBarButtonItem = settingsButton;
}

-(void)settings {
}

-(void)addNewItem {
    [self performSegueWithIdentifier:@"addNewItem" sender:self];
}

-(void)resizeSearchView {
    [self.searchTextField resignFirstResponder];
    [self.filterTextField resignFirstResponder];

    self.searchViewHeightConstraint.constant == 0 ? (self.searchViewHeightConstraint.constant = 260) : (self.searchViewHeightConstraint.constant = 0);
    self.grayTransparentView.hidden = !self.grayTransparentView.hidden;
    
    [UIView animateWithDuration:0.5 animations:^{
        [self.view layoutIfNeeded]; // Called on parent view
    }];
}

#pragma mark - Segues

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"addNewItem"]) {
        AddItemViewController *target = segue.destinationViewController;
        target.willAddNewItemBlock = ^() {
            willReturnFromAddingNewItem = YES;
        };
    }
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
    //willReturnFromDetails = YES;

    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return  120;
}

#pragma mark - Actions

- (IBAction)clearFilterTouched:(id)sender {
    self.filterTextField.text = @"";
    self.searchTextField.text = @"";
    selectedBrandIndex = 0;
    
    filterIsActive = NO;
    self.filterView.hidden = YES;
    self.filterViewHeightConstraint.constant = 0.0f;
    [self showAllItems];
}

- (IBAction)searchTouched:(id)sender {
    [self resizeSearchView];
    self.filterViewHeightConstraint.constant = 44.0f;
    self.filterView.hidden = NO;
    
    NSString *search_by_title = [self.searchTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSString *filter_by_brand = [self.filterTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];    
    
    if ([search_by_title isEqualToString:@""] && [filter_by_brand isEqualToString:@""]) {
        self.items = [[Database sharedDatabase] getAllAddedItems];
        self.filterViewHeightConstraint.constant = 0.0f;
        self.filterView.hidden = YES;
    }
    else if (![search_by_title isEqualToString:@""] && ![filter_by_brand isEqualToString:@""]) {
        self.items = [[Database sharedDatabase] getItemsWithTitle:search_by_title andTag:filter_by_brand];
    }
    else if (![search_by_title isEqualToString:@""]) {
        self.items = [[Database sharedDatabase] getItemsWithTitle:search_by_title];
    }
    else if (![filter_by_brand isEqualToString:@""]) {
        self.items = [[Database sharedDatabase] getItemsWithTag:filter_by_brand];
    }
    [self reloadTableView];

}

- (IBAction)clearSearchTouched:(id)sender {
    self.filterTextField.text = @"";
    self.searchTextField.text = @"";
    selectedBrandIndex = 0;
}

#pragma mark - SWTableViewCell Methods

-(NSArray *)rightButtons {
    NSMutableArray *rightUtilityButtons = [NSMutableArray new];
    //[rightUtilityButtons sw_addUtilityButtonWithColor:OliveColor title:@"Comprado"];
    [rightUtilityButtons sw_addUtilityButtonWithColor:GoldColor icon:[UIImage imageNamed:@"ic_edit"]];
    [rightUtilityButtons sw_addUtilityButtonWithColor:FireBrickColor icon:[UIImage imageNamed:@"ic_delete"]];
    
    return rightUtilityButtons;
}

-(void)swipeableTableViewCell:(SWTableViewCell *)cell didTriggerRightUtilityButtonWithIndex:(NSInteger)index {
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    [cell hideUtilityButtonsAnimated:YES];
    selectedIemIndex = indexPath.row;
    
    switch (index) {
        case 0: { //Editar
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            AddItemViewController *target =  (AddItemViewController*)[storyboard instantiateViewControllerWithIdentifier:@"AddItemViewController"];
            target.item = [self.items objectAtIndex:indexPath.row];
            target.willAddNewItemBlock = ^() {
                willReturnFromAddingNewItem = YES;
            };
            [self.navigationController pushViewController:target animated:YES];
            break;
        }
        case 1: { //Aagar
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Atenção"
                                                            message:@"Tem a certeza que pretende eliminar este artigo?"
                                                           delegate:self
                                                  cancelButtonTitle:@"Cancelar"
                                                  otherButtonTitles:@"Sim",nil];
            [alert show];
            break;
        }
    }
}

-(BOOL)swipeableTableViewCellShouldHideUtilityButtonsOnSwipe:(SWTableViewCell *)cell {
    return YES;
}

#pragma mark - Alert View

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 1) { //YES pressed
        Item *i = [self.items objectAtIndex:selectedIemIndex];
        [[Database sharedDatabase] deleteItemWithId:i.item_id];
        [self showAllItems];
    }
}

#pragma mark - UITextFieldDelegate Methods

-(void)textFieldDidBeginEditing:(UITextField *)textField {
    if (textField == self.filterTextField) {
        [ActionSheetStringPicker showPickerWithTitle:@"Escolha a loja"
                                                rows:BRAND_NAMES
                                    initialSelection:selectedBrandIndex
                                           doneBlock:^(ActionSheetStringPicker *picker, NSInteger selectedIndex, id selectedValue) {
                                               selectedBrandIndex = selectedIndex;
                                               filterIsActive = YES;
                                               
                                               NSString *brand_name = [BRAND_NAMES objectAtIndex:selectedIndex];
                                               self.filterTextField.text = brand_name;
                                               [textField resignFirstResponder];
                                           }
                                         cancelBlock:^(ActionSheetStringPicker *picker) {
                                             NSLog(@"Block Picker Canceled");
                                         }
                                              origin:self.view];
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    if (textField == self.searchTextField) {
        if (![self.searchTextField.text isEqualToString:@""]) {
            filterIsActive = YES;
        }
    }
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

@end
