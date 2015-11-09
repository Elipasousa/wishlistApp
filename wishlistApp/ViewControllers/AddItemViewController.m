//
//  AddItemViewController.m
//  wishlistApp
//
//  Created by Elisabete Sousa on 09/11/15.
//  Copyright © 2015 Elisabete Bicho. All rights reserved.
//

#import "AddItemViewController.h"

@interface AddItemViewController ()

@end

@implementation AddItemViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNavigationBar];
    [self setupNavigationButton];
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
    UIBarButtonItem *customButton = [[UIBarButtonItem alloc] initWithTitle:@"Done"
                                                                     style:UIBarButtonItemStylePlain
                                                                    target:self
                                                                    action:@selector(doneAddingItem)];
    
    self.navigationItem.rightBarButtonItem = customButton;
}

-(void)doneAddingItem {
    //validate fields
    [[Database sharedDatabase] addItemWithTitle:self.titleTextField.text reference:self.referenceTextField.text andTag:self.tagTextField.text];
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
