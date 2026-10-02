import UIKit

struct FriendRequest_CMPTS {
    
    let HEADERTITEL_CMPT = HEADER_CMPT(title: "Friend Requests")
    
    let Searchbar_CMPT = SEARCHBAR_CMPT(
        placeholder: "Search Your Friend....."
    )
    
}

struct FriendRequest_CNT {
    let SegmentIndicater = FRIEND_REQ_SAGMENT_INDICATER()
}

struct FriendRequest_LYTS {
    
    let HEADER_LYT = FRIENDREQUEST_HEADER_LYT()
    
    let SUBHEADER_LYT = FRIENDREQUEST_SUBHEADER_LYT()
    
    var scrollLayout = UIScrollView()
    
    let SearchBar_LYT = FRIENDREQUEST_SEARCHBAR_LYT()
    
    let FriendRequestRecevied_LYT = FRIENDREQUEST_RECIEVIED_LYT()
    
    let FriendRequestSend_LYT = FRIENDREQUEST_REQUESR_SEND_LYT()
    
    let FriendRequest_Segment = FRIENDREQUEST_SEGMENTEDCONTROL_LYT()
}


@MainActor
class FRIEND_REQUEST_LIST_VC: UIViewController, UIScrollViewDelegate {
    
    let CMPT = FriendRequest_CMPTS()
    
    let LYT = FriendRequest_LYTS()
    
    let internetcall = INTERNET()
    
    let refreshControl = UIRefreshControl()
    
    // NOTE: removed the old unused `MainBox` property — it was a leftover
    // pointing at a brand-new FriendRequest_LYTS().scrollLayout instance
    // that was never actually used anywhere. `LYT.scrollLayout` is the
    // real scroll view in use.
    var REQ_ResiveedLayout = FriendRequest_LYTS().FriendRequestRecevied_LYT
    var REQ_SendedLayout = FriendRequest_LYTS().FriendRequestSend_LYT
    
    enum Segment {
        case received(FRIENDREQUEST_RES_RESIVED_LIST)
        case sended(FRIENDREQUEST_RES_SENDED_LIST)
    }
    
    
    var Segment_Indicater = FRIEND_REQ_SAGMENT_INDICATER()
    
    let eventCaptucher = EventCaptucher()
    
    // MARK: - Current page
    // 0 = Received
    // 1 = Sended
    
    private var currentPage: Int = 0
    
    
    override func viewDidLoad()   {
        super.viewDidLoad()
        
        APPCOLOR.CurrentThem()
        
        let scrollLayout = LYT.scrollLayout
        let MainBoxLYT = LYT.scrollLayout
        
        view.backgroundColor = APPCOLOR.BackgroundColor
        
        view.addSubview(LYT.HEADER_LYT)
        
        view.addSubview(LYT.SUBHEADER_LYT)
        
        view.addSubview(scrollLayout)
        
        // MARK: - Scroll delegate
        
        
        Auto_Page_Sizing()
        
        HaderView()
        
        SubHeder(
            mainBox: MainBoxLYT,
            SegmentIndicat: Segment_Indicater
        )
        
        
        // MARK: Paging
        // FIX: MainGrupOne/MainGrupTwo now await their network fetch
        // directly (no more untracked inner Task{}), so this sequence
        // is genuinely sequential: page 1's fetch fully completes
        // before page 2's fetch starts. If you want them to run in
        // parallel instead, see the `async let` version noted below.
        MainBoxLYT.alwaysBounceVertical = false
        MainBoxLYT.delegate = self
        MainBoxLYT.isPagingEnabled = true
        MainBoxLYT.alwaysBounceHorizontal = true
        MainBoxLYT.showsHorizontalScrollIndicator = false
        
        Task {
            
            // MARK: - First Task
            let Members = await Online(NumberOfaPage: 0)
            
            if let Members {
                switch Members {
                case .received(let Members):
                    await MainGrupOne(
                        mainBox: MainBoxLYT,
                        Members: Members
                    )
                    
                case .sended:
                    break
                }
            }
            
            // MARK: - Second Task
            let MembersTwo = await Online(NumberOfaPage: 1)
            
            if let MembersTwo {
                switch MembersTwo {
                case .received:
                    break
                    
                case .sended(let Members):
                    await MainGrupTwo(
                        mainBox: MainBoxLYT,
                        Members: Members
                    )
                }
            }
        }
    }
    
    
    // MARK: - Page sizing
    
