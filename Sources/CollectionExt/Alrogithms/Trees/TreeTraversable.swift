/// A protocol that defines requirements for types that can be traversed using tree-based search algorithms.
/// Types conforming to this protocol must implement both depth-first and breadth-first search capabilities.
///
/// This protocol is particularly useful for tree-like data structures where you need to search
/// through hierarchical data to find elements matching specific criteria.
public protocol TreeTraversable {

    /// The type of elements that can be found through traversal.
    associatedtype Element

    /// Searches for an element in the tree structure using a depth-first search algorithm.
    ///
    /// Depth-first search explores as far as possible along each branch before backtracking.
    /// This is particularly efficient for deep tree structures or when the target element
    /// is likely to be found deep in the tree.
    ///
    /// - Parameter predicate: A closure that takes an element and returns a boolean indicating
    ///                       whether the element matches the search criteria.
    /// - Returns: The first element that satisfies the predicate, or nil if no match is found.
    /// - Throws: Rethrows any errors that the predicate closure might throw.
    @inlinable
    func depthFirstSearch(_ predicate: (Element) throws -> Bool) rethrows -> Element?

    /// Searches for an element in the tree structure using a breadth-first search algorithm.
    ///
    /// Breadth-first search explores all nodes at the present depth before moving on to nodes
    /// at the next depth level. This is particularly efficient for shallow tree structures
    /// or when the target element is likely to be found near the root.
    ///
    /// - Parameter predicate: A closure that takes an element and returns a boolean indicating
    ///                       whether the element matches the search criteria.
    /// - Returns: The first element that satisfies the predicate, or nil if no match is found.
    /// - Throws: Rethrows any errors that the predicate closure might throw.
    @inlinable
    func breadthFirstSearch(_ predicate: (Element) throws -> Bool) rethrows -> Element?
}
