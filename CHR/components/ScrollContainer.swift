import UIKit

class SCROLAREA {
    
    // item -> items
    // wraper -> wrap the items
    var VC : UIViewController
    var btn: BUTTON_ACTIVITY!
    var scrollView: VarticalScrolling?
    // controle
    class VarticalScrolling: UIScrollView {
        override var contentOffset: CGPoint {
            get{
                return super.contentOffset
            }
            set{
                super.contentOffset = CGPoint(x:0 , y: newValue.y)
            }
        }
    }
    
    init(VC: UIViewController) {
        self.VC = VC
    }
    
    private func Cellinit(I:Int,Gap:Int,cellHeight:Int ,cellwidth:Int, Items: ()-> [UIView] )->UIView{
        let cell = UIView()
//        cell.backgroundColor = .white
//        cell.layer.cornerRadius = 20
        cell.clipsToBounds = true
        cell.frame = CGRect(
                        x: 10,
                        y: 20 + (I * (cellHeight + Gap)),
                        width: cellwidth - 30,
                        height: cellHeight
        )
        let itemView = Items()
        
        for item in itemView {
            cell.addSubview(item)
        }
        
        
        
        return cell
    }
    
    // why this one is importent @escaping ()-> what the meaning on this ()-> and whats need of this  @escaping

    
    
    func Scroll(height: Int,
                width:Int! ,
                view_X:Int!,
                view_Y:Int,
                Cellcount:Int ,
                cellHeight:Int ,
                cellwidth:Int,Gap:Int, items: @escaping (Int)-> [UIView]){
        
        scrollView?.removeFromSuperview() // it well remove the cell when again cell calling
        let scrollView = VarticalScrolling(frame: VC.view.bounds)
        VC.view.addSubview(scrollView)
        self.scrollView = scrollView // it can save the reference of previus cell information (it act like information frzer)
        

        
        for i in 0...Cellcount{
            
            let subcell = Cellinit(I: i,Gap:Gap,cellHeight: cellHeight,cellwidth:cellwidth, Items: {
                items(i)
            })
            scrollView.addSubview(subcell)
        }
        
        // scrolll area
        scrollView.frame = CGRect(x: view_X ?? Int(0),
                                  y: view_Y,
                                  width: width ?? Int(VC.view.frame.width),
                                  height: height
        )

        scrollView.contentSize = CGSize(
               width: VC.view.frame.width,
               height: CGFloat(Cellcount * (cellHeight + 50))
        )
        
        // scrollView.alwaysBounceHorizontal = false
        scrollView.showsHorizontalScrollIndicator = false
        // scrollView.backgroundColor = .systemBlue
    }

   
}


//for i in 0...100{
//
//
//            let arg = CARD.CardDising(
//                P_X: 70,
//                P_Y: 20 + (i * 320),
//                Width: 250,
//                Height: 300
//            )
//
//            let cardView = Cards.Add_Card(
//                on: scrollView, // ✅ FIX
//                CardDisingAgrument: arg
//            )
//
//    scrollView.addSubview(cardView)
//}
//
//scrollView.frame = CGRect(x: 0,
//                          y: 10,
//
//                          width: self.view.frame.width,
//                          height:self.view.frame.height - 40
//)
//
//scrollView.contentSize = CGSize(
//       width: self.view.frame.width,
//       height: 250 + (100 * 320)
//   )
//scrollView.backgroundColor = .systemBlue
