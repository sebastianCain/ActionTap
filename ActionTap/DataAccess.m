

#import "DataAccess.h"

//static instance for singleton implementation
static DataAccess __strong *manager = nil;

//Private instance methods/properties
@interface DataAccess ()

// Returns the managed object context for the application.
// If the context doesn't already exist, it is created and
// bound to the persistent store coordinator for the application.
@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;

// Returns the managed object model for the application.
// If the model doesn't already exist, it is created from the application's model.
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;

// Returns the persistent store coordinator for the application.
// If the coordinator doesn't already exist, it is created and the application's
// store added to it.
@property (readonly,strong,nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

// Returns the URL to the application's Documents directory.
- (NSURL *)applicationDocumentsDirectory;
@end


@implementation DataAccess

@synthesize managedObjectContext = __managedObjectContext;
@synthesize managedObjectModel = __managedObjectModel;
@synthesize persistentStoreCoordinator = __persistentStoreCoordinator;

//DataAccessLayer singleton instance shared across application
+ (id)sharedInstance
{
    @synchronized(self)
    {
        if (manager == nil)
            manager = [[self alloc] init];
    }
    return manager;
}

+ (void)disposeInstance
{
    @synchronized(self)
    {
        manager = nil;
    }
}

+(NSManagedObjectContext *)context
{
    return [[DataAccess sharedInstance] managedObjectContext];
}

//Saves the Data Model onto the DB
- (void)saveContext
{
    NSError *error = nil;
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil)
    {
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error])
        {
            //Need to come up with a better error management here.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}

// Returns the managed object context for the application.
// If the context doesn't already exist, it is created and
// bound to the persistent store coordinator for the application.
- (NSManagedObjectContext *)managedObjectContext
{
    if (__managedObjectContext != nil)
        return __managedObjectContext;
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil)
    {
        __managedObjectContext = [[NSManagedObjectContext alloc] init];
        [__managedObjectContext setPersistentStoreCoordinator:coordinator];
    }
    return __managedObjectContext;
}

// Returns the managed object model for the application.
// If the model doesn't already exist, it is created from the
// application's model.
- (NSManagedObjectModel *)managedObjectModel
{
    if (__managedObjectModel != nil)
        return __managedObjectModel;
    
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"Model"
                                              withExtension:@"momd"];
    __managedObjectModel = [[NSManagedObjectModel alloc]
                            initWithContentsOfURL:modelURL];
    return __managedObjectModel;
}

// Returns the persistent store coordinator for the application.
// If the coordinator doesn't already exist, it is created and the
// application's store added to it.
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
    if (__persistentStoreCoordinator != nil)
        return __persistentStoreCoordinator;
    
    NSURL *storeURL = [[self applicationDocumentsDirectory]
                       URLByAppendingPathComponent:@"MyData.sqlite"];
    
    NSError *error = nil;
    __persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc]
                                    initWithManagedObjectModel:[self managedObjectModel]];
    
    if (![__persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType
                                                    configuration:nil URL:storeURL options:nil error:&error])
    {
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return __persistentStoreCoordinator;
}

// Returns the URL to the application's Documents directory.
- (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory
                                                   inDomains:NSUserDomainMask] lastObject];
}

@end