extension Array {

    @inlinable
    public mutating func mutate(
        transform: (inout Element) -> Void
    ) {
        for (index, element) in enumerated() {
            var element = element
            transform(&element)
            self[index] = element
        }
    }

    @inlinable
    public mutating func mutate(
        where predicate: (Element) -> Bool,
        transform: (inout Element) -> Void
    ) {
        for (index, element) in enumerated() where predicate(element) {
            var element = element
            transform(&element)
            self[index] = element
        }
    }

    @inlinable
    public mutating func mutate(
        ifEqualTo other: Element,
        transform: (inout Element) -> Void
    ) where Element: Equatable {
        mutate(where: { $0 == other }, transform: transform)
    }

    @inlinable
    public mutating func mutate(
        ifEqualToAny candidates: [Element],
        transform: (inout Element) -> Void
    ) where Element: Equatable {
        mutate(where: { candidates.contains($0) }, transform: transform)
    }
}
