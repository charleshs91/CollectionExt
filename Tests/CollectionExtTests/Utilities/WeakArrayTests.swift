import CollectionExt
import Foundation
import XCTest

final class WeakArrayTests: XCTestCase {
    private class Ref: NSObject {}

    func test_init_withoutParameters() {
        let sut = WeakArray<Ref>()

        XCTAssertTrue(sut.isEmpty)
    }

    func test_init_withVariadicParameters() {
        let sut = WeakArray<Ref>(Ref(), Ref(), Ref())

        XCTAssertEqual(sut.count, 3)
        XCTAssertEqual(sut, [nil, nil, nil])
    }

    func test_init_withArrayLiteral() {
        let keptItem = Ref()
        let sut: WeakArray<Ref> = [keptItem, Ref(), Ref()]

        XCTAssertEqual(sut.count, 3)
        XCTAssertEqual(sut, [keptItem, nil, nil])
    }

    func test_equatable() {
        let items1 = makeRefs()
        let items2 = makeRefs()

        let sut1 = WeakArray(items1)
        let sut2 = WeakArray(items2)

        XCTAssertNotEqual(items1, items2)
        XCTAssertNotEqual(sut1, sut2)
        XCTAssertNotEqual(sut1, [])

        let allNils = [Ref?](repeating: nil, count: items2.count)
        XCTAssertNotEqual(sut2, WeakArray(allNils))
    }

    func test_twoArraysWithSameLengthAndAllDeallocatedReferences_shouldBeEqual() {
        let sut1 = WeakArray<Ref>(makeRefs())
        let sut2 = WeakArray<Ref>(makeRefs())

        sut1.assertEachItemToBeNil()
        sut2.assertEachItemToBeNil()
        XCTAssertEqual(sut1, sut2)
    }

    func test_cleanUp() {
        let keptItem = Ref()
        var sut: WeakArray<Ref> = [keptItem, Ref(), Ref()]
        sut.removeReferencesOfDeallocatedObject()

        XCTAssertEqual(sut, [keptItem])
    }

    func test_count_shouldMatchTheFormerArray() {
        let items = makeRefs()
        let sut = WeakArray(items)

        XCTAssertEqual(sut.count, 5)
    }

    func test_isEmpty_returnTrueWhenPassingAnEmptyArray() {
        let sut = WeakArray<Ref>([])

        XCTAssertTrue(sut.isEmpty)
    }

    func test_isEmpty_returnFalseWhenPassingAnArrayWithAtLeastOneItem() {
        let sut = WeakArray<Ref>([Ref()])

        XCTAssertFalse(sut.isEmpty)
    }

    func test_iteration() {
        let items = makeRefs()
        let sut = WeakArray(items)

        sut.assertEachItemNotNil()
    }

    func test_weakReference() {
        var items: [Ref]? = makeRefs()
        let sut = WeakArray(items!)
        items = nil

        sut.assertEachItemToBeNil()
    }

    func test_reversed() {
        let items = makeRefs()
        let sut = WeakArray(items)

        XCTAssert(sut.reversed().first! === items.last)
    }

    func test_arrayIsMutable() {
        let items = makeRefs()
        var sut = WeakArray(items)

        let anotherItem = Ref()
        sut[2] = anotherItem

        XCTAssert(sut[2] === anotherItem)
    }

    func test_mutableAndWeakReference() {
        let items = makeRefs()
        var sut = WeakArray(items)

        var anotherItem: Ref? = Ref()
        sut[2] = anotherItem
        anotherItem = nil

        XCTAssertNil(sut[2])
    }

    func test_replaceSubrange() {
        let refs = makeRefs(n: 10)
        var sut = WeakArray(refs)

        let replacingRefs = makeRefs(n: 5)
        sut.replaceSubrange(0..<replacingRefs.count, with: replacingRefs)

        var newRefs = replacingRefs
        newRefs.append(contentsOf: refs.suffix(5))
        XCTAssertEqual(sut, WeakArray(newRefs))
    }

    func test_hashable() {
        let items: [Ref?] = makeRefs()
        let sut = WeakArray(items)

        XCTAssertEqual(items.hashValue, sut.hashValue)
    }

    private func makeRefs(n: Int = 5) -> [Ref] {
        (0 ..< n).map { _ in Ref() }
    }
}
