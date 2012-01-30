//
//  MyButton.m
//
//  Created by Micah Holden on 2/4/10.
//  Copyright 2010 Kansas State University. All rights reserved.
//

#import "MyButton.h"

@implementation MyButton
@synthesize row,col,currentValue,color,dim;
@synthesize prevPositions,prevValues,prevRows,prevCols;

/*- (id)initWithCoder:(NSCoder *)coder
{
	if(self = [[MyButton alloc] init])
	{
		data = [coder decodeObjectForKey:@"data"];
		row = [[data objectForKey:@"row"]intValue];
		col = [[data objectForKey:@"col"]intValue];
		currentValue = [[data objectForKey:@"currentValue"]intValue];
		color = [[data objectForKey:@"color"]intValue];
		dim = [[data objectForKey:@"dim"]intValue];
		[self setButPos];
	}
	return self;
}

- (void)encodeWithCoder:(NSCoder *)coder
{
	if(data == nil) data = [NSMutableDictionary dictionary];
	[data setObject:[NSNumber numberWithInt:row] forKey:@"row"];
	[data setObject:[NSNumber numberWithInt:col] forKey:@"col"];
	[data setObject:[NSNumber numberWithInt:currentValue] forKey:@"currentRow"];
	[data setObject:[NSNumber numberWithInt:color] forKey:@"color"];
	[data setObject:[NSNumber numberWithInt:dim] forKey:@"dim"];
	[coder encodeObject:data forKey:@"data"];
}*/

- (void)setRow:(int)r
{
	row = r;
}

- (void)setCol:(int)c
{
	col = c;
}

- (void)setInitialRow:(int)r Col:(int)c
{
	initialRow = r;
	initialCol = c;
	row = r;
	col = c;
}

- (void)setCurrentValue:(int)cv
{
	currentValue = cv;
	[self setTitle:[NSString stringWithFormat:@"%d",currentValue]];
}

- (int)row
{
	return row;
}

- (int)col
{
	return col;
}

- (int)currentValue
{
	return currentValue;
}

- (void)setButText
{
	[self setTitle:[NSString stringWithFormat:@"%d",currentValue]];
}

- (void)setDim:(int)d color:(int)c
{
	dim = d;
	color = c;
}

- (void)setColor
{
	switch(color)
	{
		case RED:
			if(dim==4)[self setImage:[NSImage imageNamed:@"redbutton128"]];
			else if(dim==5)[self setImage:[NSImage imageNamed:@"redbutton100"]];
			else if(dim==6)[self setImage:[NSImage imageNamed:@"redbutton83"]];
			else if(dim==7)[self setImage:[NSImage imageNamed:@"redbutton70"]];
			else if(dim==8)[self setImage:[NSImage imageNamed:@"redbutton60"]];
			break;
		case GREEN:
			if(dim==4)[self setImage:[NSImage imageNamed:@"greenbutton128"]];
			else if(dim==5)[self setImage:[NSImage imageNamed:@"greenbutton100"]];
			else if(dim==6)[self setImage:[NSImage imageNamed:@"greenbutton83"]];
			else if(dim==7)[self setImage:[NSImage imageNamed:@"greenbutton70"]];
			else if(dim==8)[self setImage:[NSImage imageNamed:@"greenbutton60"]];
			break;
		case BLUE:
			if(dim==4)[self setImage:[NSImage imageNamed:@"bluebutton128"]];
			else if(dim==5)[self setImage:[NSImage imageNamed:@"bluebutton100"]];
			else if(dim==6)[self setImage:[NSImage imageNamed:@"bluebutton83"]];
			else if(dim==7)[self setImage:[NSImage imageNamed:@"bluebutton70"]];
			else if(dim==8)[self setImage:[NSImage imageNamed:@"bluebutton60"]];
			break;
		case YELLOW:
			if(dim==4)[self setImage:[NSImage imageNamed:@"yellowbutton128"]];
			else if(dim==5)[self setImage:[NSImage imageNamed:@"yellowbutton100"]];
			else if(dim==6)[self setImage:[NSImage imageNamed:@"yellowbutton83"]];
			else if(dim==7)[self setImage:[NSImage imageNamed:@"yellowbutton70"]];
			else if(dim==8)[self setImage:[NSImage imageNamed:@"yellowbutton60"]];
			break;
		case PURPLE:
			if(dim==4)[self setImage:[NSImage imageNamed:@"purplebutton128"]];
			else if(dim==5)[self setImage:[NSImage imageNamed:@"purplebutton100"]];
			else if(dim==6)[self setImage:[NSImage imageNamed:@"purplebutton83"]];
			else if(dim==7)[self setImage:[NSImage imageNamed:@"purplebutton70"]];
			else if(dim==8)[self setImage:[NSImage imageNamed:@"purplebutton60"]];
			break;
		case ORANGE:
			if(dim==4)[self setImage:[NSImage imageNamed:@"orangebutton128"]];
			else if(dim==5)[self setImage:[NSImage imageNamed:@"orangebutton100"]];
			else if(dim==6)[self setImage:[NSImage imageNamed:@"orangebutton83"]];
			else if(dim==7)[self setImage:[NSImage imageNamed:@"orangebutton70"]];
			else if(dim==8)[self setImage:[NSImage imageNamed:@"orangebutton60"]];
			break;
		case CYAN:
			if(dim==4)[self setImage:[NSImage imageNamed:@"cyanbutton128"]];
			else if(dim==5)[self setImage:[NSImage imageNamed:@"cyanbutton100"]];
			else if(dim==6)[self setImage:[NSImage imageNamed:@"cyanbutton83"]];
			else if(dim==7)[self setImage:[NSImage imageNamed:@"cyanbutton70"]];
			else if(dim==8)[self setImage:[NSImage imageNamed:@"cyanbutton60"]];
			break;
		case MAGENTA:
			if(dim==4)[self setImage:[NSImage imageNamed:@"magentabutton128"]];
			else if(dim==5)[self setImage:[NSImage imageNamed:@"magentabutton100"]];
			else if(dim==6)[self setImage:[NSImage imageNamed:@"magentabutton83"]];
			else if(dim==7)[self setImage:[NSImage imageNamed:@"magentabutton70"]];
			else if(dim==8)[self setImage:[NSImage imageNamed:@"magentabutton60"]];
			break;
	}
}