    func Auto_Page_Sizing() {
        
        LYT.HEADER_LYT.translatesAutoresizingMaskIntoConstraints = false
        
        LYT.scrollLayout.translatesAutoresizingMaskIntoConstraints = false
        
        LYT.SUBHEADER_LYT.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            
            LYT.HEADER_LYT.topAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.topAnchor
            ),
            
            LYT.HEADER_LYT.leadingAnchor.constraint(
                equalTo: view.leadingAnchor,
                constant: 10
            ),
            
            LYT.HEADER_LYT.trailingAnchor.constraint(
                equalTo: view.trailingAnchor,
                constant: -10
            ),
            
            LYT.HEADER_LYT.heightAnchor.constraint(
                equalToConstant: 60
            ),
            
            
            LYT.SUBHEADER_LYT.topAnchor.constraint(
                equalTo: LYT.HEADER_LYT.bottomAnchor
            ),
            
            LYT.SUBHEADER_LYT.leadingAnchor.constraint(
                equalTo: view.leadingAnchor
            ),
            
            LYT.SUBHEADER_LYT.trailingAnchor.constraint(
                equalTo: view.trailingAnchor
            ),
            
            
            LYT.scrollLayout.topAnchor.constraint(
                equalTo: LYT.SUBHEADER_LYT.bottomAnchor,
                constant: 10
            ),
            
            LYT.scrollLayout.leadingAnchor.constraint(
                equalTo: view.leadingAnchor,
                constant: 10
            ),
            
            LYT.scrollLayout.trailingAnchor.constraint(
                equalTo: view.trailingAnchor,
                constant: -10
            ),
            
