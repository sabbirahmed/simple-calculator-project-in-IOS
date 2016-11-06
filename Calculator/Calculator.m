//
//  Calculator.m
//  Calculator
//
//  Created by Sabbir Ahmed on 11/6/16.
//  Copyright © 2016 Sabbir Ahmed. All rights reserved.
//

#import "Calculator.h"

typedef double (^UnaryOperation) (double);
typedef double (^BinaryOperation) (double, double);

@interface Calculator ()

@property (nonatomic, strong) NSDictionary *operations;

@end

@implementation Calculator{
    
    double accumulator, initialOperand;
    BinaryOperation pendingBinaryOperation;
}



-(id)init{
    self = [super init];
    
    if (self) {
        [self prepareOperation];
    }
    return self;
}

-(void)prepareOperation{
    _operations = @{
                    @"±" : ^(double operand){
                        return - operand;
                    },
                    @"%" : ^(double firstOperand, double secondOperand){
                        return firstOperand * (secondOperand / 100.0);
                    },
                    @"/" : ^(double firstOperand, double secondOperand) {
                        return firstOperand / secondOperand;
                    },
                    
                    @"×" : ^(double firstOperand, double secondOperand) {
                        return firstOperand * secondOperand;
                    },
                    
                    @"−" : ^(double firstOperand, double secondOperand) {
                        return firstOperand - secondOperand;
                    },
                    
                    @"+" : ^(double firstOperand, double secondOperand) {
                        return firstOperand + secondOperand;
                    },
                    };
}


#pragma mark - Public API

-(double)result {
    return accumulator;
}

-(void)setOperand:(double)operand {
    accumulator = operand;
}

-(void)performOperation:(NSString *)symbol{
    id operation = _operations[symbol];
    
    if ([symbol isEqualToString:@"AC"]) {
        accumulator = 0;
        pendingBinaryOperation = nil;
        initialOperand = 0;
    }else if ([symbol isEqualToString:@"±"]){
        if (operation != nil) {
            accumulator = ((UnaryOperation)operation)(accumulator);
        }
    }else if ([symbol isEqualToString:@"="]) {
        [self performPedingBinaryOperation];
    }
    else {
        if (operation) {
            [self performPedingBinaryOperation];
            
            pendingBinaryOperation = operation;
            initialOperand = accumulator;
        }
    }
    
}
@end
