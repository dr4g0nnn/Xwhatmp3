//
//  AppDelegate.m
//  Xwhatmp3
//
//  Created by dr4g0n on 01/04/2012.
//  Copyright (c) 2012. All rights reserved.
//

#import "AppDelegate.h"

#define PRIVATE_DATA_TYPE @"privateDataType"

#define NYES ([NSNumber numberWithBool:YES])
#define NNO ([NSNumber numberWithBool:NO])

@implementation AppDelegate

@synthesize window = _window;
@synthesize convertButton = _convertButton;
@synthesize addButton = _addButton;
@synthesize removeButton = _removeButton;
@synthesize directoryTable = _directoryTable;
@synthesize torrentDirButton = _torrentDirButton;
@synthesize dataDirButton = _dataDirButton;
@synthesize dataDirTextfield = _dataDirTextfield;
@synthesize torrentDirTextfield = _torrentDirTextfield;

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

- (void)awakeFromNib {
    [[self directoryTable] registerForDraggedTypes:[NSArray arrayWithObjects:PRIVATE_DATA_TYPE, NSFilenamesPboardType, nil]];
    [[self directoryTable] setDraggingSourceOperationMask:NSDragOperationCopy forLocal:NO];
}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    // Insert code here to initialize your application
    data = [[NSMutableArray alloc] init];
    [[self directoryTable] reloadData];
}

- (IBAction)convert:(id)sender {
}

- (IBAction)add:(id)sender {
    NSOpenPanel *openDialog = [NSOpenPanel openPanel];
    [openDialog setCanChooseFiles:NO];
    [openDialog setCanChooseDirectories:YES];
    [openDialog setAllowsMultipleSelection:YES];
    [openDialog setResolvesAliases:YES];

    if ([openDialog runModal] == NSOKButton) {
        [data addObjectsFromArray:[openDialog URLs]];
        [[self directoryTable] reloadData];
    }
}

- (IBAction)remove:(id)sender {
    NSIndexSet *setRows = [[self directoryTable] selectedRowIndexes];
    for (int i = [setRows firstIndex]; i <= [setRows lastIndex];i++) {
        if ( ! [setRows containsIndex:i]) {
            continue;
        }
        [data removeObject:[data objectAtIndex:i]];
        [[self directoryTable] reloadData];
    }
}

- (BOOL)tableView:(NSTableView *)tableView writeRowsWithIndexes:(NSIndexSet *)rowSet toPasteboard:(NSPasteboard*)pboard {
    // this allows us to drag rows around within the table
    // we copy the row numbers to be dragged to the pasteboard.
    NSData *setData = [NSKeyedArchiver archivedDataWithRootObject:rowSet];
    [pboard declareTypes:[NSArray arrayWithObject:PRIVATE_DATA_TYPE] owner:self];
    [pboard setData:setData forType:PRIVATE_DATA_TYPE];

    return YES;
}

- (NSDragOperation)tableView:(NSTableView*)pTableView 
                validateDrop:(id )info 
                 proposedRow:(NSInteger)row 
       proposedDropOperation:(NSTableViewDropOperation)op
{
    // Add code here to validate the drop
    return NSDragOperationEvery;
}

- (BOOL)tableView:(NSTableView *)pTableView acceptDrop:(id )info row:(NSInteger)row dropOperation:(NSTableViewDropOperation)operation {
    NSPasteboard* pBoard = [info draggingPasteboard];
    NSArray *supportedTypes = [[self directoryTable] registeredDraggedTypes]; 
    NSString *availableType = [pBoard availableTypeFromArray:supportedTypes];
    
    if ([availableType isEqualToString:PRIVATE_DATA_TYPE]) {
        NSData* rowData = [pBoard dataForType:PRIVATE_DATA_TYPE];
        NSIndexSet* setRows = [NSKeyedUnarchiver unarchiveObjectWithData:rowData];
        
        // I hate NSIndexSet.
        
        NSMutableArray *selectedElements = [[NSMutableArray alloc]init];
        NSInteger i;
        for (i=[setRows firstIndex]; i <= [setRows lastIndex];i++) {
            if ( ! [setRows containsIndex:i]) {
                continue;
            }
            [selectedElements addObject:[data objectAtIndex:i]];
        }

        NSMutableArray *newData = [[NSMutableArray alloc]init];
        for (i = 0; i < row; i++) {         
            if ([setRows containsIndex:i]) {
                continue;
            }
            [newData addObject:[data objectAtIndex:i]];
        }
        
        [newData addObjectsFromArray:selectedElements];
        
        for (i = row; i < [data count]; i++) {
            if ([setRows containsIndex:i]) {
                continue;
            }
            [newData addObject:[data objectAtIndex:i]];
        }
        
        data = newData;
        [[self directoryTable] noteNumberOfRowsChanged];
        [[self directoryTable] reloadData];
        
        return YES;
    }
    else if ([availableType isEqualToString:NSFilenamesPboardType]) {
        
        NSArray *filenames = [pBoard propertyListForType:NSFilenamesPboardType];
        NSInteger i;
        for (i = 0; i < [filenames count]; i++) {
            NSString *path   = [[filenames objectAtIndex:i] stringByStandardizingPath];
            [data insertObject:path atIndex:row++];
        }
        [[self directoryTable] noteNumberOfRowsChanged];
        [[self directoryTable] reloadData];
        
        return YES;
    }
    
    return NO;
}

- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView {
    return [data count];
}

- (id)tableView:(NSTableView *)tableView objectValueForTableColumn:(NSTableColumn *)column row:(NSInteger)row {
    return [data objectAtIndex:row];
}

- (IBAction)showPreferences:(id)sender {
    if (preferencesController == nil) {
        preferencesController = [[NSWindowController alloc] initWithWindowNibName:@"Preferences"];
    }
    [preferencesController showWindow:self];
}

- (IBAction)browse:(id)sender {
    NSOpenPanel *openDialog = [NSOpenPanel openPanel];
    [openDialog setCanChooseFiles:NO];
    [openDialog setCanChooseDirectories:YES];
    [openDialog setAllowsMultipleSelection:NO];
    [openDialog setResolvesAliases:YES];
    [openDialog setCanCreateDirectories:YES];

    if ([openDialog runModal] == NSOKButton) {
        NSURL *dir = [[openDialog URLs] objectAtIndex:0];
        if ([[sender alternateTitle] isEqualToString: @"dataButton"])
            [[self dataDirTextfield] setStringValue:[dir path]];
        else
            [[self torrentDirTextfield] setStringValue:[dir path]];
    }
}

@end
