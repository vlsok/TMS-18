import UIKit

class LabelStyle: UIView {
    
    func setFont(for label: UILabel, to value: CGFloat) {
        label.font = UIFont(name: "Montserrat-Regular", size: value)
    }
    
    func setLineHeight(for label: UILabel, to value: CGFloat) {
        let attributedString = NSMutableAttributedString(string: label.text!)
        let paragraphStyle = NSMutableParagraphStyle()

        paragraphStyle.lineSpacing = value
        attributedString.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range:NSMakeRange(0, attributedString.length))
        label.attributedText = attributedString
    }
    
}
