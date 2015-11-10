//
//  ItemDetailsViewController.h
//  wishlistApp
//
//  Created by Elisabete Sousa on 10/11/15.
//  Copyright © 2015 Elisabete Bicho. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

@interface ItemDetailsViewController : BaseViewController

@property (weak, nonatomic) IBOutlet UIImageView *photoImageView;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *referenceLabel;
@property (weak, nonatomic) IBOutlet UILabel *brandLabel;
@property (weak, nonatomic) IBOutlet UIImageView *brandImageView;

@property (strong, nonatomic) Item *item;

@end
