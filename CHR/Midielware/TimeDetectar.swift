internal import Foundation

class TimeDetectr{
    var outComeDate = DateFormatter()
    var calendar = Calendar.current
     
    
    func FindCurrentTime(_ TimeWIthString:String? , DateWithDateFormat:Date?)->String?{
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = [
            .withInternetDateTime,
            .withFractionalSeconds
        ]
        let timestamp = TimeWIthString ?? formatter.string(from: DateWithDateFormat!)
        
        // 2026-02-18T05:00:11.272+00:00
        if let date = formatter.date(from: timestamp) {
            calendar.timeZone = TimeZone.current
            
            if(calendar.isDateInToday(date)){
                outComeDate.dateFormat = "hh:mm a"
                return outComeDate.string(from: date)
                
            }else if(calendar.isDateInYesterday(date)){
                return "Yesterday"
            }else{
                outComeDate.dateFormat = "dd/MM/yyyy"
                return outComeDate.string(from: date)
                
            }
            
        }else{
            return "Date invalid"
        }
        
        
    }
}

