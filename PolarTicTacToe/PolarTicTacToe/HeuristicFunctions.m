//
//  HeuristicFunctions.m
//  PolarTicTacToe
//
//  Created by Fred Kneeland on 9/29/14.
//  Copyright (c) 2014 Fred Kneeland. All rights reserved.
//

#import "HeuristicFunctions.h"
#import "Utilities.h"

@implementation HeuristicFunctions

//Value will center around 0. 999 means the team won, -999 means the team lost. negative numbers mean the other team is doing better.
+(int) getValue:(int *)gameboard :(int)team
{
    int value = 0;

    int winner = 0;

    //Look for how many unrestricted lines each player has and determine who is in better shape from there
    int k, a, t;

    //Check for vertical lines
    for(k = 0; k < 12; k++)
    {
        int x = 1;
        int y = 1;
        int winX = 0;
        int winY = 0;
        for(a = 0; a < 4; a++)
        {
            if(gameboard[k*4 + a] == 1)
            {
                y = 0;
                winX++;
            }
            else if(gameboard[k*4 + a] == 2)
            {
                x = 0;
                winY++;
            }
        }

        if(winX == 4)
        {
            winner = 1;
            value = 999;
            break;
        }
        else if(winY == 4)
        {
            winner = 1;
            value = -999;
            break;
        }

        if(x && !y)
        {
            value++;
        }
        else if(!x && y)
        {
            value--;
        }
    }

    if(winner == 0)
    {
        //Check for diagonal lines
        for(k = 0; k < 12; k++)
        {
            int x = 1;
            int y = 1;
            int winX = 0; 
            int winY = 0;
            for(a = 0; a < 4; a++)
            {
                    if(gameboard[((k + a) % 12)*4 + a] == 1)
                    {
                        y = 0;
                        winX++;
                    }
                    else if(gameboard[((k + a) % 12)*4 + a] == 2)
                    {
                        x = 0;
                        winY++;
                    }
            }
    
            if(x && !y)
            {
                value++;
            }
            else if(!x && y)
            {
                value--;
            }
    
            x = 1;
            y = 1;
            for(a = 0; a < 4; a++)
            {
                    if(gameboard[((12 + k - a) % 12)*4 + a] == 1)
                    {
                        y = 0;
                    }
                    else if(gameboard[((12 + k - a) % 12)*4 + a] == 2)
                    {
                        x = 0;
                    }
            }
    
            if(winX == 4)
            {
                winner = 1;
                value = 999;
                break;
            }
            else if(winY == 4)
            {
                winner = 1;
                value = -999;
                break;
            }

            if(x && !y)
            {
                value++;
            }
            else if(!x && y)
            {
                value--;
            }
        }
    }

    if(winner == 0)
    {
        //Check for horizontal
        for(a = 0; a < 4; a++)
        {
            for(k = 0; k < 12; k++)
            {
                int x = 1;
                int y = 1;
                int winX = 0;
                int winY = 0;
    
                for(t = 0; t < 4; t++)
                {
                    if(gameboard[((k + t) % 12)*4 + a] == 1)
                    {
                        y = 0;
                        winX++;
                    }
                    else if(gameboard[((k + t) % 12)*4 + a] == 2)
                    {
                        x = 0;
                        winY++;
                    }
                }

                if(winX == 4)
                {
                    winner = 1;
                    value = 999;
                    break;
                }
                else if(winY == 4)
                {
                    winner = 1;
                    value = -999;
                    break;
                }
    
                if(x && !y)
                {
                    value++;
                }
                else if(!x && y)
                {
                    value--;
                }
            }

            if(winner == 1)
            {
                break;
            }
        }
    }
    
    if(team == 2)
    {
        value *= -1;
    }

    return value;
}

