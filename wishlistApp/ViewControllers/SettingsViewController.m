//
//  SettingsViewController.m
//  wishlistApp
//
//  Created by Elisabete Sousa on 12/11/15.
//  Copyright © 2015 Elisabete Bicho. All rights reserved.
//

#import "SettingsViewController.h"

@interface SettingsViewController ()

@end

@implementation SettingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupViews];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setupViews {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *view_type = [defaults objectForKey:PREFERENCES_VIEW_TYPE];
    
    if ([view_type isEqualToString:VIEW_TYPE_COLLECTION]) {
        self.boolTableImageView.image = [UIImage imageNamed:@"ic_deselected"];
        self.boolCollectionImageView.image = [UIImage imageNamed:@"ic_selected"];
    } else {
        self.boolTableImageView.image = [UIImage imageNamed:@"ic_selected"];
        self.boolCollectionImageView.image = [UIImage imageNamed:@"ic_deselected"];
    }
}

- (IBAction)tableSelectedTouched:(id)sender {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:VIEW_TYPE_TABLE forKey:PREFERENCES_VIEW_TYPE];
    [defaults synchronize];
    
    self.boolTableImageView.image = [UIImage imageNamed:@"ic_selected"];
    self.boolCollectionImageView.image = [UIImage imageNamed:@"ic_deselected"];
}

- (IBAction)collectionSelectedTouched:(id)sender {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:VIEW_TYPE_COLLECTION forKey:PREFERENCES_VIEW_TYPE];
    [defaults synchronize];

    self.boolTableImageView.image = [UIImage imageNamed:@"ic_deselected"];
    self.boolCollectionImageView.image = [UIImage imageNamed:@"ic_selected"];
}

@end
