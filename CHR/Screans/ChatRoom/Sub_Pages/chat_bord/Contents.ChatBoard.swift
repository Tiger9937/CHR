import UIKit

class USER_BNNER_CNT: UIView {

    // MARK: Public callbacks
    var onBackTapped: (() -> Void)?
    var onVideoTapped: (() -> Void)?
    var onCallTapped: (() -> Void)?
    var onMoreTapped: (() -> Void)?

    // MARK: Subviews
    let BackButton = UIButton(type: .system)
    let ProfileImage = UIImageView()
    let Username = UILabel()
    let CurrentStatus = UILabel()
    let VideoButton = UIButton(type: .system)
    let CallButton = UIButton(type: .system)
    let MoreButton = UIButton(type: .system)

    private let textStack = UIStackView()
    private let actionsStack = UIStackView()

    // MARK: Data Config
    struct DataClass {
        var Username: String
        var ProfileImg: UIImage
        var CurrentStatus: String
    }

    // MARK: CNT Configur
    func Configur(with Data: DataClass) {
        VideoButton.isHidden = true
        CallButton.isHidden = true
        MoreButton.isHidden = true
        
        
        ProfileImage.image = Data.ProfileImg
        Username.text = Data.Username
        CurrentStatus.text = Data.CurrentStatus
    }

    // MARK: Initialize Config
    init(data: DataClass) {
        super.init(frame: .zero)
        setupViews()
        setupConstraints()
        Configur(with: data)
    }

    required init?(coder: NSCoder) {
        fatalError("USER_BNNER_CNT has not been implemented")
    }

    // MARK: Setup
    private func setupViews() {
        // Back button
        BackButton.setImage(UIImage(systemName: "arrow.backward"), for: .normal)
        BackButton.tintColor = .secondaryLabel
        BackButton.addTarget(self, action: #selector(backTapped), for: .touchUpInside)

        // Profile image (circle)
        ProfileImage.contentMode = .scaleAspectFill
        ProfileImage.clipsToBounds = true
        ProfileImage.layer.cornerRadius = 22   // half of the 44pt size set below

        // Labels
        Username.font = .systemFont(ofSize: 17, weight: .bold)
        Username.textColor = .label

        CurrentStatus.font = .systemFont(ofSize: 14)
        CurrentStatus.textColor = .secondaryLabel

        // Name + status stacked vertically
        textStack.axis = .vertical
        textStack.spacing = 2
        textStack.addArrangedSubview(Username)
        textStack.addArrangedSubview(CurrentStatus)

        // Right-side action buttons
        VideoButton.setImage(UIImage(systemName: "video"), for: .normal)
        CallButton.setImage(UIImage(systemName: "phone"), for: .normal)
        MoreButton.setImage(UIImage(systemName: "ellipsis"), for: .normal)
        MoreButton.transform = CGAffineTransform(rotationAngle: .pi / 2) // vertical dots

        [VideoButton, CallButton, MoreButton].forEach { $0.tintColor = .label }

        VideoButton.addTarget(self, action: #selector(videoTapped), for: .touchUpInside)
        CallButton.addTarget(self, action: #selector(callTapped), for: .touchUpInside)
        MoreButton.addTarget(self, action: #selector(moreTapped), for: .touchUpInside)

        actionsStack.axis = .horizontal
        actionsStack.spacing = 20
        actionsStack.alignment = .center
        actionsStack.addArrangedSubview(VideoButton)
        actionsStack.addArrangedSubview(CallButton)
        actionsStack.addArrangedSubview(MoreButton)

        [BackButton, ProfileImage, textStack, actionsStack].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            addSubview($0)
        }
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            // Back button (left)
            BackButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            BackButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            BackButton.widthAnchor.constraint(equalToConstant: 28),

            // Avatar
            ProfileImage.leadingAnchor.constraint(equalTo: BackButton.trailingAnchor, constant: 8),
            ProfileImage.centerYAnchor.constraint(equalTo: centerYAnchor),
            ProfileImage.widthAnchor.constraint(equalToConstant: 44),
            ProfileImage.heightAnchor.constraint(equalToConstant: 44),

            // Name + status
            textStack.leadingAnchor.constraint(equalTo: ProfileImage.trailingAnchor, constant: 12),
            textStack.centerYAnchor.constraint(equalTo: centerYAnchor),
            textStack.trailingAnchor.constraint(lessThanOrEqualTo: actionsStack.leadingAnchor, constant: -12),

            // Action buttons (right)
            actionsStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            actionsStack.centerYAnchor.constraint(equalTo: centerYAnchor),

            // Banner height
            heightAnchor.constraint(equalToConstant: 64)
        ])
    }

    // MARK: Actions
    @objc private func backTapped()  { onBackTapped?() }
    @objc private func videoTapped() { onVideoTapped?() }
    @objc private func callTapped()  { onCallTapped?() }
    @objc private func moreTapped()  { onMoreTapped?() }
}

class USER_ACTIVITY_CNT: UIView, UITextViewDelegate {
    
