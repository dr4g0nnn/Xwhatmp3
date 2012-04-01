//
//  AppDelegate.m
//  Xwhatmp3
//
//  Created by dr4g0n on 01/04/2012.
//  Copyright (c) 2012. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate

@synthesize window = _window;
@synthesize convertButton = _convertButton;
@synthesize addButton = _addButton;
@synthesize removeButton = _removeButton;
@synthesize directoryTable = _directoryTable;
@synthesize preferencesController;

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
