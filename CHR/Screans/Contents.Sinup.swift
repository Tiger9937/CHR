import UIKit

class SINGIN_TITLE_CNT:UIView {
    //class Getway
    struct Controlelements{
        var PageTitle:String = " "
        var PageTitletextColor:UIColor = .black
        var BackbuttonColor:UIColor = .black
        var SpaceBetweenButton_AND_Pagename:CGFloat = 80
    }
    var Controlelement:Controlelements
    
    func Constructor(PageTitletext:String! , PageTitletextColor:UIColor! , BackButtonColor:UIColor! , SpaceBetweenButtonANDPagename:CGFloat!,
        ){
        
        Controlelement.BackbuttonColor = BackButtonColor
        Controlelement.PageTitletextColor = PageTitletextColor
        Controlelement.BackbuttonColor = BackButtonColor
        Controlelement.SpaceBetweenButton_AND_Pagename = SpaceBetweenButtonANDPagename
    }
    
    
    // class Builder
    struct elemnts{
        let BackButton = UIButton()
        let Pagename = UILabel()
    }
    
    let element = elemnts()
    private func BackButtonView(){
        APPCOLOR.CurrentThem()
        let BackButton = element.BackButton
        BackButton.translatesAutoresizingMaskIntoConstraints = false
        BackButton.tintColor = APPCOLOR.ContentColor
        BackButton.setImage(UIImage(systemName: "chevron.left"), for: .normal)
        BackButton.backgroundColor = APPCOLOR.LayoutToperColor
        BackButton.layer.cornerRadius = 20
        addSubview(BackButton)
        NSLayoutConstraint.activate([
            BackButton.topAnchor.constraint(equalTo: topAnchor),
            BackButton.widthAnchor.constraint(equalToConstant: 40),
            BackButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    private func PageNameView(){
        APPCOLOR.CurrentThem()
        let Pagename = element.Pagename
        Pagename.translatesAutoresizingMaskIntoConstraints = false
        Pagename.text = Controlelement.PageTitle
        Pagename.textAlignment = .center
        Pagename.textColor = APPCOLOR.ContentColor
        Pagename.font = UIFont.boldSystemFont(ofSize: 30)
        addSubview(Pagename)
        NSLayoutConstraint.activate([
            Pagename.centerXAnchor.constraint(equalTo: centerXAnchor),
            Pagename.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
    // class instructor
    init(title:String){
        Controlelement = Controlelements()
        Controlelement.PageTitle = title
        super.init(frame: .zero)
        Configur()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("PRIVATE_PROFILE_HEADER_LYT has not been implemented")
    }
    
    
    // class operator
    private func Configur(){
        translatesAutoresizingMaskIntoConstraints = false
        layer.cornerRadius = 15
        BackButtonView()
        PageNameView()
    }
}