    // MARK: Public callbacks
    var onSendTapped: ((String) -> Void)?

    // MARK: Subviews
    let TextFild =  UITextView()
    let SendButton = UIButton(type: .system)
    let PlaceHolder = UILabel()
    
    
    // MARK: Height Configar
    private var contentHeight: CGFloat = 35
    private var textViewHeightConstraint: NSLayoutConstraint!
    override var intrinsicContentSize: CGSize {
        CGSize(width: UIView.noIntrinsicMetric, height: contentHeight)
    }
    
    

    // MARK: Data Config
    struct DataClass {
        var Username: String
        var ProfileImg: UIImage
        var CurrentStatus: String

        init(Username: String, ProfileImg: UIImage, CurrentStatus: String) {
            self.Username = Username
            self.CurrentStatus = CurrentStatus
            self.ProfileImg = ProfileImg
        }
    }

    // MARK: CNT Configur
    func Configur(with Data: DataClass) {
        // use Data here (e.g. placeholder text from Username)
    }
    


    // MARK: Initialize Config
    init(data: DataClass) {
        super.init(frame: .zero)
        TextFild.delegate = self
        setupViews()
        Configur(with: data)
    }

    required init?(coder: NSCoder) {
        fatalError("USER_ACTIVITY_CNT has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
    }

    // MARK: Setup
    private func setupViews() {
        backgroundColor = APPCOLOR.LayoutToperColor
        layer.cornerRadius = 25
        clipsToBounds = true
        layer.borderColor = APPCOLOR.ContentColor.withAlphaComponent(0.02).cgColor
        layer.borderWidth = 2

        // MARK: TextView
        TextFild.backgroundColor = .clear
        TextFild.textColor = APPCOLOR.ContentColor
        TextFild.tintColor = APPCOLOR.ContentColor
        
        
        TextFild.font = .systemFont(ofSize: 16)
        TextFild.isScrollEnabled = true
        TextFild.textContainerInset = UIEdgeInsets( top: 8, left: 12, bottom: 8, right: 12)

        if(APPCOLOR.Islight){
            TextFild.keyboardAppearance = .light
        }else{
            TextFild.keyboardAppearance = .dark
        }
        
        
        TextFild.returnKeyType = .send
        
        

        
        // MARK: Place Holder

        PlaceHolder.text = "Type a message..."
        PlaceHolder.font = .systemFont(ofSize: 16)
        PlaceHolder.textColor = UIColor(white: 0.55, alpha: 1)
        PlaceHolder.isUserInteractionEnabled = false
        
        
         // MARK: Send Button

        let sendConfig = UIImage.SymbolConfiguration(
            pointSize: 16,
            weight: .semibold
        )

        SendButton.setImage( UIImage( systemName: "paperplane.fill", withConfiguration: sendConfig), for: .normal )

        SendButton.tintColor = UIColor( white: 0.11, alpha: 1)
        SendButton.backgroundColor = .systemGreen

        SendButton.layer.cornerRadius = 20

        SendButton.addTarget( self, action: #selector(sendTapped), for: .touchUpInside)

        // MARK: Add Views

        [TextFild,SendButton,PlaceHolder].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            addSubview($0)
        }
        
        textViewHeightConstraint = TextFild.heightAnchor.constraint(equalToConstant: contentHeight)
        
         // MARK: Constraints
        NSLayoutConstraint.activate([

            // MARK: Send Button

            SendButton.trailingAnchor.constraint( equalTo: trailingAnchor, constant: -12 ),

            SendButton.bottomAnchor.constraint(
                equalTo: bottomAnchor,
                constant: -14
            ),

            SendButton.widthAnchor.constraint(
                equalToConstant: 40
            ),

            SendButton.heightAnchor.constraint(
                equalToConstant: 40
            ),

            // MARK: Text Field

            TextFild.topAnchor.constraint(
                equalTo: topAnchor,
                constant: 15
            ),

            TextFild.leadingAnchor.constraint(
                equalTo: leadingAnchor,
                constant: 12
            ),

            TextFild.trailingAnchor.constraint(
                equalTo: SendButton.leadingAnchor,
                constant: -10
            ),

            TextFild.bottomAnchor.constraint(
                equalTo: bottomAnchor,
                constant: -15
            ),

            textViewHeightConstraint,
            
            // MARK: Place Holder
            // 12 (left inset) + 5 (UITextView's default line padding)
            PlaceHolder.leadingAnchor.constraint(
                equalTo: TextFild.leadingAnchor,
                constant: 17
            ),

            PlaceHolder.topAnchor.constraint(
                equalTo: TextFild.topAnchor,
                constant: 8
            ),

            PlaceHolder.trailingAnchor.constraint(
                lessThanOrEqualTo: TextFild.trailingAnchor,
                constant: -12
            )
        ])
        

    }
    
    internal func textViewDidChange(_ textView: UITextView) {
        PlaceHolder.isHidden = !textView.text.isEmpty
        
        let size = textView.sizeThatFits(
            CGSize(
                width: textView.bounds.width,
                height: .greatestFiniteMagnitude
            )
        )
        
        DidChangeHeight(size.height)
    }
    
    func DidChangeHeight(_ NewHeight:CGFloat){
        if(NewHeight > 120){
            return
        }else{
            textViewHeightConstraint.constant = NewHeight
            contentHeight = NewHeight
            // invalidateIntrinsicContentSize()
        }
    }
    


    @objc private func sendTapped() {
        guard let text = TextFild.text, !text.isEmpty else { return }
        onSendTapped?(text)
        TextFild.text = ""
        PlaceHolder.isHidden = false
    }
}

class USER_CHATBOARD_TEXTFILD_UPCOMING_CNT: CHATBOARD_TEXTFILD_UPCOMING_LYT {

