import AVKit

class RCTVideoPlayerViewController: AVPlayerViewController {
    
    var rctDelegate:RCTVideoPlayerViewControllerDelegate!
    
    // Optional paramters
    var preferredOrientation:String?
    var autorotate:Bool?
    
    func shouldAutorotate() -> Bool {

        if autorotate! || preferredOrientation == nil || (preferredOrientation!.lowercased() == "all") {
            return true
        }

        return false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Toan"
        
        let alert = UIAlertController(title: "Toan", message: "", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .cancel))
        self.present(alert, animated: true)
        
        navigationController?.setNavigationBarHidden(false, animated: false)
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)

        if rctDelegate != nil {
            rctDelegate.videoPlayerViewControllerWillDismiss(playerViewController: self)
            rctDelegate.videoPlayerViewControllerDidDismiss(playerViewController: self)
        }
    }

    #if !TARGET_OS_TV

    func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        return .all
    }

    func preferredInterfaceOrientationForPresentation() -> UIInterfaceOrientation {
        if preferredOrientation?.lowercased() == "landscape" {
            return .landscapeRight
        } else if preferredOrientation?.lowercased() == "portrait" {
            return .portrait
        } else {
            // default case
            let orientation = UIApplication.shared.statusBarOrientation
            return orientation
        }
    }
    #endif
}
