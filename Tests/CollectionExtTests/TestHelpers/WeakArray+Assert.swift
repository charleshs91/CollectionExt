import CollectionExt
import XCTest

extension WeakArray {
    func assertEachItemNotNil() {
        forEach { XCTAssertNotNil($0) }
    }

    func assertEachItemToBeNil() {
        forEach { XCTAssertNil($0) }
    }
}
