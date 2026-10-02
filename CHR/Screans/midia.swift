import UIKit

class PRIVITEPROFILE: UIViewController {   // ✅ Must inherit from UIViewControl
    let Heder_Layout: UIView = {
        let Heder_Layout = UIView()
        Heder_Layout.translatesAutoresizingMaskIntoConstraints = false
        // Heder_Layout.backgroundColor = .systemBlue

        let insiderBOX = UIView()
        insiderBOX.translatesAutoresizingMaskIntoConstraints = false
        // insiderBOX.backgroundColor = .systemPurple
        insiderBOX.layer.cornerRadius = 10
        Heder_Layout.addSubview(insiderBOX)

        NSLayoutConstraint.activate([
            insiderBOX.topAnchor.constraint(equalTo: Heder_Layout.topAnchor, constant: 10),
            insiderBOX.leadingAnchor.constraint(equalTo: Heder_Layout.leadingAnchor, constant: 10),
            insiderBOX.trailingAnchor.constraint(equalTo: Heder_Layout.trailingAnchor, constant: -10),
            insiderBOX.bottomAnchor.constraint(equalTo: Heder_Layout.bottomAnchor, constant: -10)
        ])

            let Button_Back = UIButton()
            Button_Back.translatesAutoresizingMaskIntoConstraints = false
            Button_Back.setTitle("<-", for: .normal)
            Button_Back.setTitleColor(.white, for: .normal)
            Button_Back.backgroundColor = .systemBackground
            Button_Back.layer.cornerRadius = 20
        
            // Button_Back.clipsToBounds = true
            insiderBOX.addSubview(Button_Back)

            let Text_Title = UILabel()
            Text_Title.translatesAutoresizingMaskIntoConstraints = false
            Text_Title.text = "Profile"
            Text_Title.textColor = .black
            Text_Title.font = UIFont.boldSystemFont(ofSize: 30)
            insiderBOX.addSubview(Text_Title)

            NSLayoutConstraint.activate([
                // Back button: pinned to the left, vertically centered, fixed circular size
                Button_Back.leadingAnchor.constraint(equalTo: insiderBOX.leadingAnchor, constant: 12),
                Button_Back.centerYAnchor.constraint(equalTo: insiderBOX.centerYAnchor),
                Button_Back.widthAnchor.constraint(equalToConstant: 40),
                Button_Back.heightAnchor.constraint(equalToConstant: 40),

                // Title: dead center of insiderBOX, both axes
                Text_Title.centerXAnchor.constraint(equalTo: insiderBOX.centerXAnchor),
                Text_Title.centerYAnchor.constraint(equalTo: insiderBOX.centerYAnchor)
            ])

        return Heder_Layout
    }()
    let content_Layout: UIView = {
        let content_Layout = UIView()
        // content_Layout.backgroundColor = .systemMint
        content_Layout.translatesAutoresizingMaskIntoConstraints = false
        
        let CoverIMG = UIImageView()
        CoverIMG.translatesAutoresizingMaskIntoConstraints = false
        CoverIMG.backgroundColor = .systemPurple
        CoverIMG.contentMode = .scaleAspectFill
        CoverIMG.clipsToBounds = true
        CoverIMG.image = UIImage(named: "TEST")
        CoverIMG.layer.cornerRadius = 25
        
        content_Layout.addSubview(CoverIMG)

        
        
        let profileStatusBAR = UIView()
        profileStatusBAR.translatesAutoresizingMaskIntoConstraints = false
        profileStatusBAR.backgroundColor = .white
        profileStatusBAR.layer.cornerRadius = 20
        content_Layout.addSubview(profileStatusBAR)
        
            func infoBOX(Number:String , label:String )->UIView{
                let info = UIView()
                info.translatesAutoresizingMaskIntoConstraints = false
                // info.backgroundColor = .systemMint
                
                let infolabel_NUMBER = UILabel()
                infolabel_NUMBER.translatesAutoresizingMaskIntoConstraints = false
                infolabel_NUMBER.text = Number
                infolabel_NUMBER.textColor = .black
                infolabel_NUMBER.font = .systemFont(ofSize: 18 , weight: .bold)
                infolabel_NUMBER.textAlignment = .center
                info.addSubview(infolabel_NUMBER)
                
                let infolabel_TITEL = UILabel()
                infolabel_TITEL.translatesAutoresizingMaskIntoConstraints = false
                infolabel_TITEL.text = label
                infolabel_TITEL.textColor = .nightDark
                infolabel_TITEL.font = .systemFont(ofSize: 10 , weight: .semibold)
                infolabel_TITEL.textAlignment = .center
                info.addSubview(infolabel_TITEL)
                
                NSLayoutConstraint.activate([
                    
                    
                    infolabel_NUMBER.topAnchor.constraint(equalTo:info.topAnchor ),
                    infolabel_NUMBER.leadingAnchor.constraint(equalTo: info.leadingAnchor ),
                    infolabel_NUMBER.trailingAnchor.constraint(equalTo: info.trailingAnchor),
                    
                    
                    infolabel_TITEL.topAnchor.constraint(equalTo: infolabel_NUMBER.bottomAnchor , constant: 5),
                    infolabel_TITEL.leadingAnchor.constraint(equalTo: info.leadingAnchor),
                    infolabel_TITEL.trailingAnchor.constraint(equalTo: info.trailingAnchor),
                    infolabel_TITEL.bottomAnchor.constraint(equalTo: info.bottomAnchor)
                    
                ])
                return info
            }
            
            func Divider()->UIView{
                let divider = UIView()
                divider.translatesAutoresizingMaskIntoConstraints = false
                divider.backgroundColor = .morningLight
                
                return divider
            }
            
            let Chats = infoBOX(Number: "26M", label: "CHATS")
            let follwers = infoBOX(Number: "28M", label: "FOLLOWERS")
            let following = infoBOX(Number: "34k", label: "FOLLOWING")
            let DivderOne = Divider()
            let DividerTwo = Divider()
            
            [Chats , DivderOne , follwers , DividerTwo , following].forEach{profileStatusBAR.addSubview($0)}
            
            NSLayoutConstraint.activate([
                
                
                Chats.centerYAnchor.constraint(equalTo: profileStatusBAR.centerYAnchor),
                Chats.leadingAnchor.constraint(equalTo: profileStatusBAR.leadingAnchor),
                Chats.widthAnchor.constraint(equalTo: profileStatusBAR.widthAnchor, multiplier: 0.33),
                
                DivderOne.centerYAnchor.constraint(equalTo: profileStatusBAR.centerYAnchor),
                DivderOne.leadingAnchor.constraint(equalTo: Chats.trailingAnchor),
                DivderOne.widthAnchor.constraint(equalToConstant: 1),
                DivderOne.heightAnchor.constraint(equalToConstant: 44),
                
                follwers.centerYAnchor.constraint(equalTo: profileStatusBAR.centerYAnchor),
                follwers.leadingAnchor.constraint(equalTo: DivderOne.trailingAnchor),
                follwers.widthAnchor.constraint(equalTo: profileStatusBAR.widthAnchor, multiplier: 0.33),

                DividerTwo.centerYAnchor.constraint(equalTo: profileStatusBAR.centerYAnchor),
                DividerTwo.leadingAnchor.constraint(equalTo: follwers.trailingAnchor, constant: -4),
                DividerTwo.widthAnchor.constraint(equalToConstant: 1),
                DividerTwo.heightAnchor.constraint(equalToConstant: 44),
                
                following.centerYAnchor.constraint(equalTo: profileStatusBAR.centerYAnchor),
                following.leadingAnchor.constraint(equalTo: DividerTwo.trailingAnchor),
                following.trailingAnchor.constraint(equalTo: profileStatusBAR.trailingAnchor)
                
            ])
        
        
        func BIO(TEXT: String) -> UIView {
            let BioBox = UIView()
            BioBox.translatesAutoresizingMaskIntoConstraints = false

            let FullBio = UILabel()
            FullBio.translatesAutoresizingMaskIntoConstraints = false
            FullBio.textColor = .nightDark
            FullBio.backgroundColor = .systemMint
            FullBio.layer.cornerRadius = 20
            FullBio.numberOfLines = 0               // limit lines so "Read more" makes sense
            FullBio.lineBreakMode = .byTruncatingTail
            FullBio.isUserInteractionEnabled = true  // needed so tap gesture works

            // Build the combined text: bio + inline "Read more"
            let mainText = NSMutableAttributedString(
                string: TEXT,
                attributes: [
                    .font: UIFont.systemFont(ofSize: 15, weight: .regular),
                    .foregroundColor: UIColor.nightDark
                ]
            )

            let readMoreText = NSAttributedString(
                string: "  Read more",
                attributes: [
                    .font: UIFont.systemFont(ofSize: 12, weight: .semibold),
                    .foregroundColor: UIColor.systemBlue
                ]
            )

            mainText.append(readMoreText)
            FullBio.attributedText = mainText

            BioBox.addSubview(FullBio)

            NSLayoutConstraint.activate([
                FullBio.topAnchor.constraint(equalTo: BioBox.topAnchor),
                FullBio.leadingAnchor.constraint(equalTo: BioBox.leadingAnchor),
                FullBio.trailingAnchor.constraint(equalTo: BioBox.trailingAnchor),
                FullBio.bottomAnchor.constraint(equalTo: BioBox.bottomAnchor)
            ])

            return BioBox
        }
        let Bio = BIO(TEXT: "UI/UX Designer and landscape photographer based in Seattle. Currently exploring the intersection of nature and digital interactions Always up for acoffee and a chat about minimalist .Read more hii i am your BFF i love you dear ")
        content_Layout.addSubview(Bio)
        
        
        
        
        
        
        
        NSLayoutConstraint.activate([
            
            CoverIMG.topAnchor.constraint(equalTo: content_Layout.topAnchor, constant: 10),
            CoverIMG.leadingAnchor.constraint(equalTo: content_Layout.leadingAnchor, constant: 30),
            CoverIMG.trailingAnchor.constraint(equalTo: content_Layout.trailingAnchor, constant: -30),
            CoverIMG.heightAnchor.constraint(equalTo: content_Layout.heightAnchor, multiplier: 0.5),
            
            profileStatusBAR.topAnchor.constraint(equalTo: CoverIMG.bottomAnchor, constant: 20),
            profileStatusBAR.leadingAnchor.constraint(equalTo: content_Layout.leadingAnchor, constant: 30),
            profileStatusBAR.trailingAnchor.constraint(equalTo: content_Layout.trailingAnchor, constant: -30),
            profileStatusBAR.heightAnchor.constraint(equalToConstant: 90),
            
            Bio.topAnchor.constraint(equalTo: profileStatusBAR.bottomAnchor, constant: 20),
            Bio.leadingAnchor.constraint(equalTo: content_Layout.leadingAnchor, constant: 30),
            Bio.trailingAnchor.constraint(equalTo: content_Layout.trailingAnchor, constant: -30),

            
        ])
        
        return content_Layout
    }()
    
