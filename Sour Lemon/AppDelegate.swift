import UIKit
import WebKit
import Turbolinks
import SlideMenuControllerSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    var navigationController = UINavigationController()
    var session: Session!
    
    static let BASE_URL = "http://localhost:3000"
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        UIApplication.sharedApplication().statusBarStyle = .LightContent
        
        navigationController.navigationItem.title = "Sour {>.<} Lemom"
        navigationController.navigationBar.barStyle = .BlackTranslucent
        navigationController.navigationBar.barTintColor = UIColor(colorLiteralRed: 0.4, green: 0.62, blue: 0.22, alpha: 1.0)
        navigationController.navigationBar.translucent = false
        navigationController.navigationBar.tintColor = UIColor.whiteColor()
        let shadow = NSShadow()
        shadow.shadowColor = UIColor.blackColor()
        shadow.shadowOffset = CGSizeMake(0, -1)
        navigationController.navigationBar.titleTextAttributes = [
            NSShadowAttributeName: shadow
        ]
        
        let storyboard = UIStoryboard(name:"Main", bundle:nil)
        let menuViewController = storyboard.instantiateViewControllerWithIdentifier("MenuViewController")
        
        SlideMenuOptions.rightViewWidth = 200
        SlideMenuOptions.contentViewScale = 1.0
        
        let slideMenuController = SlideMenuController(mainViewController: navigationController, rightMenuViewController: menuViewController)
        self.window?.rootViewController = slideMenuController
        self.window?.makeKeyAndVisible()
        
        startApplication()
        return true
    }
    
    func startApplication() {
        let configuration = WKWebViewConfiguration()
        configuration.applicationNameForUserAgent = "SourLemon/\(self.getAppVersion())";
        session = Session(webViewConfiguration: configuration)
        session.delegate = self
        visit(NSURL(string: AppDelegate.BASE_URL)!)
    }
    
    func visit(URL: NSURL) {
        let visitableViewController = LemonViewController(URL: URL)
        navigationController.pushViewController(visitableViewController, animated: true)
        session.visit(visitableViewController)
    }
    
    func getAppVersion() -> String {
        let version = NSBundle.mainBundle().infoDictionary?["CFBundleShortVersionString"] as? String
        
        return version!
    }
}

extension AppDelegate: SessionDelegate {
    func session(session: Session, didProposeVisitToURL URL: NSURL, withAction action: Action) {
        print(URL.description)
        visit(URL)
    }
    
    func session(session: Session, didFailRequestForVisitable visitable: Visitable, withError error: NSError) {
        let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .Alert)
        alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
        navigationController.presentViewController(alert, animated: true, completion: nil)
    }
    
    func sessionDidStartRequest(session: Session) {
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
    }
    
    func sessionDidFinishRequest(session: Session) {
        UIApplication.sharedApplication().networkActivityIndicatorVisible = false
    }
}