//
//  DHDocument.h
//  ScriptGen
//
//  Created by Derrick Ho on 12/24/13.
//  Copyright (c) 2013 Derrick Ho. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface DHDocument : NSDocument <NSControlTextEditingDelegate>
@property (weak) IBOutlet NSArrayController *slideArrayController;
@property (weak) IBOutlet NSArrayController *qaArrayController;
- (BOOL)control:(NSControl *)control textView:(NSTextView *)textView doCommandBySelector:(SEL)commandSelector;
@end
