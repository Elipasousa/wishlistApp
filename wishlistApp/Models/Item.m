//
//  Item.m
//  wishlistApp
//
//  Created by Elisabete Sousa on 09/11/15.
//  Copyright © 2015 Elisabete Bicho. All rights reserved.
//

#import "Item.h"

@implementation Item

-(id)initWithTitle:(NSString *)title reference:(NSString *)reference andTag:(NSString *)tag {
    _title = title;
    _reference = reference;
    _tag = tag;

    return self;
}

@end
