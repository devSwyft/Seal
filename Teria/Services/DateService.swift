import Foundation

struct DateService {
    static func getToday() -> String {
        let today = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyyMMdd"
        
        return dateFormatter.string(from: today)
    }
    
    static func getTomorrow() {
        
    }
}
