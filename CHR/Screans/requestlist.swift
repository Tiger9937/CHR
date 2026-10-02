

import UIKit


class ReqliatVC : UIViewController {
    var screanfunction: ScreanFunc!
    var Chatwindo: ChatwindowVC!
    override func viewDidLoad() {
        super.viewDidLoad()
        screanfunction = ScreanFunc(VC:self)
        Chatwindo = ChatwindowVC()
        
        view.backgroundColor = .lightGray
        
        
        let button = UIButton()
        button.setTitle("< Go to Back ", for: .normal)
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 20
        button.frame = CGRect(x: 100, y: 300, width: 200, height: 50)
        
        
        button.addAction(UIAction{
            _ in AppRouter.Navigate(from: self, to: self.Chatwindo, isAnimated: true, hideBackButton: true , diraction: .fromLeft)
        }, for: .touchUpInside)
        
        view.addSubview(button)
    }
    
}
