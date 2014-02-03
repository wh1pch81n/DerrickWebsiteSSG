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

@property (unsafe_unretained) IBOutlet NSTextView *questionTextView;
@property (unsafe_unretained) IBOutlet NSTextView *answerTextView;

@end

@implementation DHAppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
	// Insert code here to initialize your application
	NSFont *font = [NSFont fontWithName:kMonoSpacedFontName size:kMonoSpacedFontSize12];
	[self.questionTextView setFont:font];
	[self.questionTextView setAutomaticDashSubstitutionEnabled:NO];
	[self.answerTextView setFont:font];
	[self.answerTextView setAutomaticDashSubstitutionEnabled:NO];
	//TODO: get rid of that underline red thing

}


@end
