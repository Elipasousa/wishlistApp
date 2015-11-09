//
//  Item.m
//  wishlistApp
//
//  Created by Elisabete Sousa on 09/11/15.
//  Copyright © 2015 Elisabete Bicho. All rights reserved.
//

#import "Item.h"

@implementation Item

-(id)initWithTitle:(NSString *)title reference:(NSString *)reference tag:(NSString *)tag price:(NSString *)price addedOn:(NSString *)addedOn {
    _title = title;
    _reference = reference;
    _tag = tag;
    _price = price;
    _addedOn = addedOn;

    return self;
}

@end
