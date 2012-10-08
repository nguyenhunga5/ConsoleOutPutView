//
//  ConsoleOutPutView.h
//  SmsSender
//
//  Created by Denis on 10/5/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#include <asl.h>

#define ApplicationName "SmsSender"

@interface ConsoleOutPutView : UIView{
    aslmsg q, m;
    aslresponse r;
    const char*lasttime;
    UITextView* consoleTextView;
    
    float direction;
    CGPoint startPoint;
}

-(void)update;
-(void)clear;

@end
