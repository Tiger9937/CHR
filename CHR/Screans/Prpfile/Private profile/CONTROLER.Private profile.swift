// Private profile vc · SWIFT
// ---------------------------Rules------------------
// 1. we have two structure(struct) one for layout and anthor for contents that give ass access of All the layout and content
// 2. inside the VC we have use 3 things layoutsizing(position of the main section and the Heder Section),hader(this can contain hading related content),main(A container that contain All the content for this page)
// 3. inside the main function we have diffrent diffrent functions and each function represent a element()
// 4. each element if need any layout or componets get thought variable
// 5. LYT(layout) CNT(content) CONT(Controler)
// --------------------------Error------------------
// 1. Thread 1: it is the uikit error that tell a element is not in your prrent view hierarchy

import UIKit

struct privetprofile_CMPTS {
    let HEADER__CMPT = HEADER_CMPT(title: "PROFILE")
}

struct privetprofile_LYTS {
    let HEADER_LYT             = PRIVATE_PROFILE_HEADER_LYT()
    let CONTENT_LYT            = PRIVATE_PROFILE_CONTENT_LYT()
    let STATUSBAR_LYT          = PRIVATE_PROFILE_STATUSBAR_LYT()
    let BIOINFO_LYT            = PRIVATE_PROFILE_BIOINFO_LYT()
    let PROFILE_INTREST_LYT    = PRIVATE_PROFILE_INTREST_LYT()
    let PROFILEFRONTPANAL_LYT  = PRIVATE_PROFILE_COVERIMG_LYT()
    let scrollLayout           = UIScrollView()
}

@MainActor
class PRIVATE_PROFILE_VC: UIViewController {

    // MARK: - Properties

    let LYT                         = privetprofile_LYTS()
    let CMPT                        = privetprofile_CMPTS()
    let internetcall                = INTERNET()
    let refreshControl              = UIRefreshControl()

    // MARK: - Lifecycle

    override func viewDidLoad() {
        APPCOLOR.CurrentThem()
        super.viewDidLoad()

        let scrollLayout = LYT.scrollLayout
        view.backgroundColor = APPCOLOR.BackgroundColor
        view.addSubview(LYT.HEADER_LYT)
        view.addSubview(scrollLayout)

        Auto_LYT_Sizing()
        HaderView()
        setupRefreshControl(on: scrollLayout)

        LOAD()
        // background thread
    }

    // MARK: - Setup

    func Auto_LYT_Sizing() {
        LYT.HEADER_LYT.translatesAutoresizingMaskIntoConstraints = false
        LYT.scrollLayout.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            LYT.HEADER_LYT.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            LYT.HEADER_LYT.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            LYT.HEADER_LYT.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            LYT.HEADER_LYT.heightAnchor.constraint(equalToConstant: 60),

            LYT.scrollLayout.topAnchor.constraint(equalTo: LYT.HEADER_LYT.bottomAnchor, constant: 10),
            LYT.scrollLayout.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            LYT.scrollLayout.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            LYT.scrollLayout.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }

    func HaderView() {
        let Haderlayout = LYT.HEADER_LYT
        let Haderview = CMPT.HEADER__CMPT
        Haderview.translatesAutoresizingMaskIntoConstraints = false
        Haderlayout.addSubview(Haderview)

        NSLayoutConstraint.activate([
            Haderview.topAnchor.constraint(equalTo: Haderlayout.topAnchor, constant: 10),
            Haderview.leadingAnchor.constraint(equalTo: Haderlayout.leadingAnchor, constant: 10),
            Haderview.trailingAnchor.constraint(equalTo: Haderlayout.trailingAnchor, constant: -10),
            Haderview.heightAnchor.constraint(equalToConstant: 40),
        ])
    }

    /// Wires up pull-to-refresh on the given scroll view.
    func setupRefreshControl(on scrollLayout: UIScrollView) {
        refreshControl.addTarget(
            self,
            action: #selector(reloadPage),
            for: .valueChanged
        )
        scrollLayout.refreshControl = refreshControl
    }

    // MARK: - Networking

