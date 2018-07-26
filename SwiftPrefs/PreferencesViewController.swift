import Cocoa

// in the storyboard, ensure the view controller's transition checkboxes are all off, and the NSTabView's delegate is set to this controller object

class PreferencesViewController: NSTabViewController {
    
    lazy var originalSizes = [String : NSSize]()
    
    // MARK: - NSTabViewDelegate
    
    override func tabView(_ tabView: NSTabView, willSelect tabViewItem: NSTabViewItem?) {
        super.tabView(tabView, willSelect: tabViewItem)
        autoResizeWindow(tabViewItem)
    }
    
    func autoResizeWindow(_ tabViewItem: NSTabViewItem?) {
        if let title = tabViewItem?.label {
            if !originalSizes.keys.contains(title) {
                originalSizes[title] = tabViewItem?.view?.frame.size
            }
            if let size = originalSizes[title], let window = view.window {
                window.autoResize(toFill: size)
            }
        }
    }
}

extension NSWindow {
    func autoResize(toFill size: CGSize) {
        let contentFrame = frameRect(forContentRect: CGRect(origin: .zero, size: size))
        var frame = self.frame
        frame.origin.y = frame.origin.y + (frame.size.height - contentFrame.size.height)
        frame.size = contentFrame.size
        setFrame(frame, display: false, animate: true)
    }
}
