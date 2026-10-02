import UIKit

class SHAPE_ACTIVITY {
    
    var defaultColor: UIColor = .white
    
    func Add_SHAPE(
        on view: UIView,
        Bg_Color: UIColor?,
        Corner_Radius: CGFloat?,
        
        P_X: CGFloat,
        P_Y: CGFloat,
        P_width: CGFloat,
        P_height: CGFloat,
        
        Shadow_Opacity: Float?,
        Shadow_Width: Double?,
        Shadow_Height: Double?,
        Shadow_Radius: CGFloat?
    ) {
        
        let shape = UIView()
        
        shape.backgroundColor = Bg_Color ?? defaultColor
        shape.layer.cornerRadius = Corner_Radius ?? 2.4
        
        shape.frame = CGRect(
            x: P_X,
            y: P_Y,
            width: P_width,
            height: P_height
        )
        
        shape.layer.shadowColor = UIColor.black.cgColor
        shape.layer.shadowOpacity = Shadow_Opacity ?? 0.5
        shape.layer.shadowOffset = CGSize(
            width: Shadow_Width ?? 0,
            height: Shadow_Height ?? 2
        )
        shape.layer.shadowRadius = Shadow_Radius ?? 4
        
        shape.layer.masksToBounds = false
        
        view.addSubview(shape)
    }
}

class UI_SHAPE: SHAPE_ACTIVITY {
    
    var VC : UIViewController
    
    init(VC: UIViewController) {
        self.VC = VC
    }
    
    func AddShape(
        Bg_Color: UIColor?,
        Corner_Radius: CGFloat?,
        
        P_X: CGFloat,
        P_Y: CGFloat,
        P_width: CGFloat,
        P_height: CGFloat,
        
        Shadow_Opacity: Float?,
        Shadow_Width: Double?,
        Shadow_Height: Double?,
        Shadow_Radius: CGFloat?
    ) {
        
        super.Add_SHAPE(
            on: VC.view,
            Bg_Color: Bg_Color,
            Corner_Radius: Corner_Radius,
            P_X: P_X,
            P_Y: P_Y,
            P_width: P_width,
            P_height: P_height,
            Shadow_Opacity: Shadow_Opacity,
            Shadow_Width: Shadow_Width,
            Shadow_Height: Shadow_Height,
            Shadow_Radius: Shadow_Radius
        )
    }
}
