//
//  HVEditTaskViewController.m
//  Overdue Task List assignment
//
//  Created by Heidi Vormer on 2013-11-13.
//  Copyright (c) 2013 Heidi Vormer. All rights reserved.
//

#import "HVEditTaskViewController.h"

@interface HVEditTaskViewController ()

@end

@implementation HVEditTaskViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    self.taskNameTextField.text = self.task.name;
    self.taskDetailTextView.text = self.task.description;
    self.taskDatePicker.date = self.task.date;
    
    self.taskNameTextField.delegate = self;
    self.taskDetailTextView.delegate = self;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)saveBarButtonItemPressed:(UIBarButtonItem *)sender
{
    [self updateTask];
    [self.delegate didEditTask];
    
}

#pragma mark - Helper methods

-(void)updateTask
{
    self.task.name = self.taskNameTextField.text;
    self.task.description = self.taskDetailTextView.text;
    self.task.date = self.taskDatePicker.date;
    

    
    
}

#pragma mark - UITextField Delegate

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.taskNameTextField resignFirstResponder];
    return YES;
    
}

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"]) {
        [self.taskDetailTextView resignFirstResponder];
        return NO;
        
    }
    return YES;
    
}



@end
