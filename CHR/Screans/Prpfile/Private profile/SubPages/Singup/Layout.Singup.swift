import UIKit



class SINGUP_HEADER_LYT: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        Configur()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func Configur() {
        translatesAutoresizingMaskIntoConstraints = false
        layer.cornerRadius = 15
    }
}


class SINGUP_GROUP_LYT: UIView{
    override init(frame: CGRect) {
        super.init(frame: frame)
        Configur()
    }
    
    required init?(coder: NSCoder) {
        fatalError("PRIVATE_PROFILE_INTREST_LYT has not been implemented")
    }
    
    private func Configur() {
        translatesAutoresizingMaskIntoConstraints = false

        backgroundColor = APPCOLOR.LayoutColor
        layer.cornerRadius = 40

        // Border
        layer.borderWidth = 1
        layer.borderColor = APPCOLOR.LayoutToperBORDERColor.cgColor
    }
}




class SINGUP_INPUTS_LYT: UIView{
    override init(frame: CGRect) {
        super.init(frame: frame)
        Configur()
    }
    
    required init?(coder: NSCoder) {
        fatalError("PRIVATE_PROFILE_INTREST_LYT has not been implemented")
    }
    
    private func Configur() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .red
        layer.cornerRadius = 15
    }
}


class SINGUP_ACTION_LYT: UIView{
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

class SINGUP_DIVIDER_LYT: UIView{
    override init(frame: CGRect) {
        super.init(frame: frame)
        Configur()
    }
    
    required init?(coder: NSCoder) {
        fatalError("PRIVATE_PROFILE_INTREST_LYT has not been implemented")
    }
    
    private func Configur() {
        translatesAutoresizingMaskIntoConstraints = false
//        backgroundColor = .green
        layer.cornerRadius = 15
    }
}

class SINGUP_OUTSIDE_LOG_LYT: UIView{
    override init(frame: CGRect) {
        super.init(frame: frame)
        Configur()
    }
    
    required init?(coder: NSCoder) {
        fatalError("PRIVATE_PROFILE_INTREST_LYT has not been implemented")
    }
    
    private func Configur() {
        translatesAutoresizingMaskIntoConstraints = false
//        backgroundColor = .systemMint
        layer.cornerRadius = 15
    }
}

class SINGUP_ALTERNATIV_LYT: UIView{
    override init(frame: CGRect) {
        super.init(frame: frame)
        Configur()
    }
    
    required init?(coder: NSCoder) {
        fatalError("PRIVATE_PROFILE_INTREST_LYT has not been implemented")
    }
    
    private func Configur() {
        translatesAutoresizingMaskIntoConstraints = false
  // backgroundColor = .green
        layer.cornerRadius = 15
    }
}

