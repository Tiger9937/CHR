import UIKit


class SINGIN_TITLE_CNT: UIView {

    // MARK: Subviews

    let Title = UILabel()

    // MARK: Initialize

    init(title: String) {
        super.init(frame: .zero)
        Configur(title: title)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Configuration

    private func Configur(title: String) {

        translatesAutoresizingMaskIntoConstraints = false
        APPCOLOR.CurrentThem()

        Title.translatesAutoresizingMaskIntoConstraints = false

        let AttributedTitle = NSMutableAttributedString(string: title)

        AttributedTitle.addAttribute(
            .foregroundColor,
            value: APPCOLOR.ContentColor,
            range: NSRange(location: 0, length: (title as NSString).length)
        )

        let InRange = (title as NSString).range(of: "up")

        if InRange.location != NSNotFound {
            AttributedTitle.addAttribute(
                .foregroundColor,
                value: UIColor.treeGreen,
                range: InRange
            )
        }

        Title.attributedText = AttributedTitle
        Title.textAlignment = .center
        Title.font = UIFont.boldSystemFont(ofSize: 30)

        addSubview(Title)

        NSLayoutConstraint.activate([
            Title.centerXAnchor.constraint(equalTo: centerXAnchor),
            Title.centerYAnchor.constraint(equalTo: centerYAnchor),
            Title.leadingAnchor.constraint(greaterThanOrEqualTo: leadingAnchor, constant: 10),
            Title.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor, constant: -10)
        ])
    }
}



class SINGIN_CNT: UIView {

    // MARK: - Subviews

    let UsernameInput = UITextField()
    let EmailInput = UITextField()
    let PasswordInput = UITextField()
    let ForgotpasswordINFO = UITextField()

    let SignUpButton = UIButton(type: .system)
    let ForgGotButton = UIButton(type: .system)

    // MARK: - Initialize

