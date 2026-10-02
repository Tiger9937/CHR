import UIKit

class CHAT_ROOM_SEARCHBAR_CNT: UIView, UITextFieldDelegate {

    var placeholder = ""
    private let textField = UITextField()
    private let clearButton = UIButton(type: .system)

    var onSubmit: ((String) -> Void)?
    var onClear: (() -> Void)?   // NEW: parent hooks this to clear their own screen data

    init(placeholder: String) {
        self.placeholder = placeholder
        super.init(frame: .zero)
        configure()
        buildTextField()
    }

    required init?(coder: NSCoder) {
        fatalError("CHAT_REQUEST_SEARCHBAR_CNT has not been implemented")
    }

    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        layer.cornerRadius = 18
        clipsToBounds = true
        backgroundColor = APPCOLOR.LayoutColor

        layer.borderWidth = 1
        layer.borderColor = APPCOLOR.LayoutToperBORDERColor.cgColor

        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: 44),
            widthAnchor.constraint(equalToConstant: 260)
        ])
    }

    private func buildTextField() {
        textField.attributedPlaceholder = NSAttributedString(
            string: "\(placeholder)",
            attributes: [
                .foregroundColor: APPCOLOR.SubContentColor.withAlphaComponent(0.6)
            ]
        )
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.returnKeyType = .done
        textField.delegate = self
        textField.adjustsFontSizeToFitWidth = false
        textField.clearsOnBeginEditing = false
        textField.textColor = APPCOLOR.ContentColor
        textField.backgroundColor = APPCOLOR.LayoutColor

        clearButton.setImage(UIImage(systemName: "xmark.circle.fill"), for: .normal)
        clearButton.tintColor = APPCOLOR.ContentColor
        clearButton.frame = CGRect(x: 0, y: 0, width: 22, height: 22)
        clearButton.addTarget(self, action: #selector(clearTapped), for: .touchUpInside)
        textField.rightView = clearButton
        textField.rightViewMode = .whileEditing   // shows only while there's focus/text; use .always to always show

        addSubview(textField)

        NSLayoutConstraint.activate([
            textField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            textField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            textField.topAnchor.constraint(equalTo: topAnchor, constant: 4),
            textField.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -4)
        ])
    }

    // NEW: fires when the X is tapped
    @objc private func clearTapped() {
        textField.text = ""
        textField.resignFirstResponder()
        onClear?()          // tell the parent to wipe its displayed data
        onSubmit?("")       // optional: also treat clearing as submitting an empty string
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        submitText()
        textField.resignFirstResponder()
        return true
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        submitText()
    }

    private func submitText() {
        let finalText = textField.text ?? ""
        onSubmit?(finalText)
    }
}

final class ChatRoomUser: UIView {
    // MARK: Public callbacks
    var Onclick: (() -> Void)?
    var Onhover: (() -> Void)?
    var OnclickImg: (()->Void)?
    
    // Subviews
    private let avatarImageView = UIImageView()
    private let UsenameView = UILabel()
    private let TimingView = UILabel()
    private let RecentSMSView = UILabel()
    private let UnseenSMSIndicaterView = UILabel()
    private let outlineView = UIView()
    private let mutualIcon = UIImageView(image: UIImage(systemName: "person.2.fill"))

    // MARK: Data Config
    struct DataClass {
        var Username: String
        var Time: String
        var ProfileImg: UIImage
        var RecentSMS: String
        var NuberofUnseenSMS: String

        init(Username: String, Time: String, ProfileImg: UIImage, RecentSMS: String, NuberofUnseenSMS: String) {
            self.Username = Username
            self.Time = Time
            self.ProfileImg = ProfileImg
            self.RecentSMS = RecentSMS
            self.NuberofUnseenSMS = NuberofUnseenSMS
        }
    }

    func Configur(with Data: DataClass) {
        translatesAutoresizingMaskIntoConstraints = false
        avatarImageView.image = Data.ProfileImg
        UsenameView.text = Data.Username
        TimingView.text = Data.Time
        RecentSMSView.text = Data.RecentSMS
        
        if (Data.NuberofUnseenSMS == "0"){
            UnseenSMSIndicaterView.isHidden = true
            outlineView.isHidden = true
        }else{
            UnseenSMSIndicaterView.text = Data.NuberofUnseenSMS
        }
        
    }

