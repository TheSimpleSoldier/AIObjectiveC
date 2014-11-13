//
//  Utilities.m
//  PolarTicTacToe
//
//  Created by Fred Kneeland on 9/29/14.
//  Copyright (c) 2014 Fred Kneeland. All rights reserved.
//

#import "Utilities.h"

@implementation Utilities

+(BOOL) moveValid:(int *)move :(int *)gameBoard
{
    int x = move[0];
    int y = move[1];
    BOOL update = FALSE;
    
    if (gameBoard[x*4 + y] != 0)
    {
        update = FALSE;
    }
    else
    {
        for (int i = -1; i <= 1; i++)
        {
            for (int j = -1; j <= 1; j++)
            {
                if ((x + i) < 0 || (x + i) > 11)
                {
                }
                else if ((y + j) < 0 || (y + j) > 3)
                {
                }
                else if (gameBoard[((x+i) * 4) + (y+j)] != 0)
                {
                    update = TRUE;
                }
            }
        }
        
        if (!update)
        {
            if (x == 0)
            {
                for (int i = -1; i <= 1; i++)
                {
                    if ((y + i) < 0 || (y + i) > 3)
                    {
                        
                    }
                    else if (gameBoard[44 + y + i] != 0)
                    {
                        update = TRUE;
                    }
                }
            }
            else if (x == 11)
            {
                for (int i = -1; i <= 1; i++)
                {
                    if ((y + i) < 0 || (y + i) > 3)
                    {
                        
                    }
                    else if (gameBoard[y + i] != 0)
                    {
                        update = TRUE;
                    }
                }
            }
        }
    }
    
    return update;
}

+(int *) upDateGameBoard:(int *)move :(int *)gameBoard :(int)team
{
    gameBoard[(move[0] * 4) + (move[1])] = team;
    return gameBoard;
}

