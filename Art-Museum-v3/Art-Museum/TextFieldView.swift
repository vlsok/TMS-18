import UIKit

@IBDesignable
class TextFieldView: UIView {
    
    private let backgroundView: UIView = UIView(frame: .zero)
    private let textField: UITextField = UITextField(frame: .zero)

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
    
    @IBInspectable
    var placeholder: String {
        get {
            textField.placeholder ?? ""
        }
        set {
            textField.attributedPlaceholder =
            NSAttributedString(string: newValue,
                               attributes: [
                                .font: UIFont(name: "Montserrat-Regular", size: 15.0)!,
                               ])
        }
    }
    
    @IBInspectable
    var secureEntry: Bool {
        get {
            textField.isSecureTextEntry
        }
        set {
            textField.isSecureTextEntry = newValue
        }
    }

    var text: String {
        get {
            textField.text ?? ""
        }
        set {
            textField.text = newValue
        }
    }
    
    var keyboardType: UIKeyboardType {
        get {
            textField.keyboardType
        }
        set {
            textField.keyboardType = newValue
        }
    }
    
    var shouldFilterInput: Bool = false {
        didSet {
            textField.text = ""
        }
    }
    
    private func setupView() {
        backgroundColor = .clear
        clipsToBounds = false
        
        textField.font = UIFont(name: "Montserrat-Regular", size: 15.0)
        
        backgroundView.backgroundColor = .white
        
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(backgroundView)
        
        NSLayoutConstraint.activate([
            backgroundView.leftAnchor.constraint(equalTo: self.leftAnchor),
            backgroundView.rightAnchor.constraint(equalTo: self.rightAnchor),
            backgroundView.topAnchor.constraint(equalTo: self.topAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
        ])
        
        textField.translatesAutoresizingMaskIntoConstraints = false
        addSubview(textField)

        NSLayoutConstraint.activate([
            textField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15.0),
            textField.topAnchor.constraint(equalTo: topAnchor, constant: 15.0),
            textField.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -14.0),
            textField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15.0)
        ])
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(fieldTapped(_:)))
        backgroundView.addGestureRecognizer(tapGesture)
        
        textField.delegate = self
    }
    
    @objc
    func fieldTapped(_ sender: UITapGestureRecognizer) {
        textField.becomeFirstResponder()
    }
    
    @discardableResult
    override func becomeFirstResponder() -> Bool {
        textField.becomeFirstResponder()
    }
    
    @discardableResult
    override func resignFirstResponder() -> Bool {
        textField.resignFirstResponder()
    }
    
    override var isFirstResponder: Bool {
        textField.isFirstResponder
    }
}

extension TextFieldView: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool {
        guard shouldFilterInput else {
            return true
        }
        guard (string.allSatisfy { $0.isWhitespace }) else {
            return true
        }

        let editedString = string.removeSpaces()

        var text = textField.text ?? ""

        text = text.replacingCharacters(in: Range(range, in: text)!, with: editedString)
        textField.text = text

        guard let location = textField.position(from: textField.beginningOfDocument,
                                                 offset: range.location + editedString.count),
              let textRange = textField.textRange(from: location, to: location) else {
            return false
        }

        DispatchQueue.main.async {
            textField.selectedTextRange = textRange
        }

        return false
    }
}
