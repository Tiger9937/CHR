import UIKit

// FRIEND_REQ_RISIVED

// MARK: - FriendRequestCardView


final class FRIEND_REQ_RISIVED: UIView {

    // MARK: Public callbacks

    var onAccept: (() -> Void)?
    var onDeny: (() -> Void)?

    // MARK: views

    let mainView = UIView()

    private let avatarImageView = UIImageView()
    private let statusDot = UIView()
    private let nameLabel = UILabel()
    private let verifiedBadge = UIImageView(
        image: UIImage(systemName: "checkmark.circle.fill")
    )
    private let timeLabel = UILabel()

    private let denyButton = UIButton(type: .system)
    private let friendButton = UIButton(type: .system)

    // MARK: Data Config

    struct DataClass {

        let avatarImage: UIImage?
        let name: String
        let isVerified: Bool
        let timeAgo: String
        let statusColor: Bool
    }

    // MARK: Init

    init(
        data: DataClass,
        onAccept: (() -> Void)? = nil,
        onDeny: (() -> Void)? = nil
    ) {

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

    // MARK: Configure

    func configure(with data: DataClass) {
        avatarImageView.image = data.avatarImage
        nameLabel.text = data.name

        verifiedBadge.isHidden = !data.isVerified

        timeLabel.text = data.timeAgo

        statusDot.isHidden = !data.statusColor
        statusDot.backgroundColor = data.statusColor ? .systemMint : .clear
    }

    // MARK: Setup

    private func setupViews() {

        translatesAutoresizingMaskIntoConstraints = false
        mainView.translatesAutoresizingMaskIntoConstraints = false

        addSubview(mainView)

        NSLayoutConstraint.activate([
            mainView.topAnchor.constraint(equalTo: topAnchor),
            mainView.leadingAnchor.constraint(equalTo: leadingAnchor),
            mainView.trailingAnchor.constraint(equalTo: trailingAnchor),
            mainView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])

        // MARK: Avatar

        avatarImageView.contentMode = .scaleAspectFill
        avatarImageView.clipsToBounds = true
        avatarImageView.layer.cornerRadius = 22
        avatarImageView.backgroundColor = .systemGray5
        avatarImageView.translatesAutoresizingMaskIntoConstraints = false

        statusDot.layer.cornerRadius = 6
        statusDot.layer.borderWidth = 2
        statusDot.layer.borderColor = UIColor.white.cgColor
        statusDot.translatesAutoresizingMaskIntoConstraints = false

        mainView.addSubview(avatarImageView)
        mainView.addSubview(statusDot)

        NSLayoutConstraint.activate([

            avatarImageView.leadingAnchor.constraint(
                equalTo: mainView.leadingAnchor
            ),

            avatarImageView.centerYAnchor.constraint(
                equalTo: mainView.centerYAnchor
            ),

            avatarImageView.widthAnchor.constraint(
                equalToConstant: 44
            ),

            avatarImageView.heightAnchor.constraint(
                equalToConstant: 44
            ),

            statusDot.widthAnchor.constraint(
                equalToConstant: 12
            ),

            statusDot.heightAnchor.constraint(
                equalToConstant: 12
            ),

            statusDot.trailingAnchor.constraint(
                equalTo: avatarImageView.trailingAnchor,
                constant: 1
            ),

            statusDot.bottomAnchor.constraint(
                equalTo: avatarImageView.bottomAnchor,
                constant: 1
            )
        ])

        // MARK: Name

        nameLabel.font = .systemFont(
            ofSize: 15,
            weight: .semibold
        )

        nameLabel.textColor = APPCOLOR.ContentColor
        nameLabel.translatesAutoresizingMaskIntoConstraints = false

        verifiedBadge.tintColor = .systemBlue
        verifiedBadge.contentMode = .scaleAspectFit
        verifiedBadge.translatesAutoresizingMaskIntoConstraints = false

        timeLabel.font = .systemFont(
            ofSize: 13,
            weight: .regular
        )

        timeLabel.textColor =
            APPCOLOR.SubContentColor.withAlphaComponent(0.6)

        timeLabel.translatesAutoresizingMaskIntoConstraints = false

        mainView.addSubview(nameLabel)
        mainView.addSubview(verifiedBadge)
        mainView.addSubview(timeLabel)

        NSLayoutConstraint.activate([

            nameLabel.leadingAnchor.constraint(
                equalTo: avatarImageView.trailingAnchor,
                constant: 10
            ),

            nameLabel.topAnchor.constraint(
                equalTo: avatarImageView.topAnchor,
                constant: 5
            ),
            

            verifiedBadge.leadingAnchor.constraint(
                equalTo: nameLabel.trailingAnchor,
                constant: 4
            ),

            verifiedBadge.centerYAnchor.constraint(
                equalTo: nameLabel.centerYAnchor
            ),

            verifiedBadge.widthAnchor.constraint(
                equalToConstant: 14
            ),

            verifiedBadge.heightAnchor.constraint(
                equalToConstant: 14
            ),

            timeLabel.leadingAnchor.constraint(
                equalTo: nameLabel.leadingAnchor
            ),

            timeLabel.topAnchor.constraint(
                equalTo: nameLabel.bottomAnchor,
                constant: 4
            ),

            timeLabel.trailingAnchor.constraint(
                lessThanOrEqualTo: mainView.trailingAnchor,
                constant: -8
            )
        ])

        // MARK: Deny Button

        denyButton.setTitle("Deny", for: .normal)
        denyButton.setTitleColor(
            APPCOLOR.ContentColor,
            for: .normal
        )

        denyButton.titleLabel?.font = .systemFont(
            ofSize: 14,
            weight: .semibold
        )

        denyButton.backgroundColor = APPCOLOR.LayoutToperColor
        denyButton.layer.cornerRadius = 16
        denyButton.translatesAutoresizingMaskIntoConstraints = false

        denyButton.addTarget(
            self,
            action: #selector(denyTapped),
            for: .touchUpInside
        )

        // MARK: Friend Button

        friendButton.setTitle("Friend", for: .normal)

        friendButton.setTitleColor(
            .white,
            for: .normal
        )

        friendButton.titleLabel?.font = .systemFont(
            ofSize: 14,
            weight: .semibold
        )

        friendButton.backgroundColor = .systemBlue
        friendButton.layer.cornerRadius = 16
        friendButton.translatesAutoresizingMaskIntoConstraints = false

        friendButton.addTarget(
            self,
            action: #selector(friendTapped),
            for: .touchUpInside
        )

        mainView.addSubview(denyButton)
        mainView.addSubview(friendButton)

        NSLayoutConstraint.activate([

            friendButton.trailingAnchor.constraint(
                equalTo: mainView.trailingAnchor
            ),

            friendButton.centerYAnchor.constraint(
                equalTo: mainView.centerYAnchor
            ),

            friendButton.heightAnchor.constraint(
                equalToConstant: 32
            ),

            friendButton.widthAnchor.constraint(
                equalToConstant: 72
            ),

            denyButton.trailingAnchor.constraint(
                equalTo: friendButton.leadingAnchor,
                constant: -8
            ),

            denyButton.centerYAnchor.constraint(
                equalTo: mainView.centerYAnchor
            ),

            denyButton.heightAnchor.constraint(
                equalToConstant: 32
            ),

            denyButton.widthAnchor.constraint(
                equalToConstant: 64
            ),

            nameLabel.trailingAnchor.constraint(
                lessThanOrEqualTo: denyButton.leadingAnchor,
                constant: -50
            )
        ])
    }

    // MARK: Actions

    @objc private func denyTapped() {
        onDeny?()
    }

    @objc private func friendTapped() {
        onAccept?()
    }
}

final class FRIEND_REQ_SENDED: UIView {