    // MARK: Init
    init(data: DataClass, Onclick: (() -> Void)? = nil, Onhover: (() -> Void)? = nil ,
         OnclickImg: (()-> Void)? = nil
    ) {
        self.Onclick = Onclick
        self.Onhover = Onhover
        self.OnclickImg = OnclickImg
        super.init(frame: .zero)
        setupViews()
        Configur(with: data)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    
    
    private func setupViews() {
        translatesAutoresizingMaskIntoConstraints = false
        // Avatar: circular, left side
        avatarImageView.translatesAutoresizingMaskIntoConstraints = false
        avatarImageView.contentMode = .scaleAspectFill
        avatarImageView.isUserInteractionEnabled = true
        avatarImageView.clipsToBounds = true
        avatarImageView.layer.cornerRadius = 22
        addSubview(avatarImageView)

        // Username: bold, top-left
        UsenameView.translatesAutoresizingMaskIntoConstraints = false
        UsenameView.font = .systemFont(ofSize: 15, weight: .semibold)
        UsenameView.textColor = APPCOLOR.ContentColor
        addSubview(UsenameView)

        // Timing: top-right, small + muted
        TimingView.translatesAutoresizingMaskIntoConstraints = false
        TimingView.font = .systemFont(ofSize: 12, weight: .regular)
        TimingView.textColor = APPCOLOR.SubContentColor.withAlphaComponent(0.6)
        TimingView.textAlignment = .right
        addSubview(TimingView)

        // Recent message preview: below username, muted, truncates
        RecentSMSView.translatesAutoresizingMaskIntoConstraints = false
        RecentSMSView.font = .systemFont(ofSize: 13, weight: .regular)
        RecentSMSView.textColor = APPCOLOR.SubContentColor.withAlphaComponent(0.75)
        RecentSMSView.lineBreakMode = .byTruncatingTail
        RecentSMSView.numberOfLines = 1
        addSubview(RecentSMSView)

        // Unseen indicator: small blue dot at the end of the message line
        
        outlineView.translatesAutoresizingMaskIntoConstraints = false
        outlineView.backgroundColor = .clear
        outlineView.layer.borderWidth = 5
        outlineView.layer.borderColor = UIColor.systemBlue.withAlphaComponent(0.9).cgColor
        outlineView.layer.cornerRadius = 10   // slightly bigger radius than the badge
        addSubview(outlineView)

        UnseenSMSIndicaterView.translatesAutoresizingMaskIntoConstraints = false
        UnseenSMSIndicaterView.font = .systemFont(ofSize: 11, weight: .bold)
        UnseenSMSIndicaterView.textColor = .white
        UnseenSMSIndicaterView.textAlignment = .center
        UnseenSMSIndicaterView.backgroundColor = .systemBlue.withAlphaComponent(0.9)
        UnseenSMSIndicaterView.layer.cornerRadius = 8
        UnseenSMSIndicaterView.clipsToBounds = true
        addSubview(UnseenSMSIndicaterView)

        NSLayoutConstraint.activate([
            // outlineView sized a few points bigger than the badge, centered on it
            outlineView.widthAnchor.constraint(equalTo: UnseenSMSIndicaterView.widthAnchor, constant: 4),
            outlineView.heightAnchor.constraint(equalTo: UnseenSMSIndicaterView.heightAnchor, constant: 4),
            outlineView.centerXAnchor.constraint(equalTo: UnseenSMSIndicaterView.centerXAnchor),
            outlineView.centerYAnchor.constraint(equalTo: UnseenSMSIndicaterView.centerYAnchor)
        ])

        NSLayoutConstraint.activate([
            avatarImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            avatarImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            avatarImageView.widthAnchor.constraint(equalToConstant: 44),
            avatarImageView.heightAnchor.constraint(equalToConstant: 44),

            UsenameView.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 12),
            UsenameView.topAnchor.constraint(equalTo: avatarImageView.topAnchor, constant: 2),

            TimingView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12),
            TimingView.centerYAnchor.constraint(equalTo: UsenameView.centerYAnchor),
            TimingView.leadingAnchor.constraint(greaterThanOrEqualTo: UsenameView.trailingAnchor, constant: 8),
            TimingView.widthAnchor.constraint(greaterThanOrEqualToConstant: 40),

            RecentSMSView.leadingAnchor.constraint(equalTo: UsenameView.leadingAnchor),
            RecentSMSView.topAnchor.constraint(equalTo: UsenameView.bottomAnchor, constant: 4),
            RecentSMSView.trailingAnchor.constraint(equalTo: UnseenSMSIndicaterView.leadingAnchor, constant: -8),

            UnseenSMSIndicaterView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12),
            UnseenSMSIndicaterView.centerYAnchor.constraint(equalTo: RecentSMSView.centerYAnchor),
            UnseenSMSIndicaterView.widthAnchor.constraint(equalToConstant: 16),
            UnseenSMSIndicaterView.heightAnchor.constraint(equalToConstant: 16)
        ])
        
        
        

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(OnclickIMG))
        avatarImageView.addGestureRecognizer(tapGesture)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(Viewclick))
        addGestureRecognizer(tap)
        
        let hover = UIHoverGestureRecognizer(target: self, action: #selector(Viewhover))
        addGestureRecognizer(hover)
    }
    
    
    @objc private  func OnclickIMG(){
        OnclickImg?()
    }

    @objc private func Viewclick() {
        Onclick?()
    }

    @objc private func Viewhover() {
        Onhover?()
    }
}

final class ChatRoomUserProfileImgMID_VIEW:UIImageView {

    func Mid_imgviewPass(FullImg:UIImage) -> UIImageView{
        translatesAutoresizingMaskIntoConstraints = false

        image = FullImg
        translatesAutoresizingMaskIntoConstraints = false
        contentMode = .scaleAspectFill
        isUserInteractionEnabled = true
        clipsToBounds = true
        layer.cornerRadius = 15
        return self
    }
}

