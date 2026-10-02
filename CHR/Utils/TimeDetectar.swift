internal import Foundation

class TimeDetectr{
    var outComeDate = DateFormatter()
    var calendar = Calendar.current
     
    
    func FindCurrentTime(Time:String)->String?{
        let formatter = ISO8601DateFormatter()
        

        if let date = formatter.date(from: Time) {
            calendar.timeZone = TimeZone.current
            
            if(calendar.isDateInToday(date)){
                
                outComeDate.dateFormat = "hh/mm"
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

