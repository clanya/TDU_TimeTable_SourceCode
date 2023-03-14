//
//  Week.swift
//  Timetable
//
//  Created by 谷田和基 on 2022/05/19.
//

enum Week: String{
    case Monday = "Monday"
    case Tuesday = "Tuesday"
    case Wednesday = "Wednesday"
    case Thursday = "Thursday"
    case Friday = "Friday"
    case Saturday = "Saturday"
    case Sunday = "Sunday"
    
    init(_ E :Int){
        switch E{
        case 0: self = .Monday
        case 1: self = .Tuesday
        case 2: self = .Wednesday
        case 3: self = .Thursday
        case 4: self = .Friday
        case 5: self = .Saturday
        case 6: self = .Sunday
        default: fatalError("Illegal weekday string \"\(E)\"")
        }
    }
    init(_ E :String){
            switch E {
                case "Mon": self = .Monday
                case "Tue": self = .Tuesday
                case "Wed": self = .Wednesday
                case "Thu": self = .Thursday
                case "Fri": self = .Friday
                case "Sat": self = .Saturday
                case "Sun": self = .Sunday
                default: fatalError("Illegal weekday string \"\(E)\"")
            }
        }

        var order: Int {
            switch self {
                case .Monday:    return 1
                case .Tuesday:   return 2
                case .Wednesday: return 3
                case .Thursday:  return 4
                case .Friday:    return 5
                case .Saturday:  return 6
                case .Sunday:    return 7
            }
        }
}
