import UIKit
class ERRORVIEW{
    
    
    static func WentWorng(ErrorTitle:String , Descrption:String)->(emptyScreenView:UIView , retryButton:UIButton){
        APPCOLOR.CurrentThem()
        
        let emptyScreenView = UIView()
        emptyScreenView.backgroundColor = APPCOLOR.LayoutColor
        emptyScreenView.layer.cornerRadius = 15
        emptyScreenView.layer.masksToBounds = true
        emptyScreenView.translatesAutoresizingMaskIntoConstraints = false

        let titleLabel = UILabel()
        titleLabel.text = "\(ErrorTitle)"
        titleLabel.textColor = APPCOLOR.ContentColor
        titleLabel.font = .systemFont(ofSize: 16, weight: .bold)
        titleLabel.textAlignment = .center
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        emptyScreenView.addSubview(titleLabel)
        
        let subtitleLabel = UILabel()
        subtitleLabel.text = "\(Descrption)"
        subtitleLabel.textColor = APPCOLOR.SubContentColor
        subtitleLabel.font = .systemFont(ofSize: 14, weight: .regular)
        subtitleLabel.textAlignment = .center
        subtitleLabel.numberOfLines = 0
        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        emptyScreenView.addSubview(subtitleLabel)

        let retryButton = UIButton(type: .system)
        retryButton.setTitle("Retry", for: .normal)
        retryButton.backgroundColor = .systemBlue
        retryButton.titleLabel?.font = .systemFont(ofSize: 16, weight: .semibold)
        retryButton.setTitleColor(.white, for: .normal)
        retryButton.layer.cornerRadius = 15
        retryButton.translatesAutoresizingMaskIntoConstraints = false

        // Button is now inside the container
        emptyScreenView.addSubview(retryButton)

        NSLayoutConstraint.activate([

            // Title
            titleLabel.topAnchor.constraint(
                equalTo: emptyScreenView.topAnchor,
                constant: 16
            ),
            titleLabel.leadingAnchor.constraint(
                equalTo: emptyScreenView.leadingAnchor,
                constant: 16
            ),
            titleLabel.trailingAnchor.constraint(
                equalTo: emptyScreenView.trailingAnchor,
                constant: -16
            ),

            // Subtitle
            subtitleLabel.topAnchor.constraint(
                equalTo: titleLabel.bottomAnchor,
                constant: 10
            ),
            subtitleLabel.leadingAnchor.constraint(
                equalTo: emptyScreenView.leadingAnchor,
                constant: 16
            ),
            subtitleLabel.trailingAnchor.constraint(
                equalTo: emptyScreenView.trailingAnchor,
                constant: -16
            ),

            // Button
            retryButton.topAnchor.constraint(
                equalTo: subtitleLabel.bottomAnchor,
                constant: 16
            ),
            retryButton.centerXAnchor.constraint(
                equalTo: emptyScreenView.centerXAnchor
            ),
            retryButton.widthAnchor.constraint(equalToConstant: 120),
            retryButton.heightAnchor.constraint(equalToConstant: 44),

            // IMPORTANT: gives the container its height
            retryButton.bottomAnchor.constraint(
                equalTo: emptyScreenView.bottomAnchor,
                constant: -16
            )
        ])
        
        return (emptyScreenView , retryButton)
    }

