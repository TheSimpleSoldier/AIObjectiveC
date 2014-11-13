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

//Value will center around 0. 999 means that team won, -999 means the team lost. negative numbers mean the other team is doing better.
+(int) getValue:(int *)gameBoard :(int)team
{
    int value = 0;

    int winner = 0;//[Utilities teamWon:gameBoard];

    //Check to see if anybody has won yet
    if(winner == 1)
    {
        value = 999;
    }
    else if(winner == 2)
    {
        value = -999;
    }
    //Nobody has won yet, so look for how many unrestricted lines each player has and determine who is in better shape from there
    //Look for how many unrestricted lines each player has and determine who is in better shape from there
    else
    {
        int k, a, t;

    	//Check for vertical lines
	    for(k = 0; k < 12; k++)
	    {
	        int x = 1;
	        int y = 1;
	        for(a = 0; a < 4; a++)
	        {
	            if(gameBoard[k*4 + a] == 1)
	            {
	                y = 0;
	            }
	            else if(gameBoard[k*4 + a] == 2)
	            {
	                x = 0;
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
	    }
	
	    //Check for diagonal lines
	    for(k = 0; k < 12; k++)
	    {
	        int x = 1;
	        int y = 1;
	        for(a = 0; a < 4; a++)
	        {
	                if(gameBoard[((k + a) % 12)*4 + a] == 1)
	                {
	                    y = 0;
	                }
	                else if(gameBoard[((k + a) % 12)*4 + a] == 2)
	                {
	                    x = 0;
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
	                if(gameBoard[((12 + k - a) % 12)*4 + a] == 1)
	                {
	                    y = 0;
	                }
	                else if(gameBoard[((12 + k - a) % 12)*4 + a] == 2)
	                {
	                    x = 0;
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
	        
	    }
	
	    //Check for horizontal
	    for(a = 0; a < 4; a++)
	    {
	        for(k = 0; k < 12; k++)
	        {
	            int x = 1;
	            int y = 1;
	
	            for(t = 0; t < 4; t++)
	            {
	                if(gameBoard[((k + t) % 12)*4 + a] == 1)
	                {
	                    y = 0;
	                }
	                else if(gameBoard[((k + t) % 12)*4 + a] == 2)
	                {
	                    x = 0;
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
	        }
	    }
    }
    
    if(team == 2)
    {
        value *= -1;
    }

    return value;
}

@end
