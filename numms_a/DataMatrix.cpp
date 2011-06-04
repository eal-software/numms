
// Copyright (c) 2011 Ethan Levien

#include "DataMatrix.h"

#pragma mark -
#pragma mark public


// ----------------------------------------------------
DataMatrix::DataMatrix(){
    srand(time(NULL));
    ai_count = 0;
    resetMatrix();
    s = 0;
    lvl = 0;
} // end ctor


// ----------------------------------------------------

bool DataMatrix::placePiece_human(short x,short y){
    short sum;
    if ((sum = checkCell_Human(x,y)) != 0) {
        if (matrix[x][y].type == AI){
            s = s + sum;
            ai_count--;
        }
        insertPiece(x,y, sum, HUMAN);        
        return true;
    } else {
        return false;
    } // end else
    
} // end placePiece_human

// ----------------------------------------------------

void DataMatrix::turn( void ){
    
    
    
    placePiece_AI();
    
    // iterate the age and delete inactive pieces
    for (int i = 0; i < GWIDTH; i++) {
        for (int j = 0; j < GHEIGHT-1; j++) {
            if (matrix[i][j].type == HUMAN) {
                matrix[i][j].age++;
                if ( matrix[i][j].age  > LIFESPAN) {
                    resetPiece(i, j);
                }
            }else if(matrix[i][j].type == AI){
                matrix[i][j].age++;
                if ( matrix[i][j].age  > LIFESPAN && ai_count > LIFESPAN) {
                    resetPiece(i, j);
                }
            }
            
        } // end for
    } // end for
    
    s--;
    
} // end update

// ----------------------------------------------------

void DataMatrix::resetMatrix( void ){
    for (int i = 0; i < GWIDTH; i++) {
        for (int j = 0; j < GHEIGHT-1; j++) {
            resetPiece(i, j);
            matrix[i][j].drawn = true;
        } // end for
    } // end for
    
    // add first player cell
    short xInit, yInit;
    xInit = GWIDTH-1;
    yInit = GHEIGHT-2;
    insertPiece(xInit, yInit, 9, HUMAN);
    
    turn();
    
} // end reset




#pragma mark -
#pragma mark private

// ----------------------------------------------------

void DataMatrix::placePiece_AI( void ){
   
    ruleSet = RULE_SET_1c;
    switch (ruleSet) {
        
        // RULE SET 1a
        // ----------------------------------------------------
        case RULE_SET_1a:
        { 
            short x, y, val;
            x = rand()%GWIDTH;
            y = rand()%(GHEIGHT-1);
            val = rand()%9+1;
            
            while (matrix[x][y].type != EMPTY) {
                x = rand()%GWIDTH;
                y = rand()%(GHEIGHT-1);
            }
            
            insertPiece(x, y, val, AI);
        }
        break;
        
        // RULE SET 1b
        // ----------------------------------------------------
        case RULE_SET_1b:
        { 
            short x, y, val;
            
            // find the first palyer piece to use
            for (int i = 0; i < GWIDTH; i++) {
                for (int j = 0; j < GHEIGHT; j++) {
                    if (matrix[i][j].type == HUMAN) {
                        x = i;
                        y = j;
                    }
                }
            }
    
            recursive_AiPlay(rand()%LIFESPAN+1, x, y, val);
            insertPiece(x, y, val, AI);
        }
        break;
       
        // RULE SET 1c
        // ----------------------------------------------------
        case RULE_SET_1c:
        { 
            if (ai_count < LIFESPAN) {
                short x, y, val;
                x = rand()%GWIDTH;
                y = rand()%(GHEIGHT-1);
                val = rand()%9+1;
                
                while (matrix[x][y].type != EMPTY) {
                    x = rand()%GWIDTH;
                    y = rand()%(GHEIGHT-1);
                }
                
                insertPiece(x, y, val, AI);
                ai_count++;
            }
           
        }
        break;
            
    }
    
   //recursive_AiPlay(n,x,y,val);

    
} // end placePiece_AI

// ----------------------------------------------------

void DataMatrix::recursive_AiPlay(short n, short &x,short &y, short &val){
  
    
    if ( n < 0) {
        val = matrix[x][y].val;
    }else{
        
        // to store the okayed coordinates
        list<short> xChecks;
        list<short> yChecks;
        
        short xChck, yChck;  // to store the played coords
        
        // fill lists with (x,y) coords that are okay
        for (int i = x-1; i <= x+1; i++) {
            for (int j = y-1; j <= y+1; j++) {
                if ( ( i != x || j != y) &&
                    ( i < GWIDTH && j < GHEIGHT) &&( i >= 0 && j >= 0)) {
                    if(placePiece_human(i, j)){
                        xChecks.push_front(i);
                        yChecks.push_front(j);
                        resetPiece(i, j);
                        matrix[i][j].drawn = true;
                    }
                }else{
                   //bad cell
                }
            }
        }
    
        // select a (x,y) pair from the lists
        for (int i = 0; i < xChecks.size(); i++) {
            xChck = xChecks.front();
            yChck = yChecks.front();
            xChecks.pop_front();
            yChecks.pop_front();
        }
        
        // 
        x = xChck;
        y = yChck;
        
        // place the piece
        placePiece_human(xChck, yChck);
        
        // and agian ...
        recursive_AiPlay(n-1, x, y, val);
        
        // reset the human piece played once back out
        resetPiece(xChck, yChck);
        matrix[xChck][yChck].drawn = true;
    }

} // end recursive_AiPlay

// ----------------------------------------------------

short DataMatrix::getSum( short x, short y){
    
    short sum = 0;
    
    for (int i = x-1; i <= x+1; i++) {
        for (int j = y-1; j <= y+1; j++) {
            if ( ( i != x || j != y) && matrix[i][j].type == HUMAN && 
                ( i < GWIDTH && j < GHEIGHT) &&( i >= 0 && j >= 0)) {
                sum = sum + matrix[i][j].val;
            }
        }
    }
    return sum%10;
    
} // end getSum

// ----------------------------------------------------

short DataMatrix::checkCell_Human (short x,short y){
    
    if ( matrix[x][y].type == HUMAN){
        return 0;
    } else {
        short val = getSum(x, y);
        if (matrix[x][y].type == AI) {
            return val >= matrix[x][y].val ? matrix[x][y].val : 0;
        }else{
            return val;
        }
    }

} // end checkCell_Human


// ----------------------------------------------------
void DataMatrix::insertPiece(short x,short y, short val, short type){
    matrix[x][y].val = val;
    matrix[x][y].age = 0;
    matrix[x][y].type = type;
    matrix[x][y].drawn = false;
} // end insertPiece

// ----------------------------------------------------
void DataMatrix::resetPiece ( short x,short y ){
    matrix[x][y].val = -1;
    matrix[x][y].type = EMPTY;
    matrix[x][y].age = -1;
    matrix[x][y].drawn = false;
} // end resetPiece


