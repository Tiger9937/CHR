import UIKit
final class LoadingView: UIView {

    private let loadingAnimation = UIView()

    private var animationWidthConstraint: NSLayoutConstraint!

    private var isRunning = false


    override init(frame: CGRect) {
        super.init(frame: frame)

        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    private func setupView() {

        APPCOLOR.CurrentThem()

        translatesAutoresizingMaskIntoConstraints = false


        loadingAnimation.translatesAutoresizingMaskIntoConstraints = false

        loadingAnimation.backgroundColor =
        APPCOLOR.SubContentColor.withAlphaComponent(0.1)
        loadingAnimation.layer.cornerRadius = 10
        addSubview(loadingAnimation)


        animationWidthConstraint =
            loadingAnimation.widthAnchor.constraint(
                equalTo: widthAnchor,
                multiplier: 0
            )

        NSLayoutConstraint.activate([

            animationWidthConstraint,

            loadingAnimation.leadingAnchor.constraint(
                equalTo: leadingAnchor
            ),

            loadingAnimation.topAnchor.constraint(
                equalTo: topAnchor
            ),

            loadingAnimation.bottomAnchor.constraint(
                equalTo: bottomAnchor
            )
        ])
    }
    
    private func animateLoading() {

        guard isRunning else {
            return
        }

        animationWidthConstraint.isActive = false

        animationWidthConstraint =
            loadingAnimation.widthAnchor.constraint(
                equalTo: widthAnchor,
                multiplier: 0.1
            )

        animationWidthConstraint.isActive = true

        layoutIfNeeded()


        animationWidthConstraint.isActive = false

        animationWidthConstraint =
            loadingAnimation.widthAnchor.constraint(
                equalTo: widthAnchor,
                multiplier: 1.0
            )

        animationWidthConstraint.isActive = true


        UIView.animate(
            withDuration: 0.5,
            animations: {

                self.layoutIfNeeded()

            },
            completion: { _ in

                if self.isRunning {
                    self.animateLoading()
                }
            }
        )
    }
    
    
    func start() {

        isRunning = true

        animateLoading()
    }
    
    func stop() {
        isRunning = false
    }
}


final class SpinLoadingView {
    var container = UIView()
    
    
    private func SetUpLoading() -> UIView {


        container.translatesAutoresizingMaskIntoConstraints = false
        container.layer.cornerRadius = 15

    // MARK: Loader

    let loader = UIView()
    loader.translatesAutoresizingMaskIntoConstraints = false
    loader.backgroundColor = .systemBlue
    loader.layer.cornerRadius = 10

    container.addSubview(loader)

    NSLayoutConstraint.activate([
        loader.centerXAnchor.constraint(
            equalTo: container.centerXAnchor
        ),

        loader.topAnchor.constraint(
            equalTo: container.topAnchor,
            constant: 20
        ),

        loader.widthAnchor.constraint(equalToConstant: 100),
        loader.heightAnchor.constraint(equalToConstant: 20)
    ])


    // MARK: Loading Text

    let loadingText = UILabel()
    loadingText.translatesAutoresizingMaskIntoConstraints = false
    loadingText.text = "Loading"
    loadingText.font = .systemFont(
        ofSize: 15,
        weight: .medium
    )

        loadingText.textColor = APPCOLOR.ContentColor
    loadingText.textAlignment = .left

    container.addSubview(loadingText)

    NSLayoutConstraint.activate([
        loadingText.centerXAnchor.constraint(
            equalTo: container.centerXAnchor,
            constant: 10
        ),

        loadingText.topAnchor.constraint(
            equalTo: loader.bottomAnchor,
            constant: 50
        ),

        loadingText.bottomAnchor.constraint(
            equalTo: container.bottomAnchor,
            constant: -20
        ),
        
        loadingText.widthAnchor.constraint(equalToConstant:80)
    ])


    // MARK: Rotation

    func Rotate() {

        UIView.animate(
            withDuration: 0.1,
            delay: 0,
            options: [.curveLinear],
            animations: {

                loader.transform = CGAffineTransform(
                    rotationAngle: .pi
                )

            },
            completion: { _ in

                loader.transform = .identity

                Rotate()
            }
        )
    }


    // MARK: Loading Dots

    var dotCount = 0

    func AnimateDots() {

        dotCount += 1

        if dotCount > 3 {
            dotCount = 0
        }

        let dots = String(
            repeating: ".",
            count: dotCount
        )

        loadingText.text = "Loading\(dots)"

        DispatchQueue.main.asyncAfter(
            deadline: .now() + 0.5
        ) {

            AnimateDots()
        }
    }


    Rotate()
    AnimateDots()


    return container
}
    
    
    
    func startLoading(in parentView: UIView){
        let Loadview = SetUpLoading()
        parentView.addSubview(Loadview)
        
        NSLayoutConstraint.activate([
            Loadview.centerXAnchor.constraint(equalTo: parentView.centerXAnchor),
            Loadview.centerYAnchor.constraint(equalTo: parentView.centerYAnchor),
          ])
    }
    
    func stopLoading(){
        container.removeFromSuperview()
    }
}
