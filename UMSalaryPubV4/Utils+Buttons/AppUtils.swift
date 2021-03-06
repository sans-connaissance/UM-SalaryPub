import Foundation

/// This class was written by user intelcy on fiverr.com to assist with loading data from JSON files into CoreData persistentContainer
class AppUtils {
    static func jsonDataFromFile(name: String) -> Data {
        let url = Bundle.main.url(forResource: name, withExtension: "json")!
        return try! Data(contentsOf: url)
    }

    static func dictionaryFromFile(name: String) -> [String: Any] {
        let data = jsonDataFromFile(name: name)
        return try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
    }
}
