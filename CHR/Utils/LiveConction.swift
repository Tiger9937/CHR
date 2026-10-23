
import Foundation
import SocketIO

final class SocketService {

    static let shared = SocketService()

    private let manager: SocketManager
    let socket: SocketIOClient

    private init() { let url = URL(string: "http://localhost:8000")!
        manager = SocketManager( socketURL: url, config: [
                .log(true),
                .compress,
                .reconnects(true),
                .reconnectAttempts(-1),
                .reconnectWait(5)
            ]
        )
        socket = manager.defaultSocket
    }
    

    func connect() {
        socket.on(clientEvent: .connect) {[weak self] _, _ in
            print("Socket connected")
            
            self!.socket.emit("C_to_S_CONCTION", [
                "Userid":"6984fdb67e36039f498ae131"
            ])
            
        }

        socket.on(clientEvent: .disconnect) { data, _ in
            print("Socket disconnected:", data)
        }

        socket.on(clientEvent: .error) { data, _ in
            print("Socket error:", data)
        }

        socket.connect()
    }
    
    // MARK: Writing (this can use as a Send Data)
    func disconnect() {
        socket.disconnect()
    }
    
    func SendMessageToOtherPerson(MessageID:UUID, message: String , liveID:String){
        socket.emit("C_to_C", [
            "MessageID":"\(MessageID)",
            "senderSocketId": liveID,
            "message": message
        ])
    }
    
    func SendMessageToServer(_ username: String) {
        print("Ready to send SMS")
        socket.emit("C_to_S", [
            "Username": username,
            "message": "Hello Server!",
            "time": ISO8601DateFormatter().string(from: Date())
        ])
        print("Ready to send SMS And exit")
    }
    
    
    
    // MARK: Reading (this can use as a only to Resive data)
    func listenMessagesFor_A_Server(OnPayloadReturn:@escaping (String) -> Void){
        socket.on("S_to_C") { data, _ in
            if let payloadArray = data.first as? [String: Any] {
                let payload = payloadArray["Payload"] as? [String: Any]
                let liveID = payload!["LiveID"] as? String
                 OnPayloadReturn(liveID!)
            }
        }
        
    }

    func listenMessagesFor_A_User(OnMessageReturn: @escaping (String,String)->Void ){
        socket.on("RECEIVE MESSAGE") { data, _ in
                guard let response = data.first as? [String: Any] else {
                    return
                }
            
                let message = response["message"] as? String ?? ""
                let time = response["time"] as? String ?? ""

               
            
                OnMessageReturn(message,time)
        }
    }
    
    
}
