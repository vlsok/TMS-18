import UIKit

extension String {
    func removeSpaces() -> String {
        var editedString = self
        editedString.removeAll { $0.isWhitespace }
        
        return editedString
    }
}
