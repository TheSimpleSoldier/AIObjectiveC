How to Run:
	1. download client from github: $ git clone https://github.com/fredkneeland/AIObjectiveC.git
	2. Install latest version of Xcode (we have run it on OS X Maverics and Yosemite don't know about earlier versions
	3. open PolarTicTacToe.xcodeproj with xcode and run it natively as OS X app

How to Train Neural Net:


What we did:
	This application is the polar tic-tac-toe game created in objective c for CSCI 446 at Montana State University.  In this program we implemented strict min-max, alpha-beta, and nearest-neighbor search techniques.  We also implemented several different heuristic functions with a basic heuristic, a classifier using a decision tree, and a neural net.  We created a training program for the neural net which used 40 internal nodes and trained on 5 million matches using back propogation to improve to the point of being capable of consistently defeating college students.  

Where it is all at:
	All of the UI is contained inside of the rootViewController files (.h, .m, .xib), The HeuristicFunctions files (.h, .m) contain the 3 different heuristic functions.  The different search methods are inside of the search files (.h, .m).  The training of the neural net takes place inside of the TrainNet files (.h, .m)

