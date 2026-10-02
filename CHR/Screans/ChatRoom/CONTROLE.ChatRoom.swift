import UIKit

struct chatroom_CMPTS {
    let HEADER__CMPT = HEADER_CMPT(title: "All Chats")
}

struct chatroom_CNT{
    let Searchbar_CNT = CHAT_ROOM_SEARCHBAR_CNT(placeholder: "Search Your Friends.....")
}

struct chatroom_LYTS {
    let HEADER_LYT             = CHAT_ROOM_HEADER_LYT()
    let scrollLayout           = CHAT_ROOM_ALLCHATS_LYT()
    let SEARCHBAR_LYT          = CHAT_ROOM_SEARCHBAR_LYT()
    let USER_LYT               = CHAT_ROOM_USER_LYT()
    let STACKVIEW_LYT          = CHAT_ROOM_STACKVIEW_LYT()
    let IMG_MID_VIEW_LYT       = CHAT_ROOM_USER_MID_VIEW_LYT()
}

@MainActor
class ALLCHATS_LIST_VC: UIViewController {
    let CMPT = chatroom_CMPTS()
    let LYT = chatroom_LYTS()
    let internetcall                = INTERNET()
    let refreshControl              = UIRefreshControl()
    let LocalServer                 = PERSON_Serv()
    let timeDetect                  = TimeDetectr()
    let FileDownloder               = FileDownlode()
    
    
    override func viewDidLoad() {
        APPCOLOR.CurrentThem()
        let scrollLayout = LYT.scrollLayout
        view.backgroundColor = APPCOLOR.BackgroundColor
        view.addSubview(LYT.HEADER_LYT)
        view.addSubview(scrollLayout)
        
        Auto_Page_Sizing()
        HaderView()
        
        main()
        
        
    }
    
    func Auto_Page_Sizing() {
        LYT.HEADER_LYT.translatesAutoresizingMaskIntoConstraints = false
        LYT.scrollLayout.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            LYT.HEADER_LYT.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            LYT.HEADER_LYT.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            LYT.HEADER_LYT.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            LYT.HEADER_LYT.heightAnchor.constraint(equalToConstant: 150),
            
            LYT.scrollLayout.topAnchor.constraint(equalTo: LYT.HEADER_LYT.bottomAnchor, constant: 10),
            LYT.scrollLayout.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            LYT.scrollLayout.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            LYT.scrollLayout.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
        
    }
    
    func HaderView() {
        
        let Haderlayout = LYT.HEADER_LYT
        let SearchBarlayout = LYT.SEARCHBAR_LYT
        let Haderview = CMPT.HEADER__CMPT
        
        Haderlayout.addSubview(Haderview)
        Haderlayout.addSubview(SearchBarlayout)
        
        // Remove back button
        Haderview.subviews.first?.removeFromSuperview()
        
        Haderview.translatesAutoresizingMaskIntoConstraints = false
        SearchBarlayout.translatesAutoresizingMaskIntoConstraints = false
        
        SearchBar(SearchBarlayout)
        
        NSLayoutConstraint.activate([
            
            // Header title
            Haderview.topAnchor.constraint(
                equalTo: Haderlayout.topAnchor,
                constant: 15
            ),
            
            Haderview.leadingAnchor.constraint(
                equalTo: Haderlayout.leadingAnchor,
                constant: 10
            ),
            
            Haderview.trailingAnchor.constraint(
                equalTo: Haderlayout.trailingAnchor,
                constant: -10
            ),
            
            Haderview.heightAnchor.constraint(
                equalToConstant: 40
            ),
            
            // Search bar container
            SearchBarlayout.topAnchor.constraint(
                equalTo: Haderview.bottomAnchor,
                constant: 10
            ),
            
            SearchBarlayout.leadingAnchor.constraint(
                equalTo: Haderlayout.leadingAnchor,
                constant: 10
            ),
            
            SearchBarlayout.trailingAnchor.constraint(
                equalTo: Haderlayout.trailingAnchor,
                constant: -10
            ),
            
            SearchBarlayout.bottomAnchor.constraint(
                equalTo: Haderlayout.bottomAnchor,
                constant: -10
            )
        ])
    }
    
