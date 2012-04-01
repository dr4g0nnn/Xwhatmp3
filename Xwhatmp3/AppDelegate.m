//
//  AppDelegate.m
//  Xwhatmp3
//
//  Created by dr4g0n on 01/04/2012.
//  Copyright (c) 2012. All rights reserved.
//

#import "AppDelegate.h"

#define NYES ([NSNumber numberWithBool:YES])
#define NNO ([NSNumber numberWithBool:NO])

@implementation AppDelegate

@synthesize window = _window;
@synthesize convertButton = _convertButton;
@synthesize addButton = _addButton;
@synthesize removeButton = _removeButton;
@synthesize directoryTable = _directoryTable;
@synthesize preferencesController;

+ (void)initialize {
    NSMutableDictionary *initialValues = [NSMutableDictionary dictionary];

    [initialValues setObject:NYES forKey:@"convert320"];
    [initialValues setObject:NYES forKey:@"convertV0"];
    [initialValues setObject:NYES forKey:@"convertV2"];
    [initialValues setObject:NYES forKey:@"convertQ8"];
    [initialValues setObject:NNO forKey:@"convertAlac"];
    [initialValues setObject:NNO forKey:@"convertAac"];
    [initialValues setObject:NNO forKey:@"convertFlac"];
    [initialValues setObject:NNO forKey:@"createFlacTorrent"];
    [initialValues setObject:NYES forKey:@"createTorrents"];
    [initialValues setObject:NNO forKey:@"dither"];
    [initialValues setObject:NNO forKey:@"replayGain"];
    [initialValues setObject:NYES forKey:@"zeropad"];
    [initialValues setObject:NYES forKey:@"moveLog"];
    [initialValues setObject:NYES forKey:@"moveCue"];
    [initialValues setObject:NYES forKey:@"moveOther"];
    [initialValues setObject:@"http://tracker.what.cd:34000/" forKey:@"tracker"];
    [initialValues setObject:@"" forKey:@"passkey"];
    [initialValues setObject:[NSNumber numberWithInt:1] forKey:@"threads"];

    [[NSUserDefaultsController sharedUserDefaultsController] setInitialValues:initialValues];
}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    // Insert code here to initialize your application
}

- (IBAction)convert:(id)sender {
}

- (IBAction)add:(id)sender {
}

- (IBAction)remove:(id)sender {
}

- (IBAction)showPreferences:(id)sender {
    if (preferencesController == nil) {
        preferencesController = [[NSWindowController alloc] initWithWindowNibName:@"Preferences"];
    }
    [preferencesController showWindow:self];
}

@end
