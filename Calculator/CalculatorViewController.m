//
//  CalculatorViewController.m
//  Calculator
//
//  Created by Sabbir Ahmed on 10/28/16.
//  Copyright © 2016 Sabbir Ahmed. All rights reserved.
//

#import "CalculatorViewController.h"
#import "Calculator.h"


@interface CalculatorViewController (){
    
    __weak IBOutlet UILabel *outputLabel;
    
    BOOL isTypingNumber, isDecimalPressed;
}

@property (nonatomic) double displayValue;

@property (nonatomic, strong) Calculator *calculator;

@end

@implementation CalculatorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _calculator = [[Calculator alloc] init];
   
}

-(double)displayValue {
    return [outputLabel.text doubleValue];
}

-(void)setDisplayValue:(double)displayValue {
    if (displayValue == (long int)displayValue) {
        outputLabel.text = [NSString stringWithFormat:@"%ld", (long int)displayValue];
    }
    else
        outputLabel.text = [NSString stringWithFormat:@"%g", displayValue];
}

#pragma mark - User Actions

- (IBAction)numberPressed:(UIButton *)sender {
    NSString *digit = sender.currentTitle;
    
    if ([digit isEqual:@"."]) {
        if (isTypingNumber == NO) {
            outputLabel.text = @"0.";
        }else if (isDecimalPressed == NO){
            outputLabel.text = [NSString stringWithFormat:@"%@%@", outputLabel.text, digit];
        }
        isDecimalPressed = YES;
    }else if (isTypingNumber == YES && [outputLabel.text isEqual:@"0"] == NO){
        outputLabel.text = [NSString stringWithFormat:@"%@%@", outputLabel.text, digit];
    }else{
        outputLabel.text = digit;
    }
    isTypingNumber = YES;
}

- (IBAction)performOperation:(UIButton *)sender {
    if (isTypingNumber == YES) {
        [_calculator setOperand:self.displayValue];
        isTypingNumber = NO;
        isDecimalPressed = NO;
    }
    
    if (sender.currentTitle != nil && sender.currentTitle.length > 0) {
        [_calculator performOperation:sender.currentTitle];
    }
    
    self.displayValue = _calculator.result;
}


@end
