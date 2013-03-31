#import "AppDelegate.h"
#import "GroupsController.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    EMClient.shared.accountID = @"1721603";
    EMClient.shared.publicKey = @"a3ec90e7f73042dc3f1d";
    EMClient.shared.privateKey = @"1704abcd5b5b23ce17b4";
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    UIViewController *c = [[GroupsController alloc] init];
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:c];
    _window.rootViewController = navigationController;
    [_window addSubview:navigationController.view];
    return YES;
}

@end