    private func Online() async -> PRIVET_PROFILE_RES? {
        do {
            let data = try await internetcall.GET(URI: "http://localhost:8000/Api/v1/Test/sendTEST2")
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            return try decoder.decode(PRIVET_PROFILE_RES.self, from: data)

        } catch ErrorService.AllNetworkError.Usernetoff {
            let (WentWorng, Retrybutton) = ERRORVIEW.Nointernet(
                ErrorTitle: "No internet connection",
                Description: "Your net is off please check your internet connection"
            )
            view.addSubview(WentWorng)
            NSLayoutConstraint.activate([
                WentWorng.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                WentWorng.centerYAnchor.constraint(equalTo: view.centerYAnchor),
                WentWorng.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
                WentWorng.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            ])
            Retrybutton.addAction(UIAction { _ in
                print("BTN TAB")
            }, for: .touchUpInside)

        } catch ErrorService.AllNetworkError.InvalidURL {
            let RequestError = ERRORVIEW.RequestError(
                ErrorTitle: "InvalidURL",
                Descrption: "Given url is not corect please give the valid URL"
            )
            view.addSubview(RequestError)
            NSLayoutConstraint.activate([
                RequestError.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                RequestError.centerYAnchor.constraint(equalTo: view.centerYAnchor),
                RequestError.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
                RequestError.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            ])

        } catch ErrorService.AllNetworkError.ServerError {
            let RequestError = ERRORVIEW.RequestError(
                ErrorTitle: "Server Error",
                Descrption: "Server Not Responding for this url may server is close"
            )
            view.addSubview(RequestError)
            NSLayoutConstraint.activate([
                RequestError.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                RequestError.centerYAnchor.constraint(equalTo: view.centerYAnchor),
                RequestError.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
                RequestError.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            ])

        } catch ErrorService.AllNetworkError.ServerErrorCode(let statusCode) {
            let BadRequest = ERRORVIEW.BadRequest(
                ErroCode: "\(statusCode)",
                ErroMessage: "THIS THINGS CANTBE PROSSEND"
            )
            view.addSubview(BadRequest)
            NSLayoutConstraint.activate([
                BadRequest.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
                BadRequest.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            ])

        } catch {
            let (WentWorng, Retrybutton) = ERRORVIEW.WentWorng(
                ErrorTitle: "Somthing Went Worng",
                Descrption: "Anable to connect to the server. We couldn't connect to our server right now If the problem continues, please try again later."
            )
            view.addSubview(WentWorng)
            NSLayoutConstraint.activate([
                WentWorng.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                WentWorng.centerYAnchor.constraint(equalTo: view.centerYAnchor),
                WentWorng.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
                WentWorng.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            ])
            Retrybutton.addAction(UIAction { _ in
                print("BTN TAB")
            }, for: .touchUpInside)
        }

        return nil
    }

    // MARK: -  Reload

    private func clearLayout() {
        LYT.PROFILEFRONTPANAL_LYT.subviews.forEach({ $0.removeFromSuperview() })
        LYT.PROFILEFRONTPANAL_LYT.removeFromSuperview()

        LYT.BIOINFO_LYT.subviews.forEach({ $0.removeFromSuperview() })
        LYT.BIOINFO_LYT.removeFromSuperview()

        LYT.PROFILE_INTREST_LYT.subviews.forEach({ $0.removeFromSuperview() })
        LYT.PROFILE_INTREST_LYT.removeFromSuperview()

        LYT.STATUSBAR_LYT.subviews.forEach({ $0.removeFromSuperview() })
        LYT.STATUSBAR_LYT.removeFromSuperview()
    }

    private func LOAD() {
        let LoadView = SpinLoadingView()
        LoadView.startLoading(in: view)

        Task {
            let PriviteProfileData = await Online()
            guard let PriviteProfileData else {
                return
            }
            LoadView.stopLoading()
            main(with: PriviteProfileData)
        }

        LoadView.stopLoading()
    }

    
    @objc func reloadPage() {
        clearLayout()
        LOAD()
        refreshControl.endRefreshing()
    }

    // MARK: - Main

