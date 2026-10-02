import UIKit

class CARD {
    var Text = TEXT_ACTIVITY()
    var Shape = SHAPE_ACTIVITY()
    var Button = BUTTON_ACTIVITY()
    var Img = IMG_HOLDER()
    
    

    struct CardDising {
        var P_X: Int
        var P_Y: Int
        var Width: Int
        var Height: Int
        
        var BG_color: UIColor!
        var Corner_Radius: CGFloat!
    }
    
    struct CardButton{
        var Card_BTN_ISvisible:Bool!
        var Card_BTN_P_X:Int!
        var Card_BTN_P_Y:Int!
        var Card_BTN_P_width:Int!
        var Card_BTN_P_height:Int!
        var Card_BTN_BG_color:UIColor!
        var Card_BTN_Text:String!
        var Card_BTN_Text_Color : UIColor!
        var Card_BTN_Radius : CGFloat!
    }
    
    struct CardText{
        var Card_TXT_ISvisible:Bool!
        var Card_TXT_Text: String!
        var Card_TXT_Alignment: NSTextAlignment!
        var Card_TXT_Text_Color: UIColor!
        var Card_TXT_BoldSize: CGFloat!
        var Card_TXT_Font_Name: String!
        var Card_TXT_Font_Size: CGFloat!
        var Card_TXT_Opacity: Float!
        var Card_TXT_Shadow_Width: Double!
        var Card_TXT_Shadow_Height: Double!
        var Card_TXT_Shadow_Radius: CGFloat!
        var Card_TXT_P_X:Int!
        var Card_TXT_P_Y:Int!
        var Card_TXT_Width:Int!
        var Card_TXT_Height:Int!
    }
    
    struct CardImg{
        var Card_IMG_ISvisible:Bool!
        var Card_IMG_name:String!
        var Card_IMG_P_X:Int!
        var Card_IMG_P_Y:Int!
        var Card_IMG_Width: Int!
        var Card_IMG_Height: Int!
    }
    
   
    var Card = UIView()
    
    func Add_Card(
        on view: UIView,
        CardDisingAgrument: CardDising,
        CardButtonArgments: CardButton? = nil,
        CardTextArgments: CardText? = nil,
        CardImageArgument: CardImg? = nil
    ) -> UIView {
        
        let Card = UIView() // ✅ NEW instance
        
        Card.frame = CGRect(
            x: CardDisingAgrument.P_X,
            y: CardDisingAgrument.P_Y,
            width: CardDisingAgrument.Width,
            height: CardDisingAgrument.Height
        )
        
        Card.backgroundColor = CardDisingAgrument.BG_color ?? .white
        Card.layer.cornerRadius = CardDisingAgrument.Corner_Radius ?? 10
        Card.layer.masksToBounds = true

        // ✅ Safe button
        if let btn = CardButtonArgments, btn.Card_BTN_ISvisible == true {
            Button.Add_Button(
                on: Card,
                P_X: btn.Card_BTN_P_X,
                P_Y: btn.Card_BTN_P_Y,
                P_width: btn.Card_BTN_P_width,
                P_height: btn.Card_BTN_P_height,
                BG_color: btn.Card_BTN_BG_color,
                BTN_Text: btn.Card_BTN_Text,
                Text_Color: btn.Card_BTN_Text_Color,
                Shadow_Radius: btn.Card_BTN_Radius
            )
        }

        // ✅ Safe text
        if let txt = CardTextArgments, txt.Card_TXT_ISvisible == true {
            Text.Add_TEXT(
                on: Card,
                Text: txt.Card_TXT_Text,
                Alignment: txt.Card_TXT_Alignment,
                Text_Color: txt.Card_TXT_Text_Color,
                BoldSize: txt.Card_TXT_BoldSize,
                Font_Name: txt.Card_TXT_Font_Name,
                Font_Size: txt.Card_TXT_Font_Size,
                Opacity: txt.Card_TXT_Opacity,
                Shadow_Width: txt.Card_TXT_Shadow_Width,
                Shadow_Height: txt.Card_TXT_Shadow_Height,
                Shadow_Radius: txt.Card_TXT_Shadow_Radius,
                P_X: txt.Card_TXT_P_X,
                P_Y: txt.Card_TXT_P_Y,
                Width: txt.Card_TXT_Width,
                Height: txt.Card_TXT_Height
            )
        }

        // ✅ Safe image
        if let img = CardImageArgument, img.Card_IMG_ISvisible == true {
            Img.Add_Img(
                on: Card,
                Img: img.Card_IMG_name,
                P_X: img.Card_IMG_P_X,
                P_Y: img.Card_IMG_P_Y,
                Width: img.Card_IMG_Width,
                Height: img.Card_IMG_Height
            )
        }

        view.addSubview(Card)
        return Card
    }
    
     
}

class UI_CARD: CARD{
    
    var VC : UIViewController
    
    init(VC: UIViewController) {
        self.VC = VC
    }
    
    struct UICardDising {
        var P_X: Int
        var P_Y: Int
        var Width: Int
        var Height: Int

