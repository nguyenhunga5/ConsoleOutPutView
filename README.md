ConsoleOutPutView
=================

Debug console output view. Displays a console on device.


USAGE:<br>
1) Edit in ConsoleOutPutView.h 'ApplicationName' constant according to your application executable name;<br>
2) Edit AppDelegate file like shown below;

AppDelegate.m


```
#import ConsoleOutPutView.h

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
//some your code.

    ConsoleOutPutView* o = [[ConsoleOutPutView alloc]initWithFrame:[[UIScreen mainScreen] bounds]]; //paste this
    [self.window addSubview:o];         //code

    return YES;
}
```
![ScreenShot](http://dropi.ru/KSh.png)


Then just pull the red bar to the top and you will see the console output.