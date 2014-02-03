//
//  DHDocument.h
//  ScriptGen
//
//  Created by Derrick Ho on 12/24/13.
//  Copyright (c) 2013 Derrick Ho. All rights reserved.
//

#import <Cocoa/Cocoa.h>

extern NSString *const kCodeMarker;
extern NSString *const kHeaderMarker;
extern NSString *const kCommentMarker;
extern NSString *const kAddSlideMarker;
extern NSString *const kQuestionMarker;
extern NSString *const kAnswerMarker;
extern NSString *const kEndMarker;

extern NSString *const kCodeTextViewId;
extern NSString *const kCommentTextViewId;
extern NSString *const kQuestionTextViewId;
extern NSString *const kAnswerTextViewId;

@interface DHDocument : NSDocument <NSControlTextEditingDelegate, NSTextViewDelegate>
@property (weak) IBOutlet NSArrayController *slideArrayController;
@property (weak) IBOutlet NSArrayController *qaArrayController;
- (BOOL)control:(NSControl *)control textView:(NSTextView *)textView doCommandBySelector:(SEL)commandSelector;
@end
