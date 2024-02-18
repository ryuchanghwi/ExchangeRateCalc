//
//  DateWork.swift
//  ExchangeRateCalcApp
//
//  Created by 류창휘 on 1/17/24.
//

import Foundation

enum DateConvertTypes {
    case yyyyMMddHHmm
    case yyyyMMdd
    case MMdd
}

struct DateWork {
    static func convertToString(_ date: Date, types: DateConvertTypes) -> String {
        let dateFormatter = DateFormatter()
        var returnValue = ""
        switch types {
        case .yyyyMMddHHmm:
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
            returnValue = dateFormatter.string(from: date)
            return returnValue
        case .yyyyMMdd:
            dateFormatter.dateFormat = "yyyy-MM-dd"
            returnValue = dateFormatter.string(from: date)
            return returnValue
        case .MMdd:
            dateFormatter.dateFormat = "MM-dd"
            returnValue = dateFormatter.string(from: date)
            return returnValue
        }
    }
    static func timestampToString(timeStamp: TimeInterval, types: DateConvertTypes) -> String {
        let date = Date(timeIntervalSince1970: timeStamp)
        let dateFormatter = DateFormatter()
        var returnValue = ""
        switch types {
        case .yyyyMMddHHmm:
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
            returnValue = dateFormatter.string(from: date)
            return returnValue
        case .yyyyMMdd:
            dateFormatter.dateFormat = "yyyy-MM-dd"
            returnValue = dateFormatter.string(from: date)
            return returnValue
        case .MMdd:
            dateFormatter.dateFormat = "MM-dd"
            returnValue = dateFormatter.string(from: date)
            return returnValue
        }
    }
}
struct DateWork2 {
    private static let dateFormatter = DateFormatter()
    func convertToString(_ date: Date, types: DateConvertTypes) -> String {
        var returnValue = ""
        switch types {
        case .yyyyMMddHHmm:
            DateWork2.dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
            returnValue = DateWork2.dateFormatter.string(from: date)
            return returnValue
        case .yyyyMMdd:
            DateWork2.dateFormatter.dateFormat = "yyyy-MM-dd"
            returnValue = DateWork2.dateFormatter.string(from: date)
            return returnValue
        case .MMdd:
            DateWork2.dateFormatter.dateFormat = "MM-dd"
            returnValue = DateWork2.dateFormatter.string(from: date)
            return returnValue
        }
    }
    func timestampToString(timeStamp: TimeInterval, types: DateConvertTypes) -> String {
        let date = Date(timeIntervalSince1970: timeStamp)
        var returnValue = ""
        switch types {
        case .yyyyMMddHHmm:
            DateWork2.dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
            returnValue = DateWork2.dateFormatter.string(from: date)
            return returnValue
        case .yyyyMMdd:
            DateWork2.dateFormatter.dateFormat = "yyyy-MM-dd"
            returnValue = DateWork2.dateFormatter.string(from: date)
            return returnValue
        case .MMdd:
            DateWork2.dateFormatter.dateFormat = "MM-dd"
            returnValue = DateWork2.dateFormatter.string(from: date)
            return returnValue
        }
    }
}
