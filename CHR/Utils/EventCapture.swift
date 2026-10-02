
import UIKit

// make a Event class that have
// input:uiview/uiscrollview

// 1:Touchupinside -> Send->Action use for uiview/uiscrollview
// 2:ScrollUpinside return  diraction and current element number  -> UiscrollviewOnly
// 3:




class EventCaptucher {
    @objc func viewClicked() {
        print("My UIView was clicked!")
    }
     func Touchupinside(to targetView: UIView){
        let TabGusture = UITapGestureRecognizer(
            target: self,
            action: #selector(viewClicked)
        )
        
        targetView.isUserInteractionEnabled = true
        targetView.addGestureRecognizer(TabGusture)
    }
    
    
    
    
    //

    var currentLiveTag = 100
    @objc func viewScrolled(_ sender: UIPanGestureRecognizer) {
        guard let scrollView = sender.view as? UIScrollView else { return }
        let translation = sender.translation(in: scrollView)
        let location = sender.location(in: scrollView)
        let velocity = sender.velocity(in: scrollView)
        
        scrollView.alwaysBounceHorizontal = true
        
        let visibleRect = CGRect(origin: scrollView.contentOffset, size: scrollView.bounds.size)
        let isFastDrag = abs(velocity.x) > 500 // tweak this threshold as needed
        
        
        
        if isFastDrag {
            // Fast drag: live update during the drag itself, based on 190pt threshold
            for view in scrollView.subviews {
                if view.tag == 100 {
                    let visiblePart = visibleRect.intersection(view.frame)
                    let visibleWidth = max(0, min(scrollView.bounds.size.width, visiblePart.width))
                    if visibleWidth <= 190 {
                        print("100:Is live")
                    }
                } else if view.tag == 200 {
                    let visiblePart = visibleRect.intersection(view.frame)
                    let visibleWidth = max(0, min(scrollView.bounds.size.width, visiblePart.width))
                    if visibleWidth <= 190 {
                        print("200:Is live")
                    }
                }
            }
        } else {
            // Slow drag: only decide once finger is released, based on >50% visible
            if sender.state == .ended {
                for view in scrollView.subviews {
                    if view.tag == 100 {
                        let visiblePart = visibleRect.intersection(view.frame)
                        let visibleWidth = max(0, min(scrollView.bounds.size.width, visiblePart.width))
                        
                        if visibleWidth > scrollView.bounds.size.width / 2 {
                            print("100 is live")
                        } else {
                            print("200 is live")
                        }
                    }
                }
            }
        }
    }
    func Scrolling_inside(targetView: UIScrollView){
        
        
        print(targetView.bounds.size.width)
        
        
        targetView.panGestureRecognizer.addTarget(
            self,
            action: #selector(viewScrolled(_:))
        )
        
    }
    
    
    
    
    
    
    
//    for view in scrollView.subviews {
//        if view.tag == 100 {
//            if visibleRect.intersects(view.frame) {
//                print("100 Live:","Yes")
//            }
//        }
//        
//        if view.tag == 200 {
//            if visibleRect.intersects(view.frame) {
//                if scrollView.bounds.size.width
//                print("200 Live:","Yes")
//            }
//        }
//    }
    
    
    
    
    
    
    
    static func LongPress(target: UIView , action: Selector){
        
    }
    
    static func HoldPress(){
        
    }
}



// this can be use sometime i need to do some work outside of a main Event class

//class ViewController: UIViewController {
//
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        // Attach tap handling
//        Event.addTapHandler(to: myBoxView, target: self, action: #selector(handleBoxTap(_:)))
//        
//        // Attach scroll handling
//        Event.addScrollHandler(to: myScrollView, target: self, action: #selector(handleScroll(_:)))
//    }
//
//    @objc func handleBoxTap(_ sender: UITapGestureRecognizer) {
//        let location = sender.location(in: myBoxView)
//        print("Tapped at location: \(location)")
//    }
//
//    @objc func handleScroll(_ sender: UIPanGestureRecognizer) {
//        let velocity = sender.velocity(in: myScrollView)
//        if velocity.y < 0 {
//            print("Scrolling UP")
//        } else if velocity.y > 0 {
//            print("Scrolling DOWN")
//        }
//    }
//}



// let say i have a function and i wont to pass my class inside the function
