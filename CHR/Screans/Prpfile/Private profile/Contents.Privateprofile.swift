// ---------------------------Rules------------------
// 1.all layout classname should be represent pagename-classname-shortformofcontent
// 2. make posiable this class i use IGBO(
//        Instructor: it is helping to handle class lavle error and insilize the class and ther function
//        Getway: this use for bring instction of the outsite of the class
//        Builder: it can Handle all the insider element such as (button , label etx...)
//        operator: it can Handle to class level work such as spess betwint two element etx..
//    ) method
import UIKit


class PRIVATE_PROFILE_COVERIMG_CNT:UIImageView {
    // Class instructor
    convenience init() {
        self.init(frame: .zero)
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        Configur()
    }
    
    // class builder
    struct Elements {
        var Imagename:String = "Nointernet"
    }
    // imgDownlooder(args.data.coverimg) -> return the string(imgname) that downllod and read to use
     
    // Getway
    var Element = Elements()
    func Constructor(Img:String){
        image = UIImage(named: Img)
    }
    
    // class operator
    required init?(coder: NSCoder) {
        fatalError("PRIVATE_PROFILE_DETAILS_LYT has not been implemented")
    }
    
    private func Configur(){
       translatesAutoresizingMaskIntoConstraints = false
       contentMode = .scaleAspectFill
       clipsToBounds = true
       layer.cornerRadius = 18
       image = UIImage(named: Element.Imagename)
    }
}

class PRIVATE_PROFILE_PROFILEIMG_CNT:UIImageView {
    // Class instructor
    convenience init() {
        self.init(frame: .zero)
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        Configur()
    }
    
    // class builder
    struct Elements {
        var Imagename:String = "TEST"
    }
    
    // Getway
    var Element = Elements()
    func Constructor(Img:String){
        image = UIImage(named: Img)
    }
    
    // class operator
    required init?(coder: NSCoder) {
        fatalError("PRIVATE_PROFILE_DETAILS_LYT has not been implemented")
    }
    
    private func Configur(){
       translatesAutoresizingMaskIntoConstraints = false
       contentMode = .scaleAspectFill
       clipsToBounds = true
       layer.cornerRadius = 35
       image = UIImage(named: Element.Imagename)
    }
}


class PRIVATE_PROFILE_BIO_CNT:UILabel {
    // Getway
    var ActionText = ""
    var OriginalBio =  "Passionate about building things that matter. Always learning, always growing. Coffee enthusiast ☕ | Dreamer & doer 🚀 UI/UX Designer and landscape photographer based in Seattle. Currently exploring the intersection of nature and digital interactions Always up for a coffee and a chat about minimalist"

    // Builder
    private func TextOperation(){
        
        if(OriginalBio.count > 150){
            previewText()
        }else{
            text = OriginalBio
            textColor = APPCOLOR.ContentColor
        }
        
    }
    
    @objc func previewText(){
        APPCOLOR.CurrentThem()
        
        ActionText = " ...Readmore"
        let visiableBio:String = "\(OriginalBio.prefix(150))"
        
        let BioPreview = visiableBio + ActionText
        let attributedString = NSMutableAttributedString(string: BioPreview)
        let range = (BioPreview as NSString).range(of: ActionText)
        
        textColor = APPCOLOR.ContentColor.withAlphaComponent(0.8)
        attributedString.addAttributes([ .foregroundColor: UIColor.systemBlue.withAlphaComponent(1) ], range: range )
        self.attributedText = attributedString
        textAlignment = .left
        numberOfLines = 4
        isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(ShowFullBio))
        addGestureRecognizer(tapGesture)
    }
    
    @objc func ShowFullBio(_ Gesture: UITapGestureRecognizer) {
        ActionText = "  Readless"
        let FullBio = OriginalBio + ActionText
        let attributedString = NSMutableAttributedString(string: FullBio)
        let range = (FullBio as NSString).range(of: ActionText)
        
        attributedString.addAttributes([.foregroundColor:UIColor.systemBlue.withAlphaComponent(1)],range: range)
        self.attributedText = attributedString
        
        textAlignment = .left
        numberOfLines = 0
        
        isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(previewText))
        addGestureRecognizer(tapGesture)
    }
    
    // class instructor
    
    init(bio:String) {
        self.OriginalBio = bio
        super.init(frame: .zero)
        TextOperation()
        Configur()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("PRIVATE_PROFILE_HEADER_LYT has not been implemented")
    }
    
    // class operator
    private func Configur(){
        translatesAutoresizingMaskIntoConstraints = false
    }
}

class PRIVATE_PROFILE_BIO_STATUS_BAR_INFO:UIView{
    // Getway
    private let number:String
    private let title:String
    
