//
//  DHAppDelegate.m
//  ScriptGen
//
//  Created by Derrick Ho on 12/21/13.
//  Copyright (c) 2013 Derrick Ho. All rights reserved.
//

#import "DHAppDelegate.h"

@implementation DHAppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
	// Insert code here to initialize your application
}


- (BOOL)control:(NSControl *)control textView:(NSTextView *)textView doCommandBySelector:(SEL)commandSelector {
	BOOL result = NO;
	
    if (commandSelector == @selector(insertNewline:)) {
        // new line action:
        // always insert a line-break character and don’t cause the receiver to end editing
        [textView insertNewlineIgnoringFieldEditor:self];
        result = YES;
	} //else if (commandSelector == @selector(insertTab:)) {
      //  // tab action:
      //  // always insert a tab character and don’t cause the receiver to end editing
      //  [textView insertTabIgnoringFieldEditor:self];
	  //
      //  result = YES;
	  //}
	
    return result;
}
@end
