import UIKit

class TEXT_FIELD_ACTIVITY {
    
    var defaultColor: UIColor = .black
    
    func Add_TextField(
        on view: UIView,
        Bg_Color: UIColor?,
        Corner_Radius: CGFloat?,
        
        P_X: CGFloat,
        P_Y: CGFloat,
        P_width: CGFloat,
        P_height: CGFloat,
        
        Shadow_Color: CGColor?,
        Opacity: Float?,
        Shadow_Width: Double?,
        Shadow_Height: Double?,
        Shadow_Radius: CGFloat?,
        
        Text: String?,
        Alignment: NSTextAlignment,
        Text_Color: UIColor?,
        BoldSize: CGFloat?,
        Font_Name: String?,
        Font_Size: CGFloat
    ) {
        
        let field = UITextField()
        
        field.backgroundColor = Bg_Color ?? .white
        field.layer.cornerRadius = Corner_Radius ?? 2.5
        
        field.frame = CGRect(
            x: P_X,
            y: P_Y,
            width: P_width,
            height: P_height
        )
        
        field.layer.shadowColor = Shadow_Color ?? UIColor.black.cgColor
        field.layer.shadowOpacity = Opacity ?? 0.5
        field.layer.shadowOffset = CGSize(
            width: Shadow_Width ?? 0,
            height: Shadow_Height ?? 2
        )
        field.layer.shadowRadius = Shadow_Radius ?? 4
        
        field.layer.masksToBounds = false
        
        field.text = Text ?? ""
        field.textAlignment = Alignment
        field.textColor = Text_Color ?? defaultColor
        
        if let fontName = Font_Name,
           let customFont = UIFont(
            name: fontName,
            size: Font_Size
           ) {
            field.font = customFont
        } else {
            field.font = UIFont
                .boldSystemFont(
                    ofSize: BoldSize ?? Font_Size
                )
        }
        
        view
            .addSubview(
                field
            )
    }
}

class UI_TEXT_FIELD: TEXT_FIELD_ACTIVITY {
    
    var VC : UIViewController
    
    init(VC: UIViewController) {
        self.VC = VC
    }
    
    func AddTextField(
        Bg_Color: UIColor?,
        Corner_Radius: CGFloat?,
        
        P_X: CGFloat,
        P_Y: CGFloat,
        P_width: CGFloat,
        P_height: CGFloat,
        
        Shadow_Color: CGColor?,
        Opacity: Float?,
        Shadow_Width: Double?,
        Shadow_Height: Double?,
        Shadow_Radius: CGFloat?,
        
        Text: String?,
        Alignment: NSTextAlignment,
        Text_Color: UIColor?,
        BoldSize: CGFloat?,
        Font_Name: String?,
        Font_Size: CGFloat
    ) {
        
        super.Add_TextField(
            on: VC.view,
            Bg_Color: Bg_Color,
            Corner_Radius: Corner_Radius,
            P_X: P_X,
            P_Y: P_Y,
            P_width: P_width,
            P_height: P_height,
            Shadow_Color: Shadow_Color,
            Opacity: Opacity,
            Shadow_Width: Shadow_Width,
            Shadow_Height: Shadow_Height,
            Shadow_Radius: Shadow_Radius,
            Text: Text,
            Alignment: Alignment,
            Text_Color: Text_Color,
            BoldSize: BoldSize,
            Font_Name: Font_Name,
            Font_Size: Font_Size
        )
    }
}
