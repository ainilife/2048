//
//  NVViewController.h
//  2048
//
//  Created by damon.zhu on 14-5-13.
//  Copyright (c) 2014年 HZCreative. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NV2048Model.h"

@interface NVViewController : UIViewController<NV2048Delegate>
@property (weak, nonatomic) IBOutlet UIView *labelContainer;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UIPickerView *pickView;
@property (weak, nonatomic) IBOutlet UILabel *bestScoreLabel;
- (IBAction)newGameAction:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end
