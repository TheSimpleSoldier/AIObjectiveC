#import <Foundation/Foundation.h>
#import <math.h>
#import "TrainNet.h"
#import <stdio.h>

@implementation TrainNet

//Structure of neural net is that there are 48 inputs for each spot on the board
// 1 is X, -1 is O, and 0 is empty
//There are 40 hidden rows right now
//There are 2 outputs, one for how well X is doing, and one for how well O is doing
//
//The net weights array is organized as follows
//{input1,...,input48,inner1,...inner40}
//where each of those is a sequential order of the weights emanating from those
+(void) updateInGame:(float *)netWeights :(int *)gameBoard :(int)team :(float)alpha
{
    float originalInputValues[48];
    float originalInnerValues[40];
    float originalOutputValues[2];
    float newOutputValues[2] = {-100, -100};
    int newLocation = -1;
    
    //Get current score
    [TrainNet evaluate:netWeights :gameBoard :originalInputValues :originalInnerValues :originalOutputValues];
    
    //Look at all possible next states and choose best one based on neural net evaluation
    int size = 0;
    int *spots = [TrainNet getAllAvaliableMoves:gameBoard :&size];
    int k;
    for(k = 0; k < size;k++)
    {
        float tempInputValues[48];
        float tempInnerValues[40];
        float tempOutputValues[2];
        
        if(team == 1)
        {
            gameBoard[spots[k]] = 1;
        }
        else
        {
            gameBoard[spots[k]] = 2;
        }
        
        [TrainNet evaluate:netWeights :gameBoard :tempInputValues :tempInnerValues :tempOutputValues];
        
        int compare = 0;
        if(team == 2)
        {
            compare = 1;
        }
        if(tempOutputValues[compare] > newOutputValues[compare])
        {
            newLocation = spots[k];
            newOutputValues[0] = tempOutputValues[0];
            newOutputValues[1] = tempOutputValues[1];
        }
        
        gameBoard[spots[k]] = 0;
    }
    free(spots);
    
    //Update gameboard with selected move
    if(newLocation != -1)
    {
        if(team == 1)
        {
            gameBoard[newLocation] = 1;
        }
        else
        {
            gameBoard[newLocation] = 2;
        }
    }
    
    //Update neural net weights through back propogation
    [TrainNet backProp:netWeights :originalInputValues :originalInnerValues :originalOutputValues :newOutputValues :alpha];
}

+(void) updateAfterGame:(float *)netWeights :(int *)gameBoard :(int)winner :(float)alpha
{
    float inputValues[48];
    float innerValues[40];
    float outputValues[2];
    float correctOutput[2] = {1,0};
    if(winner == 2)
    {
        correctOutput[0] = 0;
        correctOutput[1] = 1;
    }
    else if(winner == -1)
    {
        correctOutput[0] = 0;
        correctOutput[1] = 0;
    }
    
    //Get current score
    [TrainNet evaluate:netWeights :gameBoard :inputValues :innerValues :outputValues];
    
    [TrainNet backProp:netWeights :inputValues :innerValues :outputValues :correctOutput :alpha];
    
}

+(void) evaluate:(float *)netWeights :(int *)gameBoard :(float *)inputValues :(float *)innerValues :(float *)outputValues
{
    int inputLayer = 48;
    int innerLayer = 40;
    int outputLayer = 2;
    
    //Initialize inputs
    int k, a;
    for(k = 0; k < inputLayer; k++)
    {
        if(gameBoard[k] == 2)
        {
            inputValues[k] = -1;
        }
        else
        {
            inputValues[k] = gameBoard[k];
        }
    }
    
    //Calculate values for inner layer
    for(k = 0; k < innerLayer; k++)
    {
        float sum = 0;
        for(a = 0; a < inputLayer; a++)
        {
            sum += inputValues[a] * netWeights[(a * innerLayer) + k];
        }
        innerValues[k] = 1. / (1. + pow(M_E,sum * -1));
    }
    
    for(k = 0; k < outputLayer; k++)
    {
        float sum = 0;
        for(a = 0; a < innerLayer; a++)
        {
            sum += innerValues[a] * netWeights[(inputLayer * innerLayer) + (a * outputLayer) + k];
        }
        outputValues[k] = 1. / (1. + pow(M_E,sum * -1));
    }
}

+(void) backProp:(float *)netWeights :(float *)firstInputValues :(float *)firstInnerValues :(float *)firstOutputValues :(float *)secondOutputValues :(float)alpha
{
    int inputLayer = 48;
    int innerLayer = 40;
    int outputLayer = 2;
    
    float outputError[2];
    float innerError[40] = {0};
    
    int k, a;
    for(k = 0; k < outputLayer; k++)
    {
        float sum = 0;
        for(a = 0; a < innerLayer; a++)
        {
            sum += firstInnerValues[a] * netWeights[(inputLayer * innerLayer) + (a * outputLayer) + k];
        }
        outputError[k] = (pow(M_E, sum) / pow(pow(M_E, sum) + 1, 2)) * (secondOutputValues[k] - firstOutputValues[k]);
    }
    
    for(k = 0; k < innerLayer; k++)
    {
        float sum = 0;
        for(a = 0; a < inputLayer; a++)
        {
            sum += firstInputValues[a] * netWeights[(a * innerLayer) + k];
        }
        for(a = 0; a < outputLayer; a++)
        {
            innerError[k] += netWeights[(inputLayer * innerLayer) + (k * outputLayer) + a] * outputError[a];
        }
        innerError[k] *= (pow(M_E, sum) / pow(pow(M_E, sum) + 1, 2));
    }
    
    for(k = 0; k < inputLayer; k++)
    {
        for(a = 0; a < innerLayer; a++)
        {
            netWeights[(k * innerLayer) + a] += alpha * firstInputValues[k] * innerError[a];
        }
    }
    
    for(k = 0; k < innerLayer; k++)
    {
        for(a = 0; a < outputLayer; a++)
        {
            netWeights[(inputLayer * innerLayer) + (k * outputLayer) + a] += alpha * firstInnerValues[k] * outputError[a];
        }
    }
}

