//
//  BaseViewController.h
//  SocialPic
//
//  Created by Elisabete Sousa on 09/11/15.
//  Copyright © 2015 Fork IT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MBProgressHUD.h>
#import "Database.h"
#import "Item.h"
#import "Constants.h"

@interface BaseViewController : UIViewController

-(void)setLoading:(BOOL) loading;
-(void)setLoading:(BOOL) loading withMsg:(NSString*)msg;
-(void)showConfirmDialogWithTitle:(NSString*)title andMessage:(NSString*)message;


@end
