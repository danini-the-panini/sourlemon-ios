import UIKit
import WebKit
import Turbolinks

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    var navigationController = UINavigationController()
    var session: Session!
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
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
        let visitableViewController = VisitableViewController(URL: URL)
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