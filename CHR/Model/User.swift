
struct USER_MODEL:Decodable{
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

struct interests:Decodable{
    let icon:String
    let name:String
    let ishighlight:Bool
}
