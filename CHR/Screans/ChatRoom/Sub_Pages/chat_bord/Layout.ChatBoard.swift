import UIKit

class CHATBOARD_USER_BNNER_LYT: UIView{
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

class CHATBOARD_ACTIVITY_VIEW_LYT: UIScrollView {

    override init(frame: CGRect) {
        super.init(frame: frame)

        Configur()
    }

    required init?(coder: NSCoder) {
        fatalError(
            "CHATBOARD_ACTIVITY_VIEW_LYT has not been implemented"
        )
    }

    private func Configur() {
        translatesAutoresizingMaskIntoConstraints = false
        layer.cornerRadius = 15
        clipsToBounds = true   // keeps content inside the rounded corners

        
        self.layoutIfNeeded()
        let bottomY = self.contentSize.height
                       - self.bounds.height
                       + self.adjustedContentInset.bottom
           let offset = CGPoint(x: 0, y: max(-self.adjustedContentInset.top, bottomY))
        self.setContentOffset(offset, animated: true)
    }
    
}





class CHATBOARD_ACTIVITY_LYT: UIView {
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

class CHATBOARD_ALLCHATS_LYT: UIStackView{
    override init(frame: CGRect) {
        super.init(frame: frame)
        Configur()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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





class CHATBOARD_TEXTFILD_ONGOING_LYT: UIView {

    let BaseArea = UIView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        Configur()
    }

    required init?(coder: NSCoder) {
        fatalError("CHATBOARD_TEXTFILD_ONGOING_LYT has not been implemented")
    }

    func Addcontents(UserTextView: UILabel, UserTextTimeView: UILabel) {

        [UserTextView, UserTextTimeView].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            BaseArea.addSubview($0)   // added into BaseArea instead of self
        }

        UserTextView.numberOfLines = 0
        UserTextView.lineBreakMode = .byWordWrapping

        NSLayoutConstraint.activate([
            UserTextView.topAnchor.constraint(equalTo: BaseArea.topAnchor, constant: 10),
            UserTextView.leadingAnchor.constraint(equalTo: BaseArea.leadingAnchor, constant: 10),
            UserTextView.trailingAnchor.constraint(equalTo: BaseArea.trailingAnchor, constant: -15),
            
            UserTextTimeView.topAnchor.constraint(equalTo: UserTextView.bottomAnchor, constant: 5),
            UserTextTimeView.trailingAnchor.constraint(equalTo: BaseArea.trailingAnchor, constant: -10),
            UserTextTimeView.bottomAnchor.constraint(equalTo: BaseArea.bottomAnchor, constant: -10)
        ])
    }

    private func Configur() {
        translatesAutoresizingMaskIntoConstraints = false
        
        BaseArea.translatesAutoresizingMaskIntoConstraints = false
        BaseArea.backgroundColor = APPCOLOR.LayoutColor
        BaseArea.layer.cornerRadius = 20
        
        
        addSubview(BaseArea)
        NSLayoutConstraint.activate([
            BaseArea.topAnchor.constraint(equalTo: topAnchor),
            BaseArea.leadingAnchor.constraint(equalTo: leadingAnchor),
            BaseArea.trailingAnchor.constraint(equalTo: trailingAnchor),
            BaseArea.bottomAnchor.constraint(equalTo: bottomAnchor),
            BaseArea.widthAnchor.constraint(lessThanOrEqualTo: widthAnchor, multiplier: 0.8),
        ])
        
        
    }
}

class CHATBOARD_TEXTFILD_UPCOMING_LYT: UIView {
    
    let BaseArea = UIView()
    let SidePinArea = UIView()
    
    private let gradientLayer = CAGradientLayer()

    override init(frame: CGRect) {
        super.init(frame: frame)
        Setup()
        Configur()
    }

    required init?(coder: NSCoder) {
        fatalError("CHATBOARD_TEXTFILD_UPCOMING_LYT has not been implemented")
    }
    
    private func Setup() {
        BaseArea.translatesAutoresizingMaskIntoConstraints = false
        BaseArea.layer.cornerRadius = 20
        BaseArea.layer.maskedCorners = [
            .layerMinXMinYCorner, // top-left
            .layerMinXMaxYCorner, // bottom-leftu
            .layerMaxXMaxYCorner  // bottom-right
        ]
        BaseArea.clipsToBounds = true
        
        BaseArea.backgroundColor = .systemBlue.withAlphaComponent(0.9)
        addSubview(BaseArea)
        
        SidePinArea.translatesAutoresizingMaskIntoConstraints = false
        addSubview(SidePinArea)
        // Gradient
        gradientLayer.colors = [
            UIColor.systemBlue.withAlphaComponent(0.9).cgColor,
            UIColor.systemBlue.withAlphaComponent(0.9).cgColor,
            UIColor.clear.cgColor
        ]

        gradientLayer.locations = [ 0.0, 0.50, 0.50 ]

        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 1.0)
        SidePinArea.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    func AddContent( UserTextView: UILabel, UserTextTimeView: UILabel, UserTextDispatchStatusView: UIImageView ) {
        [ UserTextView,  UserTextTimeView, UserTextDispatchStatusView ].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            BaseArea.addSubview($0)
        }

        NSLayoutConstraint.activate([

            // User Text
            UserTextView.topAnchor.constraint(equalTo: BaseArea.topAnchor, constant: 10),
            UserTextView.leadingAnchor.constraint( equalTo: BaseArea.leadingAnchor, constant: 10),
            UserTextView.trailingAnchor.constraint(equalTo: BaseArea.trailingAnchor, constant: -10),


            // Time
            UserTextTimeView.topAnchor.constraint( equalTo: UserTextView.bottomAnchor , constant: 5),


            // Dispatch Status
            UserTextDispatchStatusView.leadingAnchor.constraint( equalTo: UserTextTimeView.trailingAnchor,constant:6),
            UserTextDispatchStatusView.centerYAnchor.constraint( equalTo: UserTextTimeView.centerYAnchor),
            UserTextDispatchStatusView.trailingAnchor.constraint( lessThanOrEqualTo: trailingAnchor, constant: -27),

            // Bottom
            UserTextTimeView.bottomAnchor.constraint(equalTo: BaseArea.bottomAnchor, constant: -10)
        ])
    }

    private func Configur() {
        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            
            // BaseArea
            BaseArea.topAnchor.constraint(equalTo: topAnchor),
            BaseArea.bottomAnchor.constraint(equalTo: bottomAnchor),
            BaseArea.widthAnchor.constraint( lessThanOrEqualTo: widthAnchor, multiplier: 0.7 ),
            // SidePinArea
            SidePinArea.topAnchor.constraint(equalTo: topAnchor),
            SidePinArea.heightAnchor.constraint(equalToConstant: 20),
            SidePinArea.leadingAnchor.constraint(equalTo: BaseArea.trailingAnchor),
            SidePinArea.trailingAnchor.constraint(equalTo: trailingAnchor),
            SidePinArea.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.03)
        ])
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = SidePinArea.bounds
        
    }
}
