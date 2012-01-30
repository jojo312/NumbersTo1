//
//  Controller.m
//
//  Created by Micah Holden on 1/5/10.
//  Copyright 2010 Kansas State University. All rights reserved.
//

#import "Controller.h"

@implementation Controller
- (void)awakeFromNib
{
	board = [[Board alloc]initWithdimension:4];
	dim = 4;
	//zeroPosition = [[buttons cellAtRow:3 column:3] frame];
	savedLevels = [NSUserDefaults standardUserDefaults];
	if([savedLevels stringForKey:@"Four"] == nil) [savedLevels setObject:@"4"  forKey:@"Four"];
	if([savedLevels stringForKey:@"Five"] == nil) [savedLevels setObject:@"5" forKey:@"Five"];
	if([savedLevels stringForKey:@"Six"] == nil) [savedLevels setObject:@"6" forKey:@"Six"];
	if([savedLevels stringForKey:@"Seven"] == nil) [savedLevels setObject:@"7" forKey:@"Seven"];
	if([savedLevels stringForKey:@"Eight"] == nil) [savedLevels setObject:@"8" forKey:@"Eight"];
	if([savedLevels stringForKey:@"Move"] == nil) [savedLevels setObject:[NSString stringWithFormat:@"Move: 0/%d",[[savedLevels stringForKey:@"Four"]intValue]] forKey:@"Move"];
	if([savedLevels stringForKey:@"Level"] == nil) [savedLevels setObject:[NSString stringWithFormat:@"Level: 4.%d",[[savedLevels stringForKey:@"Four"]intValue]] forKey:@"Level"];
	else if([[savedLevels stringForKey:@"Four"]isEqualToString:@"25+"])
	{
		[savedLevels setObject:@"Move: 0/25+" forKey:@"Move"];
		[savedLevels setObject:@"Level: 4.25+" forKey:@"Level"];
	}
	[board setLevel:[self getLevels]];
	[self setButText];
}

/*- (Controller*)init
{
	self = [super init];
	if(self)
	{
		board = [[Board alloc]initWithdimension:4];
		dim = 4;
		zeroPosition = [[buttons cellAtRow:3 column:3] frame];
		savedLevels = [NSUserDefaults standardUserDefaults];
		if([savedLevels stringForKey:@"Four"] == nil) [savedLevels setObject:@"4"  forKey:@"Four"];
		if([savedLevels stringForKey:@"Five"] == nil) [savedLevels setObject:@"5" forKey:@"Five"];
		if([savedLevels stringForKey:@"Six"] == nil) [savedLevels setObject:@"6" forKey:@"Six"];
		if([savedLevels stringForKey:@"Seven"] == nil) [savedLevels setObject:@"7" forKey:@"Seven"];
		if([savedLevels stringForKey:@"Eight"] == nil) [savedLevels setObject:@"8" forKey:@"Eight"];
		if([savedLevels stringForKey:@"Move"] == nil) [savedLevels setObject:[NSString stringWithFormat:@"Move: 0/%d",[[savedLevels stringForKey:@"Four"]intValue]] forKey:@"Move"];
		if([savedLevels stringForKey:@"Level"] == nil) [savedLevels setObject:[NSString stringWithFormat:@"Level: 4.%d",[[savedLevels stringForKey:@"Four"]intValue]] forKey:@"Level"];
		else if([[savedLevels stringForKey:@"Four"]isEqualToString:@"25+"])
		{
			[savedLevels setObject:@"Move: 0/25+" forKey:@"Move"];
			[savedLevels setObject:@"Level: 4.25+" forKey:@"Level"];
		}
		[board setLevel:[self getLevels]];
		[self setButText];
	}
	return self;
}*/

- (IBAction)buttonsPressed:(id)sender
{
    [savedLevels setObject:[NSString stringWithFormat:@"Move: %d/%d",[board move:[sender selectedRow] :[sender selectedColumn]], [board getLevel]] forKey:@"Move"];
	[savedLevels setObject:[NSString stringWithFormat:@"Level: %d.%d",dim,[board getLevel]] forKey:@"Level"];
	[self saveLevels];
	[self setButText];
}

