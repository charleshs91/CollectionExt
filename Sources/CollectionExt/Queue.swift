public struct Queue<T> {
    private(set) var backingStore: [T]
    private(set) var lowerBound: Int

    public var count: Int {
        backingStore.endIndex - lowerBound
    }

    var effectiveElements: ArraySlice<T> {
        backingStore.suffix(from: lowerBound)
    }

    public init() {
        backingStore = []
        lowerBound = 0
    }

    public mutating func enqueue(_ element: T) {
        backingStore.append(element)
    }

    @discardableResult
    public mutating func dequeue() -> T? {
        guard lowerBound < backingStore.endIndex else {
            return nil
        }

        let element = backingStore[lowerBound]
        lowerBound += 1

        if needsCleanUp() {
            cleanUnusedSpaces(startIndex: lowerBound)
        }

        return element
    }

    private func needsCleanUp() -> Bool {
        backingStore.count > 32 && lowerBound > backingStore.count / 2
    }

    private mutating func cleanUnusedSpaces(startIndex: Int) {
        backingStore = Array(backingStore.suffix(from: startIndex))
        lowerBound = 0
    }
}

extension Queue: Equatable where T: Equatable {
    public static func == (lhs: Queue, rhs: Queue) -> Bool {
        lhs.effectiveElements == rhs.effectiveElements
    }
}

extension Queue: Hashable where T: Hashable {
    public func hash(into hasher: inout Hasher) {
        hasher.combine(effectiveElements)
    }
}
