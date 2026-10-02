
import UIKit

class CHAT_REQUEST_SEARCHBAR_CNT: UIView, UITextFieldDelegate {

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


final class CHAT_REQUEST_INVITE_CNT: UIView {

    // MARK: Public callbacks
    var onAccept: (() -> Void)?
    var onDeny: (() -> Void)?

    // MARK: Subviews
    private let avatarImageView = UIImageView()
    private let statusDot = UIView()
    private let nameLabel = UILabel()
    private let timeLabel = UILabel()
    private let statusLabel = UILabel()
    private let mutualIcon = UIImageView(image: UIImage(systemName: "person.2.fill"))
    private let mutualLabel = UILabel()
    private let denyButton = UIButton(type: .system)
    private let acceptButton = UIButton(type: .system)

    // MARK: Data model

    struct Data {
        let avatarImage: UIImage?
        let name: String
        let timeAgo: String
        let distanceText: String
        let mutualFriendsCount: Int
        let statusColor: UIColor // e.g. .systemGreen for online, .systemGray3 for offline

        init(
            avatarImage: UIImage? = UIImage(named: "profile_placeholder"),
            name: String,
            timeAgo: String,
            distanceText: String,
            mutualFriendsCount: Int,
            statusColor: UIColor = .systemGray3
        ) {
            self.avatarImage = avatarImage
            self.name = name
            self.timeAgo = timeAgo
            self.distanceText = distanceText
            self.mutualFriendsCount = mutualFriendsCount
            self.statusColor = statusColor
        }
    }

    // MARK: Init

    /// - Parameters:
    ///   - data: the content to display on the card
    ///   - onAccept: called when the Accept button is tapped
    ///   - onDeny: called when the Deny button is tapped
    init(data: Data, onAccept: (() -> Void)? = nil, onDeny: (() -> Void)? = nil) {
        self.onAccept = onAccept
        self.onDeny = onDeny
        super.init(frame: .zero)
        setupViews()
        configure(with: data)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
    }


    func configure(with data: Data) {
        avatarImageView.image = data.avatarImage
        statusDot.backgroundColor = data.statusColor
        nameLabel.text = data.name
        timeLabel.text = data.timeAgo
        statusLabel.text = data.distanceText
        mutualLabel.text = "\(data.mutualFriendsCount) mutual friends"
    }

    // MARK: Setup

    private func setupViews() {
        translatesAutoresizingMaskIntoConstraints = false
        heightAnchor.constraint(equalToConstant: 114).isActive = true

        // Avatar
        avatarImageView.contentMode = .scaleAspectFill
        avatarImageView.clipsToBounds = true
        avatarImageView.layer.cornerRadius = 24
        avatarImageView.backgroundColor = .systemGray5
        avatarImageView.translatesAutoresizingMaskIntoConstraints = false

        statusDot.layer.cornerRadius = 6
        statusDot.layer.borderWidth = 2
        statusDot.layer.borderColor = UIColor.white.cgColor
        statusDot.translatesAutoresizingMaskIntoConstraints = false

        addSubview(avatarImageView)
        addSubview(statusDot)

        NSLayoutConstraint.activate([
            avatarImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            avatarImageView.topAnchor.constraint(equalTo: topAnchor),
            avatarImageView.widthAnchor.constraint(equalToConstant: 48),
            avatarImageView.heightAnchor.constraint(equalToConstant: 48),

            statusDot.widthAnchor.constraint(equalToConstant: 12),
            statusDot.heightAnchor.constraint(equalToConstant: 12),
            statusDot.trailingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 1),
            statusDot.bottomAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: 1),
        ])

        // Name + timestamp
        nameLabel.font = .systemFont(ofSize: 16, weight: .semibold)
        nameLabel.textColor = APPCOLOR.ContentColor
        nameLabel.translatesAutoresizingMaskIntoConstraints = false

        timeLabel.font = .systemFont(ofSize: 13, weight: .regular)
        timeLabel.textColor = APPCOLOR.SubContentColor.withAlphaComponent(0.6)
        timeLabel.textAlignment = .right
        timeLabel.translatesAutoresizingMaskIntoConstraints = false

