import Foundation

/// A collection that keeps a weak reference to each of its elements.
public struct WeakArray<T: AnyObject>: ExpressibleByArrayLiteral {

    private var boxes: [WeakBox<T>]

    public init() {
        boxes = []
    }

    public init(_ elements: [T?] = []) {
        boxes = elements.map(WeakBox.init)
    }

    public init(_ elements: T?...) {
        self.init(elements)
    }

    public init(arrayLiteral elements: T?...) {
        self.init(elements)
    }

    public mutating func removeReferencesOfDeallocatedObject() {
        boxes.removeAll(where: { box in
            box.weakObject == nil
        })
    }
}

extension WeakArray: Collection, BidirectionalCollection, MutableCollection, RangeReplaceableCollection {

    public typealias Index = Int

    public var startIndex: Index { boxes.startIndex }

    public var endIndex: Index { boxes.endIndex }

    public subscript(_ index: Index) -> T? {
        get {
            return boxes[index].weakObject
        }
        set {
            boxes[index].weakObject = newValue
        }
    }

    public func index(after i: Index) -> Index {
        return boxes.index(after: i)
    }

    public func index(before i: Index) -> Index {
        return boxes.index(before: i)
    }

    public mutating func replaceSubrange<C>(
        _ subrange: Range<Int>,
        with newElements: C
    ) where C: Collection,  C.Element == T? {
        boxes.replaceSubrange(subrange, with: newElements.map(WeakBox.init))
    }
}

extension WeakArray: Equatable where T: Equatable {

    public static func == (lhs: WeakArray<T>, rhs: WeakArray<T>) -> Bool {
        guard lhs.count == rhs.count else { return false }

        for (left, right) in  zip(lhs, rhs) {
            switch (left, right) {
            case (.none, .none):
                break
            case (.some(let leftWrapped), .some(let rightWrapped)):
                if leftWrapped != rightWrapped {
                    return false
                }
            case (.none, .some), (.some, .none):
                return false
            }
        }

        return true
    }
}

extension WeakArray: Hashable where T: Hashable {
    
    public func hash(into hasher: inout Hasher) {
        boxes.map(\.weakObject).hash(into: &hasher)
    }
}
