enum ErrorService{
    enum AllNetworkError: Error {
        case Usernetoff
        case InvalidURL
        case ServerError
        case ServerErrorCode(statusCode: Int)
    }
}

enum ServerName: String {
    case baseURL = "http://localhost:8000/Api/v1/"
}


enum StatusCODE: String, Decodable{
    case pending
    case accepted
    case denied
}

enum Save: String{
    case Temporary
    case Permanently
}
