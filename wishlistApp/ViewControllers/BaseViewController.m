//
//  BaseViewController.m
//  SocialPic
//
//  Created by Elisabete Sousa on 09/11/15.
//  Copyright © 2015 Fork IT. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

-(void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - HUD

-(void)setLoading:(BOOL) loading {
    if (loading == true){
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    } else {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
    }
}

-(void)setLoading:(BOOL) loading withMsg:(NSString*)msg {
    if (loading == true){
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.labelText = msg;
    } else {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    }
}

#pragma mark - Dialog

-(void) showConfirmDialogWithTitle:(NSString*)title andMessage:(NSString*)message {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title
                                                    message:message
                                                   delegate:self
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];

    /*
     UIAlertController *myAlertController = [UIAlertController alertControllerWithTitle:title
     message:message
     preferredStyle:UIAlertControllerStyleAlert];
     
     UIAlertAction *ok = [UIAlertAction
     actionWithTitle:@"OK"
     style:UIAlertActionStyleDefault
     handler:^(UIAlertAction * action)
     {
     //Do some thing here, eg dismiss the alertwindow
     [myAlertController dismissViewControllerAnimated:YES completion:nil];
     
     }];
     
     [myAlertController addAction:ok];
     [self presentViewController:myAlertController animated:YES completion:nil];
     */
}

@end
