import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    @IBOutlet weak var videoView: UIView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var prevView: UIView!
    @IBOutlet weak var prevLogoView: UIImageView!
    @IBOutlet weak var prevTitleView: UILabel!
    @IBOutlet weak var prevMetadataView: UILabel!
    @IBOutlet weak var nextView: UIView!
    @IBOutlet weak var nextLogoView: UIImageView!
    @IBOutlet weak var nextTitleView: UILabel!
    @IBOutlet weak var nextMetadataView: UILabel!
    @IBOutlet weak var fakeUIView: UIImageView!
    
    let queue = DispatchQueue(label: "queue", attributes: .concurrent)
    
    var playerLayer: AVPlayerLayer?
    var playerLayerCBS: AVPlayerLayer?
    var playerLayerCNN: AVPlayerLayer?
    var playerLayerCSN: AVPlayerLayer?
    var playerLayerESPN: AVPlayerLayer?
    var playerLayerFOX: AVPlayerLayer?
    var playerLayerHBO: AVPlayerLayer?
    var playerLayerHSN: AVPlayerLayer?
    
    var guideLayer: CALayer?
    var guideLayerCBS: CALayer?
    var guideLayerCNN: CALayer?
    var guideLayerCSN: CALayer?
    var guideLayerESPN: CALayer?
    var guideLayerFOX: CALayer?
    var guideLayerHBO: CALayer?
    var guideLayerHSN: CALayer?
    
    var surfing = false
    
    var direction = ""
    var oldDirection: String?
    var prevChanged = false
    var nextChanged = false
    
    var resetOrigin: CGFloat?
    var visibleOrigin: CGFloat?
    var previewView: UIView?
    
    var resetIndex = 0
    var prevIndex: Int?
    var nextIndex: Int?
    var oldIndex: Int?
    var newIndex: Int?
    
    var pendingTask: DispatchWorkItem?
    var pendingTask2: DispatchWorkItem?
    
    var pageViewController: PageViewController? {
        didSet {
            pageViewController?.gotDelegate = self
        }
    }
    
    var logoImages: [UIImage] = [#imageLiteral(resourceName: "logo_amc"),#imageLiteral(resourceName: "logo_cbs"),#imageLiteral(resourceName: "logo_cnn"),#imageLiteral(resourceName: "logo_csn"),#imageLiteral(resourceName: "logo_espn"),#imageLiteral(resourceName: "logo_fox")]
    
    var channelTitle: Array = [
        "The Walking Dead",
        "The Talk",
        "State of the Union",
        "MIL vs SAC",
        "UCLA vs AZW",
        "Empire"
    ]
    
    var channelDescription: Array = [
        "S2 E7 | The Other Side",
         "S7 EP182 | Actress Salma Hayek",
         "S77 E2 | Gary Johnson",
         "2017",
         "2017",
         "S2 E3 | Bout that"
    ]
    
    var randomNum: UInt32?
    var someInt: Int?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        (UIApplication.shared as! MyApplication).myVC = self
        
        // video player AMC
        guard let path = Bundle.main.path(forResource: "amc", ofType:"mp4") else {
            debugPrint("video not found")
            return
        }
        
        let player = AVPlayer(url: URL(fileURLWithPath: path))
        
        playerLayer = AVPlayerLayer(player: player)
        playerLayer?.videoGravity = AVLayerVideoGravityResizeAspectFill
        playerLayer!.frame = self.videoView.frame
        playerLayer?.isHidden = false
        
        NotificationCenter.default.addObserver(forName: .AVPlayerItemDidPlayToEndTime, object: player.currentItem, queue: nil, using: { (_) in
            DispatchQueue.main.async {
                player.seek(to: kCMTimeZero)
                player.play()
            }
        })
        
        player.isMuted = false;
        player.play()
        
        self.videoView.layer.addSublayer(playerLayer!)
        
        // video player CBS
        guard let pathCBS = Bundle.main.path(forResource: "cbs", ofType:"mp4") else {
            debugPrint("video not found")
            return
        }
        
        let playerCBS = AVPlayer(url: URL(fileURLWithPath: pathCBS))
        
        playerLayerCBS = AVPlayerLayer(player: playerCBS)
        playerLayerCBS?.videoGravity = AVLayerVideoGravityResizeAspectFill
        playerLayerCBS!.frame = self.videoView.frame
        playerLayerCBS?.isHidden = true
        
        self.videoView.layer.addSublayer(playerLayerCBS!)
        
        NotificationCenter.default.addObserver(forName: .AVPlayerItemDidPlayToEndTime, object: playerCBS.currentItem, queue: nil, using: { (_) in
            DispatchQueue.main.async {
                playerCBS.seek(to: kCMTimeZero)
                playerCBS.play()
            }
        })
        
        playerCBS.isMuted = true;
        playerCBS.play()
        
        // video player CNN
        guard let pathCNN = Bundle.main.path(forResource: "cnn", ofType:"mp4") else {
            debugPrint("video not found")
            return
        }
        
        let playerCNN = AVPlayer(url: URL(fileURLWithPath: pathCNN))
        
        playerLayerCNN = AVPlayerLayer(player: playerCNN)
        playerLayerCNN?.videoGravity = AVLayerVideoGravityResizeAspectFill
        playerLayerCNN!.frame = self.videoView.frame
        playerLayerCNN?.isHidden = true
        
        self.videoView.layer.addSublayer(playerLayerCNN!)
        
        NotificationCenter.default.addObserver(forName: .AVPlayerItemDidPlayToEndTime, object: playerCNN.currentItem, queue: nil, using: { (_) in
            DispatchQueue.main.async {
                playerCNN.seek(to: kCMTimeZero)
                playerCNN.play()
            }
        })
        
        playerCNN.isMuted = true;
        playerCNN.play()
        
        // video player CSN
        guard let pathCSN = Bundle.main.path(forResource: "csn", ofType:"mp4") else {
            debugPrint("video not found")
            return
        }
        
        let playerCSN = AVPlayer(url: URL(fileURLWithPath: pathCSN))
        
        playerLayerCSN = AVPlayerLayer(player: playerCSN)
        playerLayerCSN?.videoGravity = AVLayerVideoGravityResizeAspectFill
        playerLayerCSN!.frame = self.videoView.frame
        playerLayerCSN?.isHidden = true
        
        self.videoView.layer.addSublayer(playerLayerCSN!)
        
        NotificationCenter.default.addObserver(forName: .AVPlayerItemDidPlayToEndTime, object: playerCSN.currentItem, queue: nil, using: { (_) in
            DispatchQueue.main.async {
                playerCSN.seek(to: kCMTimeZero)
                playerCSN.play()
            }
        })
        
        playerCSN.isMuted = true;
        playerCSN.play()
        
        // video player ESPN
        guard let pathESPN = Bundle.main.path(forResource: "espn", ofType:"mp4") else {
            debugPrint("video not found")
            return
        }
        
        let playerESPN = AVPlayer(url: URL(fileURLWithPath: pathESPN))
        
        playerLayerESPN = AVPlayerLayer(player: playerESPN)
        playerLayerESPN?.videoGravity = AVLayerVideoGravityResizeAspectFill
        playerLayerESPN!.frame = self.videoView.frame
        playerLayerESPN?.isHidden = true
        
        self.videoView.layer.addSublayer(playerLayerESPN!)
        
        NotificationCenter.default.addObserver(forName: .AVPlayerItemDidPlayToEndTime, object: playerESPN.currentItem, queue: nil, using: { (_) in
            DispatchQueue.main.async {
                playerESPN.seek(to: kCMTimeZero)
                playerESPN.play()
            }
        })
        
        playerESPN.isMuted = true;
        playerESPN.play()
        
        // video player FOX
        guard let pathFOX = Bundle.main.path(forResource: "fox", ofType:"mp4") else {
            debugPrint("video not found")
            return
        }
        
        let playerFOX = AVPlayer(url: URL(fileURLWithPath: pathFOX))
        
        playerLayerFOX = AVPlayerLayer(player: playerFOX)
        playerLayerFOX?.videoGravity = AVLayerVideoGravityResizeAspectFill
        playerLayerFOX!.frame = self.videoView.frame
        playerLayerFOX?.isHidden = true
        
        self.videoView.layer.addSublayer(playerLayerFOX!)
        
        NotificationCenter.default.addObserver(forName: .AVPlayerItemDidPlayToEndTime, object: playerFOX.currentItem, queue: nil, using: { (_) in
            DispatchQueue.main.async {
                playerFOX.seek(to: kCMTimeZero)
                playerFOX.play()
            }
        })
        
        playerFOX.isMuted = true;
        playerFOX.play()
        
        // add target
        
        pageControl.addTarget(self, action: #selector(ViewController.didChangePageControlValue), for: .valueChanged)
        
        // tap detection
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.respondToTapGesture))
        self.view.addGestureRecognizer(tapGesture)
        
        // swipe detection
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(self.respondToSwipeGesture))
        swipeRight.direction = UISwipeGestureRecognizerDirection.right
        self.view.addGestureRecognizer(swipeRight)
        
        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(self.respondToSwipeGesture))
        swipeDown.direction = UISwipeGestureRecognizerDirection.down
        self.view.addGestureRecognizer(swipeDown)
        
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(self.respondToSwipeGesture))
        swipeLeft.direction = UISwipeGestureRecognizerDirection.left
        self.view.addGestureRecognizer(swipeLeft)
        
        let swipeUp = UISwipeGestureRecognizer(target: self, action: #selector(self.respondToSwipeGesture))
        swipeUp.direction = UISwipeGestureRecognizerDirection.up
        self.view.addGestureRecognizer(swipeUp)
        
        // initial appearance
        
        // Prev View
        self.prevView.alpha = 0.0
        self.prevView.frame = CGRect(x: -433, y: 0, width: 433, height: 1080)
        
        // Next View
        self.nextView.alpha = 0.0
        self.nextView.frame = CGRect(x: 1920, y: 0, width: 433, height: 1080)
        
        // Fake UI View
        self.fakeUIView.alpha = 0.0
        self.fakeUIView.frame = CGRect(x: 0, y: 1080, width: 1920, height: 1080)
        
        // Container View
        self.containerView.isHidden = true
        self.containerView.alpha = 0.0
    }
    
    func doRestartTimer() {
        pendingTask2 = DispatchWorkItem {
            if (self.surfing) {
                self.doChannelChange()
            }
            
            self.doHide()
        }
        
        if (self.surfing) {
            self.randomNum = arc4random_uniform(1000) // range
            self.someInt = Int(self.randomNum!) + 500
        } else {
            self.someInt = 3000
        }
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + .milliseconds(someInt!), execute: self.pendingTask2!)
    }
    
    func doInvalidateTimer() {
        pendingTask2?.cancel()
    }
    
    func doShowFakeUI() {
        self.doHide()
        
        UIView.animate(withDuration: 0.3, animations: {
            self.fakeUIView.alpha = 1.0
            self.fakeUIView.frame = CGRect(x: 0, y: 0, width: 1920, height: 1080)
        }, completion: nil)
    }
    
    func doHideFakeUI() {
        UIView.animate(withDuration: 0.3, animations: {
            self.fakeUIView.alpha = 0.0
            self.fakeUIView.frame = CGRect(x: 0, y: 1080, width: 1920, height: 1080)
        }, completion: nil)
    }
    
    func doShow(newDirection: String, index: Int) {
        if (newDirection == "left") {
            resetOrigin = 1920
            visibleOrigin = 1487
            previewView = self.nextView
        } else {
            resetOrigin = -433
            visibleOrigin = 0
            previewView = self.prevView
        }
        
        if (self.containerView.isHidden) { // show preview
            pendingTask = DispatchWorkItem {
                // enable channels to be swiped through
                self.pageViewController?.scrollToViewController(index: index)
                self.containerView.isHidden = false
            
                
                // set preview metadata
                
                self.prevLogoView.image = self.logoImages[index]
                self.prevTitleView.text = self.channelTitle[index]
                self.prevMetadataView.text = self.channelDescription[index]
                
                self.nextLogoView.image = self.logoImages[index]
                self.nextTitleView.text = self.channelTitle[index]
                self.nextMetadataView.text = self.channelDescription[index]
                
                // animate preview in
                UIView.animate(withDuration: 0.3, animations: {
                    self.previewView?.alpha = 1.0
                    self.previewView?.frame = CGRect(x: self.visibleOrigin!, y: 0, width: 433, height: 1080)
                }, completion: nil)
            }
            
            DispatchQueue.main.async(execute: self.pendingTask!)
        } else { // show channel
            // animate tuning to channel
            UIView.animate(withDuration: 0.3, animations: {
                self.surfing = true
                
                self.previewView?.frame = CGRect(x: 0, y: 0, width: 1920, height: 1080)
                self.previewView?.alpha = 0.0
                
                self.containerView.alpha = 1.0
                
            }, completion: { (finished: Bool) in
                // reset preview position
                self.previewView?.frame = CGRect(x: self.resetOrigin!, y: 0, width: 433, height: 1080)
            })
        }
        
        self.oldDirection = newDirection
    }
    
    func doHide() {
        // reset channel
        self.pageViewController?.scrollToViewController(index: self.resetIndex)
        
        // reset direction
        self.oldDirection = nil
        
        UIView.animate(withDuration: 0.3, animations: {
            self.prevView.alpha = 0.0
            self.prevView.frame = CGRect(x: -433, y: 0, width: 433, height: 1080)
            
            self.nextView.alpha = 0.0
            self.nextView.frame = CGRect(x: 1920, y: 0, width: 433, height: 1080)
            
            self.fakeUIView.alpha = 0.0
            self.fakeUIView.frame = CGRect(x: 0, y: 1080, width: 1920, height: 1080)
            
            self.containerView.alpha = 0.0
        }, completion: { (finished: Bool) in
            self.surfing = false
            
            self.prevView.frame = CGRect(x: -433, y: 0, width: 433, height: 1080)
            self.nextView.frame = CGRect(x: 1920, y: 0, width: 433, height: 1080)
            
            self.containerView.isHidden = true
            
        })
    }
    
    
    
    func respondToTapGesture(gesture: UIGestureRecognizer) {
        if (self.prevView.alpha == 0.0 && self.nextView.alpha == 0.0) { // neutral
            // nothing
        } else {
            // self.direction != ""
            if (self.direction == "left") {
                self.doShow(newDirection: self.direction, index: self.nextIndex!)
            } else {
                self.doShow(newDirection: self.direction, index: self.prevIndex!)
            }
        }
    }
    
    
    func respondToSwipeGesture(gesture: UIGestureRecognizer) {
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            switch swipeGesture.direction {
            case UISwipeGestureRecognizerDirection.right:
                // debugPrint("Swiped right")
                
                direction = "right"
                
                if (self.oldDirection == nil || self.oldDirection == direction) {
                
                // determine previous index, account for loops
                
                self.prevIndex = self.pageControl.currentPage - 1
                
                if (self.prevIndex! < 0) {
                    self.prevIndex = 5
                }
                
                self.doShow(newDirection: direction, index: self.prevIndex!)
                
                } else {
                    self.doHide()
                }
                
            case UISwipeGestureRecognizerDirection.down:
                debugPrint("Swiped down")
            case UISwipeGestureRecognizerDirection.left:
                // debugPrint("Swiped left")
                
                direction = "left"
                
                if (self.oldDirection == nil || self.oldDirection == direction) {
                
                // determine previous index, account for loops
                
                self.nextIndex = self.pageControl.currentPage + 1
                
                if (self.nextIndex! > 5) {
                    self.nextIndex = 0
                }
                
                self.doShow(newDirection: direction, index: self.nextIndex!)
                
                } else {
                    self.doHide()
                }
                
            case UISwipeGestureRecognizerDirection.up:
                // debugPrint("Swiped up")
                
                self.doShowFakeUI()
            default:
                break
            }
        }
    }
    
    func doChannelChange(sender: UITapGestureRecognizer? = nil) {
        resetIndex = pageControl.currentPage
        
        switch pageControl.currentPage {
        case 0: // AMC
            playerLayer?.player?.isMuted = false
            playerLayer?.isHidden = false
            guideLayer?.isHidden = false
            
            playerLayerCBS?.player?.isMuted = true
            playerLayerCBS?.isHidden = true
            guideLayerCBS?.isHidden = true
            
            playerLayerCNN?.player?.isMuted = true
            playerLayerCNN?.isHidden = true
            guideLayerCNN?.isHidden = true
            
            playerLayerCSN?.player?.isMuted = true
            playerLayerCSN?.isHidden = true
            guideLayerCSN?.isHidden = true
            
            playerLayerESPN?.player?.isMuted = true
            playerLayerESPN?.isHidden = true
            guideLayerESPN?.isHidden = true
            
            playerLayerFOX?.player?.isMuted = true
            playerLayerFOX?.isHidden = true
            guideLayerFOX?.isHidden = true
            
            //debugPrint("0")
        case 1: // CBS
            
            playerLayer?.player?.isMuted = true
            playerLayer?.isHidden = true
            guideLayer?.isHidden = true
            
            playerLayerCBS?.player?.isMuted = false
            playerLayerCBS?.isHidden = false
            guideLayerCBS?.isHidden = false
            
            playerLayerCNN?.player?.isMuted = true
            playerLayerCNN?.isHidden = true
            guideLayerCNN?.isHidden = true
            
            playerLayerCSN?.player?.isMuted = true
            playerLayerCSN?.isHidden = true
            guideLayerCSN?.isHidden = true
            
            playerLayerESPN?.player?.isMuted = true
            playerLayerESPN?.isHidden = true
            guideLayerESPN?.isHidden = true
            
            playerLayerFOX?.player?.isMuted = true
            playerLayerFOX?.isHidden = true
            guideLayerFOX?.isHidden = true
            
            //debugPrint("1")
        case 2: // CNN
            playerLayer?.player?.isMuted = true
            playerLayer?.isHidden = true
            guideLayer?.isHidden = true
            
            playerLayerCBS?.player?.isMuted = true
            playerLayerCBS?.isHidden = true
            guideLayerCBS?.isHidden = true
            
            playerLayerCNN?.player?.isMuted = false
            playerLayerCNN?.isHidden = false
            guideLayerCNN?.isHidden = false
            
            playerLayerCSN?.player?.isMuted = true
            playerLayerCSN?.isHidden = true
            guideLayerCSN?.isHidden = true
            
            playerLayerESPN?.player?.isMuted = true
            playerLayerESPN?.isHidden = true
            guideLayerESPN?.isHidden = true
            
            playerLayerFOX?.player?.isMuted = true
            playerLayerFOX?.isHidden = true
            guideLayerFOX?.isHidden = true
            
            //debugPrint("2")
        case 3: // CSN
            playerLayer?.player?.isMuted = true
            playerLayer?.isHidden = true
            guideLayer?.isHidden = true
            
            playerLayerCBS?.player?.isMuted = true
            playerLayerCBS?.isHidden = true
            guideLayerCBS?.isHidden = true
            
            playerLayerCNN?.player?.isMuted = true
            playerLayerCNN?.isHidden = true
            guideLayerCNN?.isHidden = true
            
            playerLayerCSN?.player?.isMuted = false
            playerLayerCSN?.isHidden = false
            guideLayerCSN?.isHidden = false
            
            playerLayerESPN?.player?.isMuted = true
            playerLayerESPN?.isHidden = true
            guideLayerESPN?.isHidden = true
            
            playerLayerFOX?.player?.isMuted = true
            playerLayerFOX?.isHidden = true
            guideLayerFOX?.isHidden = true
            
            //debugPrint("3")
        case 4: // ESPN
            playerLayer?.player?.isMuted = true
            playerLayer?.isHidden = true
            guideLayer?.isHidden = true
            
            playerLayerCBS?.player?.isMuted = true
            playerLayerCBS?.isHidden = true
            guideLayerCBS?.isHidden = true
            
            playerLayerCNN?.player?.isMuted = true
            playerLayerCNN?.isHidden = true
            guideLayerCNN?.isHidden = true
            
            playerLayerCSN?.player?.isMuted = true
            playerLayerCSN?.isHidden = true
            guideLayerCSN?.isHidden = true
            
            playerLayerESPN?.player?.isMuted = false
            playerLayerESPN?.isHidden = false
            guideLayerESPN?.isHidden = false
            
            playerLayerFOX?.player?.isMuted = true
            playerLayerFOX?.isHidden = true
            guideLayerFOX?.isHidden = true
            
            //debugPrint("4")
        case 5: // FOX
            playerLayer?.player?.isMuted = true
            playerLayer?.isHidden = true
            guideLayer?.isHidden = true
            
            playerLayerCBS?.player?.isMuted = true
            playerLayerCBS?.isHidden = true
            guideLayerCBS?.isHidden = true
            
            playerLayerCNN?.player?.isMuted = true
            playerLayerCNN?.isHidden = true
            guideLayerCNN?.isHidden = true
            
            playerLayerCSN?.player?.isMuted = true
            playerLayerCSN?.isHidden = true
            guideLayerCSN?.isHidden = true
            
            playerLayerESPN?.player?.isMuted = true
            playerLayerESPN?.isHidden = true
            guideLayerESPN?.isHidden = true
            
            playerLayerFOX?.player?.isMuted = false
            playerLayerFOX?.isHidden = false
            guideLayerFOX?.isHidden = false
            
            //debugPrint("5")
        default:
            debugPrint("default")
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let pageViewController = segue.destination as? PageViewController {
            self.pageViewController = pageViewController
        }
    }
    
    @IBAction func didTapNextButton(_ sender: UIButton) {
        pageViewController?.scrollToNextViewController()
    }
    
    // Fired when the user taps on the pageControl to change its current page
    
    func didChangePageControlValue() {
        pageViewController?.scrollToViewController(index: pageControl.currentPage)
    }
    
    @IBAction func didSwipe(_ sender: Any) {
        debugPrint("in deep")
    }
    
    override func pressesBegan(_ presses: Set<UIPress>, with event: UIPressesEvent?) {
        if(presses.first?.type == UIPressType.menu) {
            self.doHide()
        }
    }
}

extension ViewController: PageViewControllerDelegate {
    func pageViewController(_ pageViewController: PageViewController,
                            didUpdatePageCount count: Int) {
        pageControl.numberOfPages = count
    }
    
    func pageViewController(_ pageViewController: PageViewController,
                            didUpdatePageIndex index: Int) {
        pageControl.currentPage = index
    }
}