    static func Nointernet(ErrorTitle:String , Description:String)->(emptyScreenView:UIView , retryButton:UIButton){
        APPCOLOR.CurrentThem()
        let emptyScreenView = UIView()
        emptyScreenView.backgroundColor = APPCOLOR.LayoutColor
        emptyScreenView.layer.cornerRadius = 15
        emptyScreenView.layer.masksToBounds = true
        emptyScreenView.translatesAutoresizingMaskIntoConstraints = false

        // MARK: - Image

        let errorImageView = UIImageView()
        errorImageView.image = UIImage(named: "Nointernet")
        errorImageView.contentMode = .scaleAspectFit
        errorImageView.translatesAutoresizingMaskIntoConstraints = false
        emptyScreenView.addSubview(errorImageView)


        // MARK: - Title

        let titleLabel = UILabel()
        titleLabel.text = "\(ErrorTitle)"
        titleLabel.textColor = APPCOLOR.ContentColor
        titleLabel.font = .systemFont(ofSize: 20, weight: .bold)
        titleLabel.textAlignment = .center
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        emptyScreenView.addSubview(titleLabel)


        // MARK: - Subtitle

        let subtitleLabel = UILabel()
        subtitleLabel.text = "\(Description)"
        subtitleLabel.textColor = APPCOLOR.SubContentColor
        subtitleLabel.font = .systemFont(ofSize: 15, weight: .regular)
        subtitleLabel.textAlignment = .center
        subtitleLabel.numberOfLines = 0
        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        emptyScreenView.addSubview(subtitleLabel)


        // MARK: - Retry Button

        let retryButton = UIButton(type: .system)
        retryButton.setTitle("Retry", for: .normal)
        retryButton.titleLabel?.font = .systemFont(ofSize: 16, weight: .semibold)
        retryButton.backgroundColor = .systemBlue
        retryButton.setTitleColor(.white, for: .normal)
        retryButton.layer.cornerRadius = 15
        retryButton.translatesAutoresizingMaskIntoConstraints = false
        emptyScreenView.addSubview(retryButton)


        // MARK: - Constraints

        NSLayoutConstraint.activate([

            // Image
            errorImageView.topAnchor.constraint(
                equalTo: emptyScreenView.topAnchor,
                constant: 40
            ),
            errorImageView.centerXAnchor.constraint(
                equalTo: emptyScreenView.centerXAnchor
            ),
            errorImageView.widthAnchor.constraint(
                equalToConstant: 120
            ),
            errorImageView.heightAnchor.constraint(
                equalToConstant: 120
            ),

            // Title
            titleLabel.topAnchor.constraint(
                equalTo: errorImageView.bottomAnchor,
                constant: 35
            ),
            titleLabel.leadingAnchor.constraint(
                equalTo: emptyScreenView.leadingAnchor,
                constant: 16
            ),
            titleLabel.trailingAnchor.constraint(
                equalTo: emptyScreenView.trailingAnchor,
                constant: -16
            ),

            // Subtitle
            subtitleLabel.topAnchor.constraint(
                equalTo: titleLabel.bottomAnchor,
                constant: 14
            ),
            subtitleLabel.leadingAnchor.constraint(
                equalTo: emptyScreenView.leadingAnchor,
                constant: 16
            ),
            subtitleLabel.trailingAnchor.constraint(
                equalTo: emptyScreenView.trailingAnchor,
                constant: -16
            ),

            // Retry Button
            retryButton.topAnchor.constraint(
                equalTo: subtitleLabel.bottomAnchor,
                constant: 36
            ),
            retryButton.centerXAnchor.constraint(
                equalTo: emptyScreenView.centerXAnchor
            ),
            retryButton.widthAnchor.constraint(
                equalToConstant: 200
            ),
            retryButton.heightAnchor.constraint(
                equalToConstant: 52
            ),

            // Bottom of container
            retryButton.bottomAnchor.constraint(
                equalTo: emptyScreenView.bottomAnchor,
                constant: -40
            )
        ])
        return(emptyScreenView,retryButton)
    }

    static func BadRequest(ErroCode:String , ErroMessage:String)->UIView{
        let emptyScreenView = UIView()
        emptyScreenView.translatesAutoresizingMaskIntoConstraints = false
        
        // MARK: - 404
        let errorCodeLabel = UILabel()
        errorCodeLabel.text = "\(ErroCode)"
        errorCodeLabel.textColor = .systemBlue
        errorCodeLabel.font = .systemFont(ofSize: 96, weight: .bold)
        errorCodeLabel.textAlignment = .center
        errorCodeLabel.translatesAutoresizingMaskIntoConstraints = false
        emptyScreenView.addSubview(errorCodeLabel)


        // MARK: - Not Found

        let notFoundLabel = UILabel()
        notFoundLabel.text = "Not Found"
        notFoundLabel.textColor = .systemBlue.withAlphaComponent(0.6)
        notFoundLabel.font = .systemFont(ofSize: 24, weight: .semibold)
        notFoundLabel.textAlignment = .center
        notFoundLabel.translatesAutoresizingMaskIntoConstraints = false
        emptyScreenView.addSubview(notFoundLabel)


        // MARK: - Whale Image

        let whaleImage = UIImageView()
        whaleImage.image = UIImage(named: "whale")
        whaleImage.contentMode = .scaleAspectFit
        whaleImage.translatesAutoresizingMaskIntoConstraints = false
        emptyScreenView.addSubview(whaleImage)


        // MARK: - Message

        let messageLabel = UILabel()
        messageLabel.backgroundColor = .systemBlue
        messageLabel.text = "\(ErroMessage)"
        messageLabel.textColor = APPCOLOR.ContentColor
        messageLabel.font = .systemFont(ofSize: 15, weight: .light)
        messageLabel.textAlignment = .center
        messageLabel.numberOfLines = 0
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        emptyScreenView.addSubview(messageLabel)


        // MARK: - Constraints

        NSLayoutConstraint.activate([
            // 404
            errorCodeLabel.topAnchor.constraint(
                equalTo: emptyScreenView.topAnchor,
                constant: 150
            ),
            errorCodeLabel.centerXAnchor.constraint(
                equalTo: emptyScreenView.centerXAnchor
            ),


            // Not Found
            notFoundLabel.topAnchor.constraint(
                equalTo: errorCodeLabel.bottomAnchor,
                constant: -5
            ),
            notFoundLabel.centerXAnchor.constraint(
                equalTo: emptyScreenView.centerXAnchor
            ),


            // Whale
            whaleImage.topAnchor.constraint(
                equalTo: notFoundLabel.bottomAnchor,
                constant: 45
            ),
            whaleImage.centerXAnchor.constraint(
                equalTo: emptyScreenView.centerXAnchor
            ),
            whaleImage.widthAnchor.constraint(
                equalToConstant: 280
            ),
            whaleImage.heightAnchor.constraint(
                equalToConstant: 170
            ),


            // Message
            messageLabel.topAnchor.constraint(
                equalTo: whaleImage.bottomAnchor,
                constant: 35
            ),
            messageLabel.leadingAnchor.constraint(
                equalTo: emptyScreenView.leadingAnchor,
                constant: 20
            ),
            messageLabel.trailingAnchor.constraint(
                equalTo: emptyScreenView.trailingAnchor,
                constant: -20
            )
        ])
        return emptyScreenView
    }
    
