# CollectionExt

A package to provide both extended functions and features for handling collection-based data. 

## Table of Contents

- [WeakArray](#weakarray)

## WeakArray

The type `WeakArray` behaves almost like an array, except it does not retain the elements it manages.
Instead, it keeps a weak reference to each of its elements. 
`WeakArray` conforms to protocols of the collection family,
including `Collection`, `MutableCollection`, `BidirectionalCollection`, `RangeReplaceableCollection`.
This makes it support various kinds of methods you are already familiar with, 
such as `map(_:)`, `reversed()`, `replaceSubrange(_:with:)`, `removeAll(where:)`, and more.

In the circumstances where the array may keep a large number of references to objects that have been
deallocated from the memory, the method `removeReferencesOfDeallocatedObject()` is provided to
perform a clean-up for such case.