//for clarity, ? is or, ; is and, and ~ is not
//Variable inside function are all points on the vertical and horizonal of the board.
//Functions for identity: isX(x,y) says spot has an x, isO(x,y) says spot has an o
//functions for position: sameVertical(w,x,y,z) says that the points are next to each other vertically
//                        sameHorizontal(w,x,y,z) says the points are next to each othe horizontally
//                        sameDiagonalLeft(w,x,y,z) says the points form a back slash diagonally
//                        sameDiagonalRight(w,x,y,z) says the points form a forward slash diagonally 
//
//There are 8 queries we are trying to prove, 4 for x, 4 for o,
//the only difference is whether the last conditions are isX or isO so only the x check will be shown
//vertical: sameVertical(a,b,c,d);sameVertical(c,d,e,f);sameVertical(e,f,g,h);isX(a,b);isX(c,d);isX(e,f);isX(g,h)
//horizontal: sameHorizontal(a,b,c,d);sameHorizontal(c,d,e,f);sameHorizontal(e,f,g,h);isX(a,b);isX(c,d);isX(e,f);isX(g,h)
//diagonalLeft: sameDiagonalLeft(a,b,c,d);sameDiagonalLeft(c,d,e,f);sameDiagonalLeft(e,f,g,h);isX(a,b);isX(c,d);isX(e,f);isX(g,h)
//diagonalRight: sameDiagonalRight(a,b,c,d);sameDiagonalRight(c,d,e,f);sameDiagonalRight(e,f,g,h);isX(a,b);isX(c,d);isX(e,f);isX(g,h)
+(int) teamWon:(int *)gameBoard
{
	//The following takes the game board to make the knowlege base
	NSMutableSet *knowlegeBase = [[NSMutableSet alloc] init];
	int k, a, t;
	for(k = 0; k < 12; k++)
	{
		for(a = 0; a < 4; a++)
		{
			//if it is an x
			if(gameBoard[k*4 + a] == 1)
			{
				NSMutableString *tempString = [NSMutableString stringWithFormat: @"isX(%i,%i)", k, a];
				[knowlegeBase addObject: tempString];
			}
			//if it is an o
			else if(gameBoard[k*4 + a] == 2)
			{
				NSMutableString *tempString = [NSMutableString stringWithFormat: @"isO(%i,%i)", k, a];
				[knowlegeBase addObject: tempString];
			}
			
			//if they are horizontally next to each other
			if(gameBoard[k*4 + a] != 0 && gameBoard[k*4 + a] == gameBoard[((k + 1) % 12)*4 + a])
			{
				NSMutableString *tempString = [NSMutableString stringWithFormat: @"sameHorizontal(%i,%i,%i,%i)", k, a, ((k + 1) % 12), a];
				[knowlegeBase addObject: tempString];
				
			}
			//if they are vertically next to each other
			else if(a < 3 && gameBoard[k*4 + a] != 0 &&gameBoard[k*4 + a] == gameBoard[k*4 + a + 1])
			{
				NSMutableString *tempString = [NSMutableString stringWithFormat: @"sameVertical(%i,%i,%i,%i)", k, a, k, (a + 1)];
				[knowlegeBase addObject: tempString];
			}
			//if they are diagonalRight
			else if(a < 3 && gameBoard[k*4 + a] != 0 && gameBoard[k*4 + a] == gameBoard[((k + 1) % 12)*4 + a + 1])
			{
				NSMutableString *tempString = [NSMutableString stringWithFormat: @"sameDiagonalRight(%i,%i,%i,%i)", k, a, ((k + 1) % 12), (a + 1)];
				[knowlegeBase addObject: tempString];
			}
			//if they are diagonalLeft
			else if(a < 3 && gameBoard[k*4 + a] != 0 && gameBoard[k*4 + a] == gameBoard[((12 + k - 1) % 12)*4 + a + 1])
			{
				NSMutableString *tempString = [NSMutableString stringWithFormat: @"sameDiagonalLeft(%i,%i,%i,%i)", k, a, ((12 + k - 1) % 12), (a + 1)];
				[knowlegeBase addObject: tempString];
			}
		}
	}
	
	//now we create our 8 negated queries to run
	NSMutableString *verticalX = [NSMutableString stringWithString:
    @"~sameVertical(a,0,a,1)?~sameVertical(a,1,a,2)?~sameVertical(a,2,a,3)?~isX(a,0)?~isX(a,1)?~isX(a,2)?~isX(a,3)"];
	NSMutableString *horizontalX = [NSMutableString stringWithString:
    @"~sameHorizontal(a,b,c,b)?~sameHorizontal(c,b,e,b)?~sameHorizontal(e,b,g,b)?~isX(a,b)?~isX(c,b)?~isX(e,b)?~isX(g,b)"];
	NSMutableString *diagRightX = [NSMutableString stringWithString:
    @"~sameDiagonalRight(a,0,c,1)?~sameDiagonalRight(c,1,e,2)?~sameDiagonalRight(e,2,g,3)?~isX(a,0)?~isX(c,1)?~isX(e,2)?~isX(g,3)"];
	NSMutableString *diagLeftX = [NSMutableString stringWithString:
    @"~sameDiagonalLeft(a,0,c,1)?~sameDiagonalLeft(c,1,e,2)?~sameDiagonalLeft(e,2,g,3)?~isX(a,0)?~isX(c,1)?~isX(e,2)?~isX(g,3)"];
	
	NSMutableString *verticalO = [NSMutableString stringWithString:
    @"~sameVertical(a,0,a,1)?~sameVertical(a,1,a,2)?~sameVertical(a,2,a,3)?~isO(a,0)?~isO(a,1)?~isO(a,2)?~isO(a,3)"];
	NSMutableString *horizontalO = [NSMutableString stringWithString:
    @"~sameHorizontal(a,b,c,b)?~sameHorizontal(c,b,e,b)?~sameHorizontal(e,b,g,b)?~isO(a,b)?~isO(c,b)?~isO(e,b)?~isO(g,b)"];
	NSMutableString *diagRightO = [NSMutableString stringWithString:
    @"~sameDiagonalRight(a,0,c,1)?~sameDiagonalRight(c,1,e,2)?~sameDiagonalRight(e,2,g,3)?~isO(a,0)?~isO(c,1)?~isO(e,2)?~isO(g,3)"];
	NSMutableString *diagLeftO = [NSMutableString stringWithString:
    @"~sameDiagonalLeft(a,0,c,1)?~sameDiagonalLeft(c,1,e,2)?~sameDiagonalLeft(e,2,g,3)?~isO(a,0)?~isO(c,1)?~isO(e,2)?~isO(g,3)"];
	
	NSMutableArray *queries = [[NSMutableArray alloc] init];
	[queries addObject: verticalX];
	[queries addObject: horizontalX];
	[queries addObject: diagRightX];
	[queries addObject: diagLeftX];
	[queries addObject: verticalO];
	[queries addObject: horizontalO];
	[queries addObject: diagRightO];
	[queries addObject: diagLeftO];
	
	
	//now we run resolution on all the queries and the first to return true we use to return the answer
	//if none of them return, we return 0, or no winner
	for(k = 0; k < 8; k++)
	{
        //start of resolution algorithm
		NSMutableSet *clauses = [[NSMutableSet alloc] init];
        [clauses addObjectsFromArray: [knowlegeBase allObjects]];
		[clauses addObject: [queries objectAtIndex: k]];
        NSMutableSet *new = [[NSMutableSet alloc] init];
        
        while(true)
        {
            int clauseCount = [clauses count];
            NSArray *tempClauses = [clauses allObjects];
            for(a = 0; a < clauseCount; a++)
            {
                for(t = 0; t < clauseCount; t++)
                {
                    if(a != t)
                    {
                        NSMutableSet *resolvents = [[NSMutableSet alloc] init];
                        resolvents = [Utilities resolveVars: [tempClauses objectAtIndex: a] :[tempClauses objectAtIndex: t]]; 

                        for(NSString *i in resolvents)
                        {
                            if([i isEqualToString:@" "])
                            {
                                if(k < 4)
                                {
                                    return 1;
                                }
                                else
                                {
                                    return 2;
                                }
                            }
                        }

                        [new unionSet: resolvents];
                    }
                }
            }

            NSMutableSet *temp1 = [[NSMutableSet alloc] init];
            [temp1 setSet: clauses];
            [temp1 minusSet: new];
            NSMutableSet *temp2 = [[NSMutableSet alloc] init];
            [temp2 setSet: new];
            [temp1 minusSet: clauses];
            if([temp1 count] > 0 || [temp2 count] == 0)
            {
                break;
            }
            [clauses unionSet: new];
        }

	}

    return 0;
}

