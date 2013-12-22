//
//  DHAppDelegate.h
//  ScriptGen
//
//  Created by Derrick Ho on 12/21/13.
//  Copyright (c) 2013 Derrick Ho. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface DHAppDelegate : NSObject <NSApplicationDelegate, NSControlTextEditingDelegate>

@property (assign) IBOutlet NSWindow *window;
- (BOOL)control:(NSControl *)control textView:(NSTextView *)textView doCommandBySelector:(SEL)commandSelector;
@end
