
// Copyright (c) 2011 Ethan Levien

#import "Consts.h"
#include "GameAI.h"
#include <stdlib.h>
#include <list>
#include <time.h>

using namespace std;

/*--------------------------------------------------------------
 Programmer: ethan levien
 
 SUMMARY: Encapsulates the game data
 
 todo: - implement recurive algorithm for placing ai pieces
       - level design? possibly add more types of pieces?
       - BUG: ghost pieces (often around the edges) , may be problem w/ board)
 
 REVISIONS: 
 05/27/2011 (eal) - wrote and implemented class basics
 05/28/2011 (eal) - commented
 ----------------------------------------------------------------*/


struct pieceData {
    short val;
    short type;   // AI, HUMAN, or EMPTY
    short age;    // 0 when created( always before turn)
    bool  drawn;  // true if piece has been drawn
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
    inline bool drawn(short x,short y) { return matrix[x][y].drawn; };
    inline void drawP(short x,short y) { matrix[x][y].drawn = true; };
    
    // matrix
    inline short score() {return s;};
    inline short level() {return lvl;};
    
    // set
    inline void setLevel(short l) { lvl = l; };
    
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