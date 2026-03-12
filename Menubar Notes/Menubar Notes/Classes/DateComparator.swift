//
//  DateComparator.swift
//  Menubar Notes
//
//  Created by Shayan Eivaz Khani on 2024-07-13.
//

import Foundation


class DateComparator {
    
    init() {}
    
    func getCurrentTime() -> String {
        let now = Date()
        let calendar = Calendar.current
        
        let hour = calendar.component(.hour, from: now)
        let minute = calendar.component(.minute, from: now)
        let second = calendar.component(.second, from: now)
        
        // Get nanoseconds
        let nanosecond = calendar.component(.nanosecond, from: now)
        
        // Format with leading zeros
        return String(format: "%02d:%02d:%02d.%09d", hour, minute, second, nanosecond)
    }
    
/*
        if this.Date > that.Date -> RETURNS A NEGATIVE NUMBER (i.e. if this.Date has passed by that.Date)
        - A POSITIVE RETURN means there is days left in the future this.Date so gets equall to that. Date
*/
    func compareDate(this: Date, that: Date, byYears: Bool, byMonths: Bool, byDays: Bool) -> Int {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy hh:mm:ss"
        dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
        
        var thisMuch: Int = 0
       
        if byYears {
            thisMuch = -1 * this.distance(from: that, only: .year)
        }
        if byMonths {
            thisMuch = -1 * this.distance(from: that, only: .month)
        }
        if byDays {
            thisMuch = -1 * this.distance(from: that, only: .day)
        }
        
        return thisMuch
    }
    
    
    func howManyDaysDoesCurrentMonthHave() -> Int {
        let calendar = Calendar.current
        let date = Date()

        // Calculate start and end of the current year (or month with `.month`):
        let interval = calendar.dateInterval(of: .month, for: date)! //change year it will no of days in a year , change it to month it will give no of days in a current month
        // Compute difference in days:
        let thisManyDays = calendar.dateComponents([.day], from: interval.start, to: interval.end).day!

        return thisManyDays
    }
    
    /* return the number of week of year of argument */
    func weekNumberOf(this: Date) -> Int {
        let calendar = Calendar.current
        let wNum = calendar.component(.weekOfYear, from: this)
        return wNum
    }
    
    /* return the current number of week in this year */
    func weekNumber() -> Int {
        let date = Date()
        let calendar = Calendar.current
        let wNum = calendar.component(.weekOfYear, from: date)
        return wNum
    }
    
    // MARK: – För att displaya rätt Day Name on the första 4 Button Start Page
    func dayNameOfWeek() -> String {
        let calendar = Calendar.current
        
        var dayOfWeek = "?"
        
        let components = calendar.dateComponents([.weekday], from: Date())
        
        if let weekday = components.weekday {
            let dayIndex = max(0, (weekday - 1) % 7)
            
            if dayIndex < calendar.weekdaySymbols.count {
                dayOfWeek = calendar.weekdaySymbols[dayIndex]
            }
        }
        
        return dayOfWeek
    }
    
    func dayNameOfThis(d: Date) -> String {
        let calendar = Calendar.current
        
        var dayOfWeek = "?"
        
        let components = calendar.dateComponents([.weekday], from: d)
        
        if let weekday = components.weekday {
            let dayIndex = max(0, (weekday - 1) % 7)
            
            if dayIndex < calendar.weekdaySymbols.count {
                dayOfWeek = calendar.weekdaySymbols[dayIndex]
            }
        }
        
        return dayOfWeek
    }
    
    
    func numberOfDaysBetween(_ from: Date,_ to: Date) -> Int {
        let calendar = Calendar.current
        //let numberOfDays = calendar.dateComponents([.day], from: from, to: to)
        
        return  calendar.numberOfDaysBetween(from, to)
    }
}


// MARK: – Make Date Comparable••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••
extension Date {
/*
    var dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "dd-MM-yyyy hh:mm:ss"
    //dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
    let smallerDate = dateFormatter.date(from: "01-01-2012 00:05:01")!
    let biggerDate  = dateFormatter.date(from: "03-12-2019 09:30:01")!
*/
    
    /*
        print(smallerDate.distance(from: biggerDate, only: .day))               // -2
        print(biggerDate.distance(from: smallerDate, only: .day))               // 2
        print(smallerDate.distance(from: biggerDate, only: .year))              // -7
        print(biggerDate.distance(from: smallerDate, only: .year))              // 7
        print(smallerDate.distance(from: biggerDate, only: .hour))              // -9
        print(biggerDate.distance(from: smallerDate, only: .hour))              // 9
    */
    func distance(from date: Date, only component: Calendar.Component, calendar: Calendar = .current) -> Int {
        let days1 = calendar.component(component, from: self)
        let days2 = calendar.component(component, from: date)
        return days1 - days2
    }
    
    /* todaysDate.
        print(biggerDate.fullDistance(from: smallerDate, resultIn: .day))       // Optional(-2893)
        print(smallerDate.fullDistance(from: biggerDate, resultIn: .year))      // Optional(7)
        print(biggerDate.fullDistance(from: smallerDate, resultIn: .year))      // Optional(7)
        print(smallerDate.fullDistance(from: biggerDate, resultIn: .hour))      // Optional(69441)
        print(biggerDate.fullDistance(from: smallerDate, resultIn: .hour))      // Optional(-69441)
    */
    func fullDistance(from date: Date, resultIn component: Calendar.Component, calendar: Calendar = .current) -> Int? {
        calendar.dateComponents([component], from: self, to: date).value(for: component)
    }
    
    
    /*
        print(smallerDate.hasSame(.day, as: biggerDate))                        // false
        print(biggerDate.hasSame(.second, as: smallerDate))                     // true
    */
    func hasSame(_ component: Calendar.Component, as date: Date) -> Bool {
        distance(from: date, only: component) == 0
    }
}


extension Calendar {
    func numberOfDaysBetween(_ from: Date,_ to: Date) -> Int {
        let fromDate = startOfDay(for: from)
        //let fromDate = from
        let toDate = startOfDay(for: to)
        //let toDate = to
        let numberOfDays = dateComponents([.day], from: fromDate, to: toDate)
        
        return numberOfDays.day!
    }
}
