//
//  AppDelegate.h
//  Xwhatmp3
//
//  Created by dr4g0n on 01/04/2012.
//  Copyright (c) 2012. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface AppDelegate : NSObject <NSApplicationDelegate,NSTableViewDelegate,NSTableViewDataSource> {
    NSMutableArray *data;
    NSWindowController *preferencesController;
}

@property (assign) IBOutlet NSWindow *window;

@property (weak) IBOutlet NSButton *convertButton;
@property (weak) IBOutlet NSButton *addButton;
@property (weak) IBOutlet NSButton *removeButton;

@property (weak) IBOutlet NSTableView *directoryTable;

- (IBAction)convert:(id)sender;
- (IBAction)add:(id)sender;
- (IBAction)remove:(id)sender;
- (IBAction)showPreferences:(id)sender;

@end
