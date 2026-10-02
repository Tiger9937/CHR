struct CHATREINVITE_RES:Decodable{
    let statusCode: Int
    let message: String
    let success: Bool
    let data: [CHATREINVITE_MODELS]
}


struct CHATREINVITE_MODELS: Decodable {
    let username: String
    let avatarImage: String
    let timeAgo: String
    let distanceText: Double
    let mutualFriendsCount: Int
    let isUserOnline: Bool
}
