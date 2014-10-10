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
                    if (y + i < 0 || y + i > 3)
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
                    if (y + i < 0 || y + i > 3)
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

@end
