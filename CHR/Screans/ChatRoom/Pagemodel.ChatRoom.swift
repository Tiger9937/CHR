internal import Foundation

struct ALLPERSON_RES_LIST:Decodable{
    let statusCode: Int
    let message: String
    let success: Bool
    let data: [PERSON_MODEL]
}

struct PERSON_MODEL:Decodable{
    let id: String?
    let Usserid:String
    let Username: String
    let avatar: String
    let lastActivitydate:String
    let unseensmses: Int64
    let LastSMS:String
    let LastModelUpdate: String?
    var ISUserviewed: Bool? = nil
}