//Since all the clauses are nicely formatted, a full unification rule is not neccessary.
//For efficiency, a smaller, more efficient version will be used.
+(NSMutableSet *) resolveVars: (NSMutableString *)first : (NSMutableString *)second
{
    NSMutableSet *toReturn = [[NSMutableSet alloc] init];

    //Splits string into clauses separated by or.
    NSMutableArray *firstArray = [NSMutableArray arrayWithArray: [first componentsSeparatedByString:@"?"]];
    NSMutableArray *secondArray = [NSMutableArray arrayWithArray: [second componentsSeparatedByString:@"?"]];

    int k, a;
    for(k= 0; k < [firstArray count]; k++)
    {
        //index 0 of temp 1 is function name.
        NSArray *temp1 = [[firstArray objectAtIndex: k] componentsSeparatedByString:@"("];

        for(a = 0; a < [secondArray count]; a++)
        {
            //index 0 of temp 2 is function name.
            NSArray *temp2 = [[secondArray objectAtIndex: a] componentsSeparatedByString:@"("];

            //if they negate each other, perform unification.
            if([[temp1 objectAtIndex: 0] isEqualToString: [NSString stringWithFormat:@"%@%@", @"~", [temp1 objectAtIndex: 0]]] ||
            [[temp2 objectAtIndex: 0] isEqualToString: [NSString stringWithFormat:@"%@%@", @"~", [temp1 objectAtIndex: 0]]])
            {
                //first figure out the substitution string, which is just the first strings args and the second strings args.
                NSString *args1 = [[[temp1 objectAtIndex: 1] componentsSeparatedByString:@")"] objectAtIndex: 0];
                NSString *args2 = [[[temp2 objectAtIndex: 1] componentsSeparatedByString:@")"] objectAtIndex: 0];
                NSArray *argArray1 = [args1 componentsSeparatedByString:@","];
                NSArray *argArray2 = [args2 componentsSeparatedByString:@","];

                //this part is substituting the first for the second
                int t;
                int i = 0;
                for(t = 0; t < [argArray1 count]; t++)
                {
                    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
                    NSNumber *number = [formatter numberFromString:[argArray2 objectAtIndex: t]];
                    //[formatter release];
                    if(!!number)
                    {
                        if(![[argArray1 objectAtIndex: t] isEqualToString: [argArray2 objectAtIndex: t]])
                        {
                            i = 1;
                        }
                    }
                }

                if(i == 0)
                {
                    NSMutableString *resolved = [NSMutableString stringWithString:@""];
                    int inserted = 0;
                    for(t = 0; t < [firstArray count]; t++)
                    {
                        if(t != k)
                        {
                            [resolved appendFormat:@"%@", [firstArray objectAtIndex: t]];
                            if(t < [firstArray count] - 1)
                            {
                                [resolved appendString:@"?"];
                            }
                            inserted = 1;
                        }
                    }
                    for(t = 0; t < [secondArray count]; t++)
                    {
                        if(t != a)
                        {
                            NSMutableString *replacement = [NSMutableString stringWithFormat:@"%@", [secondArray objectAtIndex: t]];
                            for(i = 0; i < [argArray1 count]; i++)
                            {
                                NSString *toReplace1 = [NSString stringWithFormat:@"%@,", [argArray2 objectAtIndex: i]];
                                NSString *toReplace2 = [NSString stringWithFormat:@"%@)", [argArray2 objectAtIndex: i]];
                                NSString *toReplaceWith1 = [NSString stringWithFormat:@"%@,", [argArray1 objectAtIndex: i]];
                                NSString *toReplaceWith2 = [NSString stringWithFormat:@"%@)", [argArray1 objectAtIndex: i]];
                                [replacement setString:[replacement stringByReplacingOccurrencesOfString:toReplace1 withString:toReplaceWith1]]; 
                                [replacement setString:[replacement stringByReplacingOccurrencesOfString:toReplace2 withString:toReplaceWith2]];
                            }
                            [resolved appendFormat:@"%@", replacement];
                            if(t < [secondArray count] - 1)
                            {
                                [resolved appendString:@"?"];
                            }
                            inserted = 1;
                        }
                    }

                    if(inserted == 0)
                    {
                        [resolved appendString:@" "];
                    }

                    [toReturn addObject:resolved];
                }
            }
        }
    }

    return toReturn;
}

+(int *) getAllAvaliableMoves:(int *)board :(int *)size
{
    int *newArray = (int *)malloc(sizeof(int) * 48);
    for (int a = 0; a < 48; a++)
    {
        newArray[a] = 0;
    }
    int *move = (int *)malloc(sizeof(int) * 2);
    int totalSize = 0;
    for (int i = 0; i < 48; i++)
    {
        int x = i / 4;
        int y = i % 4;
        move[0] = x;
        move[1] = y;
        if ([Utilities moveValid:move :board])
        {
            newArray[i] = 1;
            totalSize++;
        }
    }
    
    int *avaliableMoves = (int *)malloc(sizeof(int) * totalSize);
    int k = 0;
    for (int j = 0; j < totalSize; j++)
    {
        while (newArray[k] != 1 && k < 48)
        {
            k++;
        }
        avaliableMoves[j] = k;
        k++;
    }
    
    *size = totalSize;
    return avaliableMoves;
}

@end
