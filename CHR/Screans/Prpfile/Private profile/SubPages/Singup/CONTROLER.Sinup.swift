import UIKit

struct Singin_CMPTS {
     let HEADER__CMPT = SINGIN_TITLE_CNT(title: "Singup")
}

struct Singin_LYTS {
    let HEADER_LYT             = SINGUP_HEADER_LYT()
    let GRUP_LYT           = SINGUP_GROUP_LYT()
    let INPUTS_LYT         = SINGUP_INPUTS_LYT()
    let ACTION_LYT         = SINGUP_ACTION_LYT()
    let OUTSIDE_LOG_LYT    = SINGUP_OUTSIDE_LOG_LYT()
    let DividerLYT        = SINGUP_DIVIDER_LYT()
    let ALTERNATIV_LYT     = SINGUP_ALTERNATIV_LYT()
    
}

@MainActor
class SINGIN_VC: UIViewController {
    
    let CMPT = Singin_CMPTS()
    let LYT = Singin_LYTS()
    let internetcall                = INTERNET()
    let refreshControl              = UIRefreshControl()
    
    override func viewDidLoad() {
        APPCOLOR.CurrentThem()
        
        view.backgroundColor = APPCOLOR.BackgroundColor
        view.addSubview(LYT.HEADER_LYT)
        
        Auto_Page_Sizing()
        HaderView()
        main()
    }
    
    func Auto_Page_Sizing() {
        LYT.HEADER_LYT.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            LYT.HEADER_LYT.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            LYT.HEADER_LYT.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            LYT.HEADER_LYT.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            LYT.HEADER_LYT.heightAnchor.constraint(equalToConstant: 60),

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
    
    
    func main(){
        let GrupLYT = LYT.GRUP_LYT
        let AlternativLOG_LYT = LYT.ALTERNATIV_LYT
        let DividerLYT =  LYT.DividerLYT
        let OutsidelogLYT = LYT.OUTSIDE_LOG_LYT
        
        let GrupCNT = SINGIN_CNT()
        let DividerCNT = SINGIN_DIVIDER_CNT()
        let OutsideLogCNT = SINGIN_OUSIDE_CNT()
        let AlternativeCNT = SINGIN_ALTERNATIVE_CNT()
        
        view.addSubview(GrupLYT)
        view.addSubview(AlternativLOG_LYT)
        
        GrupLYT.addSubview(GrupCNT)
        GrupLYT.addSubview(DividerLYT)
        GrupLYT.addSubview(OutsidelogLYT)
        
        DividerLYT.addSubview(DividerCNT)
        OutsidelogLYT.addSubview(OutsideLogCNT)
        AlternativLOG_LYT.addSubview(AlternativeCNT)
        
        NSLayoutConstraint.activate([
            GrupLYT.topAnchor.constraint(
                equalTo: LYT.HEADER_LYT.bottomAnchor,
                constant: 20
            ),
            GrupLYT.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            GrupLYT.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            
            GrupCNT.topAnchor.constraint(equalTo: GrupLYT.topAnchor, constant: 20),
            GrupCNT.leadingAnchor.constraint(equalTo: GrupLYT.leadingAnchor, constant: 20),
            GrupCNT.trailingAnchor.constraint(equalTo: GrupLYT.trailingAnchor, constant: -20),
            
            DividerLYT.topAnchor.constraint(equalTo: GrupCNT.bottomAnchor, constant: 10),
            DividerLYT.leadingAnchor.constraint(equalTo: GrupLYT.leadingAnchor, constant: 20),
            DividerLYT.trailingAnchor.constraint(equalTo: GrupLYT.trailingAnchor, constant: -20),
            DividerLYT.heightAnchor.constraint(equalToConstant: 50),
            
                DividerCNT.topAnchor.constraint(equalTo: GrupCNT.bottomAnchor, constant: 25),
                DividerCNT.leadingAnchor.constraint(equalTo: GrupLYT.leadingAnchor, constant: 20),
                DividerCNT.trailingAnchor.constraint(equalTo: GrupLYT.trailingAnchor, constant: -20),
            
            OutsidelogLYT.topAnchor.constraint(equalTo:DividerLYT.bottomAnchor , constant: 10),
            OutsidelogLYT.leadingAnchor.constraint(equalTo: GrupLYT.leadingAnchor, constant: 20),
            OutsidelogLYT.trailingAnchor.constraint(equalTo: GrupLYT.trailingAnchor, constant: -20),
            OutsidelogLYT.bottomAnchor.constraint(equalTo: GrupLYT.bottomAnchor, constant: -10),
            
            OutsideLogCNT.topAnchor.constraint(equalTo: OutsidelogLYT.topAnchor, constant: 10),
            OutsideLogCNT.leadingAnchor.constraint(equalTo: OutsidelogLYT.leadingAnchor, constant: 20),
            OutsideLogCNT.trailingAnchor.constraint(equalTo: OutsidelogLYT.trailingAnchor, constant: -20),
            OutsideLogCNT.bottomAnchor.constraint(equalTo: OutsidelogLYT.bottomAnchor, constant: -20),
            
           //  DividerCNT.bottomAnchor.constraint(equalTo: DividerLYT.bottomAnchor, constant: -10)
            
            AlternativLOG_LYT.topAnchor.constraint(equalTo:GrupLYT.bottomAnchor , constant: 10),
            AlternativLOG_LYT.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            AlternativLOG_LYT.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            AlternativLOG_LYT.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            
            
            AlternativeCNT.topAnchor.constraint(equalTo:AlternativLOG_LYT.topAnchor),
            AlternativeCNT.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            AlternativeCNT.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
        ])
        
    }
}