    // MARK: - Public callbacks

    var AddFriend: (() -> Void)?

    // MARK: - Views

    let mainView = UIView()

    private let avatarImageView = UIImageView()

    private let statusDot = UIView()

    private let nameLabel = UILabel()

    private let verifiedBadge = UIImageView(
        image: UIImage(systemName: "checkmark.circle.fill")
    )

    private let timeLabel = UILabel()

    private let statusLabel = UIButton(type: .system)

    // MARK: - Data Config

    struct DataClass {

        let username: String
        let avatarImageView: UIImage
        let statusDot: Bool
        let verifiedBadge: Bool
        let time: String
        let currentRequestStatus: StatusCODE
    }

    // MARK: - Init

    init(
        data: DataClass,
        AddFriend: (() -> Void)? = nil
    ) {

        self.AddFriend = AddFriend

        super.init(frame: .zero)

        setupViews()
        configure(with: data)
    }

    required init?(coder: NSCoder) {

        super.init(coder: coder)

        setupViews()
    }

    // MARK: - Configure

    private func configure(with data: DataClass) {

        avatarImageView.image = data.avatarImageView

        nameLabel.text = data.username
        
        verifiedBadge.isHidden = !data.verifiedBadge

        statusDot.isHidden = !data.statusDot

        if data.statusDot {
            statusDot.backgroundColor = .systemMint
        }
        switch data.currentRequestStatus {
          case .pending:
            statusLabel.isEnabled = false
            statusLabel.contentHorizontalAlignment = .trailing
            statusLabel.setTitle("\(data.currentRequestStatus)", for: .normal)
            statusLabel.setTitleColor(.systemOrange, for: .normal)
            statusLabel.backgroundColor = .clear
            timeLabel.text = "\(data.time)"
            
          case .accepted:
            statusLabel.isEnabled = false
            statusLabel.contentHorizontalAlignment = .trailing
            statusLabel.setTitle("\(data.currentRequestStatus)", for: .normal)
            statusLabel.setTitleColor(APPCOLOR.SubContentColor, for: .normal)
            statusLabel.backgroundColor = .clear
            timeLabel.text = "\(data.time)"
            
          case .denied:
            statusLabel.isEnabled = true
            statusLabel.setTitle("Add friend", for: .normal)
            statusLabel.setTitleColor(.white, for: .normal)
            statusLabel.backgroundColor = .systemBlue.withAlphaComponent(0.9)
            timeLabel.text = "Not accept"
        }
    }