            LYT.scrollLayout.bottomAnchor.constraint(
                equalTo: view.bottomAnchor
            )
        ])
    }
    
    
    // MARK: - Header
    
    func HaderView() {
        
        let Haderlayout = LYT.HEADER_LYT
        
        let Haderview = CMPT.HEADERTITEL_CMPT
        
        Haderview.translatesAutoresizingMaskIntoConstraints = false
        
        Haderlayout.addSubview(Haderview)
        
        NSLayoutConstraint.activate([
            
            Haderview.topAnchor.constraint(
                equalTo: Haderlayout.topAnchor,
                constant: 10
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
            )
        ])
    }
    
    
    // MARK: - Sub Header
    func SubHeder( mainBox: UIScrollView, SegmentIndicat: FRIEND_REQ_SAGMENT_INDICATER) {
        let Subhederlayout = LYT.SUBHEADER_LYT
        
        // MARK: SearchBar
        
        let SearchBarlayout = LYT.SearchBar_LYT
        
        Subhederlayout.addSubview(SearchBarlayout)
        
        searchBar(SearchBarlayout)
        
        NSLayoutConstraint.activate([
            
            SearchBarlayout.topAnchor.constraint(
                equalTo: Subhederlayout.topAnchor,
                constant: 10
            ),
            
            SearchBarlayout.leadingAnchor.constraint(
                equalTo: Subhederlayout.leadingAnchor,
                constant: 10
            ),
            
            SearchBarlayout.trailingAnchor.constraint(
                equalTo: Subhederlayout.trailingAnchor,
                constant: -10
            ),
            
            SearchBarlayout.heightAnchor.constraint(
                equalToConstant: 47
            )
        ])
        
        
        // MARK: SegmentedControl
        
        let SegmentedControlLayout = LYT.FriendRequest_Segment
        
        Subhederlayout.addSubview(SegmentedControlLayout)
        
        Segment_Control(SegmentedControlLayout, SegmentIndicat: SegmentIndicat, TrgetedMainView: mainBox)
        
        NSLayoutConstraint.activate([
            
            SegmentedControlLayout.topAnchor.constraint(
                equalTo: SearchBarlayout.bottomAnchor,
                constant: 10
            ),
            
            SegmentedControlLayout.leadingAnchor.constraint(
                equalTo: Subhederlayout.leadingAnchor,
                constant: 10
            ),
            
            SegmentedControlLayout.trailingAnchor.constraint(
                equalTo: Subhederlayout.trailingAnchor,
                constant: -10
            ),
            
            SegmentedControlLayout.heightAnchor.constraint(
                equalToConstant: 47
            ),
            
            SegmentedControlLayout.bottomAnchor.constraint(
                equalTo: Subhederlayout.bottomAnchor
            )
        ])
    }
    
    
    // MARK: - Network
    func Online(NumberOfaPage: Int) async -> Segment? {
        do {
            let LastNameOfaRequest: String
            
            if (NumberOfaPage == 0) {
                LastNameOfaRequest = "RequestResived"
                let data = try await internetcall.GET(
                    URI: "\(ServerName.baseURL.rawValue)Test/sendTEST2/\(LastNameOfaRequest)"
                )
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                
                let ResivedDecodedData = try decoder.decode(FRIENDREQUEST_RES_RESIVED_LIST.self, from: data)
                return .received(ResivedDecodedData)
                
            } else if (NumberOfaPage > 0) {
                LastNameOfaRequest = "RequestSendedList"
                let data = try await internetcall.GET(
                    URI: "http://localhost:8000/Api/v1/Test/sendTEST2/RequestSendedList"
                )
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                
                let ResivedDecodedData = try decoder.decode(FRIENDREQUEST_RES_SENDED_LIST.self, from: data)
                return .sended(ResivedDecodedData)
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
    
    
    // MARK: - MainGrupe horizontal pages
    
    func MainGrupOne(mainBox: UIScrollView , Members:FRIENDREQUEST_RES_RESIVED_LIST) async {
        let stackView = UIStackView()
        REQ_ResiveedLayout.translatesAutoresizingMaskIntoConstraints = false
        // Individual vertical scrolling
        REQ_ResiveedLayout.alwaysBounceVertical = true
        REQ_ResiveedLayout.showsVerticalScrollIndicator = true
        
        mainBox.addSubview(REQ_ResiveedLayout)
        NSLayoutConstraint.activate([

            // MARK: First page - Received

            REQ_ResiveedLayout.leadingAnchor.constraint(
                equalTo: mainBox.contentLayoutGuide.leadingAnchor
            ),

            REQ_ResiveedLayout.topAnchor.constraint(
                equalTo: mainBox.contentLayoutGuide.topAnchor
            ),

            REQ_ResiveedLayout.widthAnchor.constraint(
                equalTo: mainBox.frameLayoutGuide.widthAnchor
            ),

            REQ_ResiveedLayout.bottomAnchor.constraint(
                equalTo: mainBox.frameLayoutGuide.bottomAnchor
            )
        ])
        Frends_RequestsResiveedList(REQ_ResiveedLayout, FetchData: Members, stackViewLYT: stackView)
        
        
        
        let refreshControl = UIRefreshControl()
        refreshControl.tintColor = APPCOLOR.SubContentColor
        REQ_ResiveedLayout.refreshControl = refreshControl
        refreshControl.tintColor = APPCOLOR.SubContentColor
        
        refreshControl.addAction( UIAction { [self] _ in
            
            stackView.arrangedSubviews.forEach {
                        stackView.removeArrangedSubview($0)
                        $0.removeFromSuperview()
            }
            
            Task{
                let New_Members = await self.Online(NumberOfaPage: 0)
                if let New_Members {
                    switch New_Members {
                    case .received(let New_Members):
                        Frends_RequestsResiveedList(REQ_ResiveedLayout, FetchData: New_Members, stackViewLYT: stackView)
                    case .sended:
                        break
                    }
                }
            }
            
            refreshControl.endRefreshing()
        }, for: .valueChanged)

        REQ_ResiveedLayout.refreshControl = refreshControl
    
    }
    
    func MainGrupTwo(mainBox: UIScrollView , Members:FRIENDREQUEST_RES_SENDED_LIST) async {
        let stackView = UIStackView()
        REQ_SendedLayout.translatesAutoresizingMaskIntoConstraints = false
        mainBox.addSubview(REQ_SendedLayout)
        NSLayoutConstraint.activate([

            // MARK: Second page - Sended

            REQ_SendedLayout.leadingAnchor.constraint(
                equalTo: REQ_ResiveedLayout.trailingAnchor
            ),

            REQ_SendedLayout.topAnchor.constraint(
                equalTo: mainBox.contentLayoutGuide.topAnchor
            ),

            REQ_SendedLayout.widthAnchor.constraint(
                equalTo: mainBox.frameLayoutGuide.widthAnchor
            ),

            REQ_SendedLayout.bottomAnchor.constraint(
                equalTo: mainBox.frameLayoutGuide.bottomAnchor
            ),

            REQ_SendedLayout.trailingAnchor.constraint(
                equalTo: mainBox.contentLayoutGuide.trailingAnchor
            )
        ])

        let refreshControl = UIRefreshControl()
        refreshControl.tintColor = APPCOLOR.SubContentColor
        REQ_SendedLayout.refreshControl = refreshControl
        REQ_SendedLayout.alwaysBounceVertical = true
        
        Frends_RequestsSendedList(REQ_SendedLayout, FetchData: Members, stackViewLYT: stackView)
        
        refreshControl.addAction( UIAction { [self] _ in
            
            stackView.arrangedSubviews.forEach {
                        stackView.removeArrangedSubview($0)
                        $0.removeFromSuperview()
            }
            Task{
                let New_Members = await self.Online(NumberOfaPage: 1)
                if let New_Members {
                    switch New_Members {
                    case .received:
                       break
                    case .sended(let New_Members):
                        Frends_RequestsSendedList(REQ_SendedLayout, FetchData: New_Members, stackViewLYT: stackView)
                    }
                }
            }
            
            refreshControl.endRefreshing()
        }, for: .valueChanged)

        
    }
    
    
    
    
    func scrollViewDidEndDragging( _ scrollView: UIScrollView, willDecelerate decelerate: Bool ) {
        if !decelerate {
            updatePageFromScroll(scrollView)
        }
    }

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView ) {
        updatePageFromScroll(scrollView)
    }

    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView ) {
        updatePageFromScroll(scrollView)
    }

    func updatePageFromScroll( _ scrollView: UIScrollView ) {
        
        let pageWidth = scrollView.bounds.width
        
        guard pageWidth > 0 else {
            return
        }
        
        let currentOffsetX = scrollView.contentOffset.x
        
        let page = Int(
            round(currentOffsetX / pageWidth)
        )
        
        
        // Don't call the action repeatedly
        if page == currentPage {
            return
        }
        currentPage = page
        if page == 0 {
            Segment_Indicater.trigger(.received)
        }
        else if page == 1 {
            Segment_Indicater.trigger(.sended)
        }
    }
    
    
    
    
    
}


