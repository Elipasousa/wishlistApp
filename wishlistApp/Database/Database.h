//
//  Database.h
//  SocialPic
//
//  Created by Elisabete Sousa on 09/11/15.
//  Copyright © 2015 Fork IT. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDatabase.h"
#import "FMDatabaseAdditions.h"
#import "Item.h"

@interface Database : NSObject

@property (nonatomic, strong) FMDatabase *db;

+(id)sharedDatabase;

-(BOOL)addItemWithTitle:(NSString *)item_title reference:(NSString *)item_reference tag:(NSString *)item_tag price:(NSString *)item_price addedOn:(NSString *)item_addedOn;
-(NSArray *)getAllAddedItems;
-(NSArray*)getItemsWithTitle:(NSString *)item_title;
-(NSArray*)getItemsWithReference:(NSString *)item_reference;
-(NSArray*)getItemsWithTag:(NSString *)item_tag;
-(BOOL)deleteItemWithTitle:(NSString *)item_title;

@end