    let scroolView: UIScrollView = {
        let ScrollComponents = UIScrollView()
        ScrollComponents.translatesAutoresizingMaskIntoConstraints = false
        ScrollComponents.backgroundColor = .systemBlue
        
        
        
        let ContentShow = UIView()
        ContentShow.translatesAutoresizingMaskIntoConstraints = false
        ContentShow.backgroundColor = .black
        ScrollComponents.addSubview(ContentShow)
        NSLayoutConstraint.activate([

            ContentShow.topAnchor.constraint(equalTo: ScrollComponents.contentLayoutGuide.topAnchor),
            ContentShow.leadingAnchor.constraint(equalTo: ScrollComponents.contentLayoutGuide.leadingAnchor ),
            ContentShow.trailingAnchor.constraint(equalTo: ScrollComponents.contentLayoutGuide.trailingAnchor ),
            ContentShow.bottomAnchor.constraint(equalTo: ScrollComponents.contentLayoutGuide.bottomAnchor),

            ContentShow.widthAnchor.constraint(equalTo: ScrollComponents.frameLayoutGuide.widthAnchor)

        ])
        
        let topCom = UIView()
        topCom.translatesAutoresizingMaskIntoConstraints = false
        topCom.backgroundColor = .milkwhite
        let midCom = UIView()
        midCom.translatesAutoresizingMaskIntoConstraints = false
        midCom.backgroundColor = .nightDark
        let botCom = UIView()
        botCom.translatesAutoresizingMaskIntoConstraints = false
        botCom.backgroundColor = .systemMint
        
        ContentShow.addSubview(topCom)
        ContentShow.addSubview(midCom)
        ContentShow.addSubview(botCom)
        
        NSLayoutConstraint.activate([

            topCom.topAnchor.constraint(equalTo: ContentShow.topAnchor),
            topCom.leadingAnchor.constraint(equalTo: ContentShow.leadingAnchor, constant: 10),
            topCom.trailingAnchor.constraint(equalTo: ContentShow.trailingAnchor, constant: -10),
            topCom.heightAnchor.constraint(equalToConstant: 600),

            midCom.topAnchor.constraint(equalTo: topCom.bottomAnchor),
            midCom.leadingAnchor.constraint(equalTo: ContentShow.leadingAnchor, constant: 10),
            midCom.trailingAnchor.constraint(equalTo: ContentShow.trailingAnchor, constant: -10),
            midCom.heightAnchor.constraint(equalToConstant: 900),

            botCom.topAnchor.constraint(equalTo: midCom.bottomAnchor),
            botCom.leadingAnchor.constraint(equalTo: ContentShow.leadingAnchor, constant: 10),
            botCom.trailingAnchor.constraint(equalTo: ContentShow.trailingAnchor, constant: -10),
            botCom.heightAnchor.constraint(equalToConstant: 660),
            botCom.bottomAnchor.constraint(equalTo: ContentShow.bottomAnchor)

        ])
        
        return ScrollComponents
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .milkwhite
        
        view.addSubview(Heder_Layout)
        view.addSubview(scroolView)
        // view.addSubview(content_Layout)
        
        
        Autosizing()
    }
    
    func Autosizing(){
        NSLayoutConstraint.activate([
            // Heder sizing
            Heder_Layout.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            Heder_Layout.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            Heder_Layout.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            Heder_Layout.heightAnchor.constraint(equalToConstant: 60),
            
            
            scroolView.topAnchor.constraint(equalTo: Heder_Layout.bottomAnchor , constant:  20),
            scroolView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scroolView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scroolView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            
            // content
            // content_Layout.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            // content_Layout.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            // content_Layout.heightAnchor.constraint(equalToConstant: 730),
            
            // content_Layout.topAnchor.constraint(equalTo: Heder_Layout.bottomAnchor, constant: 10),
            // content_Layout.bottomAnchor.constraint(equalTo: view.bottomAnchor , constant: 10),

        ])
    }

}

