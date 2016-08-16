import Turbolinks
import UIKit

class LemonViewController: Turbolinks.VisitableViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let menuButton = UIBarButtonItem(image: UIImage(named: "hamburger.png"), style: .Plain, target: self, action: #selector(openMenu))
        
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .Plain, target: nil, action: nil)
        navigationItem.rightBarButtonItem = menuButton
    }
    
    override func visitableDidRender() {
        title = formatTitle(visitableView.webView?.title)
    }
    
    func formatTitle(title: String?) -> String? {
        if title == "Sour Lemon" {
            return "Sour {>.<} Lemon"
        }
        return title
    }
    
    func openMenu() {
        self.slideMenuController()?.openRight()
    }
}