    func main(with response: PRIVET_PROFILE_RES) {
        if response.success == true {
            PROFILE_FRONTPANEL(LYT, with: response)
            STATUS_BAR(LYT, with: response)

            BIO(LYT, with: response)
            INTERESTS(LYT, with: response)
            // POSTS(LYT)
        } else {

            // let RequestError = ERRORVIEW.RequestError(ErrorTitle: "Server Error", Descrption: "Server Not Responding for this url may server is close kindly try again")
            //
            // view.addSubview(RequestError)
            // NSLayoutConstraint.activate([
            //     RequestError.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            //     RequestError.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            //     RequestError.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            //     RequestError.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10)
            // ])

            // let loadingView = LoadingView()
            //
            // view.addSubview(loadingView)
            //
            // NSLayoutConstraint.activate([
            //     loadingView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            //     loadingView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            //     loadingView.heightAnchor.constraint(equalToConstant: 20),
            //     loadingView.widthAnchor.constraint(equalToConstant: 300)
            // ])
            //
            // loadingView.start()
            //
            // DispatchQueue.main.asyncAfter(deadline: .now() + 10) {
            //     loadingView.stop()
            // }
        }
    }
}

// MARK: - Front Panel

func PROFILE_FRONTPANEL(_ Layout: privetprofile_LYTS, with args: PRIVET_PROFILE_RES) {
    // ****  VIEW HIRERCHY STRUCTURE  ****
    /*
        mainbox -> ProfileFrontpanelLayout -> CoverImg -> |-> ProfileImaglayout -> profileImg
                                                        |-> Profiledetailslayout |-> edit Button
                                                                                    |-> Username with VarificationTAG
    */

    let mainbox = Layout.scrollLayout
    let ProfileFrontpanelLayout = Layout.PROFILEFRONTPANAL_LYT

    let ProfileImaglayout = PRIVATE_PROFILE_PROFILEIMG_LYT()
    let Profiledetailslayout = PRIVATE_PROFILE_DETAILS_LYT()

    let CoverIMG = PRIVATE_PROFILE_COVERIMG_CNT()
    let ProfileIMG = PRIVATE_PROFILE_PROFILEIMG_CNT()
    APPCOLOR.CurrentThem()

    ProfileFrontpanelLayout.translatesAutoresizingMaskIntoConstraints = false
    ProfileImaglayout.translatesAutoresizingMaskIntoConstraints = false
    Profiledetailslayout.translatesAutoresizingMaskIntoConstraints = false

    mainbox.addSubview(ProfileFrontpanelLayout)
    ProfileFrontpanelLayout.insertSubview(CoverIMG, at: 0)
    CoverIMG.translatesAutoresizingMaskIntoConstraints = false

    CoverIMG.Constructor(Img: args.data.coverimg)

    NSLayoutConstraint.activate([
        CoverIMG.heightAnchor.constraint(equalTo: ProfileFrontpanelLayout.heightAnchor),
        CoverIMG.widthAnchor.constraint(equalTo: ProfileFrontpanelLayout.widthAnchor),
        CoverIMG.leadingAnchor.constraint(equalTo: ProfileFrontpanelLayout.leadingAnchor),
        CoverIMG.trailingAnchor.constraint(equalTo: ProfileFrontpanelLayout.trailingAnchor),
    ])

    NSLayoutConstraint.activate([
        ProfileFrontpanelLayout.topAnchor.constraint(equalTo: mainbox.contentLayoutGuide.topAnchor),
        ProfileFrontpanelLayout.leadingAnchor.constraint(equalTo: mainbox.leadingAnchor, constant: 25),
        ProfileFrontpanelLayout.trailingAnchor.constraint(equalTo: mainbox.trailingAnchor, constant: -25),
        ProfileFrontpanelLayout.heightAnchor.constraint(equalToConstant: 427),
    ])

    ProfileFrontpanelLayout.addSubview(ProfileImaglayout)
    ProfileIMG.Constructor(Img: args.data.avtar)
    ProfileImaglayout.addSubview(ProfileIMG)

    ProfileFrontpanelLayout.addSubview(Profiledetailslayout)
    Editbutton()

    let UsernameWith_Vtag = UILabel()
    Profiledetailslayout.addSubview(UsernameWith_Vtag)
    UsernameWith_Vtag.translatesAutoresizingMaskIntoConstraints = false

    let attachment = NSTextAttachment()
    attachment.image = UIImage(systemName: "checkmark.seal.fill")?.withTintColor(.systemGreen)
    attachment.bounds = CGRect(x: 0, y: -2, width: 17.5, height: 16.75)

    let username = "\(args.data.username) "

    let attributedText = NSMutableAttributedString(string: String(username))
    let range = (username as NSString).range(of: username)
    attributedText.addAttributes([.font: UIFont.boldSystemFont(ofSize: 20)], range: range)
    attributedText.append(NSAttributedString(attachment: attachment))

    UsernameWith_Vtag.attributedText = attributedText
    UsernameWith_Vtag.numberOfLines = 2
    UsernameWith_Vtag.textColor = .white

    let EmailView = UILabel()
    EmailView.translatesAutoresizingMaskIntoConstraints = false
    Profiledetailslayout.addSubview(EmailView)

    func attributedLinkText(from text: String, maxChars: Int) -> NSAttributedString {
        // 1. Truncate the raw string first, if needed
        var displayText = text
        if text.count > maxChars {
            let endIndex = text.index(text.startIndex, offsetBy: maxChars)
            displayText = String(text[text.startIndex..<endIndex]) + "..."
        }

        let result = NSMutableAttributedString()

        // 2. Build the link icon as a text attachment
        let attachment = NSTextAttachment()
        let iconImage = UIImage(systemName: "envelope")?
            .withTintColor(.systemBlue, renderingMode: .alwaysOriginal)

        attachment.image = iconImage
        attachment.bounds = CGRect(x: 0, y: -2, width: 18, height: 14) // y tweaks vertical alignment

        result.append(NSAttributedString(attachment: attachment))
        result.append(NSAttributedString(string: " ")) // spacing between icon and text
        result.append(NSAttributedString(string: displayText, attributes: [
            .foregroundColor: UIColor.secondaryLabel,
            .font: UIFont.systemFont(ofSize: 14),
        ]))

        return result
    }

    EmailView.attributedText = attributedLinkText(from: "\(args.data.email)", maxChars: 20)

    NSLayoutConstraint.activate([
        UsernameWith_Vtag.leadingAnchor.constraint(equalTo: Profiledetailslayout.leadingAnchor, constant: 16),
        UsernameWith_Vtag.widthAnchor.constraint(
            equalTo: Profiledetailslayout.widthAnchor,
            multiplier: 2.0 / 3.0
        ),

        EmailView.topAnchor.constraint(equalTo: UsernameWith_Vtag.bottomAnchor, constant: 5),
        EmailView.leadingAnchor.constraint(equalTo: UsernameWith_Vtag.leadingAnchor),
        EmailView.trailingAnchor.constraint(equalTo: Profiledetailslayout.trailingAnchor, constant: -16),
        EmailView.bottomAnchor.constraint(equalTo: Profiledetailslayout.bottomAnchor, constant: -20),
    ])

    NSLayoutConstraint.activate([
        // profile img
        ProfileImaglayout.topAnchor.constraint(equalTo: ProfileFrontpanelLayout.topAnchor, constant: 10),
        ProfileImaglayout.leadingAnchor.constraint(equalTo: ProfileFrontpanelLayout.leadingAnchor, constant: 15),
        ProfileImaglayout.widthAnchor.constraint(equalToConstant: 70),
        ProfileImaglayout.heightAnchor.constraint(equalToConstant: 70),

        // profile details
        Profiledetailslayout.leadingAnchor.constraint(equalTo: ProfileFrontpanelLayout.leadingAnchor),
        Profiledetailslayout.trailingAnchor.constraint(equalTo: ProfileFrontpanelLayout.trailingAnchor),
        Profiledetailslayout.bottomAnchor.constraint(equalTo: ProfileFrontpanelLayout.bottomAnchor),
        Profiledetailslayout.heightAnchor.constraint(equalToConstant: 300),
    ])

    func Editbutton() {
        let editButton = UIButton(type: .system)
        editButton.translatesAutoresizingMaskIntoConstraints = false

        var config = UIButton.Configuration.filled()

        config.title = "Edit"
        config.image = UIImage(
            systemName: "pencil",
            withConfiguration: UIImage.SymbolConfiguration(pointSize: 15, weight: .medium)
        )

        config.imagePlacement = .leading
        config.imagePadding = 8

        config.baseBackgroundColor = .systemBlue
        config.baseForegroundColor = .white

        // Padding around the content
        config.contentInsets = NSDirectionalEdgeInsets(top: 15, leading: 18, bottom: 15, trailing: 18)

        // Font
        config.titleTextAttributesTransformer = UIConfigurationTextAttributesTransformer { incoming in
            var outgoing = incoming
            outgoing.font = .systemFont(ofSize: 18, weight: .bold)
            return outgoing
        }

        editButton.configuration = config

        // Make it a capsule
        editButton.layer.cornerRadius = 40
        editButton.clipsToBounds = true

        Profiledetailslayout.addSubview(editButton)

        NSLayoutConstraint.activate([
            editButton.bottomAnchor.constraint(equalTo: Profiledetailslayout.bottomAnchor, constant: -25),
            editButton.trailingAnchor.constraint(equalTo: Profiledetailslayout.trailingAnchor, constant: -15),
        ])
    }
}

