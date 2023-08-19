import Foundation

struct DateService {
    static func getDate(add: Int) -> String {
        let today = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyyMMdd"
        
        let calendar = Calendar.current
        let tomorrow = calendar.date(byAdding: .day, value: add, to: today)
        
        return dateFormatter.string(from: tomorrow!)
    }
    
    static func getDateView(add: Int) -> String {
        let today = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy.MM.dd"
        
        let calendar = Calendar.current
        let tomorrow = calendar.date(byAdding: .day, value: add, to: today)
        
        return dateFormatter.string(from: tomorrow!)
    }
}
