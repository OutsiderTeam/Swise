//
//  WeekStore.swift
//  Swise
//
//  Created by Agfid Prasetyo on 20/07/23.
//

import Foundation

class WeekStore : ObservableObject {
    // Combined of all Weeks
    @Published var allWeeks : [WeekValue] = []
    
    // Current chosen date indicator
    @Published var currentDate : Date = Date()
    
    // Index indicator
    @Published var currentIndex : Int = 0
    @Published var indexToUpdate : Int = 0
    
    // Array of Weeks
    @Published var currentWeek: [Date] = []
    @Published var nextWeek : [Date] = []
    @Published var previousWeek : [Date] = []
    
    @Published var currentSugarCondition: [Int] = []
    @Published var nextSugarCondition: [Int] = []
    @Published var previousSugarCondition: [Int] = []

    // Initial append of weeks
    init() {
        fetchCurrentWeek()
        fetchPreviousNextWeek()
    }
    
    func fetchAll(items: [DataItem] = []) {
        fetchCurrentWeek(items: items)
        fetchPreviousNextWeek(items: items)
        appendAll()
    }
    
    func appendAll() {
        allWeeks.removeAll()
        var  newWeek = WeekValue(id: 0, date: currentWeek, sugarCondition: currentSugarCondition)
        allWeeks.append(newWeek)
        
        newWeek = WeekValue(id: 2, date: nextWeek, sugarCondition: nextSugarCondition)
        allWeeks.append(newWeek)
        
        newWeek = WeekValue(id: 1, date: previousWeek, sugarCondition: previousSugarCondition)
        allWeeks.append(newWeek)
    }
    
    func update(index : Int, items: [DataItem] = []) {
        var value : Int = 0
        if index < currentIndex {
            value = 1
            if indexToUpdate ==  2 {
                indexToUpdate = 0
            } else {
                indexToUpdate = indexToUpdate + 1
            }
        } else {
            value = -1
            if indexToUpdate ==  0{
                indexToUpdate = 2
            } else {
                indexToUpdate = indexToUpdate - 1
            }
        }
        currentIndex = index
        addWeek(index: indexToUpdate, value: value, items: items)
    }
    
    func addWeek(index: Int, value: Int, items: [DataItem] = []) {
        allWeeks[index].date.removeAll()
        allWeeks[index].sugarCondition.removeAll()
        var calendar = Calendar(identifier: .gregorian)
        let today = Calendar.current.date(byAdding: .day, value: 7 * value , to: self.currentDate)!
        self.currentDate = today
        
        calendar.firstWeekday = 7
        let startOfWeek = calendar.date(from: calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: today))!
        
        (1...7).forEach{ day in
            if let weekday = calendar.date(byAdding: .day, value: day, to: startOfWeek){
                allWeeks[index].sugarCondition.append(Int(items.filter {$0.date == weekday.formatted(date: .complete, time: .omitted)}.first?.sugarCondition ?? 3))
                allWeeks[index].date.append(weekday)
            }
        }
    }
    
    func isToday(date:Date)->Bool{
        let calendar = Calendar.current
        return calendar.isDate(currentDate, inSameDayAs: date)
    }
    
    
    func dateToString(date: Date,format: String)->String{
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: date)
    }
    
    func fetchCurrentWeek(items: [DataItem] = []){
        currentWeek.removeAll()
        currentSugarCondition.removeAll()
        let today = currentDate
        var calendar = Calendar(identifier: .gregorian)
    
        calendar.firstWeekday = 7
        let startOfWeek = calendar.date(from: calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: today))!
        
        (1...7).forEach{ day in
            if let weekday = calendar.date(byAdding: .day, value: day, to: startOfWeek){
                currentSugarCondition.append(Int(items.filter {$0.date == weekday.formatted(date: .complete, time: .omitted)}.first?.sugarCondition ?? 3))
                currentWeek.append(weekday)
            }
        }
    }
    
    func fetchPreviousNextWeek(items: [DataItem] = []){
        nextWeek.removeAll()
        nextSugarCondition.removeAll()
        
        let nextWeekToday = Calendar.current.date(byAdding: .day, value: 7, to: currentDate )!
        
        var calendar = Calendar(identifier: .gregorian)
        calendar.firstWeekday = 7
        
        let startOfWeekNext = calendar.date(from: calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: nextWeekToday))!
        
        (1...7).forEach{ day in
            if let weekday = calendar.date(byAdding: .day, value: day, to: startOfWeekNext){
                nextSugarCondition.append(Int(items.filter {$0.date == weekday.formatted(date: .complete, time: .omitted)}.first?.sugarCondition ?? 3))
                nextWeek.append(weekday)
            }
            
        }
        
        previousWeek.removeAll()
        previousSugarCondition.removeAll()
        let previousWeekToday = Calendar.current.date(byAdding: .day, value: -7, to: currentDate)!
        
        let startOfWeekPrev = calendar.date(from: calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: previousWeekToday))!
        
        (1...7).forEach{ day in
            if let weekday = calendar.date(byAdding: .day, value: day, to: startOfWeekPrev){
                previousSugarCondition.append(Int(items.filter {$0.date == weekday.formatted(date: .complete, time: .omitted)}.first?.sugarCondition ?? 3))
                previousWeek.append(weekday)
            }
        }
    }
}
