import CollectionExt
import Foundation
import XCTest

final class ArrayMutateTests: XCTestCase {
    func test_mutate() {
        var students = Student.makeTestData()
        students.mutate {
            if !$0.hasSkippedClasses {
                $0.increaseScore(by: 20)
            }
        }

        XCTAssertEqual(students.map(\.score), [71, 80, 67, 87, 100])
    }

    func test_mutate_withPredicate() {
        var students = Student.makeTestData()
        students.mutate(where: {
            !$0.hasSkippedClasses
        }) {
            $0.increaseScore(by: 20)
        }

        XCTAssertEqual(students.map(\.score), [71, 80, 67, 87, 100])
    }

    func test_mutate_ifEqualTo() {
        var students = Student.makeTestData()
        students.mutate(ifEqualTo: students[0]) {
            $0.score = 0
        }

        XCTAssertEqual(students.map(\.score), [0, 60, 47, 87, 95])
    }

    func test_mutate_ifEqualToAny() {
        var students = Student.makeTestData()
        students.mutate(ifEqualToAny: students.filter(\.hasSkippedClasses)) {
            $0.score = 0
        }

        XCTAssertEqual(students.map(\.score), [0, 60, 47, 0, 95])
    }
}

extension ArrayMutateTests {
    struct Student: Equatable {
        static func == (lhs: Student, rhs: Student) -> Bool {
            lhs.name == rhs.name && lhs.hasSkippedClasses == rhs.hasSkippedClasses
        }

        static func makeTestData() -> [Student] {
            [
                Student(name: "Elle", score: 71, hasSkippedClasses: true),
                Student(name: "Dodo", score: 60, hasSkippedClasses: false),
                Student(name: "Charles", score: 47, hasSkippedClasses: false),
                Student(name: "Bill", score: 87, hasSkippedClasses: true),
                Student(name: "Alice", score: 95, hasSkippedClasses: false),
            ]
        }

        let name: String
        var score: Int
        var hasSkippedClasses: Bool

        mutating func increaseScore(by increment: Int) {
            score = min(score + increment, 100)
        }
    }
}
