import UIKit

class SEARCHBAR_CMPT: UIView, UITextFieldDelegate {

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
