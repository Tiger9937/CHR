


import UIKit


class BUTTON_ACTIVITY {
   
    var defaultColor:UIColor = .systemBackground
    var defultTextcolor:UIColor = .black

    var Button = UIButton()

    func Add_Button(
        on view:UIView!,
        P_X:Int ,
        P_Y:Int ,
        P_width:Int ,
        P_height:Int,
        BG_color: UIColor! ,
        BTN_Text: String ,
        Text_Color:UIColor!,
        Shadow_Radius:CGFloat!
    ){
        
        Button.frame = CGRect(x: P_X, y: P_Y,width: P_width,height: P_height)
        
        Button.backgroundColor = BG_color ?? defaultColor
        Button.setTitle( BTN_Text,for: .normal)
        
        Button.setTitleColor(Text_Color ?? defultTextcolor,for: .normal)
         
        Button.layer.cornerRadius = Shadow_Radius ?? 5.6
        Button.layer.masksToBounds = true
        
        
        
        view.addSubview(Button)
        
    }
    
//    func Button_NAV_Action(PageForm:UIViewController , PageTO:UIViewController,
//                           Animation: Bool!,
//    ){
//        let Navigation = UINavigationController(rootViewController: PageForm)
//        Button.addAction(UIAction{_ in Navigation.pushViewController(PageTO, animated: Animation)
//        }, for: .touchUpInside)
//    }
    
    func Button_Action(Situation:UIAction){
        Button.addAction(Situation, for: .touchUpInside)
    }
}

class UI_BUTTON:BUTTON_ACTIVITY {
    var VC : UIViewController
    
    init(VC: UIViewController) {
        self.VC = VC
    }
    
    func AddButton(
        P_X: Int,
        P_Y: Int,
        P_width: Int,
        P_height: Int,
        BG_color: UIColor!,
        BTN_Text: String,
        Text_Color: UIColor!,
        Shadow_Radius: CGFloat!
    )
    {
        super.Add_Button(
            on: VC.view,
                                        P_X: P_X,
                                        P_Y: P_Y,
                                        P_width: P_width,
                                        P_height: P_height,
                                        BG_color: BG_color,
                                        BTN_Text: BTN_Text,
                                        Text_Color: Text_Color,
                                        Shadow_Radius: Shadow_Radius
                                        )
                }
    
    override func Button_Action(Situation:UIAction){
        Button.addAction(Situation, for: .touchUpInside)
    }
}
