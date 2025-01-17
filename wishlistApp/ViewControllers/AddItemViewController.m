//
//  AddItemViewController.m
//  wishlistApp
//
//  Created by Elisabete Sousa on 09/11/15.
//  Copyright © 2015 Elisabete Bicho. All rights reserved.
//

#import "AddItemViewController.h"

@interface AddItemViewController () {
    NSInteger selectedBrandIndex;
}

@end

@implementation AddItemViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNavigationBar];
    [self setupNavigationButton];
    [self setupDate];
    [self setupViews];

    selectedBrandIndex = 0;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setupViews {
    if (self.item == nil) {
        return;
    }
    
    self.titleTextField.text = self.item.title;
    self.referenceTextField.text = self.item.reference;
    self.priceTextField.text = self.item.price;
    self.tagTextField.text = self.item.tag;
    
    NSData *data = [[NSData alloc]initWithBase64EncodedString:self.item.photo options:NSDataBase64DecodingIgnoreUnknownCharacters];
    self.photoImageView.image =[UIImage imageWithData:data];
}

#pragma mark - Setup Methods

-(void)setupDate {
    NSDate *currentDate = [NSDate date];
    NSDateFormatter * dateFormart = [[NSDateFormatter alloc] init];
    [dateFormart setDateFormat:@"dd-MM-yyyy"];
    NSString *stringdate = [dateFormart stringFromDate:currentDate];

    self.dateLabel.text = [NSString stringWithFormat:@"Adicionado em %@", stringdate];
}

-(void)setupNavigationBar {
    //self.navigationController.navigationBar.tintColor = [UIColor blackColor];
}

-(void)setupNavigationButton {
    UIBarButtonItem *customButton = [[UIBarButtonItem alloc] initWithTitle:@"Adicionar"
                                                                     style:UIBarButtonItemStylePlain
                                                                    target:self
                                                                    action:@selector(doneAddingItem)];
    
    self.navigationItem.rightBarButtonItem = customButton;
}

-(void)doneAddingItem {
    if ([self validaFields]) {
        NSString *stringFromPhoto = [UIImageJPEGRepresentation(self.photoImageView.image, 0.7) base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
        //NSString *stringFromPhoto = [UIImagePNGRepresentation(self.photoImageView.image) base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
        
        if (self.item == nil) {
            NSDate *currentDate = [NSDate date];
            NSDateFormatter * dateFormart = [[NSDateFormatter alloc] init];
            [dateFormart setDateFormat:@"dd-MM-yyyy"];
            NSString *stringdate = [dateFormart stringFromDate:currentDate];
            
            [[Database sharedDatabase] addItemWithTitle:self.titleTextField.text reference:self.referenceTextField.text tag:self.tagTextField.text price:self.priceTextField.text addedOn:stringdate photo:stringFromPhoto];
        } else {
            [[Database sharedDatabase] updateItemWithID:self.item.item_id WithTitle:self.titleTextField.text reference:self.referenceTextField.text tag:self.tagTextField.text price:self.priceTextField.text addedOn:self.item.addedOn photo:stringFromPhoto];
        }
        self.willAddNewItemBlock(); //new content was added/updated and wishlist must be reloaded
        [self.navigationController popViewControllerAnimated:YES];
    } else {
        [self showConfirmDialogWithTitle:@"Atenção" andMessage:@"Por favor insira os dados necessários."];
    }
}

-(BOOL)validaFields {
    return  ![self.titleTextField.text isEqualToString:@""] &&
            ![self.tagTextField.text isEqualToString:@""] &&
            ![self.priceTextField.text isEqualToString:@""];
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

- (IBAction)barcodeReaderTouched:(id)sender {    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    BarCodeReaderViewController *target =  (BarCodeReaderViewController*)[storyboard instantiateViewControllerWithIdentifier:@"BarCodeReaderViewController"];
    target.codeReadBlock = ^(NSString *code) {
        self.referenceTextField.text = code;
        [self.referenceTextField resignFirstResponder];
    };
    [self.navigationController pushViewController:target animated:YES];
}

#pragma mark - UIImagePickerControllerDelegate Methods

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    [picker dismissViewControllerAnimated:YES completion:nil];
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    self.photoImageView.image = [image resizedImageByMagick:@"1000x1000"];
}

#pragma mark - UITextFieldDelegate Methods

- (void)textFieldDidEndEditing:(UITextField *)textField {
    if (textField == self.priceTextField) {
        if (![textField.text isEqualToString:@""]) {
            self.priceTextField.text = [NSString stringWithFormat:@"%@ €", self.priceTextField.text];
        }
    }
}

-(void)textFieldDidBeginEditing:(UITextField *)textField {
    if (textField == self.tagTextField) {
        [textField resignFirstResponder]; //iOS 9 only
        [ActionSheetStringPicker showPickerWithTitle:@"Select a brand"
                                                rows:BRAND_NAMES
                                    initialSelection:selectedBrandIndex
                                           doneBlock:^(ActionSheetStringPicker *picker, NSInteger selectedIndex, id selectedValue) {
                                               selectedBrandIndex = selectedIndex;
                                               self.tagTextField.text = selectedValue;
                                               [textField resignFirstResponder];
                                           }
                                         cancelBlock:^(ActionSheetStringPicker *picker) {
                                             //[textField resignFirstResponder];
                                         }
                                              origin:self.view];
    }
    else if (textField == self.priceTextField) {
        if (![self.priceTextField.text isEqualToString:@""]) {
            self.priceTextField.text = [self.priceTextField.text substringToIndex:[self.priceTextField.text length]-2];
        }
    }
}
        
@end
