

#import "XMPP.h"

#import "XMPPFramework.h"

#import <UIKit/UIKit.h>

#import "MBProgressHUD+MJ.h"
//#import "NSXMLElement+XMPP.h"
//
//#import <SystemConfiguration/SystemConfiguration.h>
// 自定义Log
#ifdef DEBUG

#define WCLog(...) NSLog(@"%s %d \n %@\n\n",__func__,__LINE__,[NSString stringWithFormat:__VA_ARGS__])

#else
#define WCLog(...)

#endif