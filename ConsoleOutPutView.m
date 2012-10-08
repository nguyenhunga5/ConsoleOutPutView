//
//  ConsoleOutPutView.m
//
//  Created by Denis on 10/5/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ConsoleOutPutView.h"

@implementation ConsoleOutPutView

- (id)initWithFrame:(CGRect)frame
{
    if (![[UIApplication sharedApplication]isStatusBarHidden]) {
        frame = CGRectMake(0, 20, frame.size.width, frame.size.height-20);
    } 
    
    self = [super initWithFrame:frame];
    if (self) {
        
        UIView*v = [[UIView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, 20)];                                  
        [v setBackgroundColor:[UIColor redColor]];
        
        [self setBackgroundColor:[UIColor viewFlipsideBackgroundColor]];
        consoleTextView = [[UITextView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        [consoleTextView setBackgroundColor:[UIColor clearColor]];
        [consoleTextView setTextColor:[UIColor whiteColor]];
        [consoleTextView setEditable:FALSE];
        [self addSubview:consoleTextView];
        [self addSubview:v];
        
        q = asl_new(ASL_TYPE_QUERY);
        
        UILongPressGestureRecognizer* longPress = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(clear)];
        [self addGestureRecognizer:longPress];
        
        [self update];

    }
    return self;
}

-(void)clear{
    consoleTextView.text = @"";
}

-(void)update{
    const char *val;
    
    asl_set_query(q, ASL_KEY_SENDER, ApplicationName, ASL_QUERY_OP_EQUAL);
    asl_set_query(q, ASL_KEY_TIME, lasttime, ASL_QUERY_OP_GREATER);
    r = asl_search(NULL, q);
    
    while (NULL != (m = aslresponse_next(r)))
    {
        val = asl_get(m, ASL_KEY_MSG);
        consoleTextView.text = [consoleTextView.text stringByAppendingFormat:@"\n%@",[NSString stringWithUTF8String:val]];
        lasttime = asl_get(m, ASL_KEY_TIME);
    }
}

-(void)animate{
    [self update];
    [UIView beginAnimations:@"inout" context:nil];    
    [UIView setAnimationDuration:0.2];
    CGRect sbf = [[UIApplication sharedApplication]statusBarFrame];
    if (direction>0) {
        [self setCenter:CGPointMake(self.center.x, (self.frame.size.height/2)*3+sbf.size.height-20)];        
    } else {
        [self setCenter:CGPointMake(self.center.x, self.frame.size.height/2+sbf.size.height)];        
    }
    [UIView commitAnimations];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    UITouch* touch = [touches anyObject];
    CGPoint loc = [touch locationInView:self];
    startPoint = CGPointMake(loc.x-self.frame.size.width/2, loc.y-self.frame.size.height/2);
    direction = self.center.y;
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    UITouch* touch = [touches anyObject];
    CGPoint loc = [touch locationInView:self];
    CGPoint finalPoint = CGPointMake(loc.x-self.frame.size.width/2, self.center.y-startPoint.y+loc.y-self.frame.size.height/2 );
    direction = -self.center.y;
    [self setCenter:CGPointMake(self.center.x,finalPoint.y)];    
    direction += self.center.y;    
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    [self animate];
}

-(void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event{
    [self animate];
}
@end
