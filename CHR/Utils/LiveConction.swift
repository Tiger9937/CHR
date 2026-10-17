
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
        socket.on(clientEvent: .connect) { _, _ in
            print("Socket connected")
        }

        socket.on(clientEvent: .disconnect) { data, _ in
            print("Socket disconnected:", data)
        }

        socket.on(clientEvent: .error) { data, _ in
            print("Socket error:", data)
        }

        socket.connect()
    }

    func disconnect() {
        socket.disconnect()
    }

    func sendMessage(_ message: String) {
        socket.emit("sendMessage", [
            "message": message
        ])
    }
    
    func SendMessageToOtherPerson(_ message: String , liveID:String){
        socket.emit("C_to_C", [
            "senderSocketId": liveID,
            "message": message
        ])
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
