//
//  HVTaskDetailViewController.m
//  Overdue Task List assignment
//
//  Created by Heidi Vormer on 2013-11-13.
//  Copyright (c) 2013 Heidi Vormer. All rights reserved.
//

#import "HVTaskDetailViewController.h"

@interface HVTaskDetailViewController ()

@end

@implementation HVTaskDetailViewController

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
    
    self.taskLabel.text = self.task.name;
    self.taskDetailLabel.text = self.task.description;
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd/ HH-mm"];
    NSString *stringFromDate = [formatter stringFromDate:self.task.date];
    self.dateLabel.text = stringFromDate;
    
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.destinationViewController isKindOfClass:[HVEditTaskViewController class]]) {
        HVEditTaskViewController *editTaskVC = segue.destinationViewController;
        editTaskVC.task = self.task;
        editTaskVC.delegate = self;
        
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)editBarButtonItemPressed:(UIBarButtonItem *)sender
{
    [self performSegueWithIdentifier:@"toEditTaskViewControllerSegue" sender:nil];
    
}




-(void)didEditTask
{
    self.taskLabel.text = self.task.name;
    self.taskDetailLabel.text = self.task.description;
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyy-MM-dd"];
     NSString *stringFromDate = [formatter stringFromDate:self.task.date];
     self.dateLabel.text = stringFromDate;
     
     [self.navigationController popViewControllerAnimated:YES];
     
     [self.delegate updateTask];
     
}

#pragma mark - helper methods

-(BOOL)isDateGreaterThanDueDate:(NSDate *)date and:(NSDate *)dueDate
{
    NSTimeInterval dateTimeInterval = [date timeIntervalSince1970];
    NSTimeInterval dueDateTimeInterval = [dueDate timeIntervalSince1970];
    
    
    if (dateTimeInterval > dueDateTimeInterval) return YES;
    else return NO;
}

@end
