//
//  NVViewController.m
//  2048
//
//  Created by damon.zhu on 14-5-13.
//  Copyright (c) 2014年 HZCreative. All rights reserved.
//

#import "NVViewController.h"
#import "NVPoint.h"

@interface NVViewController ()<UIPickerViewDataSource, UIPickerViewDelegate>
@end

@implementation NVViewController {
    NV2048Model *_model;
    int _maxScore;
    int _selectedMode;
    
    NSArray *mode;
    NSArray *color;
    NSArray *content;
    NSArray *font;
    
    UIColor *colorNum;
}

-(void) ainimateNVPoint:(NVPoint*)point{
     UILabel *label = self.labelContainer.subviews[point.x * 4 + point.y];
    
    label.transform = CGAffineTransformMakeScale(0.9, 0.9);
    
    [UIView animateWithDuration:0.3 delay:0.0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        label.transform = CGAffineTransformMakeScale(1.2, 1.2);
    } completion:^(BOOL finished) {
        if (finished) {
            label.transform = CGAffineTransformMakeScale(1.0, 1.0);
        }
    }];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        _model = [[NV2048Model alloc] init];
        _model.delegate = self;
        _maxScore = 0;
        _selectedMode = 0;
        color = [[NSArray alloc]initWithObjects:
                 [UIColor colorWithRed:204.0/255.0 green:192.0/255.0 blue:179.0/255.0 alpha:1.0],
                 [UIColor colorWithRed:238.0/255.0 green:228.0/255.0 blue:218.0/255.0 alpha:1.0],
                 [UIColor colorWithRed:237.0/255.0 green:224.0/255.0 blue:200.0/255.0 alpha:1.0],
                 [UIColor colorWithRed:242.0/255.0 green:177.0/255.0 blue:121.0/255.0 alpha:1.0],
                 [UIColor colorWithRed:245.0/255.0 green:149.0/255.0 blue:99.0/255.0 alpha:1.0],
                 [UIColor colorWithRed:246.0/255.0 green:124.0/255.0 blue:98.0/255.0 alpha:1.0],
                 [UIColor colorWithRed:246.0/255.0 green:94.0/255.0 blue:59.0/255.0 alpha:1.0],
                 [UIColor colorWithRed:237.0/255.0 green:207.0/255.0 blue:114.0/255.0 alpha:1.0],
                 [UIColor colorWithRed:237.0/255.0 green:204.0/255.0 blue:97.0/255.0 alpha:1.0],
                 [UIColor colorWithRed:237.0/255.0 green:200.0/255.0 blue:95.0/255.0 alpha:1.0],
                 [UIColor colorWithRed:237.0/255.0 green:195.0/255.0 blue:90.0/255.0 alpha:1.0],
                 [UIColor colorWithRed:237.0/255.0 green:190.0/255.0 blue:85.0/255.0 alpha:1.0],nil];
        
        font = [[NSArray alloc]initWithObjects:[UIFont fontWithName:@"Arial-BoldMT" size:25.0],
                [UIFont fontWithName:@"Arial-BoldMT" size:30.0],
                [UIFont fontWithName:@"Arial-BoldMT" size:20.0],[UIFont fontWithName:@"Arial-BoldMT" size:15.0],nil];
        colorNum = [UIColor colorWithRed:119.0/255.0 green:110.0/255.0 blue:101.0/255.0 alpha:1.0];
        self.labelContainer.layer.cornerRadius = 5;
        self.scoreLabel.layer.cornerRadius = 5;
        self.bestScoreLabel.layer.cornerRadius = 5;
        
        mode = [[NSArray alloc]initWithObjects:@"程序猿成长之路",@"2048",@"斗地主", nil];//@"节操掉了"
        content = [[NSArray alloc]initWithObjects:
                   [[NSArray alloc]initWithObjects:@"码畜",@"码奴",@"码农",@"码工",@"码管",@"码帅",@"码皇",@"码妖",@"码魔",@"码仙",@"码神",nil],
                   [[NSArray alloc]initWithObjects:@"2",@"4",@"8",@"16",@"32",@"64",@"128",@"256",@"512",@"1024",@"2048",@"4096",nil],
                   [[NSArray alloc]initWithObjects:@"包身工",@"短工",@"长工",@"佃户",@"贫农",@"渔夫",@"中农",@"富农",@"掌柜",@"商人",@"财主",@"知县",@"知府",@"总督",@"巡抚",@"丞相",@"帝王",nil],
                   [[NSArray alloc]initWithObjects:@"1次几秒",@"1次半天",@"1晚几次",@"1晚1次",@"半天1次",@"1天一次",@"1周几次",@"1周1次",@"1月1次",@"半年几次",@"1年1次",@"老了",@"不中用了",nil],
                   nil];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self loadData];
    for (int i = 0 ; i < 4 ; i++)
    {
        // 创建手势处理器，指定使用该控制器的handleSwipe:方法处理轻扫手势
        UISwipeGestureRecognizer* gesture = [[UISwipeGestureRecognizer alloc]
                                             initWithTarget:self action:@selector(handleSwipeAction:)];
        // 设置该手势处理器只处理i 个手指的轻扫手势
        gesture.numberOfTouchesRequired = 1;
        // 指定该手势处理器只处理1 << i 方向的轻扫手势
        gesture.direction = 1 << i;
        // 为gv 控件添加手势处理器  
        [self.view addGestureRecognizer:gesture];
    }
    
    [self refresh];
}

