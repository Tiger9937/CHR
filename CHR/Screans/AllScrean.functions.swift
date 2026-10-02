import UIKit


class ScreanFunc {

    init(
        VC: UIViewController
    ) {
        self.VC = VC
    }
    
    // elements
    var VC : UIViewController
    var defaultColor:UIColor = .white
    
    
    // functions
    func backgroundcolor(
        BGcolor:UIColor?
    ) {
        VC.view.backgroundColor = BGcolor ?? defaultColor
    }
    
    func ChangeDefaultColor(
        BGcolor:UIColor
    ){
        defaultColor = BGcolor
    }
    
    func AddimageONbackground(
        Bgimage:String
    ){
        let BG_img = UIImageView(
            frame: VC.view.bounds
        )
        BG_img.image = UIImage(
            named: Bgimage
        )
        BG_img.contentMode = .scaleToFill
        
        VC.view
            .addSubview(
                BG_img
            )
        VC.view
            .sendSubviewToBack(
                BG_img
            )
    }
}
