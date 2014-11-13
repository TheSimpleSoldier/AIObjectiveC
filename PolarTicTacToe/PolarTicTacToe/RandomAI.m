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
    int size = 0;
    int *avaliableMoves = [Utilities getAllAvaliableMoves:board :&size];
    int *nextMove = (int *)malloc(sizeof(int) * 2);
    
    if (size == 0)
    {
        NSLog(@"Houston we have a problem");
    }
    
    NSString *stringer = [[NSString alloc] initWithFormat:@"%i", size];
    //NSLog(stringer);
    
    int j = 0;
    bool done = false;
    while (!done)
    {
        int random = arc4random()%size;
        if (random <= 1)
        {
            nextMove[0] = avaliableMoves[j] / 4;
            nextMove[1] = avaliableMoves[j] % 4;
            //NSLog(@"Found move");
            if ([Utilities moveValid:nextMove :board])
            {
                done = true;
                return nextMove;
            }
            else
            {
                NSLog(@"Tried an invalid move");
            }
        }
        
        j = (j + 1) % size;
        if (j == 0)
        {
            NSLog(@"J == 0");
        }
    }
    stringer = [[NSString alloc] initWithFormat:@"%i, %i", nextMove[0], nextMove[1]];
    //NSLog(stringer);
    return nextMove;
}

@end
