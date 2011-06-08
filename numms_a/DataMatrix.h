
// Copyright (c) 2011 Ethan Levien
// DataMatrix.h

#import "Consts.h"
#include <stdlib.h>
#include <list>
#include <time.h>

using namespace std;

/*--------------------------------------------------------------
 Programmer: ethan levien
 
 SUMMARY: Encapsulates the game data and logic
 
 todo: - implement recurive algorithm for placing ai pieces
       - level design? possibly add more types of pieces?
       - rexamine how pieces drawn member is kept track of throught
         code
 
 REVISIONS: 
 05/27/2011 (eal) - wrote and implemented class basics
 05/28/2011 (eal) - commented
 06/07/2011 (eal) - score may or maynot be reset when level is changed
                    (stil playing with scoring methods)
                  - ghost piece bug fixed. was using GHEIGHT to check if
                    cells were in grid inside getSum, but actual size of
                    board is GHEIGHT - 1
 06/08/2011 (eal) - replaced the bool draw with a short and altered code accordingly
 ----------------------------------------------------------------*/


struct pieceData {
    short val;
    short type;   // AI, HUMAN, or EMPTY
    short age;    // 0 when created( always before turn)
    short  drawn;  // true if piece has been drawn
};


class DataMatrix{
public:
    
    DataMatrix();
    
   
    bool placePiece_human(short x,short y);
    // PRE: (x,y) is valid position on board
    // POST: returns true of sucessful
  
    void turn( void );
    // PRE: none
    // POST: - ages of none empty cells incremented
    //       - resets expired cells
    
    void resetMatrix( void );
    // PRE: none
    // POST: - all cells are reset
    //       - initial player cell is placed

    
    
    // inlines
    
    // pieces
    inline short val(short x,short y)  { return matrix[x][y].val;   };
    inline short type(short x,short y) { return matrix[x][y].type;  };
    inline short age(short x,short y)  { return matrix[x][y].age;   };
    inline short drawn(short x,short y) { return matrix[x][y].drawn; };
    inline void drawP(short x,short y) { matrix[x][y].drawn = DRAWN; };
    
    // matrix
    inline short score() {return s;};
    inline short level() {return lvl;};
    
    // set
    inline void setLevel(short l) { 
        lvl = l;
       // s = 0;
    };
    
private:
    
    // enternal methods
    
    void placePiece_AI( void );
    // AI plays
    // dependent on ruleset - see rules.rtf
    
    void recursive_AiPlay(short n, short &x,short &y, short &val);
    // not yet implemented
    
    short getSum( short x, short y);
    // PRE: (x,y) is valid position on board
    // POST: returns the sum of all adjacent HUMAN cells
        
    short checkCell_Human (short x,short y);
    // PRE: (x,y) is valid position of board
    // POST: returns 0 if HUMAN can not play here
    //       reutrns cells computed value if can
    
    void insertPiece(short x,short y, short val, short type);
    // PRE: (x,y) is valid position on board, type is valid type and val is valid value for piece
    // POST: the cell (x,y) is initialized to according to args
        
    void resetPiece (short x,short y);
    // PRE: (x,y) is valid position of board
    // POST: cell (x,y) is now empty
    
    
    // data
    pieceData matrix[GWIDTH][GHEIGHT-1];    
    short s;   // total sum
    short lvl; // level
    short ai_count;
    
    short ruleSet;
};