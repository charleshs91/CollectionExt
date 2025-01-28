public protocol StackProtocol<Element> {
    associatedtype Element

    var top: Element? { get }

    mutating func push(_ element: Element)

    @discardableResult
    mutating func pop() -> Element?
}

extension Array: StackProtocol {

    public var top: Element? {
        return last
    }

    public mutating func push(_ element: Element) {
        append(element)
    }

    @discardableResult
    public mutating func pop() -> Element? {
        return popLast()
    }
}
