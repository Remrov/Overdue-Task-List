//
//  HVEditTaskViewController.h
//  Overdue Task List assignment
//
//  Created by Heidi Vormer on 2013-11-13.
//  Copyright (c) 2013 Heidi Vormer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HVTaskModel.h"


@protocol HVEditTaskViewControllerDelegate <NSObject>

-(void)didEditTask;


@end

@interface HVEditTaskViewController : UIViewController <UITextViewDelegate, UITextFieldDelegate>


@property (weak, nonatomic) id <HVEditTaskViewControllerDelegate> delegate;

@property (strong, nonatomic) HVTaskModel *task;

@property (strong, nonatomic) IBOutlet UITextField *taskNameTextField;
@property (strong, nonatomic) IBOutlet UITextView *taskDetailTextView;
@property (strong, nonatomic) IBOutlet UIDatePicker *taskDatePicker;

- (IBAction)saveBarButtonItemPressed:(UIBarButtonItem *)sender;
@end