    private func Online() async -> ALLPERSON_RES_LIST? {
        do {
            let data = try await internetcall.GET(
                URI: "\(ServerName.baseURL.rawValue)Test/sendTEST2/RequestResived"
            )
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            
            return try decoder.decode(ALLPERSON_RES_LIST.self, from: data)
            
            
        } catch ErrorService.AllNetworkError.Usernetoff {
            
        } catch ErrorService.AllNetworkError.InvalidURL {
            
        } catch ErrorService.AllNetworkError.ServerError {
            
        } catch ErrorService.AllNetworkError.ServerErrorCode(_) {
        } catch {
        }
        
        return nil
    }
    
    
    
    func main(){
        let ChatRoomLYT = LYT.scrollLayout
        let stackView = LYT.STACKVIEW_LYT
        ChatRoomLYT.addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: ChatRoomLYT.contentLayoutGuide.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: ChatRoomLYT.contentLayoutGuide.leadingAnchor, constant: 0),
            stackView.trailingAnchor.constraint(equalTo: ChatRoomLYT.contentLayoutGuide.trailingAnchor, constant: 0),
            stackView.bottomAnchor.constraint(equalTo: ChatRoomLYT.contentLayoutGuide.bottomAnchor, constant: -10),
            stackView.widthAnchor.constraint(equalTo: ChatRoomLYT.frameLayoutGuide.widthAnchor, constant: 0)
        ])
        
        LocalServer.UpdateInViewFalse_AllUser()
        
        Task {
            let data = await Online()
            guard let users = data?.data else { return }
            
            
//            let p = PERSON_CRUD()
//            p.DeleteAllPerson()
            
//            let temp = await FileDownlode().ImgDonwlode(URL:"https://picsum.photos/seed/sebastian/50/50" , SaveType: Save.Temporary)
//            
            
            // print(temp)
            
            
            for user in users {
                let Imgpath = await FileDownloder.ImgDonwlode(URL: user.avatar, SaveType: Save.Temporary)
                // this function means user allrady exsest on mobile and we update that usser coming on topup stack(this can prevent user dupilication)
                LocalServer.UserViewupdate(UserID: user.Usserid, updateView: true)
                
                let user = User(LYT.USER_LYT, MidViewLYT: LYT.IMG_MID_VIEW_LYT,
                                Username: user.Username,
                                Time: user.lastActivitydate,
                                avatar: Imgpath,
                                avatarAt:Save.Temporary,
                                RecentSMS: user.LastSMS,
                                NuberofUnseenSMS: user.unseensmses)
                user.alpha = 0
                user.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
                
                stackView.insertArrangedSubview(user, at: 0)
                stackView.superview?.layoutIfNeeded()
                
                UIView.animate(withDuration: 0.3, delay: 0, options: [.curveEaseIn]) {
                    user.alpha = 1
                    user.transform = .identity
                }
                
            }
            
            StoredUsersListView(stackView,UserLYT: LYT.USER_LYT , LS: LocalServer, MidViewLYT: LYT.IMG_MID_VIEW_LYT)

            await LocalServer.addPerson(persons: users)
        }
        
    }
    
    func SearchBar(_ LYT: CHAT_ROOM_SEARCHBAR_LYT) {
        
        let SearchBar = chatroom_CNT().Searchbar_CNT
        
        SearchBar.translatesAutoresizingMaskIntoConstraints = false
        
        LYT.addSubview(SearchBar)
        
        NSLayoutConstraint.activate([
            
            SearchBar.leadingAnchor.constraint(
                equalTo: LYT.leadingAnchor
            ),
            
            SearchBar.trailingAnchor.constraint(
                equalTo: LYT.trailingAnchor
            ),
            
            SearchBar.centerYAnchor.constraint(
                equalTo: LYT.centerYAnchor
            ),
            
            SearchBar.heightAnchor.constraint(
                equalToConstant: 50
            )
        ])
    }
    
    func User(_ UserLYT: CHAT_ROOM_USER_LYT , MidViewLYT:CHAT_ROOM_USER_MID_VIEW_LYT, Username:String , Time:String , avatar:String , avatarAt:Save ,RecentSMS:String , NuberofUnseenSMS:Int64)->CHAT_ROOM_USER_LYT{
        
        let user = CHAT_ROOM_USER_LYT()
        user.backgroundColor = APPCOLOR.LayoutColor
        user.translatesAutoresizingMaskIntoConstraints = false
        user.heightAnchor.constraint(equalToConstant: 70).isActive = true
        
        func profileImageDetector(path: String) -> UIImage {
            if (path.isEmpty){
                return UIImage(systemName: "person.circle.fill")!
            }else{
                
                
                if (avatarAt == Save.Temporary){
                    let temporaryURL = FileManager.default.temporaryDirectory
                    let temporaryPath = temporaryURL.appendingPathComponent(path).path
                
                    return UIImage(contentsOfFile: temporaryPath) ?? UIImage(systemName: "person.circle.fill")!
                }else if(avatarAt == Save.Permanently) {
                    let documentsURL = FileManager.default.urls(
                            for: .documentDirectory,
                            in: .userDomainMask
                    )[0]
                        
                    let Fullpath = documentsURL.appendingPathComponent(path).path
                    
                    return UIImage(contentsOfFile: Fullpath) ?? UIImage(systemName: "person.circle.fill")!
                }else{
                    return UIImage(systemName: "person.circle.fill")!
                }
                
            }
        }
                
        let ChatRoomUser = ChatRoomUser(
            data: .init(
                Username: Username,
                Time: timeDetect.FindCurrentTime(Time: Time)!,
                ProfileImg:profileImageDetector(path: avatar),
                RecentSMS: RecentSMS,
                NuberofUnseenSMS:String(NuberofUnseenSMS)
            ),
            Onclick: {
                //            let service = PERSON_CRUD()
                //            let result: () = service.PERSON_Model_All_Person()
                //            print(result)
                
            },
            OnclickImg: {
                            
                self.view.addSubview(MidViewLYT)
                NSLayoutConstraint.activate([
                    MidViewLYT.topAnchor.constraint(equalTo: self.view.topAnchor),
                    MidViewLYT.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
                    MidViewLYT.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
                    MidViewLYT.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
                ])
                
                let myUI = UIView()
                
                let ImgView = ChatRoomUserProfileImgMID_VIEW()
                    .Mid_imgviewPass(
                        FullImg: profileImageDetector(path: avatar)
                )
                MidViewLYT.addSubview(ImgView)
                ImgView.translatesAutoresizingMaskIntoConstraints = false
                NSLayoutConstraint.activate([
                    ImgView.leadingAnchor.constraint(
                        equalTo: MidViewLYT.leadingAnchor,
                        constant: 10
                    ),

                    ImgView.trailingAnchor.constraint(
                        equalTo: MidViewLYT.trailingAnchor,
                        constant: -10
                    ),

                    ImgView.centerYAnchor.constraint(
                        equalTo: MidViewLYT.centerYAnchor
                    )
                ])
                
                

            }
        )
        user.addSubview(ChatRoomUser)
        NSLayoutConstraint.activate([
            ChatRoomUser.topAnchor.constraint(equalTo: user.topAnchor , constant: 8),
            ChatRoomUser.leadingAnchor.constraint(equalTo: user.leadingAnchor, constant: 8),
            ChatRoomUser.trailingAnchor.constraint(equalTo: user.trailingAnchor, constant: -8),
            ChatRoomUser.bottomAnchor.constraint(equalTo: user.bottomAnchor , constant: -8)
        ])
        return user
        
    }
    
    func StoredUsersListView(_ LYT: UIStackView, UserLYT: CHAT_ROOM_USER_LYT , LS:PERSON_Serv, MidViewLYT:CHAT_ROOM_USER_MID_VIEW_LYT) {
        // Call the local Server and Get the users
        
        let UsserBasket = LS.GetAllUser()
        
        for USER in UsserBasket {
            if(USER.ISUserviewed != true){
                let user = User(UserLYT,
                                MidViewLYT: MidViewLYT,
                                Username: USER.Username,
                                Time: USER.lastActivitydate,
                                avatar: USER.avatar, avatarAt: Save.Permanently,
                                RecentSMS: USER.LastSMS,
                                NuberofUnseenSMS: USER.unseensmses)
                LYT.addArrangedSubview(user)
            }
        }
    }
    
}
