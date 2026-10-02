import UIKit

class SLIDER {
    var SlideView = UIView()
    var Bar = UILabel()
    private var C_Height:CGFloat = 0
    
    struct SliderInfo{
        var Slider_ISvisible:Bool!
        var SliderBG_color:UIColor!
        var Slider_P_X:Int!
        var Slider_P_Y:Int!
        var Slider_Width: Int!
        var Slider_Height: Int!
    }
    
    struct SliderBarInfo{
        var SliderBarBG_color:UIColor!
        var SliderBar_P_X:Int!
        var SliderBar_P_Y:Int!
        var SliderBar_Width: Int!
        var SliderBar_Height: Int!
    }
    
    
    
    
    func Add_Slider(on view:UIView , Slider_InfoArgument:SliderInfo , SliderBar_Info:SliderBarInfo
    ){
        // if(Slider_InfoArgument.Slider_ISvisible == true){
            
            SlideView.backgroundColor = Slider_InfoArgument.SliderBG_color
            SlideView.frame = CGRect(x: Slider_InfoArgument.Slider_P_X,
                                     y: Slider_InfoArgument.Slider_P_Y,
                                     width: Slider_InfoArgument.Slider_Width,
                                     height: Slider_InfoArgument.Slider_Height
            )
            SlideView.layer.cornerRadius = 20
            SlideView.layer.masksToBounds = true
            
            // if the usser dragUP (Tuchdown and grag up)
            // Slider_Height ++
            
            Bar.backgroundColor = SliderBar_Info.SliderBarBG_color
            
            Bar.frame = CGRect(x: SliderBar_Info.SliderBar_P_X,
                               y: SliderBar_Info.SliderBar_P_Y,
                               width: SliderBar_Info.SliderBar_Width,
                               height: SliderBar_Info.SliderBar_Height
            )
            
            Bar.layer.cornerRadius = 3
            Bar.layer.masksToBounds = true
            
            Bar.center = CGPoint(
                x: SlideView.frame.width / 2,
                y: SlideView.frame.height / 20
            )
            view.addSubview(SlideView)
        
        let panGesture = UIPanGestureRecognizer(target: self,
                                                        action: #selector(Drager(_:)))
            SlideView.addGestureRecognizer(panGesture)
            SlideView.addSubview(Bar)
           
        
        
    }
    
    @objc func Drager(_ gesture: UIPanGestureRecognizer){
        // UIPanGestureRecognizer is that cam handel draging on the screan
       //  guard Gesture.view != nil else {return}
        let translation = gesture.translation(in: SlideView.superview)
        
        
        
        switch gesture.state{
            
            case .began:
               C_Height = SlideView.frame.origin.y
            
            
            case .changed:
                // let newHeight = C_Height + translation.y
            
            let newHeight = C_Height + translation.y
              
              if newHeight >= 100 && newHeight <= 700 {
                  SlideView.frame.origin.y = newHeight
                  // SlideView.frame.size.height = 600
              }
            
            case .ended:
                print("is ok")
            
            
            default:
                    break
            }
            
        }
        
    }
    


class UI_SLIDER: SLIDER{
    
    var VC : UIViewController
    
    init(VC: UIViewController) {
        self.VC = VC
    }
    
     
    
    struct UISlider_Info{
        var Slider_ISvisible:Bool!
        var SliderBG_color:UIColor!
        var Slider_P_X:Int!
        var Slider_P_Y:Int!
        var Slider_Width: Int!
        var Slider_Height: Int!
    }
    
    struct UISliderBar_Info{
        var SliderBarBG_color:UIColor!
        var SliderBar_P_X:Int!
        var SliderBar_P_Y:Int!
        var SliderBar_Width: Int!
        var SliderBar_Height: Int!
    }
    
    
    func AddSlider(
                   Slider_InfoArgument:UISlider_Info ,
                   SliderBar_InfoArgument:UISliderBar_Info
    ){
         // guard Slider_InfoArgument != nil else {return}
        let Slider_Info = SliderInfo(
            Slider_ISvisible: Slider_InfoArgument.Slider_ISvisible,
            SliderBG_color: Slider_InfoArgument.SliderBG_color,
            Slider_P_X: Slider_InfoArgument.Slider_P_X,
            Slider_P_Y: Slider_InfoArgument.Slider_P_Y,
            Slider_Width: Slider_InfoArgument.Slider_Width,
            Slider_Height: Slider_InfoArgument.Slider_Height
        )
        
        
        let SliderBar_Info = SliderBarInfo(
            
            SliderBarBG_color: SliderBar_InfoArgument.SliderBarBG_color,
            SliderBar_P_X: SliderBar_InfoArgument.SliderBar_P_X,
            SliderBar_P_Y: SliderBar_InfoArgument.SliderBar_P_Y,
            SliderBar_Width: SliderBar_InfoArgument.SliderBar_Width,
            SliderBar_Height: SliderBar_InfoArgument.SliderBar_Height
            
        )
        
        super.Add_Slider(on: VC.view,
                         Slider_InfoArgument:Slider_Info,
                         SliderBar_Info: SliderBar_Info
        )
    }
    
}
