
class PRIVATE_PROFILE_POST_LYT: UIView{
    override init(frame: CGRect) {
        super.init(frame: frame)
        Configur()
    }
    
    required init?(coder: NSCoder) {
        fatalError("PRIVATE_PROFILE_INTREST_LYT has not been implemented")
    }
    
    private func Configur() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .systemRed
        layer.cornerRadius = 15
    }
}