- (IBAction)shuffleUndoColor:(id)sender
{
    int x = [[sender selectedCell]tag];
	switch(x)
	{
		case 1001:
			[board shuffle];
			[self setButText];
			break;
		case 1002:
			[board undo];
			[self setButText];
			break;
		case 1003:
			colorsOn = [[sender selectedCell] intValue];
			[self fixColors];
			[self setButText];
			break;
	}
}

- (void)setButText
{
	int i,j;
	if(colorsOn) [self fixColors];
	for(i=0; i<dim; i++)
	{
		for(j=0; j<dim; j++)
		{
			if([board getVal:i :j] != 0) [[buttons cellAtRow:i column:j] setTitle:[NSString stringWithFormat:@"%d",[board getVal:i :j]]];
			else [[buttons cellAtRow:i column:j] setTitle:@""];
		}
	}
	[savedLevels setObject:[NSString stringWithFormat:@"Move: %d/%d",[board getMoves], [board getLevel]] forKey:@"Move"];
	[savedLevels setObject:[NSString stringWithFormat:@"Level: %d.%d",dim,[board getLevel]] forKey:@"Level"];
}

- (IBAction)dimPressed:(id)sender
{
	NSSize s;
	NSFont *f;
    dim = [[sender selectedCell]tag];
	[board setDimension:dim];
	if([buttons numberOfRows] < dim)
	{
		while ([buttons numberOfRows] < dim)
		{
			[buttons addRow];
			[buttons addColumn];
		}
	}
	else 
	{
		while([buttons numberOfRows] > dim)
		{
			[buttons removeRow:0];
			[buttons removeColumn:0];
		}
	}
	
	switch(dim)
	{
		case 4:
			s = NSMakeSize(128, 128);
			f = [NSFont fontWithName:@"Lucida Grande" size:120];
			[board setLevel:[[savedLevels stringForKey:@"Four"]intValue]];
			break;
		case 5:
			s = NSMakeSize(100, 100);
			f = [NSFont fontWithName:@"Lucida Grande" size:96];
			[board setLevel:[[savedLevels stringForKey:@"Five"]intValue]];
			break;
		case 6:
			s = NSMakeSize(84, 84);
			f = [NSFont fontWithName:@"Lucida Grande" size:72];
			[board setLevel:[[savedLevels stringForKey:@"Six"]intValue]];
			break;
		case 7:
			s = NSMakeSize(70, 70);
			f = [NSFont fontWithName:@"Lucida Grande" size:64];
			[board setLevel:[[savedLevels stringForKey:@"Seven"]intValue]];
			break;
		case 8:
			s = NSMakeSize(60, 60);
			f = [NSFont fontWithName:@"Lucida Grande" size:48];
			[board setLevel:[[savedLevels stringForKey:@"Eight"]intValue]];
			break;
	}
	for(int i=0; i<dim; i++)
	{
		for(int j=0; j<dim; j++)
		{
			[[buttons cellAtRow:i column:j]setFont:f];
		}
	}
	[buttons setCellSize:s];
	[buttons sizeToCells];
	[savedLevels setObject:[NSString stringWithFormat:@"Move: %d/%d",[board move:[sender selectedRow] :[sender selectedColumn]], [board getLevel]] forKey:@"Move"];
	[savedLevels setObject:[NSString stringWithFormat:@"Level: %d.%d",dim,[board getLevel]] forKey:@"Level"];
	[self fixColors];
	[self setButText];
}

