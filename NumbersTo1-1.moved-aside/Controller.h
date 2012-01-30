//
//  Controller.h
//
//  Created by Micah Holden on 1/5/10.
//  Copyright 2010 Kansas State University. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "Board.h"
enum 
{
	SHUFFLE = 1001,
	UNDO = 1002,
	COLOR = 1003
};
@interface Controller : NSObject {
    IBOutlet id colors;
    IBOutlet id buttons;
	NSMutableArray *buts;
	Board *board;
	NSRect zeroPosition;
	int dim;
	int colorsOn;
	NSUserDefaults *savedLevels;
}
- (IBAction)buttonsPressed:(id)sender;
- (IBAction)shuffleUndoColor:(id)sender;
- (void)setButText;
- (IBAction)dimPressed:(id)sender;
- (IBAction)resetLevels:(id)sender;
- (void)fixColors;
- (void)saveLevels;
- (int)getLevels;
@end
