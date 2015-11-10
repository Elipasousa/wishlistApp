//
//  ItemDetailsViewController.m
//  wishlistApp
//
//  Created by Elisabete Sousa on 10/11/15.
//  Copyright © 2015 Elisabete Bicho. All rights reserved.
//

#import "ItemDetailsViewController.h"

@interface ItemDetailsViewController ()

@end

@implementation ItemDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self setupViews];
}

-(void)setupViews {
    if (self.item == nil) {
        return;
    }
    
    self.title = self.item.title;
    self.referenceLabel.text = [NSString stringWithFormat:@"Ref.: %@", self.item.reference];
    self.priceLabel.text = self.item.price;
    
    NSString *tag_name = [BRAND_LOGOS objectForKey:self.item.tag];
    if (tag_name != nil) {
        self.brandLabel.hidden = YES;
        self.brandImageView.hidden = NO;
        self.brandImageView.image = [UIImage imageNamed:tag_name];
    } else {
        self.brandLabel.hidden = NO;
        self.brandImageView.hidden = YES;
        self.brandLabel.text = self.item.tag;
    }
    
    NSData *data = [[NSData alloc]initWithBase64EncodedString:self.item.photo options:NSDataBase64DecodingIgnoreUnknownCharacters];
    self.photoImageView.image =[UIImage imageWithData:data];
}


@end