- (void)fixColors
{
	int i,j;
	NSSize s;
	if(colorsOn)
	{
		if([colors numberOfColumns] < dim)
		{
			while([colors numberOfColumns] < dim)
			{
				[colors addColumn];
			}
		}
		else 
		{
			while([colors numberOfColumns] > dim)
			{
				[colors removeColumn:[colors numberOfColumns]-1];
			}
		}
	}
	switch(dim)
	{
		case 4:
			if(colorsOn)
			{
				int z = 0;
				[colors setHidden:FALSE];
				s = NSMakeSize(128, 17);
				for(i=0; i<4; i++)
				{
					for(j=0; j<4; j++)
					{
						if([board getVal:i :j]==0)
						{
							[[buttons cellAtRow:i column:j]setBordered:TRUE];
							[[buttons cellAtRow:i column:j]setImage:nil];
							continue;
						}
						z = [board getColor:i :j];
						[[buttons cellAtRow:i column:j]setBordered:FALSE];
						if(z==1) [[buttons cellAtRow:i column:j]setImage:[NSImage imageNamed:@"redbutton128.png"]];
						else if(z==2) [[buttons cellAtRow:i column:j]setImage:[NSImage imageNamed:@"greenbutton128.png"]];
						else if(z==3) [[buttons cellAtRow:i column:j]setImage:[NSImage imageNamed:@"bluebutton128.png"]];
						else if(z==4) [[buttons cellAtRow:i column:j]setImage:[NSImage imageNamed:@"yellowbutton128.png"]];
					}
				}
			}
			else if(!colorsOn)
			{
				[colors setHidden:TRUE];
				for(i=0; i<4; i++)
				{
					for(j=0; j<4; j++)
					{
						[[buttons cellAtRow:i column:j]setImage:nil];
						[[buttons cellAtRow:i column:j]setBordered:TRUE];
					}
				}
			}
			break;
		case 5:
			if(colorsOn)
			{
				int z = 0;
				[colors setHidden:FALSE];
				s = NSMakeSize(100, 17);
				[[colors cellAtRow:0 column:4]setBackgroundColor:[NSColor purpleColor]];
				for(i=0; i<5; i++)
				{
					for(j=0; j<5; j++)
					{
						if([board getVal:i :j]==0)
						{
							[[buttons cellAtRow:i column:j]setBordered:TRUE];
							[[buttons cellAtRow:i column:j]setImage:nil];
							continue;
						}
						z = [board getColor:i :j];
						[[buttons cellAtRow:i column:j]setBordered:FALSE];
						if(z==1) [[buttons cellAtRow:i column:j]setImage:[NSImage imageNamed:@"redbutton100.png"]];
						else if(z==2) [[buttons cellAtRow:i column:j]setImage:[NSImage imageNamed:@"greenbutton100.png"]];
						else if(z==3) [[buttons cellAtRow:i column:j]setImage:[NSImage imageNamed:@"bluebutton100.png"]];
						else if(z==4) [[buttons cellAtRow:i column:j]setImage:[NSImage imageNamed:@"yellowbutton100.png"]];
						else if(z==5) [[buttons cellAtRow:i column:j]setImage:[NSImage imageNamed:@"purplebutton100.png"]];
					}
				}
			}
			else if(!colorsOn)
			{
				[colors setHidden:TRUE];
				for(i=0; i<5; i++)
				{
					for(j=0; j<5; j++)
					{
						[[buttons cellAtRow:i column:j]setImage:nil];
						[[buttons cellAtRow:i column:j]setBordered:TRUE];
					}
				}
			}
			break;
		case 6:
			if(colorsOn)
			{
				int z = 0;
				[colors setHidden:FALSE];
				s = NSMakeSize(84, 17);
				[[colors cellAtRow:0 column:4]setBackgroundColor:[NSColor purpleColor]];
				[[colors cellAtRow:0 column:5]setBackgroundColor:[NSColor orangeColor]];
				for(i=0; i<6; i++)
				{
					for(j=0; j<6; j++)
					{
						if([board getVal:i :j]==0)
						{
							[[buttons cellAtRow:i column:j]setBordered:TRUE];
							[[buttons cellAtRow:i column:j]setImage:nil];
							continue;
						}
						z = [board getColor:i :j];
						[[buttons cellAtRow:i column:j]setBordered:FALSE];
						if(z==1) [[buttons cellAtRow:i column:j]setImage:[NSImage imageNamed:@"redbutton83.png"]];
						else if(z==2) [[buttons cellAtRow:i column:j]setImage:[NSImage imageNamed:@"greenbutton83.png"]];
						else if(z==3) [[buttons cellAtRow:i column:j]setImage:[NSImage imageNamed:@"bluebutton83.png"]];
						else if(z==4) [[buttons cellAtRow:i column:j]setImage:[NSImage imageNamed:@"yellowbutton83.png"]];
						else if(z==5) [[buttons cellAtRow:i column:j]setImage:[NSImage imageNamed:@"purplebutton83.png"]];
						else if(z==6) [[buttons cellAtRow:i column:j]setImage:[NSImage imageNamed:@"orangebutton83.png"]];
					}
				}
			}
			else if(!colorsOn)
			{
				[colors setHidden:TRUE];
				for(i=0; i<6; i++)
				{
					for(j=0; j<6; j++)
					{
						[[buttons cellAtRow:i column:j]setImage:nil];
						[[buttons cellAtRow:i column:j]setBordered:TRUE];
					}
				}
			}
			break;
		case 7:
			if(colorsOn)
			{
				int z = 0;
				[colors setHidden:FALSE];
				s = NSMakeSize(70, 17);
				[[colors cellAtRow:0 column:4]setBackgroundColor:[NSColor purpleColor]];
				[[colors cellAtRow:0 column:5]setBackgroundColor:[NSColor orangeColor]];
				[[colors cellAtRow:0 column:6]setBackgroundColor:[NSColor cyanColor]];
				for(i=0; i<7; i++)
				{
					for(j=0; j<7; j++)
					{
						if([board getVal:i :j]==0)
						{
							[[buttons cellAtRow:i column:j]setBordered:TRUE];
							[[buttons cellAtRow:i column:j]setImage:nil];
							continue;
						}
						z = [board getColor:i :j];
						[[buttons cellAtRow:i column:j]setBordered:FALSE];
						if(z==1) [[buttons cellAtRow:i column:j]setImage:[NSImage imageNamed:@"redbutton70.png"]];
						else if(z==2) [[buttons cellAtRow:i column:j]setImage:[NSImage imageNamed:@"greenbutton70.png"]];
						else if(z==3) [[buttons cellAtRow:i column:j]setImage:[NSImage imageNamed:@"bluebutton70.png"]];
						else if(z==4) [[buttons cellAtRow:i column:j]setImage:[NSImage imageNamed:@"yellowbutton70.png"]];
						else if(z==5) [[buttons cellAtRow:i column:j]setImage:[NSImage imageNamed:@"purplebutton70.png"]];
						else if(z==6) [[buttons cellAtRow:i column:j]setImage:[NSImage imageNamed:@"orangebutton70.png"]];
						else if(z==7) [[buttons cellAtRow:i column:j]setImage:[NSImage imageNamed:@"cyanbutton70.png"]];
					}
				}
			}
			else if(!colorsOn)
			{
				[colors setHidden:TRUE];
				for(i=0; i<7; i++)
				{
					for(j=0; j<7; j++)
					{
						[[buttons cellAtRow:i column:j]setImage:nil];
						[[buttons cellAtRow:i column:j]setBordered:TRUE];
					}
				}
			}
			break;
		case 8:
			if(colorsOn)
			{
				int z = 0;
				[colors setHidden:FALSE];
				s = NSMakeSize(60, 17);
				[[colors cellAtRow:0 column:4]setBackgroundColor:[NSColor purpleColor]];
				[[colors cellAtRow:0 column:5]setBackgroundColor:[NSColor orangeColor]];
				[[colors cellAtRow:0 column:6]setBackgroundColor:[NSColor cyanColor]];
				[[colors cellAtRow:0 column:7]setBackgroundColor:[NSColor magentaColor]];
				for(i=0; i<8; i++)
				{
					for(j=0; j<8; j++)
					{
						if([board getVal:i :j]==0)
						{
							[[buttons cellAtRow:i column:j]setBordered:TRUE];
							[[buttons cellAtRow:i column:j]setImage:nil];
							continue;
						}
						z = [board getColor:i :j];
						[[buttons cellAtRow:i column:j]setBordered:FALSE];
						if(z==1) [[buttons cellAtRow:i column:j]setImage:[NSImage imageNamed:@"redbutton60.png"]];
						else if(z==2) [[buttons cellAtRow:i column:j]setImage:[NSImage imageNamed:@"greenbutton60.png"]];
						else if(z==3) [[buttons cellAtRow:i column:j]setImage:[NSImage imageNamed:@"bluebutton60.png"]];
						else if(z==4) [[buttons cellAtRow:i column:j]setImage:[NSImage imageNamed:@"yellowbutton60.png"]];
						else if(z==5) [[buttons cellAtRow:i column:j]setImage:[NSImage imageNamed:@"purplebutton60.png"]];
						else if(z==6) [[buttons cellAtRow:i column:j]setImage:[NSImage imageNamed:@"orangebutton60.png"]];
						else if(z==7) [[buttons cellAtRow:i column:j]setImage:[NSImage imageNamed:@"cyanbutton60.png"]];
						else if(z==8) [[buttons cellAtRow:i column:j]setImage:[NSImage imageNamed:@"magentabutton60.png"]];
					}
				}
			}
			else if(!colorsOn)
			{
				[colors setHidden:TRUE];
				for(i=0; i<8; i++)
				{
					for(j=0; j<8; j++)
					{
						[[buttons cellAtRow:i column:j]setImage:nil];
						[[buttons cellAtRow:i column:j]setBordered:TRUE];
					}
				}
			}
			break;
	}
	if(colorsOn)
	{
		[colors setCellSize:s];
		[colors sizeToCells];
	}
}

