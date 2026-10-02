import UIKit

class IMG_HOLDER{
    
    var ImgBackground = UIImageView()
    
    func Add_Img (
        on view:UIView ,
        Img:String ,
        P_X:Int ,
        P_Y:Int ,
        Width: Int ,
        Height: Int
    ){
        
        ImgBackground.backgroundColor = .black
        ImgBackground.frame = CGRect(
            x: P_X,
            y: P_Y,
            width: Width,
            height: Height
        )
        ImgBackground.image = UIImage(
            named: Img
        )
        ImgBackground.layer.cornerRadius = 10
        ImgBackground.layer.masksToBounds = true
        
        
        
        view
            .addSubview(
                ImgBackground
            )
    }
}







class UI_IMG_HOLDER:IMG_HOLDER {
    var VC : UIViewController
    
    init(VC: UIViewController) {
        self.VC = VC
    }
    
    func AddImg(
        Img:String ,
        P_X:Int ,
        P_Y:Int ,
        Width: Int ,
        Height: Int
    ){
        
        super.Add_Img(
            on: VC.view,
            Img: Img ,
            P_X: P_X ,
            P_Y: P_Y ,
            Width: Width ,
            Height: Height
            
        )
            
    }
}