    // MARK: - Setup
    
    private func setupViews() {
        // MARK: Main View
        translatesAutoresizingMaskIntoConstraints = false

        mainView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(mainView)

        NSLayoutConstraint.activate([
            mainView.topAnchor.constraint(equalTo: topAnchor),
            mainView.leadingAnchor.constraint(equalTo: leadingAnchor),
            mainView.trailingAnchor.constraint(equalTo: trailingAnchor),
            mainView.bottomAnchor.constraint(equalTo: bottomAnchor)

        ])

        // MARK: Avatar

        avatarImageView.translatesAutoresizingMaskIntoConstraints = false

        avatarImageView.contentMode = .scaleAspectFill
        avatarImageView.clipsToBounds = true
        avatarImageView.layer.cornerRadius = 22
        avatarImageView.backgroundColor = .systemGray5

        mainView.addSubview(avatarImageView)

        // MARK: Status Dot

        statusDot.translatesAutoresizingMaskIntoConstraints = false

        statusDot.layer.cornerRadius = 6
        statusDot.layer.borderWidth = 2
        statusDot.layer.borderColor = UIColor.white.cgColor

        mainView.addSubview(statusDot)

        NSLayoutConstraint.activate([

            avatarImageView.leadingAnchor.constraint(equalTo: mainView.leadingAnchor),
            avatarImageView.centerYAnchor.constraint(equalTo: mainView.centerYAnchor),
            avatarImageView.widthAnchor.constraint(equalToConstant: 44),
            avatarImageView.heightAnchor.constraint(equalToConstant: 44),

            statusDot.widthAnchor.constraint(equalToConstant: 12),
            statusDot.heightAnchor.constraint(equalToConstant: 12),
            statusDot.trailingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 1),
            statusDot.bottomAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: 1)
        ])

        // MARK: Name

        nameLabel.translatesAutoresizingMaskIntoConstraints = false

        nameLabel.font = .systemFont(ofSize: 15, weight: .semibold)
        nameLabel.textColor = APPCOLOR.ContentColor

        mainView.addSubview(nameLabel)

        // MARK: Verified Badge

        verifiedBadge.translatesAutoresizingMaskIntoConstraints = false

        verifiedBadge.tintColor = .systemBlue
        verifiedBadge.contentMode = .scaleAspectFit

