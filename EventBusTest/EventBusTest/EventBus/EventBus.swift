import Foundation
final class EventBus {
    //get global UI queue
    static private let mainQueue = DispatchQueue.main

    //get global background queue
    static private let backgroundQueue = DispatchQueue.global(qos: DispatchQoS.QoSClass.default)

    static private var observers = [ObserverInfo]()
    
    static private var lock = NSRecursiveLock()

    static func Register<T>(_ observer: AnyObject, dispatchType: DispatchMode = .UI, handler: @escaping (T) -> Void) {
        lock.lock()
        defer { lock.unlock() }
        observers.append(ObserverInfo(observer: observer, handler: handler, dispatchType: dispatchType))
    }

    static func UnRegister(_ observer: AnyObject) {
        lock.lock()
        defer { lock.unlock() }
        observers = observers.filter { $0.observer != nil && $0.observer !== observer }
    }

    static func Post<T>(_ event: T) {
        lock.lock()
        defer { lock.unlock() }
        for observer in observers {
            if let handler = observer.handler as? ((T) -> Void) {
                var queue: DispatchQueue

                switch observer.dispatchType {
                case .UI:
                    queue = mainQueue

                case .BACKGROUND:
                    queue = backgroundQueue
                }

                queue.async {
                    handler(event)
                }
            }
        }
    }

    static func DebugPrint() {
        lock.lock()
        defer { lock.unlock() }
        for observer in observers {
            print("observer.dynamicType:", type(of: observer.observer))
        }
    }

}
