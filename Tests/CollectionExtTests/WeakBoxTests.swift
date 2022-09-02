@testable import CollectionExt
import XCTest

final class WeakBoxTests: XCTestCase {
    private class Ref {}

    func test_init() {
        let ref = Ref()
        let sut = WeakBox<Ref>(ref)

        XCTAssertNotNil(sut.weakObject)
    }

    func test_weakReference() {
        var ref: Ref? = Ref()
        let sut = WeakBox<Ref>(ref!)
        ref = nil

        XCTAssertNil(sut.weakObject)
    }
}
