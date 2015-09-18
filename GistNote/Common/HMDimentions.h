//
//  HMDimentions.h
//  GistNotes
//
//  Created on 26/02/15.
//  Copyright (c) 2015  . All rights reserved.
//

#import <Foundation/Foundation.h>

#define APP_COLOR 0xf8b715

//==================
// Navigation bar
//==================
extern CGFloat NAV_BAR_HEIGHT;
extern CGFloat NAV_BAR_WIDTH;
extern CGFloat STATUS_BAR_HEIGHT;



//=========================
// Table cell height
//=========================
extern CGFloat TBL_CELL_HEIGHT;

extern CGFloat TBL_SEGMENT_BAR_HEADER;

//==========
// Font
//==========
#define FONT_NAME           @"HelveticaNeue"
#define FONT_NAME_LIGHT     @"HelveticaNeue-Light"
#define FONT_NAME_BOLD      @"HelveticaNeue-Bold"

#define FONT_SMALL_LIGHT    [UIFont fontWithName:FONT_NAME_LIGHT size:12]
#define FONT_SMALL          [UIFont fontWithName:FONT_NAME size:12]

#define FONT_LIGHT          [UIFont fontWithName:FONT_NAME_LIGHT size:14]
#define FONT_NORMAL         [UIFont fontWithName:FONT_NAME size:14]


@interface HMDimentions : NSObject

@end