- (void)saveLevels
{
	switch(dim)
	{
		case 4:
			if([board getLevel] < 25) [savedLevels setObject:[NSString stringWithFormat:@"%d",[board getLevel]] forKey:@"Four"];
			else [savedLevels setObject:@"25+" forKey:@"Four"];
			break;
		case 5:
			if([board getLevel] < 30) [savedLevels setObject:[NSString stringWithFormat:@"%d",[board getLevel]] forKey:@"Five"];
			else [savedLevels setObject:@"30+" forKey:@"Five"];
			break;
		case 6:
			if([board getLevel] < 35) [savedLevels setObject:[NSString stringWithFormat:@"%d",[board getLevel]] forKey:@"Six"];
			else [savedLevels setObject:@"35+" forKey:@"Six"];
			break;
		case 7:
			if([board getLevel] < 50) [savedLevels setObject:[NSString stringWithFormat:@"%d",[board getLevel]] forKey:@"Seven"];
			else [savedLevels setObject:@"50+" forKey:@"Seven"];
			break;
		case 8:
			if([board getLevel] < 75) [savedLevels setObject:[NSString stringWithFormat:@"%d",[board getLevel]] forKey:@"Eight"];
			else [savedLevels setObject:@"75+" forKey:@"Eight"];
			break;
	}
}

