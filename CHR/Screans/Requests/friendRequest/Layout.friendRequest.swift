import UIKit
let refreshControl = UIRefreshControl()


class FRIENDREQUEST_HEADER_LYT: UIView{
    override init(frame: CGRect) {
        super.init(frame: frame)
        Configur()
    }
    
    required init?(coder: NSCoder) {
        fatalError("PRIVATE_PROFILE_INTREST_LYT has not been implemented")
    }
    
    private func Configur() {
        translatesAutoresizingMaskIntoConstraints = false
        layer.cornerRadius = 15
    }
}

class FRIENDREQUEST_SUBHEADER_LYT: UIView{
    override init(frame: CGRect) {
        super.init(frame: frame)
        Configur()
    }
    
    required init?(coder: NSCoder) {
        fatalError("PRIVATE_PROFILE_INTREST_LYT has not been implemented")
    }
    
    private func Configur() {
        translatesAutoresizingMaskIntoConstraints = false
        layer.cornerRadius = 15
    }
}

class FRIENDREQUEST_SEARCHBAR_LYT: UIView{
    override init(frame: CGRect) {
        super.init(frame: frame)
        Configur()
    }
    
    required init?(coder: NSCoder) {
        fatalError("PRIVATE_PROFILE_INTREST_LYT has not been implemented")
    }
    
    private func Configur() {
        translatesAutoresizingMaskIntoConstraints = false
        layer.cornerRadius = 15
    }
}

class FRIENDREQUEST_SEGMENTEDCONTROL_LYT: UIView{
        override init(frame: CGRect) {
            super.init(frame: frame)
            Configur()
        }
        
        required init?(coder: NSCoder) {
            fatalError("PRIVATE_PROFILE_INTREST_LYT has not been implemented")
        }
        
        private func Configur() {
            translatesAutoresizingMaskIntoConstraints = false
            layer.cornerRadius = 15
        }
}


class FRIENDREQUEST_RECIEVIED_LYT: UIScrollView{
    var onRefresh: (() -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        Configur()
    }
    
    required init?(coder: NSCoder) {
        fatalError("PRIVATE_PROFILE_INTREST_LYT has not been implemented")
    }
    
    private func PageRefresh() {
        let refreshControl = UIRefreshControl()
        refreshControl.tintColor = APPCOLOR.SubContentColor
        
        refreshControl.addAction(
            UIAction { [weak self] _ in
                self?.onRefresh?()
            },
            for: .valueChanged
        )
        
        self.refreshControl = refreshControl
    }
    
    private func Configur() {
        
        
        
        translatesAutoresizingMaskIntoConstraints = false
        layer.cornerRadius = 15
    }
}

class FRIENDREQUEST_REQUESR_SEND_LYT: UIScrollView{
    
    var onRefresh: (() -> Void)?

    override init(frame: CGRect) {
        super.init(frame: frame)
        Configur()
    }
    
    required init?(coder: NSCoder) {
        fatalError("PRIVATE_PROFILE_INTREST_LYT has not been implemented")
    }
    
    private func PageRefresh() {
        let refreshControl = UIRefreshControl()
        refreshControl.tintColor = APPCOLOR.SubContentColor
        
        refreshControl.addAction(
            UIAction { [weak self] _ in
                self?.onRefresh?()
            },
            for: .valueChanged
        )
        
        self.refreshControl = refreshControl
    }
    
    
    private func Configur() {
        translatesAutoresizingMaskIntoConstraints = false
        layer.cornerRadius = 15
    }
}