- (void)setColored:(BOOL)flag
{
	if(flag)
	{
		if(![self image]) [self setColor];
		[self setButText];
	}
	else 
	{
		[self setImage:nil];
		[self setButText];
	}
}

- (BOOL)isInRow:(int)r Col:(int)c
{
	return (self.row==r && self.col==c);
}

- (void)addPosition
{
	if(!prevPositions)
	{
		prevPositions = [[NSMutableArray alloc]init];
		prevValues = [[NSMutableArray alloc]init];
		prevRows = [[NSMutableArray alloc]init];
		prevCols = [[NSMutableArray alloc]init];
	}
	[prevPositions addObject:[NSValue valueWithRect:[self frame]]];
	[prevValues addObject:[NSNumber numberWithInt:currentValue]];
	[prevRows addObject:[NSNumber numberWithInt:row]];
	[prevCols addObject:[NSNumber numberWithInt:col]];
}

- (void)undo;
{
	if(prevPositions && prevPositions.count > 0)
	{
		[[self animator] setFrame:[[prevPositions lastObject] rectValue]];
		[self setCurrentValue:[[prevValues lastObject] intValue]];
		row = [[prevRows lastObject] intValue];
		col = [[prevCols lastObject] intValue];
		[prevPositions removeLastObject];
		[prevValues removeLastObject];
		[prevRows removeLastObject];
		[prevCols removeLastObject];
	}
}

- (void)undoAll;
{
	if(prevValues && prevCols && prevRows && prevPositions)
	{
		[[self animator] setFrame:[[prevPositions objectAtIndex:0]rectValue]];
		[self setCurrentValue:[[prevValues objectAtIndex:0] intValue]];
		row = [[prevRows objectAtIndex:0]intValue];
		col = [[prevCols objectAtIndex:0]intValue];
		[prevPositions removeAllObjects];
		[prevValues removeAllObjects];
		[prevRows removeAllObjects];
		[prevCols removeAllObjects];
	}
}

- (void)revertToInitialFrame
{
	row = initialRow;
	col = initialCol;
	[self setButPos];
}

- (void)setRow:(int)r Col:(int)c
{
	row = r;
	col = c;
	[self setButPos];
}

- (void)setButPos
{
	int x=0,y=0;
	NSRect fr;
	switch(dim)
	{
		case 4:
			if(col == 0) x = X14;
			else if(col == 1) x = X24;
			else if(col == 2) x = X34;
			else if(col == 3) x = X44;
			if(row == 0) y = Y14;
			else if(row == 1) y = Y24;
			else if(row == 2) y = Y34;
			else if(row == 3) y = Y44;
			fr = NSMakeRect(x, y, 128, 128);
			break;
		case 5:
			if(col == 0) x = X15;
			else if(col == 1) x = X25;
			else if(col == 2) x = X35;
			else if(col == 3) x = X45;
			else if(col == 4) x = X55;
			if(row == 0) y = Y15;
			else if(row == 1) y = Y25;
			else if(row == 2) y = Y35;
			else if(row == 3) y = Y45;
			else if(row == 4) y = Y55;
			fr = NSMakeRect(x, y, 100, 100);
			break;
		case 6:
			if(col == 0) x = X16;
			else if(col == 1) x = X26;
			else if(col == 2) x = X36;
			else if(col == 3) x = X46;
			else if(col == 4) x = X56;
			else if(col == 5) x = X66;
			if(row == 0) y = Y16;
			else if(row == 1) y = Y26;
			else if(row == 2) y = Y36;
			else if(row == 3) y = Y46;
			else if(row == 4) y = Y56;
			else if(row == 5) y = Y66;
			fr = NSMakeRect(x, y, 84, 84);
			break;
		case 7:
			if(col == 0) x = X17;
			else if(col == 1) x = X27;
			else if(col == 2) x = X37;
			else if(col == 3) x = X47;
			else if(col == 4) x = X57;
			else if(col == 5) x = X67;
			else if(col == 6) x = X77;
			if(row == 0) y = Y17;
			else if(row == 1) y = Y27;
			else if(row == 2) y = Y37;
			else if(row == 3) y = Y47;
			else if(row == 4) y = Y57;
			else if(row == 5) y = Y67;
			else if(row == 6) y = Y77;
			fr = NSMakeRect(x, y, 70, 70);
			break;
		case 8:
			if(col == 0) x = X18;
			else if(col == 1) x = X28;
			else if(col == 2) x = X38;
			else if(col == 3) x = X48;
			else if(col == 4) x = X58;
			else if(col == 5) x = X68;
			else if(col == 6) x = X78;
			else if(col == 7) x = X88;
			if(row == 0) y = Y18;
			else if(row == 1) y = Y28;
			else if(row == 2) y = Y38;
			else if(row == 3) y = Y48;
			else if(row == 4) y = Y58;
			else if(row == 5) y = Y68;
			else if(row == 6) y = Y78;
			else if(row == 7) y = Y88;
			fr = NSMakeRect(x, y, 60, 60);
			break;
	}
	//[[self superview] addSubview:self positioned:NSWindowAbove relativeTo:nil];
	[[self animator] setFrame:fr];
}
@end
