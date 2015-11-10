//
//  AddItemViewController.h
//  wishlistApp
//
//  Created by Elisabete Sousa on 09/11/15.
//  Copyright © 2015 Elisabete Bicho. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import <UIImage+ResizeMagick.h>
#import <ActionSheetPicker.h>

@interface AddItemViewController : BaseViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *photoImageView;
@property (weak, nonatomic) IBOutlet UITextField *titleTextField;
@property (weak, nonatomic) IBOutlet UITextField *referenceTextField;
@property (weak, nonatomic) IBOutlet UITextField *tagTextField;
@property (weak, nonatomic) IBOutlet UITextField *priceTextField;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
- (IBAction)cameraTouched:(id)sender;
- (IBAction)galleryTouched:(id)sender;

@property (strong, nonatomic) Item *item;

@end
