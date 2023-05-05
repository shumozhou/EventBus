struct ObserverInfo {
    weak var observer: AnyObject?
    var handler: Any
    var dispatchType: DispatchMode
}
