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

-(BOOL)addItemWithTitle:(NSString *)item_title reference:(NSString *)item_reference tag:(NSString *)item_tag price:(NSString *)item_price addedOn:(NSString *)item_addedOn photo:(NSString *)item_photo;
-(NSArray *)getAllAddedItems;
-(NSArray*)getItemsWithTitle:(NSString *)item_title;
-(NSArray*)getItemsWithReference:(NSString *)item_reference;
-(NSArray*)getItemsWithTag:(NSString *)item_tag;
-(BOOL)updateItemWithID:(NSInteger)item_id WithTitle:(NSString *)item_title reference:(NSString *)item_reference tag:(NSString *)item_tag price:(NSString *)item_price addedOn:(NSString *)item_addedOn photo:(NSString *)item_photo;
-(BOOL)deleteItemWithId:(NSInteger)item_id;

@end
