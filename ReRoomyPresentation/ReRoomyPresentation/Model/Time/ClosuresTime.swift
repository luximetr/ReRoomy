import Foundation

internal class ClosuresTime: Time {
    
    public init(currentDeviceTime: @escaping () -> Date, currentDeviceCalendar: @escaping () -> Calendar, currentDeviceTimeZone: @escaping () -> TimeZone) {
        self._currentDeviceTime = currentDeviceTime
        self._currentDeviceCalendar = currentDeviceCalendar
        self._currentDeviceTimeZone = currentDeviceTimeZone
    }
    
    private let _currentDeviceTime: () -> Date
    public var currentDeviceTime: Date {
        return _currentDeviceTime()
    }
    
    private let _currentDeviceCalendar: () -> Calendar
    public var currentDeviceCalendar: Calendar {
        return _currentDeviceCalendar()
    }
    
    private let _currentDeviceTimeZone: () -> TimeZone
    public var currentDeviceTimeZone: TimeZone {
        return _currentDeviceTimeZone()
    }
    
    
}
