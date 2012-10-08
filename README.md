ConsoleOutPutView
=================

Debug console output view. Displays a console on device.


USAGE:


AppDelegate.m



#import ConsoleOutPutView.h

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
//some your code.

    ConsoleOutPutView* o = [[ConsoleOutPutView alloc]initWithFrame:[[UIScreen mainScreen] bounds]]; //paste this
    [self.window addSubview:o];         //code

    return YES;
}

Then just pull the red bar to the top and you will see the console output.