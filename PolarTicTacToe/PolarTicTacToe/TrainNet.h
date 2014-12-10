#import <Foundation/Foundation.h>

@interface TrainNet : NSObject

+(void) updateInGame:(float *)netWeights :(int *)gameBoard :(int)team :(float)alpha;
+(void) updateAfterGame:(float *)netWeights :(int *)gameBoard :(int)winner :(float)alpha;
+(void) evaluate:(float *)netWeights :(int *)gameBoard :(float *)inputValues :(float *)innerValues :(float *)outputValues;
+(void) backProp:(float *)netWeights :(float *)firstInputValues :(float *)firstInnerValues :(float *)firstOutputValues :(float *)secondOutputValues :(float)alpha;
+(int) checkWin:(int *)gameBoard;
+(BOOL) moveValid:(int *)move :(int *)gameBoard;
+(int *) getAllAvaliableMoves:(int *)board :(int *)size;

@end
