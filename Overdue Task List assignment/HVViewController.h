//
//  HVViewController.h
//  Overdue Task List assignment
//
//  Created by Heidi Vormer on 2013-11-13.
//  Copyright (c) 2013 Heidi Vormer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HVAddTaskViewController.h"
#import "HVTaskDetailViewController.h"

@interface HVViewController : UIViewController <HVAddTaskViewControllerDelegate, UITableViewDataSource, UITableViewDelegate, HVTaskDetailViewControllerDelegate>

@property (strong, nonatomic) IBOutlet UITableView *taskListTableView;
@property (strong, nonatomic) NSMutableArray *taskObjects;


- (IBAction)reorderBarButtonItemPressed:(UIBarButtonItem *)sender;
- (IBAction)addTaskBarButtonItemPressed:(UIBarButtonItem *)sender;

@end
