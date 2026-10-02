
struct FRIENDREQUEST_RES_RESIVED_LIST:Decodable{
    let statusCode: Int
    let message: String
    let success: Bool
    let data: [FRIENDREQUEST_MODELS_ALLREQUEST_RESIVED_LIST]
}

struct FRIENDREQUEST_RES_SENDED_LIST:Decodable{
    let statusCode: Int
    let message: String
    let success: Bool
    let data: [FRIENDREQUEST_MODELS_ALLREQUEST_SENDED_LIST]
}

struct FRIENDREQUEST_MODELS_ALLREQUEST_RESIVED_LIST: Decodable {
    let username: String
    let TimeAgo: String
    let verifiedBadge: Bool
    let isUserOnline: Bool
    let avatarImage: String
}

struct FRIENDREQUEST_MODELS_ALLREQUEST_SENDED_LIST: Decodable {
    let username: String
    let verifiedBadge: Bool
    let isUserOnline: Bool
    let avatarImage: String
    let TimeAgo: String
    let RequestCurrentStatus:StatusCODE
}
