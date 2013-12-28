//
//  DHDocument.m
//  ScriptGen
//
//  Created by Derrick Ho on 12/24/13.
//  Copyright (c) 2013 Derrick Ho. All rights reserved.
//

#import "DHDocument.h"
#import "DHSlideModel.h"
#import "DHQuestionAnswerModel.h"

static const NSInteger kTextFieldCode = 23;
static const NSInteger kTextFieldComment = 24;
static const NSInteger kTextFieldQuestion = 10;
static const NSInteger kTextFieldAnswer = 11;

@implementation DHDocument

- (id)init
{
	self = [super init];
	if (self) {
		// Add your subclass-specific initialization here.
	}
	return self;
}

- (NSString *)windowNibName
{
	// Override returning the nib file name of the document
	// If you need to use a subclass of NSWindowController or if your document supports multiple NSWindowControllers, you should remove this method and override -makeWindowControllers instead.
	return @"DHDocument";
}

- (void)windowControllerDidLoadNib:(NSWindowController *)aController
{
	[super windowControllerDidLoadNib:aController];
	// Add any code here that needs to be executed once the windowController has loaded the document's window.
}


#pragma mark - File Handling
- (NSData *)dataOfType:(NSString *)typeName error:(NSError **)outError
{
	// Insert code here to write your document to data of the specified type. If outError != NULL, ensure that you create and set an appropriate error when returning nil.
	// You can also choose to override -fileWrapperOfType:error:, -writeToURL:ofType:error:, or -writeToURL:ofType:forSaveOperation:originalContentsURL:error: instead.
	
	//NSString *slideShowStr = [self slideShowToString];
	//data = [slideShowStr dataUsingEncoding:NSASCIIStringEncoding];

	NSAttributedString *mString = [[NSAttributedString alloc] initWithString:
																 [NSString stringWithFormat:@"%@%@%@",
																	[self slideShowToString],
																	[self questionAnswerToString],
																	[self endSlideString]]];
	NSData *data = [mString dataFromRange:NSMakeRange(0, mString.length)
						 documentAttributes:@{
																	NSDocumentTypeDocumentAttribute:
																		NSPlainTextDocumentType
																	}
													error:outError];

	if (!data && outError) {
		*outError = [NSError errorWithDomain:NSCocoaErrorDomain
																		code:NSFileWriteUnknownError userInfo:nil];
	}
	return data;
}



- (BOOL)readFromData:(NSData *)data ofType:(NSString *)typeName error:(NSError **)outError
{
	// Insert code here to read your document from the given data of the specified type. If outError != NULL, ensure that you create and set an appropriate error when returning NO.
	// You can also choose to override -readFromFileWrapper:ofType:error: or -readFromURL:ofType:error: instead.
	// If you override either of these, you should also override -isEntireFileLoaded to return NO if the contents are lazily loaded.
	if (outError) {
		*outError = [NSError errorWithDomain:NSOSStatusErrorDomain code:unimpErr userInfo:nil];
	}
	return YES;
}

+ (BOOL)autosavesInPlace
{
	return YES;
}

/*Method needed to silence warning "Trying to save a document without any appropriate writable type defined."*/
- (NSArray *)writableTypesForSaveOperation:(NSSaveOperationType)saveOperation {
	NSArray *arrOfTypes;
	switch (saveOperation) {
		case NSSaveOperation:
		case NSSaveAsOperation:
			arrOfTypes = [self allowedFileTypes];
			break;
	}
	return arrOfTypes;
}

- (BOOL)prepareSavePanel:(NSSavePanel *)savePanel {
	[savePanel setCanSelectHiddenExtension:NO];
	[savePanel setExtensionHidden:NO];
	[savePanel setAllowedFileTypes:[self allowedFileTypes]];
	[savePanel setAllowsOtherFileTypes:NO];
	return YES;
}

- (NSArray *)allowedFileTypes {
	return @[@"txt"];
}

