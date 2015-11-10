//
//  WishlistInfoTableViewCell.m
//  wishlistApp
//
//  Created by Elisabete Sousa on 09/11/15.
//  Copyright © 2015 Elisabete Bicho. All rights reserved.
//

#import "WishlistInfoTableViewCell.h"

@implementation WishlistInfoTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setItem:(Item *)item {
    if (item == nil) {
        return;
    }
    _item = item;
    
    self.titleLabel.text = self.item.title;
    self.referenceLabel.text = self.item.reference;
    self.priceLabel.text = self.item.price;
    
    NSString *tag_name = [BRAND_LOGOS objectForKey:self.item.tag];
    if (tag_name != nil) {
        self.tagLabel.hidden = YES;
        self.tagImageView.hidden = NO;
        self.tagImageView.image = [UIImage imageNamed:tag_name];
    } else {
        self.tagLabel.hidden = NO;
        self.tagImageView.hidden = YES;
        self.tagLabel.text = self.item.tag;
    }

    NSData *data = [[NSData alloc]initWithBase64EncodedString:self.item.photo options:NSDataBase64DecodingIgnoreUnknownCharacters];
    self.photoImageView.image =[UIImage imageWithData:data];
}

@end
