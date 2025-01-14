/// A generic tree node structure that supports depth-first and breadth-first traversal.
/// Each node contains a value and can have multiple children nodes.
public struct SequenceTreeNode<Element>: TreeTraversable {

    /// The value stored in this node.
    public let value: Element

    /// A sequence of child nodes connected to this node.
    /// Each child is also a SequenceTreeNode containing the same element type.
    public let children: any Sequence<Self>

    /// Creates a new tree node with the specified value and children.
    ///
    /// - Parameters:
    ///   - value: The value to store in this node.
    ///   - children: A sequence of child nodes. Can be empty for leaf nodes.
    public init(value: Element, children: any Sequence<Self>) {
        self.value = value
        self.children = children
    }

    /// Performs a depth-first search through the tree to find a value that matches
    /// the given evaluation criteria.
    ///
    /// DFS traverses down each branch of the tree to its leaves before backtracking.
    /// The search evaluates the current node first, then recursively searches through
    /// its children.
    ///
    /// - Parameter evaluate: A closure that determines if the current value matches
    ///                      the search criteria.
    /// - Returns: The first value that satisfies the evaluation criteria, or nil if
    ///           no matching value is found.
    /// - Throws: Rethrows any errors that the evaluation closure might throw.
    ///
    /// - Complexity: O(n) where n is the total number of nodes in the tree.
    @inlinable
    public func depthFirstSearch(_ evaluate: (Element) throws -> Bool) rethrows -> Element? {
        if try evaluate(value) {
            return value
        }

        for node in children {
            if let match = try node.depthFirstSearch(evaluate) {
                return match
            }
        }

        return nil
    }

    /// Performs a breadth-first search through the tree to find a value that matches
    /// the given evaluation criteria.
    ///
    /// BFS traverses the tree level by level, examining all nodes at the current depth
    /// before moving to nodes at the next depth. This implementation uses a queue to
    /// maintain the order of traversal.
    ///
    /// - Parameter evaluate: A closure that determines if the current value matches
    ///                      the search criteria.
    /// - Returns: The first value that satisfies the evaluation criteria, or nil if
    ///           no matching value is found.
    /// - Throws: Rethrows any errors that the evaluation closure might throw.
    ///
    /// - Complexity: O(n) where n is the total number of nodes in the tree.
    @inlinable
    public func breadthFirstSearch(_ evaluate: (Element) throws -> Bool) rethrows -> Element? {
        var queue: Queue<Self> = .init()
        queue.enqueue(self)

        while let item = queue.dequeue() {
            if try evaluate(item.value) {
                return item.value
            }

            item.children.forEach {
                queue.enqueue($0)
            }
        }

        return nil
    }
}
