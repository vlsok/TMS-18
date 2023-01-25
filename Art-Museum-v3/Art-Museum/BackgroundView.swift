import UIKit

class BackgroundView: UIView {
    
    private let backgroundView = UIImageView(frame: .zero)

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }

    private func setupView() {
        backgroundView.image = UIImage(named: "BackgroundImage")
        backgroundView.contentMode = .scaleAspectFill

        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        insertSubview(backgroundView, at: 0)
        //sendSubviewToBack(backgroundView)

        NSLayoutConstraint.activate([
            backgroundView.topAnchor.constraint(equalTo: topAnchor, constant: -10.0),
            backgroundView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 10.0),
            backgroundView.rightAnchor.constraint(equalTo: rightAnchor, constant: 80.0),
            backgroundView.leftAnchor.constraint(equalTo: leftAnchor)
        ])
    }
    
}
