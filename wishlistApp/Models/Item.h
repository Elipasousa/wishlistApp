//
//  Item.h
//  wishlistApp
//
//  Created by Elisabete Sousa on 09/11/15.
//  Copyright © 2015 Elisabete Bicho. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Item : NSObject

@property (weak, nonatomic) NSString *title;
@property (weak, nonatomic) NSString *reference;
@property (weak, nonatomic) NSString *tag;

-(id)initWithTitle:(NSString *)title reference:(NSString *)reference andTag:(NSString *)tag;

@end
