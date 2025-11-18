import Foundation

public protocol Time {
    
    var currentDeviceTime: Date { get }
    var currentDeviceCalendar: Calendar { get }
    var currentDeviceTimeZone: TimeZone { get }
    
}