    override init(frame: CGRect) {
        super.init(frame: frame)
        Configur()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Configuration
    private func Configur() {

        translatesAutoresizingMaskIntoConstraints = false
        // Username
        styleInput(UsernameInput, placeholder: "Enter your username")
        UsernameInput.autocapitalizationType = .none
        UsernameInput.autocorrectionType = .no

        // Email
        styleInput(EmailInput, placeholder: "Enter your email")
        EmailInput.keyboardType = .emailAddress
        EmailInput.autocapitalizationType = .none
        EmailInput.autocorrectionType = .no

        // Password
        styleInput(PasswordInput, placeholder: "Enter your password")
        PasswordInput.isSecureTextEntry = true

        // Forgot Password
        ForgGotButton.translatesAutoresizingMaskIntoConstraints = false
        ForgGotButton.setTitle("Forgot Password?", for: .normal)
        ForgGotButton.setTitleColor(.systemBlue, for: .normal)
        ForgGotButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        
        // Forgot Password Info
        ForgotpasswordINFO.translatesAutoresizingMaskIntoConstraints = false
        ForgotpasswordINFO.text = "if don't know your password."
        ForgotpasswordINFO.textColor = APPCOLOR.ContentColor.withAlphaComponent(0.5)
        ForgotpasswordINFO.font = UIFont.systemFont(ofSize: 12)
        
        let ForgotPasswordStack = UIStackView(
            arrangedSubviews: [ForgotpasswordINFO , ForgGotButton]
        )
        
        ForgotPasswordStack.translatesAutoresizingMaskIntoConstraints = false
        ForgotPasswordStack.axis = .horizontal
        ForgotPasswordStack.alignment = .center
        ForgotPasswordStack.distribution = .fill
        ForgotpasswordINFO.setContentHuggingPriority(.defaultLow, for: .horizontal)
        ForgGotButton.setContentHuggingPriority(.required, for: .horizontal)
        ForgotPasswordStack.spacing = 8

        addSubview(ForgotPasswordStack)

        // Sign Up Button
        SignUpButton.translatesAutoresizingMaskIntoConstraints = false
        SignUpButton.setTitle("Sign Up", for: .normal)
        SignUpButton.setTitleColor(.white, for: .normal)
        SignUpButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        SignUpButton.backgroundColor = .systemBlue
        SignUpButton.layer.cornerRadius = 25
        SignUpButton.clipsToBounds = true

        // Add Subviews
        addSubview(UsernameInput)
        addSubview(EmailInput)
        addSubview(PasswordInput)
        addSubview(ForgGotButton)
        addSubview(SignUpButton)

        // Auto Layout
        NSLayoutConstraint.activate([

            // Username
            UsernameInput.topAnchor.constraint(equalTo: topAnchor),
            UsernameInput.leadingAnchor.constraint(equalTo: leadingAnchor),
            UsernameInput.trailingAnchor.constraint(equalTo: trailingAnchor),
            UsernameInput.heightAnchor.constraint(equalToConstant: 50),

            // Email
            EmailInput.topAnchor.constraint(equalTo: UsernameInput.bottomAnchor, constant: 15),
            EmailInput.leadingAnchor.constraint(equalTo: leadingAnchor),
            EmailInput.trailingAnchor.constraint(equalTo: trailingAnchor),
            EmailInput.heightAnchor.constraint(equalToConstant: 50),

            // Password
            PasswordInput.topAnchor.constraint(equalTo: EmailInput.bottomAnchor, constant: 15),
            PasswordInput.leadingAnchor.constraint(equalTo: leadingAnchor),
            PasswordInput.trailingAnchor.constraint(equalTo: trailingAnchor),
            PasswordInput.heightAnchor.constraint(equalToConstant: 50),

            // Forgot Password
            ForgGotButton.topAnchor.constraint(equalTo: PasswordInput.bottomAnchor, constant: 10),
            ForgGotButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5),
            ForgGotButton.heightAnchor.constraint(equalToConstant: 30),
            
            // Forgot Password Stack
            ForgotPasswordStack.topAnchor.constraint(
                equalTo: PasswordInput.bottomAnchor,
                constant: 5
            ),

            ForgotPasswordStack.trailingAnchor.constraint(
                equalTo: trailingAnchor,
                constant: -5
            ),

            ForgotPasswordStack.leadingAnchor.constraint(
                equalTo: leadingAnchor,
                constant: 10
            ),

            ForgotPasswordStack.heightAnchor.constraint(equalToConstant: 30),

            // Sign Up
            SignUpButton.topAnchor.constraint(
                equalTo: ForgotPasswordStack.bottomAnchor,
                constant: 15
            ),

            // Sign Up
            SignUpButton.topAnchor.constraint(equalTo: ForgGotButton.bottomAnchor, constant: 15),
            SignUpButton.leadingAnchor.constraint(equalTo: leadingAnchor , constant: 25),
            SignUpButton.trailingAnchor.constraint(equalTo: trailingAnchor , constant: -25),
            SignUpButton.heightAnchor.constraint(equalToConstant: 50),

            // Bottom
            SignUpButton.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }

    // MARK: - Helpers
    private func styleInput(_ field: UITextField, placeholder: String) {

        field.backgroundColor = APPCOLOR.LayoutToperColor
        field.translatesAutoresizingMaskIntoConstraints = false

        field.attributedPlaceholder = NSAttributedString(
            string: placeholder,
            attributes: [
                .foregroundColor: APPCOLOR.SubContentColor.withAlphaComponent(0.5)
            ]
        )

        field.borderStyle = .none
        field.layer.cornerRadius = 25
        field.clipsToBounds = true

        field.leftView = UIView(
            frame: CGRect(x: 0, y: 0, width: 15, height: 50)
        )

        field.leftViewMode = .always
    }
    
    
}




class SINGIN_DIVIDER_CNT: UIView {

    // MARK: - Public
    var title: String = "OR SIGN UP WITH" {
        didSet { label.text = title }
    }

//    // MARK: - Subviews
    private let leftLine = UIView()
    private let rightLine = UIView()

    private let label: UILabel = {
        let l = UILabel()
        l.font = .systemFont(ofSize: 13, weight: .medium)
        l.textColor = UIColor(red: 0.45, green: 0.45, blue: 0.58, alpha: 1)
        l.textAlignment = .center
        l.setContentHuggingPriority(.required, for: .horizontal)
        l.setContentCompressionResistancePriority(.required, for: .horizontal)
        return l
    }()

    private let stack: UIStackView = {
        let s = UIStackView()
        s.axis = .horizontal
        s.alignment = .center
        s.distribution = .fill
        s.spacing = 12
        s.translatesAutoresizingMaskIntoConstraints = false
        return s
    }()

    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }

    // MARK: - Setup
    private func setup() {
        translatesAutoresizingMaskIntoConstraints = false
        addSubview(stack)
        
        label.text = title
        label.textColor = APPCOLOR.ContentColor.withAlphaComponent(0.3)

        let lineColor = APPCOLOR.ContentColor.withAlphaComponent(0.3)
        [leftLine, rightLine].forEach {
            $0.backgroundColor = lineColor
            $0.heightAnchor.constraint(equalToConstant: 1).isActive = true
        }

        stack.addArrangedSubview(leftLine)
        stack.addArrangedSubview(label)
        stack.addArrangedSubview(rightLine)
        

        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: topAnchor),
            stack.bottomAnchor.constraint(equalTo: bottomAnchor),
            stack.leadingAnchor.constraint(equalTo: leadingAnchor),
            stack.trailingAnchor.constraint(equalTo: trailingAnchor),
            leftLine.widthAnchor.constraint(equalTo: rightLine.widthAnchor)
        ])
        
    }

    override var intrinsicContentSize: CGSize {
        CGSize(width: UIView.noIntrinsicMetric, height: 20)
    }
}





