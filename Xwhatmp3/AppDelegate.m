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

    [initialValues setObject:[NSNumber numberWithBool:YES] forKey:@"convert320"];
    [initialValues setObject:[NSNumber numberWithBool:YES] forKey:@"convertV0"];
    [initialValues setObject:[NSNumber numberWithBool:YES] forKey:@"convertV2"];
    [initialValues setObject:[NSNumber numberWithBool:YES] forKey:@"convertQ8"];
    [initialValues setObject:[NSNumber numberWithBool:NO] forKey:@"convertAlac"];
    [initialValues setObject:[NSNumber numberWithBool:NO] forKey:@"convertAac"];
    [initialValues setObject:[NSNumber numberWithBool:NO] forKey:@"convertFlac"];
    [initialValues setObject:[NSNumber numberWithBool:NO] forKey:@"createFlacTorrent"];
    [initialValues setObject:[NSNumber numberWithBool:YES] forKey:@"createTorrents"];
    [initialValues setObject:[NSNumber numberWithBool:NO] forKey:@"dither"];
    [initialValues setObject:[NSNumber numberWithBool:NO] forKey:@"replayGain"];
    [initialValues setObject:[NSNumber numberWithBool:YES] forKey:@"zeropad"];
    [initialValues setObject:[NSNumber numberWithBool:YES] forKey:@"moveLog"];
    [initialValues setObject:[NSNumber numberWithBool:YES] forKey:@"moveCue"];
    [initialValues setObject:[NSNumber numberWithBool:YES] forKey:@"moveOther"];
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