        var BG_color: UIColor!
        var Corner_Radius: CGFloat!
    }
    
    struct UICardText{
        var Card_TXT_ISvisible:Bool!
        var Card_TXT_Text: String!
        var Card_TXT_Alignment: NSTextAlignment!
        var Card_TXT_Text_Color: UIColor!
        var Card_TXT_BoldSize: CGFloat!
        var Card_TXT_Font_Name: String!
        var Card_TXT_Font_Size: CGFloat!
        var Card_TXT_Opacity: Float!
        var Card_TXT_Shadow_Width: Double!
        var Card_TXT_Shadow_Height: Double!
        var Card_TXT_Shadow_Radius: CGFloat!
        
        var Card_TXT_P_X:Int!
        var Card_TXT_P_Y:Int!
        var Card_TXT_Width:Int!
        var Card_TXT_Height:Int!
    }
    
    struct UICardButton{
        var Card_BTN_ISvisible:Bool!
        var Card_BTN_P_X:Int!
        var Card_BTN_P_Y:Int!
        var Card_BTN_P_width:Int!
        var Card_BTN_P_height:Int!
        var Card_BTN_BG_color:UIColor!
        var Card_BTN_Text:String!
        var Card_BTN_Text_Color : UIColor!
        var Card_BTN_Radius : CGFloat!
    }
    
    struct UICardImg{
        var Card_IMG_ISvisible:Bool!
        var Card_IMG_name:String!
        var Card_IMG_P_X:Int!
        var Card_IMG_P_Y:Int!
        var Card_IMG_Width: Int!
        var Card_IMG_Height: Int!
    }
    

    func Add_Card(
        CardDisingAgrument: UICardDising,
        CardButtonArgments: UICardButton? = nil,
        CardTextArgments: UICardText? = nil,
        CardimgArgument: UICardImg? = nil
    ) -> UIView {
        
        let Card_Arge = CardDising(
            P_X: CardDisingAgrument.P_X,
            P_Y: CardDisingAgrument.P_Y,
            Width: CardDisingAgrument.Width,
            Height: CardDisingAgrument.Height,
            BG_color: CardDisingAgrument.BG_color,
            Corner_Radius: CardDisingAgrument.Corner_Radius
        )
        
        // Safe conversions
        var textArg: CardText? = nil
        if let txt = CardTextArgments {
            textArg = CardText(
                Card_TXT_ISvisible: txt.Card_TXT_ISvisible,
                Card_TXT_Text: txt.Card_TXT_Text,
                Card_TXT_Alignment: txt.Card_TXT_Alignment,
                Card_TXT_Text_Color: txt.Card_TXT_Text_Color,
                Card_TXT_BoldSize: txt.Card_TXT_BoldSize,
                Card_TXT_Font_Name: txt.Card_TXT_Font_Name,
                Card_TXT_Font_Size: txt.Card_TXT_Font_Size,
                Card_TXT_Opacity: txt.Card_TXT_Opacity,
                Card_TXT_Shadow_Width: txt.Card_TXT_Shadow_Width,
                Card_TXT_Shadow_Height: txt.Card_TXT_Shadow_Height,
                Card_TXT_Shadow_Radius: txt.Card_TXT_Shadow_Radius,
                Card_TXT_P_X: txt.Card_TXT_P_X,
                Card_TXT_P_Y: txt.Card_TXT_P_Y,
                Card_TXT_Width: txt.Card_TXT_Width,
                Card_TXT_Height: txt.Card_TXT_Height
            )
        }
        
        var btnArg: CardButton? = nil
        if let btn = CardButtonArgments {
            btnArg = CardButton(
                Card_BTN_ISvisible: btn.Card_BTN_ISvisible,
                Card_BTN_P_X: btn.Card_BTN_P_X,
                Card_BTN_P_Y: btn.Card_BTN_P_Y,
                Card_BTN_P_width: btn.Card_BTN_P_width,
                Card_BTN_P_height: btn.Card_BTN_P_height,
                Card_BTN_BG_color: btn.Card_BTN_BG_color,
                Card_BTN_Text: btn.Card_BTN_Text,
                Card_BTN_Text_Color: btn.Card_BTN_Text_Color,
                Card_BTN_Radius: btn.Card_BTN_Radius
            )
        }
        
        var imgArg: CardImg? = nil
        if let img = CardimgArgument {
            imgArg = CardImg(
                Card_IMG_ISvisible: img.Card_IMG_ISvisible,
                Card_IMG_name: img.Card_IMG_name,
                Card_IMG_P_X: img.Card_IMG_P_X,
                Card_IMG_P_Y: img.Card_IMG_P_Y,
                Card_IMG_Width: img.Card_IMG_Width,
                Card_IMG_Height: img.Card_IMG_Height
            )
        }
        
        return super.Add_Card(
            on: VC.view, // ✅ no !
            CardDisingAgrument: Card_Arge,
            CardButtonArgments: btnArg,
            CardTextArgments: textArg,
            CardImageArgument: imgArg
        )
    }
    
}
