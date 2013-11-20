//
//  HVAddTaskViewController.h
//  Overdue Task List assignment
//
//  Created by Heidi Vormer on 2013-11-13.
//  Copyright (c) 2013 Heidi Vormer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HVTaskModel.h"


@protocol HVAddTaskViewControllerDelegate <NSObject>

-(void)didCancel;
-(void)didAddtask:(HVTaskModel *)task;


@end

@interface HVAddTaskViewController : UIViewController <UITextFieldDelegate, UITextViewDelegate>


@property (weak, nonatomic) id <HVAddTaskViewControllerDelegate> delegate;

@property (strong, nonatomic) IBOutlet UITextField *taskNameTextField;
@property (strong, nonatomic) IBOutlet UITextView *taskTextView;
@property (strong, nonatomic) IBOutlet UIDatePicker *taskDatePicker;

- (IBAction)addTaskButtonPressed:(UIButton *)sender;
- (IBAction)cancelButtonPressed:(UIButton *)sender;

@end
