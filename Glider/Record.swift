//
//  Record.swift
//  Glider
//
//  Created by Christopher Leibiger on 09.08.22.
//

import SwiftUI

struct Record: Identifiable, Hashable, Codable {
    var id = UUID()
    var start = Date.now
    var end = Date.now.addingTimeInterval(60)
    var note = "" {
        didSet {
            let characterLimit = 13
            if note.count > characterLimit && oldValue.count <= characterLimit {
                note = oldValue
            }
        }
    }
   
    
  
    
    
    var durationInSeconds: Double {
        self.start.distance(to: self.end )
    }
    
    var duration: Double {
        Double(self.start.distance(to: self.end ) / 3600).rounded(digits: 2)
    }
    
    var durationInHours: Double {
        ( self.durationInSeconds / 60 ) / 60
    }
    
    var durationInMinutesAsString: String {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.hour, .minute]
        formatter.unitsStyle = .positional
        
        let formattedString = formatter.string(from: TimeInterval(self.durationInSeconds))!
        
        if formattedString.contains(":")
        {
            return(formattedString)}
        else {return (formattedString + "'")}
    }
    
    /*
     var isComplete: Bool {
     end != nil
     }
     */
    
    var isToday: Bool {
        Calendar.autoupdatingCurrent.isDateInToday(start)
        /* let diff = Calendar.current.dateComponents([.day], from: start, to: Date.now)
         if diff.day == 0 {
         return true
         } else {
         return false
         }
         */
    }
    
    var isThisWeek: Bool {
        Calendar.autoupdatingCurrent.isDateInThisWeek(start)
    }
    
    var isThisMonth: Bool {
        Calendar.autoupdatingCurrent.isDateInThisMonth(start)
    }
    
    static var example = Record(
        start: Date.now,
        end: Date.now.addingTimeInterval(10000),
        note: "Test"
    )
    
}

extension Calendar {
    private var currentDate: Date { return Date() }
    
    func isDateInThisWeek(_ date: Date) -> Bool {
        return isDate(date, equalTo: currentDate, toGranularity: .weekOfYear)
    }
    
    func isDateInThisMonth(_ date: Date) -> Bool {
        return isDate(date, equalTo: currentDate, toGranularity: .month)
    }
    
    func isDateInNextWeek(_ date: Date) -> Bool {
        guard let nextWeek = self.date(byAdding: DateComponents(weekOfYear: 1), to: currentDate) else {
            return false
        }
        return isDate(date, equalTo: nextWeek, toGranularity: .weekOfYear)
    }
    
    func isDateInNextMonth(_ date: Date) -> Bool {
        guard let nextMonth = self.date(byAdding: DateComponents(month: 1), to: currentDate) else {
            return false
        }
        return isDate(date, equalTo: nextMonth, toGranularity: .month)
    }
    
    func isDateInFollowingMonth(_ date: Date) -> Bool {
        guard let followingMonth = self.date(byAdding: DateComponents(month: 2), to: currentDate) else {
            return false
        }
        return isDate(date, equalTo: followingMonth, toGranularity: .month)
    }
}



extension Double {
    func rounded(digits: Int) -> Double {
        let multiplier = pow(10.0, Double(digits))
        return (self * multiplier).rounded() / multiplier
    }
}
