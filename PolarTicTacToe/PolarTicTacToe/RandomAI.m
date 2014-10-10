//
//  RandomAI.m
//  PolarTicTacToe
//
//  Created by Fred Kneeland on 10/10/14.
//  Copyright (c) 2014 Fred Kneeland. All rights reserved.
//

#import "RandomAI.h"
#import "Utilities.h"

@implementation RandomAI

+(int *) getNextMove:(int *)board
{
    int *newArray = (int *)malloc(sizeof(int) * 48);
    for (int i = 0; i < 48; i++)
    {
        int x = i / 12;
        int y = i % 12;
        int *move = (int *)malloc(sizeof(int) * 2);
        move[0] = x;
        move[1] = y;
        if ([Utilities moveValid:move :board])
        {
            newArray[i] = 1;
        }
    }
    
    int *nextMove = (int *)malloc(sizeof(int) * 2);
    nextMove[0] = -123;
    
    int j = 0;
    while (nextMove[0] == -123)
    {
        if (newArray[j] == 1)
        {
            int random = arc4random()%48;
            if (random == 1)
            {
                nextMove[0] = j / 12;
                nextMove[1] = j % 12;
                return nextMove;
            }
        }
        
        j = (j + 1) % 48;
    }
    return nextMove;
}

@end