-(void) refresh{
    NSMutableArray *array = [_model getArrays];
    for(int i = 0; i < 4; i++){
        for (int j = 0; j < 4; j++) {
            UILabel *label = self.labelContainer.subviews[i * 4 + j];
            [label setFont:font[_selectedMode]];
            label.layer.cornerRadius = 3;
            
            int num = [[[array objectAtIndex:i]objectAtIndex:j] intValue];
            
            int index = @(log2(num)).intValue;
            if (index > 0 && index <= 11) {
                label.text = content[_selectedMode][index -1 ];
            }else if(index > 11){
                label.text = content[_selectedMode][10];
            }
            
            if (num > 4) {
                label.textColor = [UIColor whiteColor];
            }else{
                label.textColor = colorNum;
            }
            
            if (num > 0) {
                label.backgroundColor = color[index];
            }else{
                label.backgroundColor = color[0];
                label.text = @"";
            }
        }
    }
    
    self.scoreLabel.text = [NSString stringWithFormat:@"%i", [_model getScore]];
    self.bestScoreLabel.text = [NSString stringWithFormat:@"%i",_maxScore];
}

- (void) handleSwipeAction:(UISwipeGestureRecognizer*)gesture{
    NSUInteger direction = gesture.direction;
    // 根据手势方向的值得到方向字符串
    if ([_model canMove]) {
        if (direction == UISwipeGestureRecognizerDirectionDown) {
            if ( [_model canMoveDown]) {
                [_model moveDown];
                [self generatePoint];
            }
        }else if(direction == UISwipeGestureRecognizerDirectionLeft){
            if ([_model canMoveLeft]) {
                [_model moveLeft];
                [self generatePoint];
            }
        }else if(direction == UISwipeGestureRecognizerDirectionRight){
            if ([_model canMoveRight]) {
                [_model moveRight];
                [self generatePoint];
            }
        }else{
            if ([_model canMoveUp]) {
                [_model moveUp];
                [self generatePoint];
            }
        }
        
        [self saveData];
        [self refresh];
    }else{
        [self showOkayCancelAlert];
    }
}

-(void) generatePoint{
    NVPoint *point = [_model randomGeneratePoint];
    if (point) {
        UILabel *label = self.labelContainer.subviews[point.x * 4 + point.y];
        [UIView beginAnimations:@"Curl"context:nil];//动画开始
        [UIView setAnimationDuration:0.5];//动画持续时间
        [UIView setAnimationTransition: UIViewAnimationTransitionFlipFromLeft//类型
                               forView:label
                                 cache:YES];
        [UIView commitAnimations];
    }
}

// Show an alert with an "Okay" and "Cancel" button.
- (void)showOkayCancelAlert {
    NSString *title = NSLocalizedString(@"Game Over", nil);
    NSString *message = NSLocalizedString(@"", nil);
    NSString *cancelButtonTitle = NSLocalizedString(@"Cancel", nil);
    NSString *otherButtonTitle = NSLocalizedString(@"Try Again", nil);
    
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:message delegate:self cancelButtonTitle:cancelButtonTitle otherButtonTitles:otherButtonTitle, nil];
    
	[alert show];
}

// 读取数据
- (void)loadData {
    _maxScore = [[NSUserDefaults standardUserDefaults] integerForKey:@"score"];
}

// 保存数据
- (void)saveData {
    if ([_model getScore] > _maxScore) {
        _maxScore = [_model getScore];
    }
    [[NSUserDefaults standardUserDefaults] setInteger:_maxScore forKey:@"maxScore"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)touchAction:(id)sender {
    NVPoint *point = [_model randomGeneratePoint];
    
    NSLog(@"%d,%d,%d",point.x,point.y,point.num);
    
}
- (IBAction)newGameAction:(id)sender {
    _model = [[NV2048Model alloc]init];
    [self refresh];
}

#pragma mark - UIPickerViewDataSource

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return [mode count];
}


#pragma mark - UIPickerViewDelegate

- (NSString *)pickerView:(UIPickerView *)thePickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    self.titleLabel.text = mode[row];
    return mode[row];
}


- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    _selectedMode = row;
}
@end
