import UIKit



struct chatrequest_CMPTS {
    let HEADER__CMPT = HEADER_CMPT(title: "Chat Invitation")
}

struct chatrequest_CNT{
    let Searchbar_CNT = CHAT_REQUEST_SEARCHBAR_CNT(placeholder: "Search Your Invites.....")
}

struct chatrequest_LYTS {
    let HEADER_LYT             = CHAT_REQUEST_HEADER_LYT()
    var scrollLayout           = UIScrollView()
    
    let SearchBar_LYT            = CHAT_REQUEST_SERACHBAR_LYT()
    let Invite_LYT               = CHAT_REQUEST_INVITE_LYT()
    
    
}

@MainActor
class CHAT_REQUEST_LIST_VC: UIViewController {
    let CMPT = chatrequest_CMPTS()
    let LYT = chatrequest_LYTS()
    let internetcall                = INTERNET()
    let refreshControl              = UIRefreshControl()
    
    override func viewDidLoad() {
        APPCOLOR.CurrentThem()
        
        let scrollLayout = LYT.scrollLayout
        view.backgroundColor = APPCOLOR.BackgroundColor
        view.addSubview(LYT.HEADER_LYT)
        view.addSubview(scrollLayout)
        
        Task {
            let Invites = await Online()
            guard let Invites else {
                return
            }
            
            main(Invites: Invites)
        }
        
        
        Auto_Page_Sizing()
        HaderView()
    }
    
    func Auto_Page_Sizing() {
        LYT.HEADER_LYT.translatesAutoresizingMaskIntoConstraints = false
        LYT.scrollLayout.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            LYT.HEADER_LYT.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            LYT.HEADER_LYT.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            LYT.HEADER_LYT.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            LYT.HEADER_LYT.heightAnchor.constraint(equalToConstant: 60),

            LYT.scrollLayout.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            LYT.scrollLayout.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            LYT.scrollLayout.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    
    private func Online() async -> CHATREINVITE_RES? {
        print("\(ServerName.baseURL.rawValue)Test/sendTEST2")
        do {
            let data = try await internetcall.GET(URI: "\(ServerName.baseURL.rawValue)Test/sendTEST2")
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            
            return try decoder.decode(CHATREINVITE_RES.self, from: data)

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
    
    func main(Invites:CHATREINVITE_RES){
        
        
        // MARK: SearchBar
        let Haderlayout = LYT.HEADER_LYT
        let SearchBarlayout = LYT.SearchBar_LYT
        let mainBox = LYT.scrollLayout
        
        view.addSubview(SearchBarlayout)
        SearchBar(LYT.SearchBar_LYT)
        
        NSLayoutConstraint.activate([
            SearchBarlayout.topAnchor.constraint(equalTo: Haderlayout.bottomAnchor, constant: 10),
            SearchBarlayout.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            SearchBarlayout.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            SearchBarlayout.heightAnchor.constraint(equalToConstant: 47),
            
            mainBox.topAnchor.constraint(equalTo:SearchBarlayout.bottomAnchor , constant: 0),
            mainBox.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mainBox.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        // MARK: InviteCard
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 10
        stack.translatesAutoresizingMaskIntoConstraints = false
        mainBox.addSubview(stack)

        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: mainBox.contentLayoutGuide.topAnchor, constant: 10),
            stack.leadingAnchor.constraint(equalTo: mainBox.frameLayoutGuide.leadingAnchor, constant: 20),
            stack.trailingAnchor.constraint(equalTo: mainBox.frameLayoutGuide.trailingAnchor, constant: -20),
            stack.bottomAnchor.constraint(equalTo: mainBox.contentLayoutGuide.bottomAnchor, constant: -30)
        ])
        
        for index in 0..<Invites.data.count {
            let inviteCardlayout = CHAT_REQUEST_INVITE_LYT()
            inviteCardlayout.heightAnchor.constraint(equalToConstant: 154).isActive = true
            InviteCard(with: inviteCardlayout, in: stack,
                       avatarImage:Invites.data[index].avatarImage ,
                       name: Invites.data[index].username,
                       timeAgo: Invites.data[index].timeAgo,
                       distanceText: Invites.data[index].distanceText,
                       mutualFriendsCount: Invites.data[index].mutualFriendsCount,
                       IsuserOnline: Invites.data[index].isUserOnline
            
            )
        stack.addArrangedSubview(inviteCardlayout)
        }
        
    }
    
}

func SearchBar(_ LYT:UIView){
    let SearchBar = chatrequest_CNT().Searchbar_CNT
    SearchBar.onSubmit = { text in
                print("\(text)")
    }
    
    
    LYT.addSubview(SearchBar)
    
    NSLayoutConstraint.activate([
        SearchBar.leadingAnchor.constraint(equalTo: LYT.leadingAnchor , constant: 10),
        SearchBar.trailingAnchor.constraint(equalTo: LYT.trailingAnchor, constant: -10),
    ])
    
    
}

func InviteCard(with LYT_View: UIView  , in stack: UIStackView,
                avatarImage: String,
                name: String,
                timeAgo: String,
                distanceText: Double,
                mutualFriendsCount: Int,
                IsuserOnline: Bool
) {
   
    
    let inviteCard = CHAT_REQUEST_INVITE_CNT(
        data: .init(
            avatarImage: UIImage(named: "some_avatar"),
            name: "Fling jet",
            timeAgo: "45m ago",
            distanceText: "2.8 km away",
            mutualFriendsCount: 5,
            statusColor: IsuserOnline ? .systemMint : .clear

        ),
        onAccept: { print("accepted")
            removeCard(LYT_View, from: stack)
        },
        onDeny: { print("denied")
            removeCard(LYT_View, from: stack)
        }
    )
    
    func removeCard(_ cardLayout: UIView, from stack: UIStackView) {
        // Optional: animate the card's own appearance first
        UIView.animate(withDuration: 0.2, animations: {
            cardLayout.alpha = 0
            cardLayout.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
        }) { _ in
            // Actually remove it, then animate the stack reflowing
            UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut) {
                stack.removeArrangedSubview(cardLayout)
                cardLayout.removeFromSuperview()
                stack.superview?.layoutIfNeeded()
            }
        }
    }
    
    inviteCard.translatesAutoresizingMaskIntoConstraints = false
    LYT_View.addSubview(inviteCard)

    NSLayoutConstraint.activate([
        inviteCard.topAnchor.constraint(equalTo: LYT_View.topAnchor, constant: 20),
        inviteCard.bottomAnchor.constraint(equalTo: LYT_View.bottomAnchor, constant: -20),
        
        inviteCard.leadingAnchor.constraint(equalTo: LYT_View.leadingAnchor, constant: 20),
        inviteCard.trailingAnchor.constraint(equalTo: LYT_View.trailingAnchor, constant: -20),
        
        inviteCard.heightAnchor.constraint(equalToConstant: 114),
    ])
}
