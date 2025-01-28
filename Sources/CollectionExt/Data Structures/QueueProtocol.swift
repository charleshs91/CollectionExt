public protocol QueueProtocol<Element> {
    associatedtype Element

    mutating func enqueue(_ element: Element)

    @discardableResult
    mutating func dequeue() -> Element?

    func peek() -> Element?
}
