public struct Queue<T>: ExpressibleByArrayLiteral, QueueProtocol {

    private(set) var buffer: [T]

    private(set) var lowerBound: Int

    public var count: Int {
        buffer.endIndex - lowerBound
    }

    var elements: ArraySlice<T> {
        buffer.suffix(from: lowerBound)
    }

    public init() {
        self.buffer = []
        self.lowerBound = 0
    }

    public init(_ elements: [T]) {
        self.buffer = elements
        self.lowerBound = 0
    }

    public init(arrayLiteral elements: T...) {
        self.init(elements)
    }

    public mutating func enqueue(_ element: T) {
        buffer.append(element)
    }

    @discardableResult
    public mutating func dequeue() -> T? {
        guard lowerBound < buffer.endIndex else {
            return nil
        }

        let element = buffer[lowerBound]
        lowerBound += 1

        if needsCleanUp() {
            cleanUnusedSpaces(startIndex: lowerBound)
        }

        return element
    }

    public func peek() -> T? {
        guard lowerBound < buffer.endIndex else {
            return nil
        }

        return buffer[lowerBound]
    }

    private func needsCleanUp() -> Bool {
        buffer.count > 32 && lowerBound > buffer.count / 2
    }

    private mutating func cleanUnusedSpaces(startIndex: Int) {
        buffer = Array(buffer.suffix(from: startIndex))
        lowerBound = 0
    }
}

extension Queue: Equatable where T: Equatable {

    public static func == (lhs: Queue, rhs: Queue) -> Bool {
        lhs.elements == rhs.elements
    }
}

extension Queue: Hashable where T: Hashable {

    public func hash(into hasher: inout Hasher) {
        hasher.combine(elements)
    }
}
