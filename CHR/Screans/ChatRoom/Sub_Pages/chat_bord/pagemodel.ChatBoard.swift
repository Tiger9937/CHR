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
}

struct ALL_ONGOING_CHATS:Decodable{
    let id: String
    let Message: String
    let DispatchTime: String
    let DispatchStatus: StatusDispatch
}
