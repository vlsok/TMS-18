import Foundation

class JsonData {
    
    lazy var pathToJsonFile = generateJsonFile()
    
    func generateJsonFile() -> URL? {
        guard let pathToJsonFile = try? FileManager.default.url(for: .documentDirectory,
                                                          in: .allDomainsMask,
                                                          appropriateFor: nil,
                                                          create: true)
            .appending(path: "loginInformation.json") else {
            return nil
        }
        
        return pathToJsonFile
    }

    public func writeToJsonFile(_ information: LoginInformation) {
        let jsonEncoder = JSONEncoder()
        jsonEncoder.outputFormatting = .prettyPrinted
        
        guard let result = try? jsonEncoder.encode(information) else {
            print("Have an error with jsonEncoder")
            return
        }
    
        try? result.write(to: pathToJsonFile ?? URL(filePath: ""))
    }
    
    func readFromJsonFile() -> LoginInformation? {
        let jsonDecoder = JSONDecoder()
        
        guard let data = try? Data(contentsOf: pathToJsonFile ?? URL(filePath: "")) else {
            return nil
        }
        
        guard let loginInformation = try? jsonDecoder.decode(LoginInformation.self, from: data) else {
            return nil
        }
        
        return loginInformation
    }
    
}
