import Foundation

public extension Array {
    mutating func mutate(_ transform: (inout Element) -> Void) {
        for (index, element) in enumerated() {
            var element = element
            transform(&element)
            self[index] = element
        }
    }

    mutating func mutate(
        where predicate: (Element) -> Bool,
        _ transform: (inout Element) -> Void
    ) {
        for (index, element) in enumerated() where predicate(element) {
            var element = element
            transform(&element)
            self[index] = element
        }
    }

    mutating func mutate(
        ifEqualTo other: Element,
        _ transform: (inout Element) -> Void
    ) where Element: Equatable {
        mutate(where: { $0 == other }, transform)
    }

    mutating func mutate(
        ifEqualToAny candidates: [Element],
        _ transform: (inout Element) -> Void
    ) where Element: Equatable {
        mutate(where: { candidates.contains($0) }, transform)
    }
}
