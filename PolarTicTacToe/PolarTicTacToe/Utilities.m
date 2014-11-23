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
        //NSLog(@"already taken");
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
    int *newGameBoard = (int *)malloc(sizeof(int) * 48);
    for (int i = 0; i < 48; i++)
    {
        newGameBoard[i] = gameBoard[i];
    }
    
    if (((move[0] * 4) + move[1]) > 47)
    {
        NSLog(@"going off the board");
    }
    else
    {
        int x = move[0];
        int y = move[1];
        newGameBoard[(x * 4) + (y)] = team;
    }
    return newGameBoard;
}

//a-l represent the first 12 numbers for the variables
//N represents there is no variable there
//u represents if the point is an x
//v represents if the point is an o
//w represents if two points are on the same vertical
//x represents if two points are on the same horizontal
//y represents if two points are on the same diagonal left
//z represents if two points are on the same diagonal right
//anything else means unknown
+(int) teamWon:(int *)gameBoard
{
	//The following takes the game board to make the knowledge base
	NSMutableArray *knowledgeBase = [[NSMutableArray alloc] init];
	int k, a, t;
	for(k = 0; k < 12; k++)
	{
		for(a = 0; a < 4; a++)
		{
			//if it is an x
			if(gameBoard[k*4 + a] == 1)
			{
				NSString *tempString = [NSString stringWithFormat: @"u%c%cNN ", k + 97, a + 97];
				[knowledgeBase addObject: tempString];
			}
			//if it is an o
			else if(gameBoard[k*4 + a] == 2)
			{
				NSString *tempString = [NSString stringWithFormat: @"v%c%cNN ", k + 97, a + 97];
				[knowledgeBase addObject: tempString];
			}
			
			//if they are horizontally next to each other
			if(gameBoard[k*4 + a] != 0 && gameBoard[k*4 + a] == gameBoard[((k + 1) % 12)*4 + a])
			{
				NSString *tempString = [NSString stringWithFormat: @"x%c%c%c%c ", k + 97, a + 97, ((k + 1) % 12) + 97, a + 97];
				[knowledgeBase addObject: tempString];
			}
			//if they are vertically next to each other
			else if(a < 3 && gameBoard[k*4 + a] != 0 &&gameBoard[k*4 + a] == gameBoard[k*4 + a + 1])
			{
				NSString *tempString = [NSString stringWithFormat: @"w%c%c%c%c ", k + 97, a + 97, k + 97, (a + 1) + 97];
				[knowledgeBase addObject: tempString];
			}
			//if they are diagonalRight
			else if(a < 3 && gameBoard[k*4 + a] != 0 && gameBoard[k*4 + a] == gameBoard[((k + 1) % 12)*4 + a + 1])
			{
				NSString *tempString = [NSString stringWithFormat: @"z%c%c%c%c ", k + 97, a + 97, ((k + 1) % 12) + 97, (a + 1) + 97];
				[knowledgeBase addObject: tempString];
			}
			//if they are diagonalLeft
			else if(a < 3 && gameBoard[k*4 + a] != 0 && gameBoard[k*4 + a] == gameBoard[((12 + k - 1) % 12)*4 + a + 1])
			{
				NSString *tempString = [NSString stringWithFormat: @"y%c%c%c%c ", k + 97, a + 97, ((12 + k - 1) % 12) + 97, (a + 1) + 97];
				[knowledgeBase addObject: tempString];
			}
		}
	}

	//now we create our 8 negated queries to run
	NSString *verticalX = [NSString stringWithString:
    @"wmamb~?wmbmc~?wmcmd~?umaNN~?umbNN~?umcNN~?umdNN~"];
	NSString *horizontalX = [NSString stringWithString:
    @"xnmom~?xompm~?xpmqm~?unmNN~?uomNN~?upmNN~?uqmNN~"];
	NSString *diagRightX = [NSString stringWithString:
    @"zmanb~?znboc~?zocpd~?umaNN~?unbNN~?uocNN~?updNN~"];
	NSString *diagLeftX = [NSString stringWithString:
    @"ymanb~?ynboc~?yocpd~?umaNN~?unbNN~?uocNN~?updNN~"];
	
	NSString *verticalO = [NSString stringWithString:
    @"wmamb~?wmbmc~?wmcmd~?vmaNN~?vmbNN~?vmcNN~?vmdNN~"];
	NSString *horizontalO = [NSString stringWithString:
    @"xnmom~?xompm~?xpmqm~?vnmNN~?vomNN~?vpmNN~?vqmNN~"];
	NSString *diagRightO = [NSString stringWithString:
    @"zmanb~?znboc~?zocpd~?vmaNN~?vnbNN~?vocNN~?vpdNN~"];
	NSString *diagLeftO = [NSString stringWithString:
    @"ymanb~?ynboc~?yocpd~?vmaNN~?vnbNN~?vocNN~?vpdNN~"];
	
    NSArray *knowledge = [knowledgeBase copy];
	NSArray *queries = [NSArray arrayWithObjects:verticalX, horizontalX, diagRightX, diagLeftX, verticalO, horizontalO, diagRightO, diagLeftO, nil];


	//now we run resolution on all the queries and the first to return true we use to return the answer
	//if none of them return, we return 0 since there is no winner
	for(k = 0; k < 8; k++)
	{
        //start of resolution algorithm
        //In order to optimize, we will only deal with the newest iteration of clauses.
        NSArray *clauses = [NSArray arrayWithObjects:[queries objectAtIndex:k], nil];
        while(true)
        {
            NSMutableSet *new = [[NSMutableSet alloc] init];
            int kcount = [knowledge count];
            int ncount = [clauses count];
            for(a = 0; a < kcount; a++)
            {
                for(t = 0; t < ncount; t++)
                {
                    NSSet *resolvents = [Utilities resolveVars: [knowledge objectAtIndex: a] :[clauses objectAtIndex: t]]; 

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

            if([new count] == 0)
            {
                break;
            }
            clauses = [NSArray arrayWithArray:[new allObjects]];
            //[NSThread sleepForTimeInterval:5];
        }

	}

    return 0;
}

//Since all the clauses are nicely formatted, a full unification rule is not neccessary.
//For efficiency, a smaller, more efficient version will be used.
+(NSSet *) resolveVars:(NSString *)first :(NSString *)second
{
    NSMutableSet *toReturn = [[NSMutableSet alloc] init];

    //Splits string into clauses separated by or.
    //First one doesn't need it since it will always be just one function.
    NSArray *secondArray = [NSArray arrayWithArray:[second componentsSeparatedByString:@"?"]];

    int k;
    int count = [secondArray count];
    for(k = 0; k < count; k++)
    {
        //if they negate each other, perform unification.
        if([first characterAtIndex:0] == [[secondArray objectAtIndex:k] characterAtIndex:0] && [[secondArray objectAtIndex:k] characterAtIndex:5] == '~')
        {
            int t;
            int i = 0;
            for(t = 0; t < 4; t++)
            {
                char firstChar = [first characterAtIndex:(t + 1)];
                char secondChar = [[secondArray objectAtIndex:k] characterAtIndex:(t + 1)];
                //if they are not the same and the second one is a number
                if(firstChar != secondChar && secondChar < 109)
                {
                    i = 1;
                }
            }

            if(i == 0)
            {
                NSMutableString *resolved = [NSMutableString stringWithString:@""];
                int inserted = 0;
                for(t = 0; t < [secondArray count]; t++)
                {
                    if(t != k)
                    {
                        NSString *replacement = [NSString stringWithFormat:@"%@", [secondArray objectAtIndex:t]];
                        for(i = 0; i < 4; i++)
                        {
                            NSString *firstChar = [NSString stringWithFormat:@"%c", [first characterAtIndex:(i + 1)]];
                            NSString *secondChar = [NSString stringWithFormat:@"%c", [[secondArray objectAtIndex:k] characterAtIndex:(i + 1)]];
                            if([[secondArray objectAtIndex:t] characterAtIndex:0] > 108)
                            {
                                NSString *newString = [replacement stringByReplacingOccurrencesOfString:secondChar withString:firstChar];
                                replacement = newString;
                            }
                        }
                        [resolved appendFormat:@"%@", replacement];
                        if(t < [secondArray count] - 1 && k != [secondArray count] - 1)
                        {
                            [resolved appendString:@"?"];
                        }
                        else if(t < [secondArray count] - 2)
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

                [toReturn addObject:[NSString stringWithString:resolved]];
            }
        }
    }

    NSSet *returned = [NSSet setWithArray:[toReturn allObjects]];
    return returned;
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