+(int) checkWin:(int *)gameBoard
{
    int k, a, t;
    //Check for vertical lines
    for(k = 0; k < 12; k++)
    {
        int winX = 0;
        int winY = 0;
        for(a = 0; a < 4; a++)
        {
            if(gameBoard[k*4 + a] == 1)
            {
                winX++;
            }
            else if(gameBoard[k*4 + a] == 2)
            {
                winY++;
            }
            else
            {
                break;
            }
        }
        
        if(winX == 4)
        {
            return 1;
        }
        else if(winY == 4)
        {
            return 2;
        }
    }
    
    //Check for diagonal lines
    for(k = 0; k < 12; k++)
    {
        int winX = 0;
        int winY = 0;
        for(a = 0; a < 4; a++)
        {
            if(gameBoard[((k + a) % 12)*4 + a] == 1)
            {
                winX++;
            }
            else if(gameBoard[((k + a) % 12)*4 + a] == 2)
            {
                winY++;
            }
            else
            {
                break;
            }
        }
        
        if(winX == 4)
        {
            return 1;
        }
        else if(winY == 4)
        {
            return 2;
        }
        
        winX = 0;
        winY = 0;
        
        for(a = 0; a < 4; a++)
        {
            if(gameBoard[((12 + k - a) % 12)*4 + a] == 1)
            {
                winX++;
            }
            else if(gameBoard[((12 + k - a) % 12)*4 + a] == 2)
            {
                winY++;
            }
            else
            {
                break;
            }
        }
        
        if(winX == 4)
        {
            return 1;
        }
        else if(winY == 4)
        {
            return 2;
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
                if(gameBoard[((k + t) % 12)*4 + a] == 1)
                {
                    winX++;
                }
                else if(gameBoard[((k + t) % 12)*4 + a] == 2)
                {
                    winY++;
                }
                else
                {
                    break;
                }
            }
            
            if(winX == 4)
            {
                return 1;
            }
            else if(winY == 4)
            {
                return 2;
            }
        }
    }
    
    return 0;
}

+(BOOL) moveValid:(int *)move :(int *)gameBoard
{
    int x = move[0];
    int y = move[1];
    BOOL update = false;
    
    if (gameBoard[x*4 + y] != 0)
    {
        update = false;
    }
    else
    {
        int i, j;
        for (i = -1; i <= 1; i++)
        {
            for (j = -1; j <= 1; j++)
            {
                if ((x + i) < 0 || (x + i) > 11)
                {
                }
                else if ((y + j) < 0 || (y + j) > 3)
                {
                }
                else if (gameBoard[((x+i) * 4) + (y+j)] != 0)
                {
                    update = true;
                }
            }
        }
        
        if (!update)
        {
            if (x == 0)
            {
                for (i = -1; i <= 1; i++)
                {
                    if ((y + i) < 0 || (y + i) > 3)
                    {
                        
                    }
                    else if (gameBoard[44 + y + i] != 0)
                    {
                        update = true;
                    }
                }
            }
            else if (x == 11)
            {
                for (i = -1; i <= 1; i++)
                {
                    if ((y + i) < 0 || (y + i) > 3)
                    {
                        
                    }
                    else if (gameBoard[y + i] != 0)
                    {
                        update = true;
                    }
                }
            }
        }
    }
    
    return update;
}

+(int *) getAllAvaliableMoves:(int *)board :(int *)size
{
    int newArray[48] = {0};
    int move[2] = {0};
    int totalSize = 0;
    int i;
    for (i = 0; i < 48; i++)
    {
        int x = i / 4;
        int y = i % 4;
        move[0] = x;
        move[1] = y;
        if ([TrainNet moveValid:move :board])
        {
            newArray[i] = 1;
            totalSize++;
        }
    }
    
    int *avaliableMoves = (int *)malloc(sizeof(int) * totalSize);
    int k = 0;
    int j;
    for (j = 0; j < totalSize; j++)
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

int main (int argc, const char * argv[])
{
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
    float alpha1 = atof(argv[1]);
    float alpha2 = atof(argv[2]);
    int netWeightSize = 48 * 40 + 40 * 2;
    float netWeights[netWeightSize];
    int k;
    for(k = 0; k < netWeightSize; k++)
    {
        netWeights[k] = (drand48() * 2) - 1;
    }
    
    
    int games = 5000000;
    for(k = 0; k < games; k++)
    {
        int board[48] = {0};
        board[2] = 1;
        int player = 2;
        int move = 0;
        int done = 0;
        while(done == 0)
        {
            [TrainNet updateInGame:netWeights :board :player :alpha1];
            player++;
            if(player == 3)
            {
                player = 1;
            }
            
            done = [TrainNet checkWin:board];
            
            if(move > 48)
            {
                done = -1;
            }
            move++;
        }
        
        [TrainNet updateAfterGame:netWeights :board :done :alpha2];
    }
    
    printf("{");
    for(k = 0; k < netWeightSize - 1; k++)
    {
        printf("%f,", netWeights[k]);
    }
    printf("%f}", netWeights[netWeightSize - 1]);
    
    return 0;
}
