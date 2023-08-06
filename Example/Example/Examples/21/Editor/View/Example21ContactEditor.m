//
//  Example21ContactEditor.m
//  Example
//
//  Created by Xezun on 2021/4/28.
//  Copyright © 2021 Xezun. All rights reserved.
//

#import "Example21ContactEditor.h"

@interface Example21ContactEditorInputView : UIView
@property (weak, nonatomic) IBOutlet UITextField *textField;
@end

@interface Example21ContactEditor ()
@property (weak, nonatomic) IBOutlet UIView *formView;
@property (weak, nonatomic) IBOutlet Example21ContactEditorInputView *firstNameView;
@property (weak, nonatomic) IBOutlet Example21ContactEditorInputView *lastNameView;
@property (weak, nonatomic) IBOutlet Example21ContactEditorInputView *phoneNumberView;
@property (weak, nonatomic) IBOutlet UIButton *cancelButton;
@property (weak, nonatomic) IBOutlet UIButton *confirmButton;
@end

@implementation Example21ContactEditor

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.modalPresentationStyle = UIModalPresentationOverFullScreen;
    }
    return self;
}

@dynamic viewModel;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = UIColor.clearColor;
    self.view.layer.shadowColor = UIColor.blackColor.CGColor;
    self.view.layer.shadowOffset = CGSizeMake(0, 2.0);
    self.view.layer.shadowRadius = 5.0;
    self.view.layer.shadowOpacity = 0.5;

    self.formView.layer.cornerRadius = 6.0;
    self.formView.layer.masksToBounds = YES;
    
    self.firstNameView.textField.text   = self.viewModel.firstName;
    self.lastNameView.textField.text    = self.viewModel.lastName;
    self.phoneNumberView.textField.text = self.viewModel.phone;
}

- (IBAction)confirmButtonAction:(UIButton *)sender {
    [self dismissViewControllerAnimated:true completion:^{
        NSString *firstName = self.firstNameView.textField.text;
        NSString *lastName = self.lastNameView.textField.text;
        NSString *phone = self.phoneNumberView.textField.text;
        [self.viewModel setFirstName:firstName lastName:lastName phone:phone];
    }];
}

- (IBAction)cancelButtonAction:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end

@implementation Example21ContactEditorInputView
@end