        addSubview(nameLabel)
        addSubview(timeLabel)

        // Distance / status line
        statusLabel.font = .systemFont(ofSize: 13, weight: .regular)
        statusLabel.textColor = APPCOLOR.SubContentColor.withAlphaComponent(0.6)
        statusLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(statusLabel)

        // Mutual friends line
        mutualIcon.tintColor = APPCOLOR.SubContentColor.withAlphaComponent(0.3)
        mutualIcon.contentMode = .scaleAspectFit
        mutualIcon.translatesAutoresizingMaskIntoConstraints = false

        mutualLabel.font = .systemFont(ofSize: 13, weight: .regular)
        mutualLabel.textColor = APPCOLOR.SubContentColor.withAlphaComponent(0.6)
        mutualLabel.translatesAutoresizingMaskIntoConstraints = false

        addSubview(mutualIcon)
        addSubview(mutualLabel)

        NSLayoutConstraint.activate([
            nameLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 12),
            nameLabel.topAnchor.constraint(equalTo: avatarImageView.topAnchor, constant: -2),

            timeLabel.leadingAnchor.constraint(greaterThanOrEqualTo: nameLabel.trailingAnchor, constant: 8),
            timeLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            timeLabel.firstBaselineAnchor.constraint(equalTo: nameLabel.firstBaselineAnchor),

            statusLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            statusLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 4),
            statusLabel.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor, constant: -16),

            mutualIcon.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            mutualIcon.topAnchor.constraint(equalTo: statusLabel.bottomAnchor, constant: 4),
            mutualIcon.widthAnchor.constraint(equalToConstant: 14),
            mutualIcon.heightAnchor.constraint(equalToConstant: 14),

            mutualLabel.leadingAnchor.constraint(equalTo: mutualIcon.trailingAnchor, constant: 6),
            mutualLabel.centerYAnchor.constraint(equalTo: mutualIcon.centerYAnchor),
        ])

        // Deny / Accept buttons
        denyButton.setTitle("Deny", for: .normal)
        denyButton.setTitleColor(APPCOLOR.ContentColor, for: .normal)
        denyButton.titleLabel?.font = .systemFont(ofSize: 15, weight: .semibold)
        denyButton.backgroundColor = APPCOLOR.LayoutToperColor
        denyButton.layer.cornerRadius = 20
        denyButton.translatesAutoresizingMaskIntoConstraints = false
        denyButton.addTarget(self, action: #selector(denyTapped), for: .touchUpInside)

        acceptButton.setTitle("Accept", for: .normal)
        acceptButton.setTitleColor(.white, for: .normal)
        acceptButton.titleLabel?.font = .systemFont(ofSize: 15, weight: .semibold)
        acceptButton.backgroundColor = .systemBlue
        acceptButton.layer.cornerRadius = 20
        acceptButton.translatesAutoresizingMaskIntoConstraints = false
        acceptButton.addTarget(self, action: #selector(acceptTapped), for: .touchUpInside)

        addSubview(denyButton)
        addSubview(acceptButton)

        NSLayoutConstraint.activate([
            denyButton.leadingAnchor.constraint(equalTo: leadingAnchor),
            denyButton.bottomAnchor.constraint(equalTo: bottomAnchor),
            denyButton.heightAnchor.constraint(equalToConstant: 40),

            acceptButton.trailingAnchor.constraint(equalTo: trailingAnchor),
            acceptButton.bottomAnchor.constraint(equalTo: bottomAnchor),
            acceptButton.heightAnchor.constraint(equalToConstant: 40),
            acceptButton.leadingAnchor.constraint(equalTo: denyButton.trailingAnchor, constant: 10),
            acceptButton.widthAnchor.constraint(equalTo: denyButton.widthAnchor),
        ])
    }

    // MARK: Actions

    @objc private func denyTapped() {
            onDeny?()
    }

    @objc private func acceptTapped() {
            onAccept?()
    }
    
    
}
