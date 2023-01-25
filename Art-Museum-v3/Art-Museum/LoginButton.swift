import UIKit

class LoginButton: UIButton {
    
    private let logInButton: UIButton = UIButton.init(frame: .zero)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.backgroundColor = UIColor(named: "LoginButton")
    }
    
}
