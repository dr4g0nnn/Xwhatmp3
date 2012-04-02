//
//  TaskWrapper.m
//  Xwhatmp3
//
//  Created by dr4g0n on 02/04/2012.
//  Copyright (c) 2012. All rights reserved.
//

#import "TaskWrapper.h"

@implementation TaskWrapper

- (id)initWithController:(id <TaskWrapperController>)ctrl launchPath:(NSString *)execPath arguments:(NSArray *) args {
    controller = ctrl;
    arguments = args;
    path = execPath;

    return self;
}

- (void)startProcess {
    task = [[NSTask alloc] init];
    [task setStandardOutput:[NSPipe pipe]];
    [task setStandardError:[task standardOutput]];
    [task setLaunchPath:path];
    [task setArguments:arguments];

    [[NSNotificationCenter defaultCenter] addObserver:self 
                                             selector:@selector(getData:) 
                                                 name: NSFileHandleReadCompletionNotification 
                                               object: [[task standardOutput] fileHandleForReading]];
    [[[task standardOutput] fileHandleForReading] readInBackgroundAndNotify];

    [controller processStarted];
    [task launch];
}

- (void)stopProcess {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:NSFileHandleReadCompletionNotification object: [[task standardOutput] fileHandleForReading]];
    [task terminate];

    NSData *data;
    while ((data = [[[task standardOutput] fileHandleForReading] availableData]) && [data length])
    {
        [controller appendOutput: [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]];
    }

    // we tell the controller that we finished, via the callback, and then blow away our connection
    // to the controller.  NSTasks are one-shot (not for reuse), so we might as well be too.
    [controller processFinished];
    controller = nil;
}

@end
