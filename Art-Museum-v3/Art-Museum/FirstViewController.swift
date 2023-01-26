import UIKit

class FirstViewController: UIViewController {
    
    @IBOutlet var firstLabel: UILabel!
    @IBOutlet var secondLabel: UILabel!
    @IBOutlet var thirdLabel: UILabel!
    
    @IBOutlet var emailTextField: TextFieldView!
    @IBOutlet var passwordTextField: TextFieldView!
    
    @IBOutlet var scrollView: UIScrollView!
    
    let jsonData = JsonData()
    
    lazy var jsonDataFromFile = jsonData.readFromJsonFile()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let labelStyle = LabelStyle()
    
        labelStyle.setFont(for: firstLabel, to: 40.0)
        labelStyle.setLineHeight(for: firstLabel, to: 5.0)

        labelStyle.setFont(for: secondLabel, to: 15.0)
        labelStyle.setLineHeight(for: secondLabel, to: 2.5)
        
        labelStyle.setFont(for: thirdLabel, to: 12.0)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillChangeFrame(_:)),
                                               name: UIResponder.keyboardWillChangeFrameNotification,
                                               object: nil)
        
        emailTextField.keyboardType = .emailAddress
        emailTextField.shouldFilterInput = true
        
        emailTextField.text = jsonDataFromFile?.email ?? ""
        passwordTextField.text = jsonDataFromFile?.password ?? ""
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // _ = textField.becomeFirstResponder()
        emailTextField.becomeFirstResponder()
    }
    
    @IBAction
    func backgroundTapped(_ sender: UITapGestureRecognizer) {
        // resignFirstResponder()
        view.endEditing(false)
    }
    
    @IBAction @objc
    func buttonTapped(_ sender: UIButton) {
        guard emailTextField.text == "" && passwordTextField.text == "" else {
            let loginInformation = LoginInformation(email: emailTextField.text,
                                                    password: passwordTextField.text)
            
            jsonData.writeToJsonFile(loginInformation)
            
            let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SecondViewController")
            navigationController?.setViewControllers([viewController], animated: true)
            
            return
        }
    }
    
    @objc
    func keyboardWillChangeFrame(_ notification: NSNotification) {
        guard let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else {
            return
        }
        
        scrollView.contentInset = UIEdgeInsets(top: 0.0, left: 0.0,
                                               bottom: scrollView.frame.maxY - keyboardFrame.minY, right: 0.0)
        
        let textFields = [emailTextField!, passwordTextField!]
        
        if let firstResponder = textFields.first(where: \.isFirstResponder) {
            let frame = firstResponder.frame
                .inset(by: UIEdgeInsets(top: -10.0,
                                        left: -10.0,
                                        bottom: -10.0,
                                        right: -10.0))
            
            let newOrigin = scrollView.convert(frame.origin, from: firstResponder.superview)
            let newFrame = CGRect(origin: newOrigin, size: frame.size)
            
            scrollView.scrollRectToVisible(newFrame, animated: true)
        }
    }
}
