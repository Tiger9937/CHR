import UIKit

struct chatroom_CMPTS {
    let HEADER__CMPT = HEADER_CMPT(title: "All Chats")
}

struct chatroom_LYTS {
    let HEADER_LYT             = PRIVATE_PROFILE_HEADER_LYT()
    let scrollLayout           = UIScrollView()
}

@MainActor
class ALLCHATS_LIST_VC: UIViewController {
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
        
        Auto_Page_Sizing()
    }
    
    func Auto_Page_Sizing() {
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
    
}