+(int) decisionTreeChecker:(int *)gameboard :(int)team
{
    //The tree will be represented as an array
    NSArray *tree = [NSArray arrayWithObjects:               @"1,2,-15",
                 @"5,6,-13",                                 @"8,9,-14",                                  @"-15,-15,-15",
    @"-1,-5,-9",@"-2,-6,-10",@"-13,-13,-13",   @"-3,-7,-11",@"-4,-8,-12",@"-14,-14,-14",   @"-15,-15,-15",@"-15,-15,-15",@"-15,-15,-15",
    nil];
    //This is used to decide the next child
    int deciders[] = {1,2,3};

    //Get class info to put in decision tree
    int teamOneWin[] = {0,0,0,0};
    int teamTwoWin[] = {0,0,0,0};

    int k, a, t;
    //Check for vertical lines
    for(k = 0; k < 12; k++)
    {
        int winX = 0;
        int winY = 0;
        for(a = 0; a < 4; a++)
        {
            if(gameboard[k*4 + a] == 1)
            {
                winX++;
            }
            else if(gameboard[k*4 + a] == 2)
            {
                winY++;
            }
        }

        if(winX > 0 && winY == 0)
        {
            teamOneWin[4 - winX] = teamOneWin[4 - winX] + 1;
        }
        else if(winY > 0 && winX == 0)
        {
            teamTwoWin[4 - winY] = teamTwoWin[4 - winY] + 1;
        }
    }

    //Check for diagonal lines
    for(k = 0; k < 12; k++)
    {
        int winX = 0; 
        int winY = 0;
        for(a = 0; a < 4; a++)
        {
                if(gameboard[((k + a) % 12)*4 + a] == 1)
                {
                    winX++;
                }
                else if(gameboard[((k + a) % 12)*4 + a] == 2)
                {
                    winY++;
                }
        }
        
        if(winX > 0 && winY == 0)
        {
            teamOneWin[4 - winX] = teamOneWin[4 - winX] + 1;
        }
        else if(winY > 0 && winX == 0)
        {
            teamTwoWin[4 - winY] = teamTwoWin[4 - winY] + 1;
        }

        winX = 0;
        winY = 0;

        for(a = 0; a < 4; a++)
        {
                if(gameboard[((12 + k - a) % 12)*4 + a] == 1)
                {
                    winX++;
                }
                else if(gameboard[((12 + k - a) % 12)*4 + a] == 2)
                {
                    winY++;
                }
        }
        
        if(winX > 0 && winY == 0)
        {
            teamOneWin[4 - winX] = teamOneWin[4 - winX] + 1;
        }
        else if(winY > 0 && winX == 0)
        {
            teamTwoWin[4 - winY] = teamTwoWin[4 - winY] + 1;
        }
    }

    //Check for horizontal
    for(a = 0; a < 4; a++)
    {
        for(k = 0; k < 12; k++)
        {
            int winX = 0;
            int winY = 0;

            for(t = 0; t < 4; t++)
            {
                if(gameboard[((k + t) % 12)*4 + a] == 1)
                {
                    winX++;
                }
                else if(gameboard[((k + t) % 12)*4 + a] == 2)
                {
                    winY++;
                }
            }
            
            if(winX > 0 && winY == 0)
            {
                teamOneWin[4 - winX] = teamOneWin[4 - winX] + 1;
            }
            else if(winY > 0 && winX == 0)
            {
                teamTwoWin[4 - winY] = teamTwoWin[4 - winY] + 1;
            }
        }
    }

    if(teamOneWin[0] > 0)
    {
        if(team == 1)
        {
            return 999;
        }
        else
        {
            return -999;
        }
    }
    else if(teamTwoWin[0] > 0)
    {
        if(team == 2)
        {
            return 999;
        }
        else
        {
            return -999;
        }
    }
    //NSLog(@"First: %d,%d,%d,%d", teamOneWin[0], teamOneWin[1], teamOneWin[2], teamOneWin[3]);
    //NSLog(@"Second: %d,%d,%d,%d", teamTwoWin[0], teamTwoWin[1], teamTwoWin[2], teamTwoWin[3]);

    //Plug in values to get guess for each team
    int teamOne = 0;
    int teamTwo = 0;

    int level = 0;
    int spot = 0;
    while(teamOne == 0)
    {
        NSArray *children = [NSArray arrayWithArray:[[tree objectAtIndex:spot] componentsSeparatedByString:@","]];
        if(teamOneWin[level + 1] > deciders[level])
        {
            int value = [[children objectAtIndex:2] intValue];
            if(value < 0)
            {
                teamOne = value * -1;
            }
            else
            {
                spot = value;
            }
        }
        else if(teamOneWin[level + 1] == deciders[level])
        {
            int value = [[children objectAtIndex:1] intValue];
            if(value < 0)
            {
                teamOne = value * -1;
            }
            else
            {
                spot = value;
            }
        }
        else
        {
            int value = [[children objectAtIndex:0] intValue];
            if(value < 0)
            {
                teamOne = value * -1;
            }
            else
            {
                spot = value;
            }
        }
        level++;
    }

    level = 0;
    spot = 0;
    while(teamTwo == 0)
    {
        NSArray *children = [NSArray arrayWithArray:[[tree objectAtIndex:spot] componentsSeparatedByString:@","]];
        if(teamTwoWin[level + 1] > deciders[level])
        {
            int value = [[children objectAtIndex:2] intValue];
            if(value < 0)
            {
                teamTwo = value * -1;
            }
            else
            {
                spot = value;
            }
        }
        else if(teamTwoWin[level + 1] == deciders[level])
        {
            int value = [[children objectAtIndex:1] intValue];
            if(value < 0)
            {
                teamTwo = value * -1;
            }
            else
            {
                spot = value;
            }
        }
        else
        {
            int value = [[children objectAtIndex:0] intValue];
            if(value < 0)
            {
                teamTwo = value * -1;
            }
            else
            {
                spot = value;
            }
        }
        level++;
    }

    //Compare values and return prediction
    //NSLog(@"1: %d\t2: %d", teamOne, teamTwo);
    if(teamOne == teamTwo)
    {
        for(k = 1; k < 4; k++)
        {
            if(teamOneWin[k] > teamTwoWin[k])
            {
                teamOne = 16;
                break;
            }
            else if(teamOneWin[k] < teamTwoWin[k])
            {
                teamTwo = 16;
                break;
            }
        }
    }
    if(team == 1)
    {
        if(teamOne > teamTwo)
        {
            return 999;
        }
        else
        {
            return -999;
        }
    }
    else
    {
        if(teamTwo > teamOne)
        {
            return 999;
        }
        else
        {
            return -999;
        }
    }
}

@end
