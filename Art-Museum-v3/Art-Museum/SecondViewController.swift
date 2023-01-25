import UIKit

class SecondViewController: UIViewController {
    
    @IBOutlet var nameLabel: UILabel!
    
    let fvc = FirstViewController()
    let jsonData = JsonData()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameLabel.text = fvc.jsonDataFromFile?.email ?? "..."
        print(jsonData.pathToJsonFile ?? URL(filePath: ""))
    }
}
