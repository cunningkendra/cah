//
//  CKCAppDelegate.h
//  Cards Against Humanity
//
//  Created by Kendra Cunningham on 2013-01-28.
//  Copyright (c) 2013 Kendra Cunningham. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CKCAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

@end
