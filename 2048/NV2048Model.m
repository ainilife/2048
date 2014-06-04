//
//  NV2048Model.m
//  2048
//
//  Created by damon.zhu on 14-5-13.
//  Copyright (c) 2014年 HZCreative. All rights reserved.
//

#import "NV2048Model.h"
#import "NVPoint.h"


@implementation NV2048Model{
    NSMutableArray *_array;
    int _score;
}

-(id) init{
    _array = [[NSMutableArray alloc]init];
    _score = 0;
    
    for (int i  = 0 ; i < 4; i++) {
        NSMutableArray *row = [NSMutableArray arrayWithObjects:@0,@0,@0,@0,nil];
        
        [_array addObject:row];
    }
    
    NVPoint *point1 = [self randomGeneratePoint];
    NVPoint *point2 = [self randomGeneratePoint];

    NSNumber *num1 = [[NSNumber alloc]initWithInt:point1.num];
    _array[point1.x][point1.y] = num1;
    
    
    NSNumber *num2 = [[NSNumber alloc] initWithInt:point2.num];
    _array[point2.x][point2.y] = num2;
    
    
    return self;
}

-(void) moveUp{
    for (int i = 0; i < 4; i++) {
        int p1 = 0;
        
        for(int j = 1 ; j < 4; j++){
            if ([_array[p1][i] intValue] > 0) {
                if ([_array[j][i] intValue] > 0) {
                    if ([_array[p1][i] intValue] == [_array[j][i] intValue]) {
                        _score += [_array[p1][i] intValue] * 2;
                        _array[p1][i] = [[NSNumber alloc]initWithInt:[_array[p1][i] intValue] * 2];
                        _array[j][i] = [[NSNumber alloc]initWithInt:0];
                        
                        NVPoint *point = [[NVPoint alloc]initWithX:p1 withY:i];
                        
                        [self.delegate ainimateNVPoint:point];
                        p1++;
                    }else{
                        p1++;
                        if (p1 != j) {
                            _array[p1][i] = [[NSNumber alloc]initWithInt:[_array[j][i] intValue]];
                            _array[j][i] = [[NSNumber alloc]initWithInt:0];
                        }
                    }
                }
            }else{
                if ([_array[j][i] intValue] > 0) {
                    _array[p1][i] = _array[j][i];
                    _array[j][i] = [[NSNumber alloc]initWithInt:0];
                }
            }
        }
    }
}

-(void) moveDown{
    for (int i = 0; i < 4; i++) {
        int p1 = 3;
        
        for(int j = 2 ; j >= 0; j--){
            if ([_array[p1][i] intValue] > 0) {
                if ([_array[j][i] intValue] > 0) {
                    if ([_array[p1][i] intValue] == [_array[j][i] intValue]) {
                        _score += [_array[p1][i] intValue] * 2;
                        _array[p1][i] = [[NSNumber alloc]initWithInt:[_array[p1][i] intValue] * 2];
                        _array[j][i] = [[NSNumber alloc]initWithInt:0];
                        
                        NVPoint *point = [[NVPoint alloc]initWithX:p1 withY:i];
                        
                        [self.delegate ainimateNVPoint:point];
                        p1--;
                    }else{
                        p1--;
                        if (p1 != j) {
                            _array[p1][i] = [[NSNumber alloc]initWithInt:[_array[j][i] intValue]];
                            _array[j][i] = [[NSNumber alloc]initWithInt:0];
                        }
                    }
                }
            }else{
                if ([_array[j][i] intValue] > 0) {
                    _array[p1][i] = _array[j][i];
                    _array[j][i] = [[NSNumber alloc]initWithInt:0];
                }
            }
        }
    }
}

-(void) moveLeft{
    for (int i = 0; i < 4; i++) {
        int p1 = 0;
        
        for(int j = 1 ; j < 4;j++){
            if ([_array[i][p1] intValue] > 0) {
                if ([_array[i][j] intValue] > 0) {
                    if ([_array[i][p1] intValue] == [_array[i][j] intValue]) {
                        _score += [_array[i][p1] intValue] * 2;
                        _array[i][p1] = [[NSNumber alloc]initWithInt:[_array[i][p1] intValue] * 2];
                        _array[i][j] = [[NSNumber alloc]initWithInt:0];
                        
                        NVPoint *point = [[NVPoint alloc]initWithX:i withY:p1];
                        
                        [self.delegate ainimateNVPoint:point];
                        p1++;
                    }else{
                        p1++;
                        if (p1 != j) {
                            _array[i][p1] = [[NSNumber alloc]initWithInt:[_array[i][j] intValue]];
                            _array[i][j] = [[NSNumber alloc]initWithInt:0];
                        }
                    }
                }
            }else{
                if ([_array[i][j] intValue] > 0) {
                    _array[i][p1] = _array[i][j];
                    _array[i][j] = [[NSNumber alloc]initWithInt:0];
                }
            }
        }
    }
}