// MARK: - Bio

func BIO(_ Layout: privetprofile_LYTS, with args: PRIVET_PROFILE_RES) {

    let mainbox = Layout.scrollLayout
    let BiobackgroundView = Layout.BIOINFO_LYT
    let statusBarBackgroundView_PreviousElement = Layout.STATUSBAR_LYT

    BiobackgroundView.translatesAutoresizingMaskIntoConstraints = false
    mainbox.addSubview(BiobackgroundView)

    NSLayoutConstraint.activate([
        BiobackgroundView.topAnchor.constraint(equalTo: statusBarBackgroundView_PreviousElement.bottomAnchor, constant: 20),
        BiobackgroundView.leadingAnchor.constraint(equalTo: mainbox.leadingAnchor),
        BiobackgroundView.trailingAnchor.constraint(equalTo: mainbox.trailingAnchor),
    ])

    let Biocontent = PRIVATE_PROFILE_BIO_CNT(
        bio: args.data.bio
    )
    Biocontent.translatesAutoresizingMaskIntoConstraints = false
    BiobackgroundView.addSubview(Biocontent)

    NSLayoutConstraint.activate([
        Biocontent.topAnchor.constraint(equalTo: BiobackgroundView.safeAreaLayoutGuide.topAnchor),
        Biocontent.leadingAnchor.constraint(equalTo: BiobackgroundView.leadingAnchor, constant: 10),
        Biocontent.trailingAnchor.constraint(equalTo: BiobackgroundView.trailingAnchor, constant: -10),
        Biocontent.bottomAnchor.constraint(equalTo: BiobackgroundView.bottomAnchor),
    ])
}

