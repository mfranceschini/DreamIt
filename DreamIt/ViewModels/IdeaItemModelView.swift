//
//  IdeaItemModelView.swift
//  DreamIt
//
//  Created by Matheus Franceschini on 2020-11-12.
//

import SwiftUI
import Foundation
import Combine

extension Double {
    func reduceScale(to places: Int) -> Double {
        let multiplier = pow(10, Double(places))
        let newDecimal = multiplier * self // move the decimal right
        let truncated = Double(Int(newDecimal)) // drop the fraction
        let originalDecimal = truncated / multiplier // move the decimal back
        return originalDecimal
    }
}

struct IdeaItemModelView: Identifiable {
    
    public var id: String {
        ideaItem.id
    }
    
    static func == (lhs: IdeaItemModelView, rhs: IdeaItemModelView) -> Bool {
        return lhs.title == rhs.title
    }
    
    var ideaItem: IdeaItemModel
    private let calendar: Calendar
    
    init(ideaItem: IdeaItemModel, calendar: Calendar = Calendar(identifier: .gregorian)) {
        self.ideaItem = ideaItem
        self.calendar = calendar
    }
    
    public var title: String {
        ideaItem.title
    }
    
    public var author: String {
        ideaItem.author
    }
    
    public var description: String {
        ideaItem.description
    }
    
    public var liked: Bool {
        get {
            ideaItem.liked
        }
        set {
            ideaItem.liked = newValue
        }
    }
    
    public var category: Int {
        ideaItem.category
    }
    
    public var thumbnail: UIImage {
        switch ideaItem.category {
        case 1:
            //Mobile Apps
            return UIImage(named: "smartphone")!
        case 2:
            //Websites
            return UIImage(named: "website")!
        case 3:
            //UX Design
            return UIImage(named: "ux")!
        case 4:
            //Video Maker
            return UIImage(named: "video")!
        case 5:
            //Drawing
            return UIImage(named: "drawing")!
        default:
            return UIImage()
        }
    }
    
    public var postDate: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy'-'MM'-'dd'T'HH':'mm':'ssZZZ"
        guard let date = dateFormatter.date(from: ideaItem.createdAt) else { return "now" }
        let today = calendar.startOfDay(for: Date())
        let createDate = calendar.startOfDay(for: date)
        let components = calendar.dateComponents([.year, .month, .day, .minute, .hour], from: createDate, to: today)
        
        if let year = components.year {
            if year > 0 {
                return "\(year) year(s) ago"
            }
        }
        if let month = components.month {
            if month > 0 {
                return "\(month) month(s) ago"
            }
        }
        if let day = components.day {
            if day > 0 {
                return "\(day) day(s) ago"
            }
        }
        if let hour = components.hour {
            if hour > 0 {
                return "\(hour) hour(s) ago"
            }
        }
        if let minute = components.minute {
            if minute > 0 {
                return "\(minute) minute(s) ago"
            }
        }
        return "now"
    }
    
    public var impressions: String {
        return formatNumber(ideaItem.impressions)
    }

    private func formatNumber(_ n: Int) -> String {
        let num = abs(Double(n))
        let sign = (n < 0) ? "-" : ""

        switch num {
        case 1_000_000_000...:
            var formatted = num / 1_000_000_000
            formatted = formatted.reduceScale(to: 1)
            return "\(sign)\(formatted)B"

        case 1_000_000...:
            var formatted = num / 1_000_000
            formatted = formatted.reduceScale(to: 1)
            return "\(sign)\(formatted)M"

        case 1_000...:
            var formatted = num / 1_000
            formatted = formatted.reduceScale(to: 1)
            return "\(sign)\(formatted)K"

        case 0...:
            return "\(n)"

        default:
            return "\(sign)\(n)"
        }
    }
    
    mutating func setIdeaLike() {
        ideaItem.liked.toggle()
    }
    
    mutating func setImpressions(newValue: Int) {
        ideaItem.impressions = newValue
    }
}