#pragma mark - SlideShow Accessor Methods
/**
 Retrieves the code/header/comment data from the array controller then returns a formated version
 @return (NSString *) The formated string
 */
/*
 The Table that holds that slides is ordered from 0 down to n-1.  But slide order is from
 n-1 to 0. Need for a Reverse Reading of the Array Controller
 */
- (NSString *)slideShowToString {
	NSMutableString *slideShowString = [NSMutableString new];
	NSArray *arrOfSlides = self.slideArrayController.arrangedObjects;
	
	for (NSInteger i = arrOfSlides.count -1; i >= 0; --i) {
		DHSlideModel *m = arrOfSlides[i];
		if (m && m.code && m.header && m.comment) {
			[slideShowString appendString:[NSString stringWithFormat:@"%@%@\n%@%@\n%@%@\n",
																		 @"@code\n",
																		 [m.code stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]],
																		 @"@header\n",
																		 [m.header stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]],
																		 @"@comment\n",
																		 [m.comment stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]]];
		}
	}
	return slideShowString;
}

/**
 Gets the Question and Answers from the Q&A Array controller then returns a formated string
 @return (NSString *) formated string
 */
- (NSString *)questionAnswerToString {
	return [self questionAnswerToString:0];
}

/**
 Gets the Question and Answers from the Q&A Array controller then returns a formated string
 @param index The index of the array. Should always start a 0
 @return (NSString *) formated string
 */
/*
 The Table that holds that questions is ordered from 0 down to n-1.  But slide order is from
 n-1 to 0. Need for a Reverse Reading of the Array Controller
 */
- (NSString *)questionAnswerToString:(NSInteger)index {
	if ([self.qaArrayController.arrangedObjects count] <= index) {
		return @"";
	}
	DHQuestionAnswerModel *qa = self.qaArrayController.arrangedObjects[index];
	NSString *question = [qa.mQuestion stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
	NSString *answer = [qa.mAnswer stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
	return [NSString stringWithFormat:@"%@%@%@%@%@%@%@",
					[self questionAnswerToString:index + 1],
					question?@"@question\n":@"",
					question?:@"",
					question?@"\n":@"",
					answer?@"@answer\n":@"",
					answer?:@"",
					answer?@"\n":@""];
}

/**
 Returnes the end marker
 @return (NSString *) the end marker as a string
 */
- (NSString *)endSlideString {
	return @"@end\n";
}

#pragma mark - TextField Control
- (BOOL)control:(NSControl *)control textView:(NSTextView *)textView doCommandBySelector:(SEL)commandSelector {
	BOOL result = NO;
	
	switch ([control tag]) {
		case kTextFieldCode:
		case kTextFieldQuestion:
			if (commandSelector == @selector(insertNewline:)) {
				[textView insertText:@"\n"];
				result = YES;
			}
			break;
		case kTextFieldComment:
			if (commandSelector == @selector(insertNewline:)) {
				[textView insertText:@"\n"];
				result = YES;
			} else if (commandSelector == @selector(insertTab:)) {
				//Put previously selected slide's code in new slide
				NSInteger index = self.slideArrayController.selectionIndex;
				NSString *prevSlideCode = [(DHSlideModel *)self.slideArrayController.arrangedObjects[index] code];
				DHSlideModel *newSlide = [DHSlideModel new];
				[newSlide setCode:prevSlideCode];
				[self.slideArrayController insertObject:newSlide
													atArrangedObjectIndex:index];
				result = NO;
			}
			break;
		case kTextFieldAnswer:
			if (commandSelector == @selector(insertNewline:)) {
				[textView insertText:@"\n"];
				result = YES;
			} else if (commandSelector == @selector(insertTab:)) {
				[self.qaArrayController insert:[DHQuestionAnswerModel new]];
				result = NO;
			}
			break;
	}
	return result;
}

@end
