//
//  HVTaskModel.h
//  Overdue Task List assignment
//
//  Created by Heidi Vormer on 2013-11-13.
//  Copyright (c) 2013 Heidi Vormer. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HVTaskModel : NSObject

@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *description;
@property (strong, nonatomic) NSDate *date;
@property (nonatomic) BOOL completed;

-(id)initWithData: (NSDictionary *)data;






@end
