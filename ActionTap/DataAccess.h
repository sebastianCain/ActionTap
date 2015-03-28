//
//  DataAccess.h
//  Noteworthy
//
//  Created by Avery Lamp on 3/14/15.
//  Copyright (c) 2015 Joshua Liu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
@interface DataAccess : NSObject


//Saves the Data Model onto the DB
- (void)saveContext;

//DataAccessLayer singleton instance shared across application
+ (id) sharedInstance;
+ (void)disposeInstance;
// Returns the managed object context for the application.
// If the context doesn't already exist, it is created and bound
// to the persistent store coordinator for the application.
+ (NSManagedObjectContext *)context;



@end