func searchBar(_ LYT: UIView) {
    
    let SearchBar =
        FriendRequest_CMPTS().Searchbar_CMPT
    
    SearchBar.onSubmit = { text in
        
        print("\(text)")
    }
    
    SearchBar.translatesAutoresizingMaskIntoConstraints = false
    
    LYT.addSubview(SearchBar)
    
    NSLayoutConstraint.activate([
        
        SearchBar.topAnchor.constraint(
            equalTo: LYT.topAnchor
        ),
        
        SearchBar.leadingAnchor.constraint(
            equalTo: LYT.leadingAnchor
        ),
        
        SearchBar.trailingAnchor.constraint(
            equalTo: LYT.trailingAnchor
        ),
        
        SearchBar.bottomAnchor.constraint(
            equalTo: LYT.bottomAnchor
        )
    ])
}

func Segment_Control( _ LYT: UIView, SegmentIndicat: FRIEND_REQ_SAGMENT_INDICATER , TrgetedMainView: UIScrollView) {
    
    LYT.addSubview(SegmentIndicat)
    
   
    SegmentIndicat.onRisive = { [weak TrgetedMainView] in

        TrgetedMainView?.setContentOffset(
            CGPoint(x: 0, y: 0),
            animated: true
        )
    }

    SegmentIndicat.onSender = { [weak TrgetedMainView] in

        TrgetedMainView?.setContentOffset(
            CGPoint(x: TrgetedMainView?.bounds.width ?? 0, y: 0),
            animated: true
        )
    }
    
    SegmentIndicat.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
        
        SegmentIndicat.leadingAnchor.constraint(
            equalTo: LYT.leadingAnchor
        ),
        
        SegmentIndicat.trailingAnchor.constraint(
            equalTo: LYT.trailingAnchor
        ),
        
        SegmentIndicat.topAnchor.constraint(
            equalTo: LYT.topAnchor
        ),
    ])
}

