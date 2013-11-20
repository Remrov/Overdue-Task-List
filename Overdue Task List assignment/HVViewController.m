//
//  HVViewController.m
//  Overdue Task List assignment
//
//  Created by Heidi Vormer on 2013-11-13.
//  Copyright (c) 2013 Heidi Vormer. All rights reserved.
//

#import "HVViewController.h"
#import "HVTaskModel.h"





@interface HVViewController () 

@end

@implementation HVViewController


#pragma mark - lazy instantiation

-(NSMutableArray *)taskObjects
{
    if (!_taskObjects) {
        _taskObjects = [[NSMutableArray alloc] init];
    }
    return _taskObjects;
    
}



- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    
    //list tasks//
    
    NSArray *taskAsPropertyList = [[NSUserDefaults standardUserDefaults] arrayForKey:TASK_OBJECTS];
    
    for(NSDictionary *dictionary in taskAsPropertyList)
    {
        HVTaskModel *task = [self taskForDictionary:dictionary];
        [self.taskObjects addObject:task];
    }
    
    self.taskListTableView.delegate = self;
    self.taskListTableView.dataSource = self;
}



-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.destinationViewController isKindOfClass:[HVAddTaskViewController class]])
    {
        HVAddTaskViewController *addTaskVC = segue.destinationViewController;
        addTaskVC.delegate = self;
    }
    else if ([segue.destinationViewController isKindOfClass:[HVTaskDetailViewController class]])
    {
        HVTaskDetailViewController *taskDetailVC = segue.destinationViewController;
        
        NSIndexPath *path = sender;
        HVTaskModel *taskObject = self.taskObjects [path.row];
        taskDetailVC.task = taskObject;
        taskDetailVC.delegate = self;
        
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark - IBActions


- (IBAction)reorderBarButtonItemPressed:(UIBarButtonItem *)sender
{
    if (self.taskListTableView.editing == YES) [self.taskListTableView setEditing: NO animated:YES];
    else [self.taskListTableView setEditing:YES animated:YES];
}


- (IBAction)addTaskBarButtonItemPressed:(UIBarButtonItem *)sender
{
    [self performSegueWithIdentifier:@"toAddTaskViewControllerSegue" sender:nil];
}



#pragma mark - HVAddTaskViewController Delegate


-(void)didCancel
{
    [self dismissViewControllerAnimated:YES completion:nil];
}


-(void)didAddtask:(HVTaskModel *)task
{
    [self.taskObjects addObject:task];
    
    NSMutableArray *taskObjectsAsPropertyList = [[[NSUserDefaults standardUserDefaults] arrayForKey:TASK_OBJECTS] mutableCopy];
    if (!taskObjectsAsPropertyList) taskObjectsAsPropertyList = ([[NSMutableArray alloc] init]);
    [taskObjectsAsPropertyList addObject:[self taskObjectsAsPropertyList:task]];
    [[NSUserDefaults standardUserDefaults] setObject:taskObjectsAsPropertyList forKey:TASK_OBJECTS];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
    [self.taskListTableView reloadData];
    
}



#pragma mark - Helper Methods

-(NSDictionary *)taskObjectsAsPropertyList:(HVTaskModel *)task
{
    NSDictionary *dictionary = @{TASK_NAME: task.name, TASK_DESCRIPTION : task.description, TASK_DATE : task.date, TASK_COMPLETION : @(task.completed)};
    
    return dictionary;
    
}

-(HVTaskModel *)taskForDictionary: (NSDictionary *)dictionary
{
   
    HVTaskModel *task = [[HVTaskModel alloc] initWithData:dictionary];
    
    return task;
    
    
}


//Is task overdue?//

-(BOOL)isDateGreaterThanDueDate:(NSDate *)date and:(NSDate *)dueDate
{
    NSTimeInterval dateTimeInterval = [date timeIntervalSince1970];
    NSTimeInterval dueDateTimeInterval = [dueDate timeIntervalSince1970];
    
    
    if (dateTimeInterval > dueDateTimeInterval) return YES;
    else return NO;
}



//change status of task//

-(void)updateTaskCompletion:(HVTaskModel *)task forIndexPath:(NSIndexPath *)indexPath
{
    NSMutableArray *taskListArray = [[[NSUserDefaults standardUserDefaults] arrayForKey:TASK_OBJECTS]mutableCopy];
    
    [taskListArray removeObjectAtIndex:indexPath.row];
    task.completed = (!task.completed) ? YES : NO;
    [taskListArray insertObject:[self taskObjectsAsPropertyList:task] atIndex:indexPath.row];
    
    [[NSUserDefaults standardUserDefaults] setObject:taskListArray forKey:TASK_OBJECTS];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [self.taskListTableView reloadData];
    
}


//after reordering we want to save the new order of the tasks//

-(void)saveNewOrder
{
    NSMutableArray *taskObjectsInNewOrder = [[NSMutableArray alloc] init];
    for (int x = 0; x < [self.taskObjects count]; x ++ ){
        [taskObjectsInNewOrder addObject:[self taskObjectsAsPropertyList:self.taskObjects[x]]];
    }
    [[NSUserDefaults standardUserDefaults] setObject:taskObjectsInNewOrder forKey:TASK_OBJECTS];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
}



#pragma mark - UITableView DataSource

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.taskObjects count];
}


