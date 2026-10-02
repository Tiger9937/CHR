// ---------------------------Rules------------------
// 1. layout must be have flixiable to change Height and Weight
// 2. all layouts is a class with ther Name and if we are put layout inside a layout we may use number to represent
// 3. All layout must have Autolayout Enable
// 4. all layout classname should be represent pagename-classname-shortformoflayout
// 5. LYT(Layout)

import UIKit

class PRIVATE_PROFILE_HEADER_LYT:UIView {
   
    override init(frame: CGRect) {
        super.init(frame: frame)
        Configur()
    }
    
    required init?(coder: NSCoder) {
        fatalError("PRIVATE_PROFILE_HEADER_LYT has not been implemented")
    }
    
    private func Configur(){
        translatesAutoresizingMaskIntoConstraints = false
        layer.cornerRadius = 10
    }
}

class PRIVATE_PROFILE_CONTENT_LYT: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        Configur()
    }
    
    required init?(coder: NSCoder) {
        fatalError("PRIVATE_PROFILE_CONTENT_LYT has not been implemented")
    }
    
    private func Configur(){
        translatesAutoresizingMaskIntoConstraints = false
        layer.cornerRadius = 10
    }
}

class PRIVATE_PROFILE_DETAILS_LYT: UIView {

    private let gradientLayer = CAGradientLayer()

    override init(frame: CGRect) {
        super.init(frame: frame)
        Configur()
    }

    required init?(coder: NSCoder) {
        fatalError("PRIVATE_PROFILE_DETAILS_LYT has not been implemented")
    }

    private func Configur() {
        translatesAutoresizingMaskIntoConstraints = false
        layer.cornerRadius = 18
        layer.masksToBounds = true // needed so the gradient respects the corner radius

        gradientLayer.colors = [
            UIColor.clear.cgColor,
            UIColor.black.cgColor
        ]
        gradientLayer.locations = [0, 1]
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0.0) // top
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 1.0)   // bottom
        layer.addSublayer(gradientLayer)

    }

    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = bounds // must update on every layout pass, since CAGradientLayer doesn't auto-resize with autolayout
    }
}

class PRIVATE_PROFILE_COVERIMG_LYT: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        Configur()
    }
    
    required init?(coder: NSCoder) {
        fatalError("PRIVATE_PROFILE_COVERIMG_LYT has not been implemented")
    }
    
    private func Configur(){
        translatesAutoresizingMaskIntoConstraints = false
        layer.cornerRadius = 15
    }
}

class PRIVATE_PROFILE_PROFILEIMG_LYT: UIView{
    override init(frame: CGRect) {
        super.init(frame: frame)
        Configur()
    }
    
    required init?(coder: NSCoder) {
        fatalError("PRIVATE_PROFILE_PROFILEIMG_LYT has not been implemented")
    }
    
    private func Configur(){
        translatesAutoresizingMaskIntoConstraints = false
        layer.cornerRadius = 35
    }
}

class PRIVATE_PROFILE_STATUSBAR_LYT: UIView{
    override init(frame: CGRect) {
        super.init(frame: frame)
        Configur()
    }
    
    required init?(coder: NSCoder) {
        fatalError("PRIVATE_PROFILE_STATUSBAR_LYT has not been implemented")
    }
    
    private func Configur(){
        APPCOLOR.CurrentThem()
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor =  APPCOLOR.LayoutColor
        layer.cornerRadius = 15
    }
}

class PRIVATE_PROFILE_BIOINFO_LYT: UIView{
    override init(frame: CGRect) {
        super.init(frame: frame)
        Configur()
    }
    
    required init?(coder: NSCoder) {
        fatalError("PRIVATE_PROFILE_BIOINFO_LYT has not been implemented")
    }
    
    
    
    
    
    private func Configur(){
        APPCOLOR.CurrentThem()
        translatesAutoresizingMaskIntoConstraints = false
        layer.cornerRadius = 15
    }
}

class PRIVATE_PROFILE_INTREST_LYT: UIView{
    override init(frame: CGRect) {
        super.init(frame: frame)
        Configur()
    }
    
