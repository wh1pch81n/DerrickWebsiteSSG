//
//  DHAppDelegate.m
//  ScriptGen
//
//  Created by Derrick Ho on 12/21/13.
//  Copyright (c) 2013 Derrick Ho. All rights reserved.
//

#import "DHAppDelegate.h"

NSString *const kMonoSpacedFontName = @"Menlo";
NSInteger const kMonoSpacedFontSize12 = 12;

@interface DHAppDelegate ()

//Normally weak would be better, but NSTextView does not support it
@property (unsafe_unretained) IBOutlet NSTextView *questionTextView;
@property (unsafe_unretained) IBOutlet NSTextView *answerTextView;

@end

@implementation DHAppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
	// Insert code here to initialize your application
	NSFont *font = [NSFont fontWithName:kMonoSpacedFontName size:kMonoSpacedFontSize12];
	[self initializeFontAndSpellCheckOnTextView:self.questionTextView font:font isSpellcheckEnabled:NO];
	[self initializeFontAndSpellCheckOnTextView:self.answerTextView font:font isSpellcheckEnabled:NO];
}

/**
 Sets font and spellcheck properties
 */
- (void)initializeFontAndSpellCheckOnTextView:(NSTextView *)textView font:(NSFont *)font isSpellcheckEnabled:(BOOL)spellcheck {
	[textView setFont:font];
	[textView setAutomaticDashSubstitutionEnabled:spellcheck];
	[textView setGrammarCheckingEnabled:spellcheck];
	[textView setAutomaticSpellingCorrectionEnabled:spellcheck];
	[textView setContinuousSpellCheckingEnabled:spellcheck];
}


@end