        mainView.addSubview(verifiedBadge)

        // MARK: Time

        timeLabel.translatesAutoresizingMaskIntoConstraints = false

        timeLabel.font = .systemFont(ofSize: 13, weight: .regular)
        timeLabel.textColor = APPCOLOR.SubContentColor.withAlphaComponent(0.6)

        mainView.addSubview(timeLabel)

        // MARK: Status Label (right side "add Friend" button)

        statusLabel.translatesAutoresizingMaskIntoConstraints = false
        statusLabel.setTitleColor(.secondaryLabel, for: .normal)
        statusLabel.titleLabel?.font = .systemFont(ofSize: 14, weight: .semibold)
        statusLabel.titleLabel?.textAlignment = .center
        statusLabel.layer.cornerRadius  = 15
        
        statusLabel.addTarget(
            self,
            action: #selector(addFriendTapped),
            for: .touchUpInside
        )

        mainView.addSubview(statusLabel)

        // MARK: Constraints

        NSLayoutConstraint.activate([

            // ------------------------------------------------
            // STATUS LABEL (right side)
            // ------------------------------------------------

            statusLabel.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: -10),
            statusLabel.centerYAnchor.constraint(equalTo: mainView.centerYAnchor),
            statusLabel.widthAnchor.constraint(equalToConstant: 100),
            

            // ------------------------------------------------
            // NAME
            // ------------------------------------------------

            nameLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 10),
            nameLabel.topAnchor.constraint(equalTo: avatarImageView.topAnchor, constant: 5),
            nameLabel.trailingAnchor.constraint(lessThanOrEqualTo: statusLabel.leadingAnchor, constant: -15),
            
            // ------------------------------------------------
            // VERIFIED BADGE
            // ------------------------------------------------

            verifiedBadge.leadingAnchor.constraint(equalTo: nameLabel.trailingAnchor, constant: 4),
            verifiedBadge.centerYAnchor.constraint(equalTo: nameLabel.centerYAnchor),
            verifiedBadge.widthAnchor.constraint(equalToConstant: 14),
            verifiedBadge.heightAnchor.constraint(equalToConstant: 14),

            // ------------------------------------------------
            // TIME (directly under name)
            // ------------------------------------------------

            timeLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            timeLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 5),
            timeLabel.trailingAnchor.constraint(lessThanOrEqualTo: statusLabel.leadingAnchor, constant: -12),
            
            nameLabel.trailingAnchor.constraint(
                lessThanOrEqualTo: statusLabel.leadingAnchor,
                constant: -40
            )
        ])
    }

    // MARK: - Action

    @objc func addFriendTapped() {
        AddFriend?()
    }
}


final class FRIEND_REQ_SAGMENT_INDICATER: UIView {

    enum Segment {
        case received
        case sended
    }

    let Received = UIButton(type: .system)
    let Sended = UIButton(type: .system)
    let underline = UIView()
    let Clearall = UIButton(type: .system)

    // MARK: - Callbacks
    var onRisive: (() -> Void)?
    var onSender: (() -> Void)?
    var onClearAllTapped: (() -> Void)?

    // NEW: fires every time the active segment changes, from ANY source
    // (tap, or a parent calling trigger()).
    var onStatusChanged: ((Segment) -> Void)?

    // NEW: the single source of truth for "what's showing right now".
    // didSet fires onStatusChanged automatically, so you never have to
    // remember to notify manually from each place the segment changes.
    private(set) var currentSegment: Segment = .received {
        didSet {
            guard oldValue != currentSegment || true else { return }
            onStatusChanged?(currentSegment)
        }
    }

    private var underlineLeading: NSLayoutConstraint!
    private var underlineWidth: NSLayoutConstraint!

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
        Setup()
        ResiveATC() // default state
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Configure
    private func configure() {
        Received.setTitle("Received (2)", for: .normal)
        Sended.setTitle("Send", for: .normal)
        Clearall.setTitle("Clear all", for: .normal)
    }

