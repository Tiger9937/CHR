import UIKit

class TEXT_ACTIVITY {
    
    var defaultColor: UIColor = .black
    
    func Add_TEXT(
        on view: UIView!,
        Text: String?,
        Alignment: NSTextAlignment,
        Text_Color: UIColor?,
        BoldSize: CGFloat?,
        Font_Name: String?,
        Font_Size: CGFloat,
        
        Opacity: Float?,
        Shadow_Width: Double?,
        Shadow_Height: Double?,
        Shadow_Radius: CGFloat?,
        
        P_X:Int?,
        P_Y:Int?,
        Width:Int?,
        Height:Int?
    ) {
        
        let textLabel = UILabel()
        
        textLabel.text = Text ?? "hello world"
        textLabel.textAlignment = Alignment
        textLabel.textColor = Text_Color ?? defaultColor
        
        if let fontName = Font_Name,
           let customFont = UIFont(
            name: fontName,
            size: Font_Size
           ) {
            textLabel.font = customFont
            
        } else {
            textLabel.font = UIFont
                .boldSystemFont(
                    ofSize: BoldSize ?? Font_Size
                )
        }
        
        textLabel.frame = CGRect(
            x: P_X ?? 0,
            y: P_Y ?? 0,
            width: Width ?? 50,
            height: Height ?? 50
        )
    
        
        textLabel.layer.shadowColor = UIColor.black.cgColor
        textLabel.layer.shadowOpacity = Opacity ?? 0.5
        textLabel.layer.shadowOffset = CGSize(
            width: Shadow_Width ?? 0,
            height: Shadow_Height ?? 2
        )
        textLabel.layer.shadowRadius = Shadow_Radius ?? 4
        
        view
            .addSubview(
                textLabel
            )
    }
}

class UI_TEXT: TEXT_ACTIVITY {
    
    var VC : UIViewController
    
    init(VC: UIViewController) {
        self.VC = VC
    }
    
    func AddText(
        Text: String?,
        Alignment: NSTextAlignment,
        Text_Color: UIColor?,
        BoldSize: CGFloat?,
        Font_Name: String?,
        Font_Size: CGFloat,
        
        Opacity: Float?,
        Shadow_Width: Double?,
        Shadow_Height: Double?,
        Shadow_Radius: CGFloat?,
        
        P_X:Int?,
        P_Y:Int?,
        Width:Int?,
        Height:Int?
    ) {
        
        super.Add_TEXT(
            on: VC.view,
            Text: Text,
            Alignment: Alignment,
            Text_Color: Text_Color,
            BoldSize: BoldSize,
            Font_Name: Font_Name,
            Font_Size: Font_Size,
            Opacity: Opacity,
            Shadow_Width: Shadow_Width,
            Shadow_Height: Shadow_Height,
            Shadow_Radius: Shadow_Radius,
            
            P_X:P_X,
            P_Y:P_Y,
            Width:Width,
            Height:Height
        )
    }
}
