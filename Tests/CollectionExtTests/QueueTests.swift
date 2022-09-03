import CollectionExt
import XCTest

final class QueueTests: XCTestCase {
    func test_init() {
        var numQueue = Queue<Int>()
        XCTAssertNil(numQueue.dequeue())
    }

    func test_count() {
        let randomNumbers = (0 ..< 100).map { _ in Int(arc4random_uniform(100)) }
        var sut: Queue<Int> = randomNumbers.convertToQueue()

        sut.dequeue(times: 90)

        XCTAssertEqual(sut.count, 10)
    }

    func test_enqueueAndDequeue() {
        let randomNumbers = (0 ..< 100).map { _ in Int(arc4random_uniform(100)) }

        var sut = Queue<Int>()
        for num in randomNumbers {
            sut.enqueue(num)
        }

        for num in randomNumbers {
            XCTAssertEqual(sut.dequeue(), num)
        }
    }

    func test_equatable() {
        var sut1: Queue<Int> = [0, 0, 1, 2, 3].convertToQueue()
        let sut2: Queue<Int> = [0, 1, 2, 3].convertToQueue()

        sut1.dequeue()

        XCTAssertEqual(sut1, sut2)
    }
}

private extension Array {
    func convertToQueue() -> Queue<Element> {
        reduce(into: Queue<Element>()) { queue, elem in
            queue.enqueue(elem)
        }
    }
}

private extension Queue {
    mutating func dequeue(times: Int) {
        (0 ..< times).forEach { _ in dequeue() }
    }
}
