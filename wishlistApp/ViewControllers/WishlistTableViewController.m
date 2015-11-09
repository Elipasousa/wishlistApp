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
    [self registerNibs];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    return 20;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString * CellIdentifier0 = @"WishlistInfoTableViewCell";
    
    
    WishlistInfoTableViewCell * cell = (WishlistInfoTableViewCell *) [tableView dequeueReusableCellWithIdentifier:CellIdentifier0 forIndexPath:indexPath];
    if (cell == nil) {
        NSArray * nib = [[NSBundle mainBundle] loadNibNamed:CellIdentifier0 owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return  44;
}


@end