    required init?(coder: NSCoder) {
        fatalError("PRIVATE_PROFILE_INTREST_LYT has not been implemented")
    }
    
    private func Configur(){
        translatesAutoresizingMaskIntoConstraints = false
        layer.cornerRadius = 15
    }
}

class PRIVATE_PROFILE_POST_TITLE_LYT: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        Title()
        ViewAllAction()
        Configur()
    }
    
    required init?(coder: NSCoder) {
        fatalError("PRIVATE_PROFILE_INTREST_LYT has not been implemented")
    }
    
    func Title() {
        let title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        title.textColor = .black
        title.text = "Resend Activity"
        title.backgroundColor = .cyan
        addSubview(title)
        NSLayoutConstraint.activate([
            title.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            title.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            title.heightAnchor.constraint(equalToConstant: 30),
        ])
    }
    
    func ViewAllAction() {
        let action = UIButton()
        action.translatesAutoresizingMaskIntoConstraints = false
        action.setTitle("ViewAll", for: .normal)
        action.backgroundColor = .red
        action.setTitleColor(.systemBlue, for: .normal)
        addSubview(action)
        NSLayoutConstraint.activate([
            action.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            action.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            action.widthAnchor.constraint(equalToConstant: 60),
            action.heightAnchor.constraint(equalToConstant: 30),
        ])
    }
    
    private func Configur() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .systemRed
        layer.cornerRadius = 15
    }
}

class PRIVATE_PROFILE_POST_CONTENTHOLDER_LYT: UIView{
    
    
    // getway
    let numberOfItem:Int
    let HeightOfaitem:CGFloat
    
    init(Itemsize:CGFloat , totalItem:Int) {
        HeightOfaitem = Itemsize
        numberOfItem = totalItem
        super.init(frame: .zero)
        Configur()
        SetupCollectionView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("PRIVATE_PROFILE_INTREST_LYT has not been implemented")
    }
    
    private func SetupCollectionView(){
        
        let SearchCollectionView = UICollectionView(frame: .zero,collectionViewLayout: GetcompositionLYT())
        SearchCollectionView.translatesAutoresizingMaskIntoConstraints = false
        SearchCollectionView.delegate = self
        SearchCollectionView.dataSource = self
        SearchCollectionView.backgroundColor = .eveningDark
        SearchCollectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "CollectionViewCell")
        addSubview(SearchCollectionView)
        
        NSLayoutConstraint.activate([
            SearchCollectionView.topAnchor.constraint(equalTo: topAnchor),
            SearchCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            SearchCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            SearchCollectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            SearchCollectionView.heightAnchor.constraint(equalToConstant: CGFloat(ceil(Double(numberOfItem) / 2.0) * 300))
        ])
        
    }
    //

    private func GetcompositionLYT()->UICollectionViewCompositionalLayout{
                let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(
                                                   widthDimension: .fractionalWidth(1/2),
                                                   heightDimension: .fractionalHeight(1))
                )
                item.contentInsets = NSDirectionalEdgeInsets(top: 3, leading: 3, bottom: 3, trailing: 3)
        
            let insiderGroup = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)), subitems: [item])
            
        
        
        let group = NSCollectionLayoutGroup.vertical(
               layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                  heightDimension: .absolute(self.HeightOfaitem)) ,
                                                  subitems: [insiderGroup]
        )
        
        
        
        let section = NSCollectionLayoutSection(group: group)
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
        
    }
    
    private func Configur() {
        translatesAutoresizingMaskIntoConstraints = false
        layer.cornerRadius = 15
    }
}
    extension PRIVATE_PROFILE_POST_CONTENTHOLDER_LYT : UICollectionViewDelegate , UICollectionViewDataSource {
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return self.numberOfItem
        }
        
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath)
            func randomcolor()->UIColor{
                return UIColor(
                        red: CGFloat.random(in: 0...1),
                        green: CGFloat.random(in: 0...1),
                        blue: CGFloat.random(in: 0...1),
                        alpha: 1.0
                )
            }
            cell.backgroundColor = randomcolor()
            cell.layer.cornerRadius = 3
            return cell
        }
    }

