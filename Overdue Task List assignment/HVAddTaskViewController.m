//
//  HVAddTaskViewController.m
//  Overdue Task List assignment
//
//  Created by Heidi Vormer on 2013-11-13.
//  Copyright (c) 2013 Heidi Vormer. All rights reserved.
//

#import "HVAddTaskViewController.h"

@interface HVAddTaskViewController ()

@end

@implementation HVAddTaskViewController

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
    
    self.taskTextView.delegate = self;
    self.taskNameTextField.delegate = self;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)addTaskButtonPressed:(UIButton *)sender
{
    HVTaskModel *newTask = [self returnNewTask];
    [self.delegate didAddtask:newTask];
    
}

- (IBAction)cancelButtonPressed:(UIButton *)sender
{
    [self.delegate didCancel];
    
}


#pragma mark - helper methods

-(HVTaskModel *)returnNewTask

{
    HVTaskModel *addedTask = [[HVTaskModel alloc] init];
    addedTask.name = self.taskNameTextField.text;
    addedTask.description = self.taskTextView.text;
    addedTask.date = self.taskDatePicker.date;
    addedTask.completed = NO;
    
    return addedTask;
    
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
        [self.taskTextView resignFirstResponder];
        return NO;
        
    }
    return YES;
    
}



@end
