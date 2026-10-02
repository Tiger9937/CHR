internal import Foundation
import UIKit

struct chatBoard_CMPTS {
    let HEADER__CMPT = HEADER_CMPT(title: "Chat Board")
}

struct chatBoard_LYTS {
    let USER_BNNER_LYT         = CHATBOARD_USER_BNNER_LYT()
    let ACTIVITY_LYT           = CHATBOARD_ACTIVITY_LYT()
    let scrollLayout           = CHATBOARD_ACTIVITY_VIEW_LYT()
    let ALLCHATS_LYT           = CHATBOARD_ALLCHATS_LYT()
}

@MainActor
class CHATBOARD: UIViewController {
    let CMPT = chatrequest_CMPTS()
    let LYT = chatBoard_LYTS()
    let internetcall                = INTERNET()
    let refreshControl              = UIRefreshControl()
    
    override func viewDidLoad() {
        APPCOLOR.CurrentThem()
        
        let scrollLayout = LYT.scrollLayout
        view.backgroundColor = APPCOLOR.BackgroundColor
        view.addSubview(LYT.USER_BNNER_LYT)
        view.addSubview(scrollLayout)
        
        Auto_Page_Sizing()
        HaderView()
        main()
    }
    
    func Auto_Page_Sizing() {
        [LYT.USER_BNNER_LYT, LYT.scrollLayout, LYT.ALLCHATS_LYT].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }

        view.addSubview(LYT.USER_BNNER_LYT)
        view.addSubview(LYT.scrollLayout)
                       // sibling of the scroll view
        LYT.scrollLayout.addSubview(LYT.ALLCHATS_LYT)   // stack lives inside the scroll view

        let content = LYT.scrollLayout.contentLayoutGuide
        let frame   = LYT.scrollLayout.frameLayoutGuide

        NSLayoutConstraint.activate([
            // Banner (top of screen)
            LYT.USER_BNNER_LYT.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            LYT.USER_BNNER_LYT.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            LYT.USER_BNNER_LYT.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            LYT.USER_BNNER_LYT.heightAnchor.constraint(equalToConstant: 60),

            // Scroll view (between banner and activity)
            LYT.scrollLayout.topAnchor.constraint(equalTo: LYT.USER_BNNER_LYT.bottomAnchor, constant: 10),
            LYT.scrollLayout.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 5),
            LYT.scrollLayout.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -5),

            // ALLCHATS stack (all rows scroll inside the scroll view)
                LYT.ALLCHATS_LYT.topAnchor.constraint(equalTo: content.topAnchor),
                LYT.ALLCHATS_LYT.leadingAnchor.constraint(equalTo: content.leadingAnchor),
                LYT.ALLCHATS_LYT.trailingAnchor.constraint(equalTo: content.trailingAnchor),
                LYT.ALLCHATS_LYT.bottomAnchor.constraint(equalTo: content.bottomAnchor),
                LYT.ALLCHATS_LYT.widthAnchor.constraint(equalTo: frame.widthAnchor),   // no sideways scrolling


        ])
    }
    
    func HaderView() {
        let banner = USER_BNNER_CNT(data: .init(
            Username: "LUX_ben",
            ProfileImg: UIImage(named: "NoIMG") ?? UIImage(),
            CurrentStatus: "online"
        ))
        
        banner.translatesAutoresizingMaskIntoConstraints = false
        LYT.USER_BNNER_LYT.addSubview(banner)

        NSLayoutConstraint.activate([
            banner.topAnchor.constraint(equalTo: LYT.USER_BNNER_LYT.safeAreaLayoutGuide.topAnchor),
            banner.leadingAnchor.constraint(equalTo: LYT.USER_BNNER_LYT.leadingAnchor),
            banner.trailingAnchor.constraint(equalTo: LYT.USER_BNNER_LYT.trailingAnchor)
        ])
        
        
    }
    
    func Online(NumberOfaPage: Int) async -> ALLCHATS_RES_LIST? {
        do {
            let LastNameOfaRequest: String
            
            if (NumberOfaPage == 0) {
                LastNameOfaRequest = "RequestResived"
                let data = try await internetcall.GET(
                    URI: "\(ServerName.baseURL.rawValue)Test/sendTEST2/\(LastNameOfaRequest)"
                )
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                
                return try decoder.decode(ALLCHATS_RES_LIST.self, from: data)
                
            }
        }
        
        catch ErrorService.AllNetworkError.Usernetoff {
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
    
    func main() {

        let stack = LYT.ALLCHATS_LYT
        
        let sampleTexts = [
            "Hey, are you free this evening?",
            "Just finished the login screen, it's working now.",
            "Can you send me the design files when you get a chance?",
            "Lunch at 2? I'm craving biryani.",
            "The build failed again. Looks like a missing constraint.",
            "Happy birthday! Hope you have an amazing day.",
            "I'll call you in 10 minutes, I'm stuck in traffic right now and the signal keeps dropping.",
            "Did you see the new iOS update? Some of the animations feel much smoother.",
            "Okay, sounds good.",
            "Let's meet tomorrow morning to go over the project plan, the deadline is closer than we thought, so we should split the tasks today."
        ]

        func randomDateString() -> String {
            let day = Int.random(in: 1...28)
            let month = Int.random(in: 1...12)
            let year = Int.random(in: 2020...2026)
            return String(format: "%02d/%02d/%d", day, month, year)
        }

        for _ in 0..<5 {
            let leftrow = USER_CHATBOARD_TEXTFILD_ONGOING_CNT(
                data: .init(UserTextView: sampleTexts.randomElement()!,
                            UserTextTimeView: randomDateString())
            )

            let rightrow = USER_CHATBOARD_TEXTFILD_UPCOMING_CNT(
                data: .init(UserTextView: sampleTexts.randomElement()!,
                            UserTextTimeView: randomDateString(),
                            UserTextDispatchStatus: .delaverd)
            )

            [leftrow, rightrow].forEach {
                $0.translatesAutoresizingMaskIntoConstraints = false
                stack.addArrangedSubview($0)   // left first, then right
            }
        }
        
        
        // let Activity = LYT.ACTIVITY_LYT
        let bar = USER_ACTIVITY_CNT(data: .init(Username: "Jagan", ProfileImg: UIImage(), CurrentStatus: ""))
        bar.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(bar)

        NSLayoutConstraint.activate([
            bar.topAnchor.constraint(equalTo:LYT.scrollLayout.bottomAnchor ,constant: 10 ),
            bar.leadingAnchor.constraint(equalTo: view.leadingAnchor , constant: 10),
            bar.trailingAnchor.constraint(equalTo: view.trailingAnchor , constant: -10),
            bar.bottomAnchor.constraint(equalTo: view.keyboardLayoutGuide.topAnchor, constant: -8),
        ])

        bar.onSendTapped = { text in print("Send:", text) }
    }
    
    
    
}

