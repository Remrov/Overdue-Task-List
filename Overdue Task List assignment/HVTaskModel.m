//
//  HVTaskModel.m
//  Overdue Task List assignment
//
//  Created by Heidi Vormer on 2013-11-13.
//  Copyright (c) 2013 Heidi Vormer. All rights reserved.
//

#import "HVTaskModel.h"

@implementation HVTaskModel

-(id)initWithData: (NSDictionary *)data
{
    self = [super init];
    
    if (self) {
        self.name = data[TASK_NAME];
        self.description = data[TASK_DESCRIPTION];
        self.date = data[TASK_DATE];
        self.completed = [data[TASK_COMPLETION] boolValue];
        
    }
    return self;
    
}

-(id)init
{
    self = [self initWithData:nil];
    
    return self;
    
}

@end