    // MARK: - Subviews
    let UserTextView = UILabel()
    let UserTextTimeView = UILabel()
    let UserTextDispatchStatusView = UIImageView()


    // MARK: - Data

    struct DataClass {

        var UserTextView: String
        var UserTextTimeView: String
        var UserTextDispatchStatus: StatusDispatch

        init( UserTextView: String, UserTextTimeView: String, UserTextDispatchStatus: StatusDispatch ) {
            self.UserTextView = UserTextView
            self.UserTextTimeView = UserTextTimeView
            self.UserTextDispatchStatus = UserTextDispatchStatus
        }
    }


    // MARK: - Initialize

    init(data: DataClass) {

        super.init(frame: .zero)

        setupViews()
        Configur(with: data)
    }


    required init?(coder: NSCoder) {

        fatalError(
            "USER_CHATBOARD_TEXTFILD_UPCOMING_CNT has not been implemented"
        )
    }


    // MARK: - Setup Views

    private func setupViews() {

        UserTextView.translatesAutoresizingMaskIntoConstraints = false
        
        UserTextTimeView.translatesAutoresizingMaskIntoConstraints = false
        
        UserTextDispatchStatusView.translatesAutoresizingMaskIntoConstraints = false
        
        // Message
        UserTextView.font = .systemFont( ofSize: 16, weight: .regular )
        UserTextView.textColor = .white
        UserTextView.numberOfLines = 0

        // Time
        UserTextTimeView.font = .systemFont( ofSize: 11, weight: .regular)
        UserTextTimeView.textColor = .white.withAlphaComponent(0.6)
        
        // Dipatcher Status
        

        
        AddContent(UserTextView: UserTextView,UserTextTimeView: UserTextTimeView,UserTextDispatchStatusView: UserTextDispatchStatusView)
    }


