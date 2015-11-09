//
//  AddItemViewController.m
//  wishlistApp
//
//  Created by Elisabete Sousa on 09/11/15.
//  Copyright © 2015 Elisabete Bicho. All rights reserved.
//

#import "AddItemViewController.h"

@interface AddItemViewController ()

@end

@implementation AddItemViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNavigationBar];
    [self setupNavigationButton];
    [self setupDate];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Setup Methods

-(void)setupDate {
    NSDate *currentDate = [NSDate date];
    NSDateFormatter * dateFormart = [[NSDateFormatter alloc] init];
    [dateFormart setDateFormat:@"dd-MM-yyyy"];
    NSString *stringdate = [dateFormart stringFromDate:currentDate];

    self.dateLabel.text = [NSString stringWithFormat:@"Added on %@", stringdate];
}

-(void)setupNavigationBar {
    self.navigationController.navigationBar.tintColor = [UIColor blackColor];
}

-(void)setupNavigationButton {
    UIBarButtonItem *customButton = [[UIBarButtonItem alloc] initWithTitle:@"Done"
                                                                     style:UIBarButtonItemStylePlain
                                                                    target:self
                                                                    action:@selector(doneAddingItem)];
    
    self.navigationItem.rightBarButtonItem = customButton;
}

-(void)doneAddingItem {
    if ([self validaFields]) {
        NSString *stringFromPhoto = [UIImagePNGRepresentation(self.photoImageView.image) base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];

        [[Database sharedDatabase] addItemWithTitle:self.titleTextField.text reference:self.referenceTextField.text tag:self.tagTextField.text price:self.priceTextField.text addedOn:@"123" photo:stringFromPhoto];
        [self.navigationController popViewControllerAnimated:YES];
    } else {
        [self showConfirmDialogWithTitle:@"Atention" andMessage:@"Please insert all information"];
    }
}

-(BOOL)validaFields {
    /*return  ![self.titleTextField.text isEqualToString:@""] &&
            ![self.tagTextField.text isEqualToString:@""] &&
            ![self.priceTextField.text isEqualToString:@""];*/
    return  YES;
}

#pragma mark - Actions Methods

- (IBAction)cameraTouched:(id)sender {
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    picker.allowsEditing = NO;
    picker.delegate = self;
    [self presentViewController:picker animated:YES completion:nil];
}

- (IBAction)galleryTouched:(id)sender {
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    picker.allowsEditing = NO;
    picker.delegate = self;
    [self presentViewController:picker animated:YES completion:nil];
}

#pragma mark - UIImagePickerControllerDelegate Methods

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    [picker dismissViewControllerAnimated:YES completion:nil];
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    self.photoImageView.image = [image resizedImageByMagick:@"1000x1000"];
}
        
@end
