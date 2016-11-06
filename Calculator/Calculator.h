//
//  Calculator.h
//  Calculator
//
//  Created by Sabbir Ahmed on 11/6/16.
//  Copyright © 2016 Sabbir Ahmed. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Calculator : NSObject

-(void)setOperand:(double)operand;
-(void)performOperation:(NSString*)symbol;

@end