    // MARK: - CNT Configur

    func Configur(with Data: DataClass) {
        UserTextView.text = Data.UserTextView
        UserTextTimeView.text = Data.UserTextTimeView
        
        func TicMark(FirstColor:UIColor , secondColor:UIColor){
            let config = UIImage.SymbolConfiguration(
                pointSize: 13,
                weight: .bold
            )

            UserTextDispatchStatusView.image = UIImage(
                systemName: "checkmark",
                withConfiguration: config
            )

            UserTextDispatchStatusView.tintColor = secondColor
            UserTextDispatchStatusView.contentMode = .scaleAspectFit

            let secondCheckmark = UIImageView(
                image: UIImage(
                    systemName: "checkmark",
                    withConfiguration: config
                )
            )

            secondCheckmark.translatesAutoresizingMaskIntoConstraints = false
            secondCheckmark.tintColor = secondColor
            secondCheckmark.contentMode = .scaleAspectFit

            BaseArea.addSubview(secondCheckmark)

            NSLayoutConstraint.activate([
                secondCheckmark.centerYAnchor.constraint(
                    equalTo: UserTextDispatchStatusView.centerYAnchor
                ),

                secondCheckmark.leadingAnchor.constraint(
                    equalTo: UserTextDispatchStatusView.trailingAnchor,
                    constant: -10
                ),

                secondCheckmark.widthAnchor.constraint(equalToConstant: 15),
                secondCheckmark.heightAnchor.constraint(equalToConstant: 15)
            ])
        }

        if StatusDispatch.delaverd == Data.UserTextDispatchStatus {

            TicMark(FirstColor: .ticmark, secondColor: .ticmark)

        } else if StatusDispatch.panding == Data.UserTextDispatchStatus {

            TicMark(FirstColor: .white.withAlphaComponent(0.5), secondColor: .white.withAlphaComponent(0.5))

        } else if StatusDispatch.notdelaverd == Data.UserTextDispatchStatus {

            let config = UIImage.SymbolConfiguration(
                pointSize: 13,
                weight: .regular
            )

            UserTextDispatchStatusView.image = UIImage(
                systemName: "clock",
                withConfiguration: config
            )
            UserTextDispatchStatusView.tintColor = .white.withAlphaComponent(0.6)
            UserTextDispatchStatusView.contentMode = .scaleAspectFit
        }
    }
    
    
}


class USER_CHATBOARD_TEXTFILD_ONGOING_CNT: CHATBOARD_TEXTFILD_ONGOING_LYT{
    // MARK: Subviews
    let UserTextView = UILabel()
    let UserTextTimeView = UILabel()
    
    // MARK: - Data
    struct DataClass {
        var UserTextView: String
        var UserTextTimeView: String
        init( UserTextView: String, UserTextTimeView: String) {
            self.UserTextView = UserTextView
            self.UserTextTimeView = UserTextTimeView
        }
        
    }
    
    init(data: DataClass) {
        super.init(frame: .zero)
        setupViews()
        Configur(with: data)
        
    }


    required init?(coder: NSCoder) {
        fatalError(
            "USER_CHATBOARD_TEXTFILD_UPCOMING_CNT has not been implemented"
        )
    }
    
    
    
    func setupViews(){
        UserTextView.font = .systemFont( ofSize: 16, weight: .regular )
        UserTextView.textColor = APPCOLOR.ContentColor
        UserTextView.numberOfLines = 0
        
        UserTextTimeView.font = .systemFont( ofSize: 11, weight: .regular)
        
        UserTextTimeView.textColor = APPCOLOR.ContentColor.withAlphaComponent(0.6)
        Addcontents(UserTextView: UserTextView, UserTextTimeView: UserTextTimeView)

    }
    
    func Configur(with Data:DataClass){
        UserTextView.text = Data.UserTextView
        UserTextTimeView.text = Data.UserTextTimeView
    }
}
