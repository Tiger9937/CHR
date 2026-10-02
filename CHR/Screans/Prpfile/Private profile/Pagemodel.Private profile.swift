
struct PRIVET_PROFILE_RES: Decodable {
    let statusCode: Int
    let message: String
    let success: Bool
    let data: PRIVET_PROFILE_MODEL
}

struct PRIVET_PROFILE_MODEL:Decodable{
    let username:String
    let email:String
    let fullname:String
    let avtar:String
    let coverimg:String
    let bio:String
    let chats:String
    let friends:String
    let followers:String
    let following:String
    let interests:[interests]
}


// MARK: Backend Model
//"username": "jone vev",
//    "email": "jone.vev@example.com",
//    "fullname": "Jone Vev",
//    "avtar": "Profileimg",
//    "coverimg": "NoIMG",
//    "bio": "Passionate about building things that matter. Always learning, always growing. Coffee enthusiast ☕ | Dreamer & doer 🚀 UI/UX Designer and landscape photographer based in Seattle. Currently exploring the intersection of nature and digital interactions Always up for a coffee and a chat about minimalist",
//    "chats": "123",
//    "friends": "150",
//    "followers": "1200",
//    "following": "350",
//    "interests": [
//        {
//            "icon":"camera",
//            "name":"photo",
//            "ishighlight":true
//        },
//        {
//            "icon":"music.note",
//            "name":"music",
//            "ishighlight":false
//        }
//    ]