// MARK: - Status Bar

func STATUS_BAR(_ Layout: privetprofile_LYTS, with args: PRIVET_PROFILE_RES) {
    let mainbox = Layout.scrollLayout
    let statusBarBackgroundView = Layout.STATUSBAR_LYT
    let ProfileFrontpanelLayout_PriviousElement = Layout.PROFILEFRONTPANAL_LYT

    func Divider() -> UIView {
        APPCOLOR.CurrentThem()
        let divider = UIView()
        divider.translatesAutoresizingMaskIntoConstraints = false
        divider.backgroundColor = APPCOLOR.SubContentColor.withAlphaComponent(0.2)
        return divider
    }

    statusBarBackgroundView.translatesAutoresizingMaskIntoConstraints = false

    let Chats = PRIVATE_PROFILE_BIO_STATUS_BAR_INFO(title: "CHATS", number: "\(args.data.chats)")
    let Divider1 = Divider()
    statusBarBackgroundView.addSubview(Chats)
    statusBarBackgroundView.addSubview(Divider1)

    NSLayoutConstraint.activate([
        Chats.topAnchor.constraint(equalTo: statusBarBackgroundView.topAnchor),
        Chats.centerYAnchor.constraint(equalTo: statusBarBackgroundView.centerYAnchor),
        Chats.leadingAnchor.constraint(equalTo: statusBarBackgroundView.leadingAnchor),
        Chats.widthAnchor.constraint(equalTo: statusBarBackgroundView.widthAnchor, multiplier: 0.33),

        Divider1.centerYAnchor.constraint(equalTo: statusBarBackgroundView.centerYAnchor),
        Divider1.leadingAnchor.constraint(equalTo: Chats.trailingAnchor),
        Divider1.widthAnchor.constraint(equalToConstant: 1),
        Divider1.heightAnchor.constraint(equalToConstant: 44),
    ])

    let following = PRIVATE_PROFILE_BIO_STATUS_BAR_INFO(title: "FOLLWERS", number: "\(args.data.followers)")
    let Divider2 = Divider()
    statusBarBackgroundView.addSubview(following)
    statusBarBackgroundView.addSubview(Divider2)

    NSLayoutConstraint.activate([
        following.centerXAnchor.constraint(equalTo: statusBarBackgroundView.centerXAnchor),
        following.centerYAnchor.constraint(equalTo: statusBarBackgroundView.centerYAnchor),
        following.widthAnchor.constraint(equalTo: statusBarBackgroundView.widthAnchor, multiplier: 0.33),
        following.topAnchor.constraint(equalTo: statusBarBackgroundView.topAnchor),

        Divider2.centerYAnchor.constraint(equalTo: statusBarBackgroundView.centerYAnchor),
        Divider2.leadingAnchor.constraint(equalTo: following.trailingAnchor),
        Divider2.widthAnchor.constraint(equalToConstant: 1),
        Divider2.heightAnchor.constraint(equalToConstant: 44),
    ])

    let follwers = PRIVATE_PROFILE_BIO_STATUS_BAR_INFO(title: "FOLLOWING", number: "\(args.data.following)")
    statusBarBackgroundView.addSubview(follwers)

    NSLayoutConstraint.activate([
        follwers.topAnchor.constraint(equalTo: statusBarBackgroundView.topAnchor),
        follwers.centerYAnchor.constraint(equalTo: statusBarBackgroundView.centerYAnchor),
        // following.leadingAnchor.constraint(equalTo: Divider2.trailingAnchor),
        follwers.trailingAnchor.constraint(equalTo: statusBarBackgroundView.trailingAnchor),
        follwers.widthAnchor.constraint(equalTo: statusBarBackgroundView.widthAnchor, multiplier: 0.33),
    ])

    mainbox.addSubview(statusBarBackgroundView)

    NSLayoutConstraint.activate([
        statusBarBackgroundView.topAnchor.constraint(equalTo: ProfileFrontpanelLayout_PriviousElement.bottomAnchor, constant: 20),
        statusBarBackgroundView.leadingAnchor.constraint(equalTo: mainbox.leadingAnchor),
        statusBarBackgroundView.trailingAnchor.constraint(equalTo: mainbox.trailingAnchor),
        statusBarBackgroundView.widthAnchor.constraint(equalTo: mainbox.frameLayoutGuide.widthAnchor),
        statusBarBackgroundView.heightAnchor.constraint(equalToConstant: 92),
    ])
}

