//
//  DHAppDelegate.m
//  ScriptGen
//
//  Created by Derrick Ho on 12/21/13.
//  Copyright (c) 2013 Derrick Ho. All rights reserved.
//

#import "DHAppDelegate.h"
#import "DHSlideModel.h"
@implementation DHAppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
	// Insert code here to initialize your application
}


- (BOOL)control:(NSControl *)control textView:(NSTextView *)textView doCommandBySelector:(SEL)commandSelector {
	BOOL result = NO;
	
    switch ([control tag]) {
		case kTextFieldCode:
			if (commandSelector == @selector(insertNewline:)) {
				[textView insertText:@"\n"];
				result = YES;
			} else if (commandSelector == @selector(insertTab:)) {
				[textView insertText:@"`"];
				result = YES;
			} 
			break;
		case kTextFieldComment:
			if (commandSelector == @selector(insertNewline:)) {
				[textView insertText:@"\n"];
				result = YES;
			} else if (commandSelector == @selector(insertTab:)) {
				[self.SlideArrayController add:[DHSlideModel new]];
				result = NO;
			}
			break;
	}
    return result;
}
@end