func Frends_RequestsResiveedList(_ LYT: UIScrollView ,
                                 FetchData: FRIENDREQUEST_RES_RESIVED_LIST ,
                                 stackViewLYT: UIStackView
) {
    stackViewLYT.axis = .vertical
    stackViewLYT.spacing = 10
    stackViewLYT.alignment = .fill
    stackViewLYT.distribution = .fill
    stackViewLYT.translatesAutoresizingMaskIntoConstraints = false
    LYT.addSubview(stackViewLYT)
    
    NSLayoutConstraint.activate([
        stackViewLYT.topAnchor.constraint(equalTo: LYT.contentLayoutGuide.topAnchor),
        stackViewLYT.leadingAnchor.constraint(equalTo: LYT.contentLayoutGuide.leadingAnchor),
        stackViewLYT.trailingAnchor.constraint(equalTo: LYT.contentLayoutGuide.trailingAnchor),
        stackViewLYT.bottomAnchor.constraint(equalTo: LYT.contentLayoutGuide.bottomAnchor),
        stackViewLYT.widthAnchor.constraint(equalTo: LYT.frameLayoutGuide.widthAnchor)
    ])
    
    
    for member in 0..<FetchData.data.count {
        let member = FetchData.data[member]
        let Card_LYT = UIView()
        Card_LYT.layer.cornerRadius = 15
        Card_LYT.backgroundColor = APPCOLOR.LayoutColor
        Card_LYT.translatesAutoresizingMaskIntoConstraints = false
        Card_LYT.heightAnchor.constraint(equalToConstant: 74).isActive = true
        
        let card = FRIEND_REQ_RISIVED(
            
            data: .init(avatarImage: UIImage(systemName: "person.circle.fill")!,
                        name: member.username,
                        isVerified: member.verifiedBadge,
                        timeAgo: "\(member.TimeAgo) Ago",
                        statusColor: member.isUserOnline,
                ),
                onAccept: {
                            print("Friend request accepted")
                },
                onDeny: {
                            print("Friend request denied")
                }
                
        )
        Card_LYT.addSubview(card)
        
        NSLayoutConstraint.activate([
            card.topAnchor.constraint(equalTo: Card_LYT.topAnchor),
            card.leadingAnchor.constraint(equalTo: Card_LYT.leadingAnchor, constant: 10),
            card.bottomAnchor.constraint(equalTo: Card_LYT.bottomAnchor),
            card.trailingAnchor.constraint(equalTo: Card_LYT.trailingAnchor , constant: -10),
        ])
        stackViewLYT.addArrangedSubview(Card_LYT)
        
    }
}

func Frends_RequestsSendedList(_ LYT: UIScrollView , FetchData: FRIENDREQUEST_RES_SENDED_LIST , stackViewLYT:UIStackView) {
    
    
    stackViewLYT.axis = .vertical
    stackViewLYT.spacing = 10
    stackViewLYT.alignment = .fill
    stackViewLYT.distribution = .fill
    stackViewLYT.translatesAutoresizingMaskIntoConstraints = false
    LYT.addSubview(stackViewLYT)
    
    NSLayoutConstraint.activate([
        stackViewLYT.topAnchor.constraint(equalTo: LYT.contentLayoutGuide.topAnchor),
        stackViewLYT.leadingAnchor.constraint(equalTo: LYT.contentLayoutGuide.leadingAnchor),
        stackViewLYT.trailingAnchor.constraint(equalTo: LYT.contentLayoutGuide.trailingAnchor),
        stackViewLYT.bottomAnchor.constraint(equalTo: LYT.contentLayoutGuide.bottomAnchor),
        stackViewLYT.widthAnchor.constraint(equalTo: LYT.frameLayoutGuide.widthAnchor)
    ])

    
    
    for member in 0..<FetchData.data.count {
        let member = FetchData.data[member]
        let Card_LYT = UIView()
        Card_LYT.layer.cornerRadius = 15
        Card_LYT.backgroundColor = APPCOLOR.LayoutColor
        Card_LYT.translatesAutoresizingMaskIntoConstraints = false
        Card_LYT.heightAnchor.constraint(equalToConstant: 74).isActive = true
        
        let card = FRIEND_REQ_SENDED(
            data: .init(username: "\(member.username)",
                        avatarImageView: UIImage(systemName: "person.circle.fill")!,
                        statusDot: member.isUserOnline,
                        verifiedBadge: member.verifiedBadge,
                        time: member.TimeAgo,
                        currentRequestStatus: .pending
                       ),
            AddFriend: {
                print("Hello world")
            }
        )
        Card_LYT.addSubview(card)
        
        NSLayoutConstraint.activate([
            card.topAnchor.constraint(equalTo: Card_LYT.topAnchor),
            card.leadingAnchor.constraint(equalTo: Card_LYT.leadingAnchor, constant: 10),
            card.trailingAnchor.constraint(equalTo: Card_LYT.trailingAnchor , constant: -10),
            card.bottomAnchor.constraint(equalTo: Card_LYT.bottomAnchor),

        ])
        stackViewLYT.addArrangedSubview(Card_LYT)
    }
}