    // MARK: - Setup
    private func Setup() {
        Received.translatesAutoresizingMaskIntoConstraints = false
        Received.setTitleColor(APPCOLOR.ContentColor, for: .normal)
        Received.titleLabel?.font = .systemFont(ofSize: 17, weight: .semibold)
        addSubview(Received)

        Sended.translatesAutoresizingMaskIntoConstraints = false
        Sended.setTitleColor(APPCOLOR.SubContentColor, for: .normal)
        Sended.titleLabel?.font = .systemFont(ofSize: 17, weight: .regular)
        addSubview(Sended)

        underline.translatesAutoresizingMaskIntoConstraints = false
        underline.backgroundColor = .systemBlue
        addSubview(underline)

        Clearall.translatesAutoresizingMaskIntoConstraints = false
        Clearall.setTitleColor(.systemBlue, for: .normal)
        Clearall.titleLabel?.font = .systemFont(ofSize: 15, weight: .regular)
        addSubview(Clearall)

        NSLayoutConstraint.activate([
            Received.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            Received.topAnchor.constraint(equalTo: topAnchor, constant: 5),

            Sended.leadingAnchor.constraint(equalTo: Received.trailingAnchor, constant: 20),
            Sended.centerYAnchor.constraint(equalTo: Received.centerYAnchor),

            Clearall.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            Clearall.centerYAnchor.constraint(equalTo: Received.centerYAnchor),

            underline.topAnchor.constraint(equalTo: Received.bottomAnchor, constant: 4),
            underline.heightAnchor.constraint(equalToConstant: 2),
            underline.bottomAnchor.constraint(lessThanOrEqualTo: bottomAnchor),
        ])

        underlineLeading = underline.leadingAnchor.constraint(equalTo: Received.leadingAnchor)
        underlineWidth = underline.widthAnchor.constraint(equalTo: Received.widthAnchor)
        underlineLeading.isActive = true
        underlineWidth.isActive = true

        Received.addAction(UIAction { [weak self] _ in
            self?.ResiveATC()
            self?.onRisive?()
        }, for: .touchUpInside)

        Sended.addAction(UIAction { [weak self] _ in
            self?.SenedATC()
            self?.onSender?()
        }, for: .touchUpInside)

        Clearall.addAction(UIAction { [weak self] _ in
            self?.onClearAllTapped?()
        }, for: .touchUpInside)
    }

    // MARK: - Move underline
    private func moveUnderline(to target: UIButton) {
        underlineLeading.isActive = false
        underlineWidth.isActive = false

        underlineLeading = underline.leadingAnchor.constraint(equalTo: target.leadingAnchor)
        underlineWidth = underline.widthAnchor.constraint(equalTo: target.widthAnchor)

        underlineLeading.isActive = true
        underlineWidth.isActive = true

        UIView.animate(withDuration: 0.25) {
            self.layoutIfNeeded()
        }
    }

    // MARK: - Trigger (switch-case dispatcher)
    func trigger(_ segment: Segment) {
        switch segment {
        case .received:
            ResiveATC()
        case .sended:
            SenedATC()
        }
    }

    // NEW: call this any time you want the live status on demand,
    // e.g. inside another function, a timer, or before doing work
    // that depends on which tab is active.
    func getPageStatus() -> Segment {
        return currentSegment
    }

    // MARK: - Received Action (UI only)
    private func ResiveATC() {
        Received.setTitleColor(APPCOLOR.ContentColor, for: .normal)
        Received.titleLabel?.font = .systemFont(ofSize: 17, weight: .semibold)
        Sended.setTitleColor(APPCOLOR.SubContentColor, for: .normal)
        Sended.titleLabel?.font = .systemFont(ofSize: 17, weight: .regular)

        moveUnderline(to: Received)
        currentSegment = .received   // NEW: updates status + fires onStatusChanged
    }

    // MARK: - Sended Action (UI only)
    private func SenedATC() {
        Sended.setTitleColor(APPCOLOR.ContentColor, for: .normal)
        Sended.titleLabel?.font = .systemFont(ofSize: 17, weight: .semibold)

        Received.setTitleColor(APPCOLOR.SubContentColor, for: .normal)
        Received.titleLabel?.font = .systemFont(ofSize: 17, weight: .regular)

        moveUnderline(to: Sended)
        currentSegment = .sended     // NEW
    }
}
