//
//  Item.h
//  wishlistApp
//
//  Created by Elisabete Sousa on 09/11/15.
//  Copyright © 2015 Elisabete Bicho. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Item : NSObject

@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *reference;
@property (strong, nonatomic) NSString *tag;
@property (strong, nonatomic) NSString *price;
@property (strong, nonatomic) NSString *addedOn;

-(id)initWithTitle:(NSString *)title reference:(NSString *)reference tag:(NSString *)tag price:(NSString *)price addedOn:(NSString *)addedOn;

@end
