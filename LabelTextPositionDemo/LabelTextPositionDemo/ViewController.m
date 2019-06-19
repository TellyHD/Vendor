//
//  ViewController.m
//  LabelTextPositionDemo
//
//  Created by Kystar on 2019/6/18.
//  Copyright © 2019 kystar. All rights reserved.
//

#import "ViewController.h"

#import "TYCustomAlignmentLabel.h"




@interface ViewController () {
    TYTextAlignment _horAlignment;
    TYTextAlignment _verAlignment;
    TYTextAlignment _combinAlignment;
}

@property (weak, nonatomic) IBOutlet TYCustomAlignmentLabel *alignLabel;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *horAlignButtonArray;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *verAlignButtonArray;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //halign: 1   4   2
    //valign: 32  128 64
    
    _horAlignment = TYTextAlignmentHorLeft;
    _verAlignment = TYTextAlignmentVerTop;
    
    _combinAlignment = _horAlignment | _verAlignment;
    
    [self pt_updateHorAlignButtonSelectedState];
    [self pt_updateVerAlignButtonSelectedState];
    
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self pt_updateTextLabelDisplay];
}

- (IBAction)pt_clickHorAlignButtonAction:(UIButton *)sender {
    if (sender.selected == NO) {
        sender.selected = YES;
        NSInteger bitsLeftMoved = sender.tag;
        _horAlignment = 1 << bitsLeftMoved;
        
        [self pt_updateHorAlignButtonSelectedState];
        
        [self pt_updateTextLabelDisplay];
    }
    
    
}

- (IBAction)pt_clickVerAlignButtonAction:(UIButton *)sender {
    
    if (sender.selected == NO) {
        sender.selected = YES;
        NSInteger bitsLeftMoved = sender.tag;
        _verAlignment = 1 << bitsLeftMoved;
        
        [self pt_updateVerAlignButtonSelectedState];
        
        [self pt_updateTextLabelDisplay];
        
    }
    
}

- (void)pt_updateTextLabelDisplay {
    _combinAlignment = _horAlignment | _verAlignment;
    
    self.alignLabel.customAlignment = _combinAlignment;
    
}

- (void)pt_updateHorAlignButtonSelectedState {
    NSInteger bitMoved = log2(_horAlignment);
    for (UIButton *tempButton in self.horAlignButtonArray) {
        if (tempButton.tag != bitMoved) {
            tempButton.selected = NO;
        }
        else {
            tempButton.selected = YES;
        }
    }
}

- (void)pt_updateVerAlignButtonSelectedState {
    NSInteger bitMoved = log2(_verAlignment);
    for (UIButton *tempButton in self.verAlignButtonArray) {
        if (tempButton.tag != bitMoved) {
            tempButton.selected = NO;
        }
        else {
            tempButton.selected = YES;
        }
    }
}




@end
