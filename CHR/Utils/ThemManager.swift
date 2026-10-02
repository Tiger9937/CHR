import UIKit

class APPCOLOR{
    
    static var BackgroundColor: UIColor = .white
    static var LayoutColor: UIColor = .white
    static var LayoutToperColor: UIColor = .white
    static var LayoutToperBORDERColor: UIColor = .black
    static var ContentColor: UIColor = .black
    static var SubContentColor: UIColor = .gray
    static var Islight:Bool = true
    
    static func DarkTheme(){
        
        BackgroundColor = .darkBackgroundAPPCOLOR
        LayoutColor = .darkLayoutColorAPPCOLOR
        LayoutToperColor = .darkLayoutToperColorAPPCOLOR
        LayoutToperBORDERColor = .darkLayoutToperColorAPPCOLOR
        ContentColor = .lightContentColorAPPCOLOR
        SubContentColor = .darkSubContentColorAPPCOLOR
    }

    static func DefaultTheme(){
        BackgroundColor = .lightBackgroundAPPCOLOR
        LayoutColor = .lightLayoutColorAPPCOLOR
        LayoutToperColor = .lightLayoutToperColorAPPCOLOR
        LayoutToperBORDERColor = .lightLayoutToperColorAPPCOLOR
        ContentColor = .darkContentColorAPPCOLOR
        SubContentColor = .lightSubContentColorAPPCOLOR
    }
    
    static func CurrentThem() {
        if(UITraitCollection.current.userInterfaceStyle == .light){
            Islight = true
            DefaultTheme()
        }else if (UITraitCollection.current.userInterfaceStyle == .dark){
            Islight = false
            DarkTheme()
        }

    }
}
