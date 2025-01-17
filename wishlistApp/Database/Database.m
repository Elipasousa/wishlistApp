//
//  Database.m
//  SocialPic
//
//  Created by Elisabete Sousa on 09/11/15.
//  Copyright © 2015 Fork IT. All rights reserved.
//

#import "Database.h"

@implementation Database

#pragma mark Singleton Methods

+(id)sharedDatabase {
    static Database *sharedDatabase = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        sharedDatabase = [[self alloc] init];
    });
    return sharedDatabase;
}

-(id)init {
    if (self = [super init]) {
        NSURL *documentsDirectoryPath = [NSURL fileURLWithPath:[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject]];
        NSString *path = [[documentsDirectoryPath URLByAppendingPathComponent:@"WISHLIST_DB"] path];
        self.db = [FMDatabase databaseWithPath:path];
        
        NSLog(@"Connecting to local database at %@", path);
        
        if (![self.db open]) {
            NSLog(@"Error connecting to local database.");
        } else {
            NSLog(@"Successfully connected to local database.");
        }
        
        if (![self.db tableExists:@"Items"]) {
            [self createTables];
        }
    }
    return self;
}

-(void)createTables {
    [self.db executeUpdate:@"CREATE TABLE Items(item_id INTEGER PRIMARY KEY AUTOINCREMENT, item_title TEXT, item_reference TEXT, item_tag TEXT, item_price TEXT, item_addedOn TEXT, item_photo TEXT);"];

    //NSLog(@"Error creating tables %d: %@", [self.db lastErrorCode], [self.db lastErrorMessage]);
}

-(BOOL)addItemWithTitle:(NSString *)item_title reference:(NSString *)item_reference tag:(NSString *)item_tag price:(NSString *)item_price addedOn:(NSString *)item_addedOn photo:(NSString *)item_photo {
    BOOL success = [self.db executeUpdate:[NSString stringWithFormat:@"INSERT INTO Items(item_title, item_reference, item_tag, item_price, item_addedOn, item_photo) VALUES('%@', '%@', '%@', '%@', '%@', '%@');", item_title, item_reference, item_tag, item_price, item_addedOn, item_photo]];
    
    if (!success) {
        NSLog(@"Error %d: %@", [self.db lastErrorCode], [self.db lastErrorMessage]);
    }
    return success;
}

-(NSArray *)getAllAddedItems {
    FMResultSet *s = [self.db executeQuery:[NSString stringWithFormat:@"SELECT * FROM Items;"]];
    NSMutableArray *items = [[NSMutableArray alloc] init];

    while ([s next]) {
        Item *i = [[Item alloc] init];
        i.item_id = [s intForColumn:@"item_id"];
        i.title = [s stringForColumn:@"item_title"];
        i.reference = [s stringForColumn:@"item_reference"];
        i.tag = [s stringForColumn:@"item_tag"];
        i.price = [s stringForColumn:@"item_price"];
        i.addedOn = [s stringForColumn:@"item_addedOn"];
        i.photo = [s stringForColumn:@"item_photo"];
        [items addObject:i];
    }
    return items;
}

-(NSArray *)getItemsWithTitle:(NSString *)item_title {
    FMResultSet *s = [self.db executeQuery:[NSString stringWithFormat:@"SELECT * FROM Items WHERE item_title LIKE '%%%@%%';", item_title]];
    NSMutableArray *items = [[NSMutableArray alloc] init];
    
    while ([s next]) {
        Item *i = [[Item alloc] init];
        i.item_id = [s intForColumn:@"item_id"];
        i.title = [s stringForColumn:@"item_title"];
        i.reference = [s stringForColumn:@"item_reference"];
        i.tag = [s stringForColumn:@"item_tag"];
        i.price = [s stringForColumn:@"item_price"];
        i.addedOn = [s stringForColumn:@"item_addedOn"];
        i.photo = [s stringForColumn:@"item_photo"];
        [items addObject:i];
    }
    return items;
}

-(NSArray *)getItemsWithReference:(NSString *)item_reference {
    FMResultSet *s = [self.db executeQuery:[NSString stringWithFormat:@"SELECT * FROM Items WHERE item_reference LIKE '%%%@%%';", item_reference]];
    NSMutableArray *items = [[NSMutableArray alloc] init];
    
    while ([s next]) {
        Item *i = [[Item alloc] init];
        i.item_id = [s intForColumn:@"item_id"];
        i.title = [s stringForColumn:@"item_title"];
        i.reference = [s stringForColumn:@"item_reference"];
        i.tag = [s stringForColumn:@"item_tag"];
        i.price = [s stringForColumn:@"item_price"];
        i.addedOn = [s stringForColumn:@"item_addedOn"];
        i.photo = [s stringForColumn:@"item_photo"];
        [items addObject:i];
    }
    return items;
}

-(NSArray *)getItemsWithTag:(NSString *)item_tag {
    FMResultSet *s = [self.db executeQuery:[NSString stringWithFormat:@"SELECT * FROM Items WHERE item_tag LIKE '%%%@%%';", item_tag]];
    NSMutableArray *items = [[NSMutableArray alloc] init];
    
    while ([s next]) {
        Item *i = [[Item alloc] init];
        i.item_id = [s intForColumn:@"item_id"];
        i.title = [s stringForColumn:@"item_title"];
        i.reference = [s stringForColumn:@"item_reference"];
        i.tag = [s stringForColumn:@"item_tag"];
        [items addObject:i];
        i.price = [s stringForColumn:@"item_price"];
        i.addedOn = [s stringForColumn:@"item_addedOn"];
        i.photo = [s stringForColumn:@"item_photo"];
    }
    return items;
}

-(NSArray *)getItemsWithTitle:(NSString *)item_title andTag:(NSString *)item_tag {
    FMResultSet *s = [self.db executeQuery:[NSString stringWithFormat:@"SELECT * FROM Items WHERE item_title LIKE '%%%@%%' AND item_tag LIKE '%%%@%%';", item_title, item_tag]];
    NSMutableArray *items = [[NSMutableArray alloc] init];
    
    while ([s next]) {
        Item *i = [[Item alloc] init];
        i.item_id = [s intForColumn:@"item_id"];
        i.title = [s stringForColumn:@"item_title"];
        i.reference = [s stringForColumn:@"item_reference"];
        i.tag = [s stringForColumn:@"item_tag"];
        [items addObject:i];
        i.price = [s stringForColumn:@"item_price"];
        i.addedOn = [s stringForColumn:@"item_addedOn"];
        i.photo = [s stringForColumn:@"item_photo"];
    }
    return items;
}

-(BOOL)updateItemWithID:(NSInteger)item_id WithTitle:(NSString *)item_title reference:(NSString *)item_reference tag:(NSString *)item_tag price:(NSString *)item_price addedOn:(NSString *)item_addedOn photo:(NSString *)item_photo {
    return  [self.db executeUpdate:[NSString stringWithFormat:@"UPDATE Items SET item_title='%@', item_reference='%@', item_tag='%@', item_price='%@', item_addedOn='%@', item_photo='%@' WHERE item_id=%ld;", item_title, item_reference, item_tag, item_price, item_addedOn, item_photo, (long) item_id]];
}

-(BOOL)deleteItemWithId:(NSInteger)item_id {
    return [self.db executeUpdate:[NSString stringWithFormat:@"DELETE FROM Items WHERE item_id=%ld;", (long) item_id]];
}

@end
