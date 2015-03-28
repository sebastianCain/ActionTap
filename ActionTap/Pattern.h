//
//  Pattern.h
//  ActionTap
//
//  Created by Avery Lamp on 3/28/15.
//  Copyright (c) 2015 Sebastian Cain. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Pattern : NSManagedObject

@property (nonatomic, retain) NSData * allTaps;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * url;

@end
