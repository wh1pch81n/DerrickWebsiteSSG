//
//  DHDocument.h
//  ScriptGen
//
//  Created by Derrick Ho on 12/24/13.
//  Copyright (c) 2013 Derrick Ho. All rights reserved.
//

#import <Cocoa/Cocoa.h>

static const NSInteger kTextFieldCode = 23;
static const NSInteger kTextFieldComment = 24;

@interface DHDocument : NSDocument <NSControlTextEditingDelegate>
@property (weak) IBOutlet NSArrayController *SlideArrayController;
- (BOOL)control:(NSControl *)control textView:(NSTextView *)textView doCommandBySelector:(SEL)commandSelector;
@end
