//
//  SettingsViewController.h
//  wishlistApp
//
//  Created by Elisabete Sousa on 12/11/15.
//  Copyright © 2015 Elisabete Bicho. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SettingsViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *boolTableImageView;
@property (weak, nonatomic) IBOutlet UIImageView *boolCollectionImageView;
- (IBAction)tableSelectedTouched:(id)sender;
- (IBAction)collectionSelectedTouched:(id)sender;

@end