- (int)getLevels
{
	int x = 0;
	switch(dim)
	{
		case 4:
			x = [[savedLevels stringForKey:@"Four"]intValue];
			break;
		case 5:
			x = [[savedLevels stringForKey:@"Five"]intValue];
			break;
		case 6:
			x = [[savedLevels stringForKey:@"Six"]intValue];
			break;
		case 7:
			x = [[savedLevels stringForKey:@"Seven"]intValue];
			break;
		case 8:
			x = [[savedLevels stringForKey:@"Eight"]intValue];
			break;
	}
	return x;
}

- (IBAction)resetLevels:(id)sender
{
    [savedLevels setObject:@"4" forKey:@"Four"];
	[savedLevels setObject:@"5" forKey:@"Five"];
	[savedLevels setObject:@"6" forKey:@"Six"];
	[savedLevels setObject:@"7" forKey:@"Seven"];
	[savedLevels setObject:@"8" forKey:@"Eight"];
	switch(dim)
	{
		case 4:
			[board setLevel:[[savedLevels stringForKey:@"Four"]intValue]];
			break;
		case 5:
			[board setLevel:[[savedLevels stringForKey:@"Five"]intValue]];
			break;
		case 6:
			[board setLevel:[[savedLevels stringForKey:@"Six"]intValue]];
			break;
		case 7:
			[board setLevel:[[savedLevels stringForKey:@"Seven"]intValue]];
			break;
		case 8:
			[board setLevel:[[savedLevels stringForKey:@"Eight"]intValue]];
			break;
	}
	[board shuffle];
}
@end