    // Builder
    private func Builder(){
        APPCOLOR.CurrentThem()
        let infolabel_TITEL =  UILabel()
        let infolabel_NUMBER = UILabel()
        
        infolabel_TITEL.translatesAutoresizingMaskIntoConstraints = false
        infolabel_NUMBER.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(infolabel_TITEL)
        addSubview(infolabel_NUMBER)
        
        NSLayoutConstraint.activate([
            
            infolabel_NUMBER.topAnchor.constraint(equalTo: self.topAnchor, constant: 28),
            infolabel_NUMBER.leadingAnchor.constraint(equalTo: self.leadingAnchor ),
            infolabel_NUMBER.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            
            
            infolabel_TITEL.topAnchor.constraint(equalTo: infolabel_NUMBER.bottomAnchor , constant: 5),
            infolabel_TITEL.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            infolabel_TITEL.trailingAnchor.constraint(equalTo: self.trailingAnchor),
        ])
        
        
        // infolabel_TITEL.backgroundColor = .milkWhite
        infolabel_TITEL.text = "\(title)"
        infolabel_TITEL.textColor = APPCOLOR.SubContentColor
        infolabel_TITEL.font = .systemFont(ofSize: 10 , weight: .semibold)
        infolabel_NUMBER.font = UIFont(name: "Inter-SemiBold", size: 10)
        infolabel_TITEL.textAlignment = .center
        
        // infolabel_NUMBER.backgroundColor = .milkWhite
        infolabel_NUMBER.text = "\(number)"
        infolabel_NUMBER.textColor = APPCOLOR.ContentColor
        infolabel_NUMBER.font = .systemFont(ofSize: 18 , weight: .bold)
        // infolabel_NUMBER.font = UIFont(name: "Inter-Bold", size: 18)
        infolabel_NUMBER.textAlignment = .center
    }
    
    
    // class instructor
    init(title:String , number:String){
        self.title = title
        self.number = number
        super.init(frame: .zero)
        Configur()
        Builder()
    }
    required init?(coder: NSCoder) {
        
        fatalError("PRIVATE_PROFILE_BIO_STATUS_BAR_INFO has not been implemented")
    }
    // class operator
    private func Configur(){
        translatesAutoresizingMaskIntoConstraints = false
        layer.cornerRadius = 18
    }
}


class PRIVATE_PROFILE_INTREST_CAPSULE: UILabel {
    // GETWAY
    let ICON_img:String
    let NAME:String
    let ishighlight:Bool
    
    // BULDER
    struct CurrentThem {
        let TextAndIconColor:UIColor
        let CapculeBackgroundColor:UIColor
        let CapculeBorderColor:UIColor
    }
    


    
    
    func CurrentThemModifier()->CurrentThem{
        APPCOLOR.CurrentThem()
        
        if(APPCOLOR.Islight){
            return CurrentThem(
                        TextAndIconColor: UIColor.eveningBlack,
                        CapculeBackgroundColor: UIColor.eveningLight,
                        CapculeBorderColor: ishighlight ? UIColor.systemGreen: UIColor.white
            )
        }
        
        return CurrentThem(
                    TextAndIconColor: UIColor.eveningLight ,
                    CapculeBackgroundColor: UIColor.eveningBlack,
                    CapculeBorderColor: ishighlight ? UIColor.systemGreen: UIColor.darkbordercolor
        )
        
    }
    
    func MakeCapsule(){
        let currentColor = CurrentThemModifier()
        
        
       let Icon = UIImageView(image: UIImage(systemName:"\(ICON_img)" ))
       text = "           \(NAME)    "
       textColor = currentColor.TextAndIconColor
       numberOfLines = 1
        Icon.translatesAutoresizingMaskIntoConstraints = false
        Icon.tintColor = currentColor.TextAndIconColor
        Icon.contentMode = .scaleAspectFit
        addSubview(Icon)
        NSLayoutConstraint.activate([
                    heightAnchor.constraint(equalToConstant: 40),
                    Icon.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
                    Icon.centerYAnchor.constraint(equalTo: centerYAnchor),
                    Icon.widthAnchor.constraint(equalToConstant: 17),
                    Icon.heightAnchor.constraint(equalToConstant: 17),
        ])
    }

    // INSTRUCTURE
    init(Icon:String , name:String , ishighlight:Bool) {
        self.NAME = name
        self.ICON_img = Icon
        self.ishighlight = ishighlight
        super.init(frame: .zero)
        MakeCapsule()
        Configur()
    }
    
    required init?(coder: NSCoder) {
        fatalError("PRIVATE_PROFILE_HEADER_LYT has not been implemented")
    }
    // OPERATOR
    func Configur(){
        let currentColor = CurrentThemModifier()
        
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = currentColor.CapculeBackgroundColor
        layer.borderColor = currentColor.CapculeBorderColor.cgColor
        layer.borderWidth = 2
        layer.cornerRadius = 20
        clipsToBounds = true
    }
    
}

class PRIVATE_PROFILE_CONTENT_CNT{
    // resive array of a posts [img , texts , videos]
    // create a array that have posts and the add post action
    
    // Getway
    
    // Builder
    
    func Getitems(){
        
    }
    // class instructure
    init(frame: CGRect) {
        Getitems()
    }
    
    required init?(coder: NSCoder) {
        fatalError("PRIVATE_PROFILE_CONTENT_CNT has not been implemented")
    }
}