class SINGIN_OUSIDE_CNT: UIView {

    // MARK: - Types
    enum Provider: Int, CaseIterable {
        case google, apple, instagram
    }

    // MARK: - Public
    /// Called when an icon is tapped
    var onTap: ((Provider) -> Void)?

    // MARK: - Subviews
    private let stack: UIStackView = {
        let s = UIStackView()
        s.axis = .horizontal
        s.alignment = .center
        s.distribution = .equalSpacing
        s.translatesAutoresizingMaskIntoConstraints = false
        return s
    }()

    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }

    // MARK: - Setup
    private func setup() {
        translatesAutoresizingMaskIntoConstraints = false
        addSubview(stack)
        
        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: topAnchor),
            stack.bottomAnchor.constraint(equalTo: bottomAnchor),
            stack.centerXAnchor.constraint(equalTo: centerXAnchor),
            stack.leadingAnchor.constraint(greaterThanOrEqualTo: leadingAnchor),
            stack.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor),
            // Controls the gap look: a fixed width spreads the icons evenly
            stack.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.7)
        ])

        Provider.allCases.forEach { provider in
            stack.addArrangedSubview(makeButton(for: provider))
        }
    }

    private func makeButton(for provider: Provider) -> UIButton {
        let button = UIButton(type: .system)
        button.tag = provider.rawValue
        button.setImage(image(for: provider), for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.tintColor = (provider == .apple) ? .systemGray : nil
        button.translatesAutoresizingMaskIntoConstraints = false
        button.widthAnchor.constraint(equalToConstant: 44).isActive = true
        button.heightAnchor.constraint(equalToConstant: 44).isActive = true
        button.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
        return button
    }

    private func image(for provider: Provider) -> UIImage? {
        switch provider {
        case .google:
            return UIImage(systemName: "playstation.logo")
        case .apple:
            return UIImage(systemName: "apple.logo")
        case .instagram:
            return UIImage(systemName: "xbox.logo")
        }
    }

    // MARK: - Actions
    @objc private func buttonTapped(_ sender: UIButton) {
        guard let provider = Provider(rawValue: sender.tag) else { return }
        onTap?(provider)
    }

    override var intrinsicContentSize: CGSize {
        CGSize(width: UIView.noIntrinsicMetric, height: 44)
    }
}

class SINGIN_ALTERNATIVE_CNT: UIView {

    // Called when "Log in" is tapped
    var onLoginTapped: (() -> Void)?

    private let messageLabel: UILabel = {
        let label = UILabel()
        label.text = "Already have an account?"
        label.font = .systemFont(ofSize: 17, weight: .regular)
        label.textColor = UIColor(red: 0.29, green: 0.33, blue: 0.40, alpha: 1) // slate gray
        label.setContentHuggingPriority(.required, for: .horizontal)
        return label
    }()

    private let loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Log in", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 17, weight: .bold)
        button.setTitleColor(UIColor(red: 0.10, green: 0.46, blue: 0.98, alpha: 1), for: .normal) // blue
        return button
    }()

    private lazy var stackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [messageLabel, loginButton])
        stack.axis = .horizontal
        stack.spacing = 6
        stack.alignment = .center
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }

    private func setupView() {
        translatesAutoresizingMaskIntoConstraints = false
        addSubview(stackView)

        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            stackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            stackView.leadingAnchor.constraint(greaterThanOrEqualTo: leadingAnchor),
            stackView.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor)
        ])

        loginButton.addTarget(self, action: #selector(loginTapped), for: .touchUpInside)
    }

    @objc private func loginTapped() {
        onLoginTapped?()
    }
}
