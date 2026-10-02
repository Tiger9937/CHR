import UIKit

class ChatwindowVC: UIViewController {

    var Shape: UI_SHAPE!
    var Slider: UI_SLIDER!
    var Scroll: SCROLAREA!
    var Cards: CARD!

    override func viewDidLoad() {
        super.viewDidLoad()
        Cards = CARD()
        
//        for i in 0...100{
//            let arg = CARD.CardDising(
//                P_X: 70,
//                P_Y: 20 + (i * 320),
//                Width: 250,
//                Height: 300
//            )
//            
//            let cardView = Cards.Add_Card(
//                on: Scroll.addagedscroll!, // ✅ FIX
//                CardDisingAgrument: arg
//            )
//            
//            Scroll.addScrolview(items: cardView)
//        }

        // Button
//        let button = UIButton(type: .system)
//        button.setTitle("Toggle Slider", for: .normal)
//        button.frame = CGRect(x: 50, y: 100, width: 200, height: 50)
//        button.addTarget(self, action: #selector(toggleSlider), for: .touchUpInside)
//
//        view.addSubview(button)
    }

//    @objc func toggleSlider() {
//        let targetY = isOpen ? view.frame.height: view .frame.height - 300
//
//        UIView.animate(withDuration: 0.4) {
//            self.sliderView.frame.origin.y = targetY
//        }
//
//        isOpen.toggle()
//    }
}