-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}



-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    HVTaskModel *task = [self.taskObjects objectAtIndex:indexPath.row];
    cell.textLabel.text = task.name;
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd/ HH-mm"];
    NSString *stringFromDate = [formatter stringFromDate:task.date];
    cell.detailTextLabel.text = stringFromDate;
    
    
    BOOL overDue = [self isDateGreaterThanDueDate:[NSDate date] and:task.date];
    
    
    if (task.completed == YES) {
        cell.backgroundColor = [UIColor clearColor];
        cell.textLabel.textColor = [UIColor colorWithRed:0.1 green:0.7 blue:0.2 alpha:1.0];
        cell.detailTextLabel.textColor = [UIColor colorWithRed:0.1 green:0.7 blue:0.2 alpha:1.0];
    }
    else if (overDue == YES) {
        cell.backgroundColor = [UIColor clearColor];
        cell.textLabel.textColor = [UIColor colorWithRed:0.8 green:0.2 blue:0.1 alpha:1.0];
        cell.detailTextLabel.textColor = [UIColor colorWithRed:0.8 green:0.2 blue:0.1 alpha:1.0];
    }
    else {
        cell.backgroundColor = [UIColor clearColor];
        cell.textLabel.textColor = [UIColor colorWithRed:0.1 green:0.3 blue:0.7 alpha:1.0];
        cell.detailTextLabel.textColor = [UIColor colorWithRed:0.1 green:0.3 blue:0.7 alpha:1.0];
    }
    
    return cell;
    
}

#pragma mark - UITableView Delegate


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    HVTaskModel *task = self.taskObjects [indexPath.row];
    [self updateTaskCompletion:task forIndexPath:indexPath];
    
}

-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
    
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete){
        [self.taskObjects removeObjectAtIndex:indexPath.row];
        
        NSMutableArray *newTaskArray = [[NSMutableArray alloc] init];
        
        for (HVTaskModel *task in self.taskObjects){
            [newTaskArray addObject:[self taskObjectsAsPropertyList:task]];
            }
        [[NSUserDefaults standardUserDefaults] setObject:newTaskArray forKey:TASK_OBJECTS];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        
        
        }
    
    }


-(void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{
    [self performSegueWithIdentifier:@"toTaskDetailViewControllerSegue" sender:indexPath];
}


-(BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}



-(void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath
{
    HVTaskModel *taskObject = self.taskObjects[sourceIndexPath.row];
    [self.taskObjects removeObjectAtIndex:sourceIndexPath.row];
    [self.taskObjects insertObject:taskObject atIndex:destinationIndexPath.row];
    [self saveNewOrder];
}



#pragma mark - HVTaskDetailViewController Delegate

-(void)updateTask
{
    [self saveNewOrder];
    [self.taskListTableView reloadData];
}



@end
