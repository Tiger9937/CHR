import UIKit

class TEXT_INPUT_ACTIVITY {
    
    func Add_TextInput(
        on view: UIView,
        Placeholder: String?,
        P_X: CGFloat,
        P_Y: CGFloat,
        P_width: CGFloat,
        P_height: CGFloat
    ) {
        
        let textInput = UITextField()
        
        textInput.frame = CGRect(
            x: P_X,
            y: P_Y,
            width: P_width,
            height: P_height
        )
        
        textInput.placeholder = Placeholder ?? ""
        textInput.borderStyle = .roundedRect
        
        view
            .addSubview(
                textInput
            )
    }
}

class UI_TEXT_INPUT: TEXT_INPUT_ACTIVITY {
    
    var VC : UIViewController
    
    init(VC: UIViewController) {
        self.VC = VC
    }
    
    func AddTextInput(
        Placeholder: String?,
        P_X: CGFloat,
        P_Y: CGFloat,
        P_width: CGFloat,
        P_height: CGFloat
    ) {
        
        super.Add_TextInput(
            on: VC.view,
            Placeholder: Placeholder,
            P_X: P_X,
            P_Y: P_Y,
            P_width: P_width,
            P_height: P_height
        )
    }
}
