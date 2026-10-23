internal import Foundation

struct ALLCHATS_RES_LIST:Decodable{
    let statusCode: Int
    let message: String
    let success: Bool
    let data: ALLCHATS_DATA_PROFILE
}

    struct ALLCHATS_DATA_PROFILE: Decodable {
        let UserProfile: ACTIVE_USER
        let ongoing: [ALL_ONGOING_CHATS]
        let upcoming: [ALL_UPCOMING_CHATS]
    }

        struct ACTIVE_USER: Decodable {
            let Usserid:String
            let UserName:String
            let CurrentStatus:String
            let ProfileIMG:String
        }

        struct ALL_UPCOMING_CHATS:Decodable{
            let id: String
            let Message: String
            let DeliveryTime: String
            let MessageDirection:Int16
        }

        struct ALL_ONGOING_CHATS:Decodable{
            let id: String
            let Message: String
            let DispatchTime: String
            let DispatchStatus: StatusDispatch
            let MessageDirection:Int16

        }


struct FETCH_LIVE_INFO: Decodable {
    let statusCode: Int
    let message: String
    let success: Bool
    let data: LIVE_INFO_DATA
}

struct LIVE_INFO_DATA: Decodable {
    let isClintOnline: Bool
    let ClintLiveID: String
    let ClintLastActivTime: String?
}


//
struct CLIENT_CHAT_DELIVERY: Decodable {
    let statusCode: Int
    let message: String
    let success: Bool
    let data: CLIENT_CHAT_DELIVERY_INFO
}

struct CLIENT_CHAT_DELIVERY_INFO: Decodable {
    let isMessageStoreServer: Bool
    let Messageid:String
}

// MARK: Store Data When clint is Live and Work When page is active
class CLIENT_LIVE_STATUS_INFO {
    static let shared = CLIENT_LIVE_STATUS_INFO()

    private init() {}

    // Stored data
    var isClintOnline: Bool = false
    var ClintLiveID: String = ""
    var ClintLastActivTime: String? = nil

    // Save or update data
    func SaveClientData( isOnline: Bool, liveID: String, lastActiveTime: String? ) {
        self.isClintOnline = isOnline
        self.ClintLiveID = liveID
        self.ClintLastActivTime = lastActiveTime
    }

    // Get stored data
    func GetClientData() -> ( isOnline: Bool, liveID: String, lastActiveTime: String? ) {
        return ( isClintOnline, ClintLiveID, ClintLastActivTime )
    }


}


