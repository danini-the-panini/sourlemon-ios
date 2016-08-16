import Turbolinks
import UIKit

class LemonViewController: Turbolinks.VisitableViewController {
    override func visitableDidRender() {
        title = formatTitle(visitableView.webView?.title)
    }
    
    func formatTitle(title: String?) -> String? {
        if title == "Sour Lemon" {
            return "Sour {>.<} Lemon"
        }
        return title
    }
}