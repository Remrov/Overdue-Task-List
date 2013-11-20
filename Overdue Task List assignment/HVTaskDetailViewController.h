//
//  HVTaskDetailViewController.h
//  Overdue Task List assignment
//
//  Created by Heidi Vormer on 2013-11-13.
//  Copyright (c) 2013 Heidi Vormer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HVTaskModel.h"
#import "HVEditTaskViewController.h"


@protocol HVTaskDetailViewControllerDelegate <NSObject>

-(void)updateTask;


@end


@interface HVTaskDetailViewController : UIViewController <HVEditTaskViewControllerDelegate>


@property (weak, nonatomic) id <HVTaskDetailViewControllerDelegate> delegate;

@property (strong, nonatomic) HVTaskModel *task;

@property (strong, nonatomic) IBOutlet UILabel *taskLabel;
@property (strong, nonatomic) IBOutlet UILabel *dateLabel;
@property (strong, nonatomic) IBOutlet UILabel *taskDetailLabel;

- (IBAction)editBarButtonItemPressed:(UIBarButtonItem *)sender;
- (IBAction)completionSwitch:(UISwitch *)sender;


@end
