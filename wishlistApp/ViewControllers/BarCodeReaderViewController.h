//
//  BarCodeReaderViewController.h
//  wishlistApp
//
//  Created by Elisabete Sousa on 10/11/15.
//  Copyright © 2015 Elisabete Bicho. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MTBBarcodeScanner.h>

@interface BarCodeReaderViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIView *previewView;

@property (nonatomic, copy) void (^codeReadBlock)(NSString *code);

@end
