//
//  Date.swift
//  NewsDemo
//
//  Created by Khangembam Deepalaxmi Devi on 20/12/18.
//  Copyright © 2018 Khangembam Deepalaxmi Devi. All rights reserved.
//

import Foundation

extension Date {
    
    func getElapsedInterval() -> String? {
        
        let interval = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: self, to: Date())
        
        if let year = interval.year, year > 0 {
            return nil
        } else if let month = interval.month, month > 0 {
            return nil
        } else if let day = interval.day, day > 0 {
            return nil
        } else if let hour = interval.hour, hour > 0 {
            return nil
        } else if let minute = interval.minute, minute > 0 {
            return minute == 1 ? "\(minute)" + " " + "MINUTE AGO " :
                "\(minute)" + " " + "MINUTES AGO"
        } else if let second = interval.second, second > 0 {
            return second == 1 ? "\(second)" + " " + "SECOND AGO" :
                "\(second)" + " " + "SECONDS AGO"
        } else {
            return "a moment"
        }
        
    }
}
