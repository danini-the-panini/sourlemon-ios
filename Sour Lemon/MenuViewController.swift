import UIKit

class MenuViewController: UIViewController {
    @IBAction func visitHome(sender: AnyObject) {
        getAppDelegate().visit(NSURL(string: AppDelegate.BASE_URL)!)
        self.closeMenu(sender)
    }
    @IBAction func visitArchives(sender: AnyObject) {
        getAppDelegate().visit(NSURL(string: "\(AppDelegate.BASE_URL)/blog/archives")!)
        self.closeMenu(sender)
    }
    @IBAction func visitAbout(sender: AnyObject) {
        getAppDelegate().visit(NSURL(string: "\(AppDelegate.BASE_URL)/about")!)
        self.closeMenu(sender)
    }
    @IBAction func closeMenu(sender: AnyObject) {
        self.slideMenuController()?.closeRight()
    }
    
    func getAppDelegate() -> AppDelegate {
        return UIApplication.sharedApplication().delegate as! AppDelegate
    }
}