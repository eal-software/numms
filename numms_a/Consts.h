// Copyright (c) 2011 Ethan Levien
// Consts.h

#ifndef CONSTANTS
#define CONSTANTS


#pragma mark -
#pragma mark game

// game constants
// ----------------------------------------------------

// grid
#define GHEIGHT                6
#define GWIDTH                 4

// piece types
#define HUMAN                  1
#define AI                     2
#define EMPTY                  0

// piece states
#define DRAWN                  0
#define BORN                   1
#define CAPTURED               2
#define DIED                   3

// gameplay
#define LIFESPAN               3
#define MAX_LVL                300
#define LVL_TIME               30
#define LVL_SPEED              1.0f

// rule sets
#define RULE_SET_1a            1
#define RULE_SET_1b            2
#define RULE_SET_1c            3
#define RULE_SET_2             4
#define RULE_SET_3             5

#pragma mark -
#pragma mark graphics

// graphics constants
// ----------------------------------------------------
// fonts
#define MENU_FONT              @"ArnoPro-New.otf"
#define STATS_FONT             @"ArnoPro-New.otf"
#define HUD_FONT               @"ArnoPro-New.otf"
#define PIECE_FONT             @"ArnoPro-New.otf"

// text
#define BACK_TEXT              @"Back"

// size and color
#define NAV_BUTTON_SIZE        40
#define STATS_DISP_SIZE        40
#define BUTTON_OPACITY         170


// animation
#define SCENE_TRANS_TIME       0.4f

// sprites
#define PLAYER_PIECE_SPRITE           @"piece_player.png"
#define AI_PIECE_SPRITE               @"piece_ai.png"
#define BACKGROUND_GAME               @"background_game.png"
#define BACKGROUND_HELLO              @"background_hello.png"
#define RULES_SPRITE                  @"bg_rules3.png"

#pragma mark -
#pragma mark data

// data constants
// ----------------------------------------------------
#define STATSDATA_FILE @"StatsData.plist"
#define MAX_SCORES 21
#define SCORE_FIELDS 3


#endif