
import Network

class NetworkService {
    static let shared = NetworkService()
    
    private let monitor = NWPathMonitor()
    // it well helping to queue our nwtwork Task so that other procccess work uninterruptedly
    private let queue = DispatchQueue(label: "Debug:NetworkMonitor")
    private(set) var isConnected: Bool = true

    private init() {
        // pathUpdateHandler: is can helping to give the current status of the network
        monitor.pathUpdateHandler = { [weak self] path in
            print(path.status)
            self?.isConnected = path.status == .satisfied
        }
        monitor.start(queue: queue)
    }
    func Networkstatus()->Bool{
        return isConnected
    }
}
