import UIKit
import WebKit
import Turbolinks

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    var navigationController = UINavigationController()
    var session: Session!
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        UIApplication.sharedApplication().statusBarStyle = .LightContent
        
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
        
        window?.rootViewController = navigationController
        startApplication()
        return true
    }
    
    func startApplication() {
        let configuration = WKWebViewConfiguration()
        configuration.applicationNameForUserAgent = "SourLemon/\(self.getAppVersion())";
        session = Session(webViewConfiguration: configuration)
        session.delegate = self
        visit(NSURL(string: "http://localhost:3000")!)
    }
    
    func visit(URL: NSURL) {
        let visitableViewController = LemonViewController(URL: URL)
        visitableViewController.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .Plain, target: nil, action: nil)
        navigationController.pushViewController(visitableViewController, animated: true)
        session.visit(visitableViewController)
    }
    
    func getAppVersion() -> String {
        let version = NSBundle.mainBundle().infoDictionary?["CFBundleShortVersionString"] as? String
        
        return version!
    }
    
    func popToRoot(sender:UIBarButtonItem){
        self.navigationController.popToRootViewControllerAnimated(true)
    }
}

extension AppDelegate: SessionDelegate {
    func session(session: Session, didProposeVisitToURL URL: NSURL, withAction action: Action) {
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