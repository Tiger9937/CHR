import UIKit

class CHAT_ROOM_HEADER_LYT: UIView{
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

class CHAT_ROOM_SEARCHBAR_LYT: UIView{
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

class CHAT_ROOM_ALLCHATS_LYT: UIScrollView{
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

class CHAT_ROOM_STACKVIEW_LYT: UIStackView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        Configur()
    }
    
    required init(coder: NSCoder) {
        fatalError("CHAT_ROOM_STACKVIEW_LYT has not been implemented")
    }
    
    private func Configur() {
        axis = .vertical
        alignment = .fill
        distribution = .fill
        spacing = 10
        
        translatesAutoresizingMaskIntoConstraints = false
        layer.cornerRadius = 15
        clipsToBounds = true
    }
}

class CHAT_ROOM_USER_LYT: UIView{
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

class CHAT_ROOM_USER_MID_VIEW_LYT: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        Configur()
    }
    
    required init?(coder: NSCoder) {
        fatalError("PRIVATE_PROFILE_INTREST_LYT has not been implemented")
    }
    
    private func Configur() {
        isUserInteractionEnabled = true
        translatesAutoresizingMaskIntoConstraints = false
        layer.cornerRadius = 15
        backgroundColor = .black.withAlphaComponent(0.5)

        ImgMidViewClickToRemove()
    }
    
    func ImgMidViewClickToRemove(){
        let tapGesture = UITapGestureRecognizer(
            target: self,
            action: #selector(removeMidimgView)
        )
        addGestureRecognizer(tapGesture)
    }
    @objc func removeMidimgView() {
        removeFromSuperview()
    }
}

//NSLayoutConstraint.activate([
//    topAnchor.constraint(equalTo: self.view.topAnchor),
//    bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
//    leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
//    trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
//])
