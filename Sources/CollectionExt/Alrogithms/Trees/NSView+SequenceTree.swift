#if canImport(Cocoa)
import Cocoa

extension NSView: SequenceTree {

    /// Creates a tree node representation of the current view hierarchy.
    ///
    /// This property provides a tree structure where:
    /// - The current view becomes the root node
    /// - Each subview becomes a child node
    /// - The hierarchy is preserved recursively through all subviews
    ///
    /// - Returns: A SequenceTreeNode representing this view and its subview hierarchy.
    public var treeNode: SequenceTreeNode<NSView> {
        SequenceTreeNode(value: self, children: children)
    }

    private var children: any Sequence<SequenceTreeNode<NSView>> {
        subviews.map(\.treeNode)
    }
}

#endif