// MARK: - Interests

func INTERESTS(_ Layout: privetprofile_LYTS, with args: PRIVET_PROFILE_RES) {

    // MARK: Main Layout

    let mainbox = Layout.scrollLayout
    let IntrestBackgroundView = Layout.PROFILE_INTREST_LYT
    let BiobackgroundView_PreviousElement = Layout.BIOINFO_LYT

    IntrestBackgroundView.translatesAutoresizingMaskIntoConstraints = false
    mainbox.addSubview(IntrestBackgroundView)

    // MARK: Title

    APPCOLOR.CurrentThem()

    let INTREST_LYT_title = UILabel()
    INTREST_LYT_title.translatesAutoresizingMaskIntoConstraints = false

    let attributes: [NSAttributedString.Key: Any] = [
        .font: UIFont.systemFont(ofSize: 20, weight: .bold),
        .foregroundColor: APPCOLOR.ContentColor,
    ]

    INTREST_LYT_title.attributedText = NSAttributedString(string: "INTERESTED", attributes: attributes)

    IntrestBackgroundView.addSubview(INTREST_LYT_title)

    // MARK: Flow Container

    let flowContainer = GridLayoutStructure()
    flowContainer.translatesAutoresizingMaskIntoConstraints = false

    flowContainer.horizontalSpacing = 10
    flowContainer.verticalSpacing = 10

    IntrestBackgroundView.addSubview(flowContainer)

    // MARK: Interest Data

    var capsuleData: [(icon: String, name: String, highlight: Bool)] = []

    for interest in args.data.interests {
        capsuleData.append((
            icon: interest.icon,
            name: interest.name,
            highlight: interest.ishighlight
        ))
    }

    // MARK: Create Capsules

    for data in capsuleData {
        let capsule = PRIVATE_PROFILE_INTREST_CAPSULE(Icon: data.icon, name: data.name, ishighlight: data.highlight)
        capsule.translatesAutoresizingMaskIntoConstraints = false
        flowContainer.addSubview(capsule)
    }

    // MARK: Constraints

    NSLayoutConstraint.activate([

        // ------------------------------------------------
        // Interest Background
        // ------------------------------------------------

        IntrestBackgroundView.topAnchor.constraint(equalTo: BiobackgroundView_PreviousElement.bottomAnchor, constant: 20),
        IntrestBackgroundView.leadingAnchor.constraint(equalTo: mainbox.contentLayoutGuide.leadingAnchor),
        IntrestBackgroundView.trailingAnchor.constraint(equalTo: mainbox.contentLayoutGuide.trailingAnchor),
        IntrestBackgroundView.widthAnchor.constraint(equalTo: mainbox.frameLayoutGuide.widthAnchor),

        // ------------------------------------------------
        // Title
        // ------------------------------------------------

        INTREST_LYT_title.topAnchor.constraint(equalTo: IntrestBackgroundView.topAnchor, constant: 10),
        INTREST_LYT_title.leadingAnchor.constraint(equalTo: IntrestBackgroundView.leadingAnchor, constant: 10),

        // ------------------------------------------------
        // Flow Container
        // ------------------------------------------------

        flowContainer.topAnchor.constraint(equalTo: INTREST_LYT_title.bottomAnchor, constant: 10),
        flowContainer.leadingAnchor.constraint(equalTo: IntrestBackgroundView.leadingAnchor, constant: 20),
        flowContainer.trailingAnchor.constraint(equalTo: IntrestBackgroundView.trailingAnchor, constant: -20),

        // ------------------------------------------------
        // Bottom
        // ------------------------------------------------
        flowContainer.bottomAnchor.constraint(equalTo: mainbox.bottomAnchor, constant: -20),
    ])
}

