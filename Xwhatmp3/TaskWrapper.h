//
//  TaskWrapper.h
//  Xwhatmp3
//
//  Created by dr4g0n on 02/04/2012.
//  Copyright (c) 2012. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol TaskWrapperController

// Called when new data is kicked out from the Task.
- (void)appendOutput:(NSString *)output;

// Callbacks for initialisation/cleanup
- (void)processStarted;
- (void)processFinished;

@end

@interface TaskWrapper : NSObject {
    NSTask *task;
    id<TaskWrapperController> controller;
    NSString *path;
    NSArray *arguments;
}

- (id)initWithController:(id <TaskWrapperController>)controller launchPath:(NSString *)path arguments:(NSArray *) args;

- (void)startProcess;

- (void)stopProcess;


@end