    static func RequestError(ErrorTitle:String , Descrption:String) -> UIView {
        APPCOLOR.CurrentThem()
        
        let emptyScreenView = UIView()
        emptyScreenView.backgroundColor = APPCOLOR.LayoutColor
        emptyScreenView.layer.cornerRadius = 15
        emptyScreenView.layer.masksToBounds = true
        emptyScreenView.translatesAutoresizingMaskIntoConstraints = false
        
        let titleLabel = UILabel()
        titleLabel.text = "\(ErrorTitle)"
        titleLabel.textColor = APPCOLOR.ContentColor
        titleLabel.font = .systemFont(ofSize: 16, weight: .bold)
        titleLabel.textAlignment = .center
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        emptyScreenView.addSubview(titleLabel)
        
        let subtitleLabel = UILabel()
        subtitleLabel.text = "\(Descrption)"
        subtitleLabel.textColor = APPCOLOR.SubContentColor
        subtitleLabel.font = .systemFont(ofSize: 14, weight: .regular)
        subtitleLabel.textAlignment = .center
        subtitleLabel.numberOfLines = 0
        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        emptyScreenView.addSubview(subtitleLabel)
        
        let retryButton = UIButton(type: .system)
        retryButton.setTitle("Retry", for: .normal)
        retryButton.backgroundColor = .systemBlue
        retryButton.titleLabel?.font = .systemFont(ofSize: 16, weight: .semibold)
        retryButton.setTitleColor(.white, for: .normal)
        retryButton.layer.cornerRadius = 15
        retryButton.translatesAutoresizingMaskIntoConstraints = false
        
        // Button is now inside the container
        emptyScreenView.addSubview(retryButton)
        
        NSLayoutConstraint.activate([
            
            // Title
            titleLabel.topAnchor.constraint(
                equalTo: emptyScreenView.topAnchor,
                constant: 16
            ),
            titleLabel.leadingAnchor.constraint(
                equalTo: emptyScreenView.leadingAnchor,
                constant: 16
            ),
            titleLabel.trailingAnchor.constraint(
                equalTo: emptyScreenView.trailingAnchor,
                constant: -16
            ),
            
            // Subtitle
            subtitleLabel.topAnchor.constraint(
                equalTo: titleLabel.bottomAnchor,
                constant: 10
            ),
            subtitleLabel.leadingAnchor.constraint(
                equalTo: emptyScreenView.leadingAnchor,
                constant: 16
            ),
            subtitleLabel.trailingAnchor.constraint(
                equalTo: emptyScreenView.trailingAnchor,
                constant: -16
            ),
            
            // Button
            retryButton.topAnchor.constraint(
                equalTo: subtitleLabel.bottomAnchor,
                constant: 16
            ),
            retryButton.centerXAnchor.constraint(
                equalTo: emptyScreenView.centerXAnchor
            ),
            retryButton.widthAnchor.constraint(equalToConstant: 120),
            retryButton.heightAnchor.constraint(equalToConstant: 44),
            
            // IMPORTANT: gives the container its height
            retryButton.bottomAnchor.constraint(
                equalTo: emptyScreenView.bottomAnchor,
                constant: -16)
        ])
        
        
        return (emptyScreenView)
    }
    
}