-(void) moveRight{
    for (int i = 0; i < 4; i++) {
        int p1 = 3;
        
        for(int j = 2 ; j >=0 ; j--){
            if ([_array[i][p1] intValue] > 0) {
                if ([_array[i][j] intValue] > 0) {
                    if ([_array[i][p1] intValue] == [_array[i][j] intValue]) {
                        _score += [_array[i][p1] intValue] * 2;
                        _array[i][p1] = [[NSNumber alloc]initWithInt:[_array[i][p1] intValue] * 2];
                        _array[i][j] = [[NSNumber alloc]initWithInt:0];
                        
                        NVPoint *point = [[NVPoint alloc]initWithX:i withY:p1];
                        
                        [self.delegate ainimateNVPoint:point];
                        p1--;
                    }else{
                        p1--;
                        if (p1 != j) {
                            _array[i][p1] = [[NSNumber alloc]initWithInt:[_array[i][j] intValue]];
                            _array[i][j] = [[NSNumber alloc]initWithInt:0];
                        }
                    }
                }
            }else{
                if ([_array[i][j] intValue] > 0) {
                    _array[i][p1] = _array[i][j];
                    _array[i][j] = [[NSNumber alloc]initWithInt:0];
                }
            }
        }
    }
}

-(BOOL) canMoveUp{
    for (int i = 0; i < 4; i++) {
        int p1 = 0;
        
        for(int j = 1 ; j < 4; j++){
            if ([_array[p1][i] intValue] > 0) {
                if ([_array[j][i] intValue] > 0) {
                    if ([_array[p1][i] intValue] == [_array[j][i] intValue]) {
                        return YES;
                    }else{
                        p1++;
                        if (p1 != j) {
                            return YES;
                        }
                    }
                }
            }else{
                if ([_array[j][i] intValue] > 0) {
                    return YES;
                }
            }
        }
    }
    
    return FALSE;
}

-(BOOL) canMoveDown{
    for (int i = 0; i < 4; i++) {
        int p1 = 3;
        
        for(int j = 2 ; j >= 0; j--){
            if ([_array[p1][i] intValue] > 0) {
                if ([_array[j][i] intValue] > 0) {
                    if ([_array[p1][i] intValue] == [_array[j][i] intValue]) {
                        return YES;
                    }else{
                        p1--;
                        if (p1 != j) {
                            return YES;
                        }
                    }
                }
            }else{
                if ([_array[j][i] intValue] > 0) {
                    return YES;
                }
            }
        }
    }
    
    return FALSE;
}

-(BOOL) canMoveLeft{
    for (int i = 0; i < 4; i++) {
        int p1 = 0;
        for(int j = 1 ; j < 4;j++){
            if ([_array[i][p1] intValue] > 0) {
                if ([_array[i][j] intValue] > 0) {
                    if ([_array[i][p1] intValue] == [_array[i][j] intValue]) {
                        return YES;
                    }else{
                        p1++;
                        if (p1 != j) {
                            return YES;
                        }
                    }
                }
            }else{
                if ([_array[i][j] intValue] > 0) {
                    return YES;
                }
            }
        }
    }
    
    return FALSE;
}

-(BOOL) canMoveRight{
    for (int i = 0; i < 4; i++) {
        int p1 = 3;
        
        for(int j = 2 ; j >=0 ; j--){
            if ([_array[i][p1] intValue] > 0) {
                if ([_array[i][j] intValue] > 0) {
                    if ([_array[i][p1] intValue] == [_array[i][j] intValue]) {
                        return YES;
                    }else{
                        p1--;
                        if (p1 != j) {
                            return YES;
                        }
                    }
                }
            }else{
                if ([_array[i][j] intValue] > 0) {
                    return YES;
                }
            }
        }
    }
    
    return FALSE;
}

-(BOOL) canMove{
    return [self canMoveUp] || [self canMoveDown] || [self canMoveLeft] || [self canMoveRight];
}

-(NVPoint*) randomGeneratePoint{
    int index = arc4random() % 16;
    int num = arc4random() % 2 + 1;
    
    while (index >= 0) {
        for (int i = 0; i < 4; i++) {
            for(int j = 0; j < 4 ; j++){
                NSNumber *integer = _array[i][j];
                
                if([integer intValue] == 0){
                    if(index == 0){
                        NVPoint *point = [[NVPoint alloc] init];
                        
                        point.x = i;
                        point.y = j;
                        point.num = num * 2;
                        
                        NSNumber *num = [[NSNumber alloc]initWithInt:point.num];
                        _array[point.x][point.y] = num;
                        return point;
                    }else{
                        index--;
                    }
                }
            }
        }
    }
    
    return nil;
}

-(NSMutableArray*) getArrays{
    return _array;
}

-(int)getScore{
    return _score;
}

@end