// MARK: - Posts (disabled)

//func POSTS(_ Layout: privetprofile_LYTS) {
//    let mainbox = Layout.scrollLayout
//
//    let totalnumberofitem = 2
//
//    let posttitleview = PRIVATE_PROFILE_POST_TITLE_LYT()
//    posttitleview.translatesAutoresizingMaskIntoConstraints = false
//
//    let IntrestBackgroundView_PreviousElement = Layout.PROFILE_INTREST_LYT
//
//    mainbox.addSubview(posttitleview)
//
//    NSLayoutConstraint.activate([
//        posttitleview.topAnchor.constraint(equalTo: IntrestBackgroundView_PreviousElement.bottomAnchor, constant: 20),
//        posttitleview.leadingAnchor.constraint(equalTo: mainbox.leadingAnchor),
//        posttitleview.trailingAnchor.constraint(equalTo: mainbox.trailingAnchor),
//        posttitleview.heightAnchor.constraint(equalToConstant: 50),
//    ])
//
//    var previousView: UIView = posttitleview
//
//    for index in 0..<5 {
//        let postbackgroundview = PRIVATE_PROFILE_POST_CONTENTHOLDER_LYT(Itemsize: 300, totalItem: totalnumberofitem)
//        postbackgroundview.translatesAutoresizingMaskIntoConstraints = false
//
//        mainbox.addSubview(postbackgroundview)
//
//        NSLayoutConstraint.activate([
//            postbackgroundview.topAnchor.constraint(equalTo: previousView.bottomAnchor, constant: 3),
//            postbackgroundview.leadingAnchor.constraint(equalTo: mainbox.leadingAnchor),
//            postbackgroundview.trailingAnchor.constraint(equalTo: mainbox.trailingAnchor),
//        ])
//
//        if index == 4 {
//            postbackgroundview.bottomAnchor.constraint(equalTo: mainbox.contentLayoutGuide.bottomAnchor).isActive = true
//        }
//
//        previousView = postbackgroundview
//    }
//}
