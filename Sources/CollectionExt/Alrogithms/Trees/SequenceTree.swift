/// A protocol that represents a tree structure backed by a `SequenceTreeNode`.
/// This protocol provides a higher-level abstraction over tree-like data structures
/// while conforming to `TreeTraversable` for search operations.
public protocol SequenceTree<Element>: TreeTraversable {

    /// The type of elements stored in the tree.
    associatedtype Element

    /// The underlying tree node that represents the root of this tree structure.
    /// This property provides access to the concrete implementation of the tree.
    var treeNode: SequenceTreeNode<Element> { get }
}

extension SequenceTree {

    /// Default implementation of depth-first search that delegates to the underlying tree node.
    ///
    /// This implementation provides a convenient wrapper around the `SequenceTreeNode`'s
    /// depth-first search functionality, maintaining the same behavior while abstracting
    /// away the concrete implementation details.
    ///
    /// - Parameter predicate: A closure that takes an element and returns a boolean indicating
    ///                        whether the element matches the search criteria.
    /// - Returns: The first element that satisfies the predicate, or nil if no match is found.
    /// - Throws: Rethrows any errors that the predicate closure might throw.
    @inlinable
    public func depthFirstSearch(_ predicate: (Element) throws -> Bool) rethrows -> Element? {
        try treeNode.depthFirstSearch(predicate)
    }

    /// Default implementation of breadth-first search that delegates to the underlying tree node.
    ///
    /// This implementation provides a convenient wrapper around the `SequenceTreeNode`'s
    /// breadth-first search functionality, maintaining the same behavior while abstracting
    /// away the concrete implementation details.
    ///
    /// - Parameter predicate: A closure that takes an element and returns a boolean indicating
    ///                        whether the element matches the search criteria.
    /// - Throws: Rethrows any errors that the predicate closure might throw.
    /// - Returns: The first element that satisfies the predicate, or nil if no match is found.
    @inlinable
    public func breadthFirstSearch(_ predicate: (Element) throws -> Bool) rethrows -> Element? {
        try treeNode.breadthFirstSearch(predicate)
    }
}
