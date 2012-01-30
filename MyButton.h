//
//  MyButton.h
//
//  Created by Micah Holden on 2/4/10.
//  Copyright 2010 Kansas State University. All rights reserved.
//

#import <Cocoa/Cocoa.h>

#define X14 0
#define X24 136
#define X34 272
#define X44 408

#define Y14 419
#define Y24 283
#define Y34 147
#define Y44 11

#define X15 0
#define X25 108
#define X35 216
#define X45 324
#define X55 432

#define Y15 447
#define Y25 339
#define Y35 231
#define Y45 123
#define Y55 15

#define X16 0
#define X26 92
#define X36 184
#define X46 276
#define X56 368
#define X66 460

#define Y16 463
#define Y26 371
#define Y36 279
#define Y46 187
#define Y56 95
#define Y66 3

#define X17 0
#define X27 78
#define X37 156
#define X47 234
#define X57 312
#define X67 390
#define X77 468

#define Y17 477
#define Y27 399
#define Y37 321
#define Y47 243
#define Y57 165
#define Y67 87
#define Y77 9

#define X18 0
#define X28 68
#define X38 136
#define X48 204
#define X58 272
#define X68 340
#define X78 408
#define X88 476

#define Y18 487
#define Y28 419
#define Y38 351
#define Y48 283
#define Y58 215
#define Y68 147
#define Y78 79
#define Y88 11

enum
{
	RED,
	GREEN,
	BLUE,
	YELLOW,
	PURPLE,
	ORANGE,
	CYAN,
	MAGENTA
};

@interface MyButton : NSButton
{
	int row,col,currentValue,color,dim;
	NSMutableArray *prevPositions,*prevValues,*prevRows,*prevCols;
	int initialRow,initialCol;
}
- (void)setRow:(int)r;
- (void)setCol:(int)c;
- (void)setInitialRow:(int)r Col:(int)c;
- (void)setCurrentValue:(int)cv;
- (int)row;
- (int)col;
- (int)currentValue;
- (void)setButText;
- (void)setDim:(int)d color:(int)c;
- (void)setColor;
- (void)setColored:(BOOL)flag;
- (BOOL)isInRow:(int)r Col:(int)c;
- (void)addPosition;
- (void)undo;
- (void)undoAll;
- (void)revertToInitialFrame;
- (void)setRow:(int)r Col:(int)c;
- (void)setButPos;

@property (readwrite,assign) int row;
@property (readwrite,assign) int col;
@property (readwrite,assign) int currentValue;
@property (readwrite,assign) int color;
@property (readwrite,assign) int dim;
@property (nonatomic,retain) NSMutableArray* prevPositions;
@property (nonatomic,retain) NSMutableArray* prevValues;
@property (nonatomic,retain) NSMutableArray* prevRows;
@property (nonatomic,retain) NSMutableArray* prevCols;

@end
