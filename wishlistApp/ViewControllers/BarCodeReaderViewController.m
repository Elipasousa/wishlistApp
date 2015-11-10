//
//  BarCodeReaderViewController.m
//  wishlistApp
//
//  Created by Elisabete Sousa on 10/11/15.
//  Copyright © 2015 Elisabete Bicho. All rights reserved.
//

#import "BarCodeReaderViewController.h"

@interface BarCodeReaderViewController () {
    MTBBarcodeScanner *scanner;
}

@end

@implementation BarCodeReaderViewController

- (void)viewDidLoad {
    [super viewDidLoad];


    scanner = [[MTBBarcodeScanner alloc] initWithPreviewView:self.previewView];
    [MTBBarcodeScanner requestCameraPermissionWithSuccess:^(BOOL success) {
        if (success) {
            
            [scanner startScanningWithResultBlock:^(NSArray *codes) {
                AVMetadataMachineReadableCodeObject *code = [codes firstObject];
                //NSLog(@"Found code: %@", code.stringValue);
                self.codeReadBlock(code.stringValue);
                
                [scanner stopScanning];
                [self.navigationController popViewControllerAnimated:YES];
            }];
            
        } else {
            // The user denied access to the camera
        }
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
