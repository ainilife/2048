//
//  NV2048Model.h
//  2048
//
//  Created by damon.zhu on 14-5-13.
//  Copyright (c) 2014年 HZCreative. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NVPoint.h"

@protocol NV2048Delegate <NSObject>
-(void) ainimateNVPoint:(NVPoint*)point;
@end

@interface NV2048Model : NSObject

@property (weak) id <NV2048Delegate> delegate;

-(void) moveUp;

-(void) moveDown;

-(void) moveLeft;

-(void) moveRight;

-(BOOL) canMoveUp;

-(BOOL) canMoveDown;

-(BOOL) canMoveLeft;

-(BOOL) canMoveRight;

-(BOOL) canMove;

-(NVPoint*) randomGeneratePoint;

-(NSMutableArray*) getArrays;

-(int)getScore;

@end
