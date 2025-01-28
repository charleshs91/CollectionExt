struct WeakBox<T: AnyObject> {

    weak var weakObject: T?

    init(_ weakObject: T?) {
        self.weakObject = weakObject
    }
}
