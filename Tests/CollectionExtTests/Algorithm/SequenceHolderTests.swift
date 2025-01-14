#if canImport(UIKit)
import CollectionExt
import UIKit
import XCTest

final class SequenceHolder_DepthFirstSearchTests: XCTestCase {
    private var rootView: UIView!
    private var stackView: UIStackView!
    private var secondStackView: UIStackView!

    override func setUp() {
        super.setUp()

        rootView = .init()
        stackView = .init()
        secondStackView = .init()

        rootView.addSubview(stackView)
        rootView.addSubview(UIButton())
        rootView.addSubview(UITextView())
        stackView.addArrangedSubview(UIButton())
        stackView.addArrangedSubview(UILabel())
        stackView.addArrangedSubview(secondStackView)
        secondStackView.addArrangedSubview(UITextField())
    }

    func test_match_variant1() {
        let result = rootView.depthFirstSearch { view in
            view is UILabel
        }
        XCTAssertNotNil(result)
        XCTAssertEqual(result?.superview, stackView)
    }

    func test_match_variant2() {
        let result = rootView.depthFirstSearch { view in
            view is UITextField
        }
        XCTAssertNotNil(result)
        XCTAssertEqual(result?.superview, secondStackView)
    }

    func test_match_variant3() {
        let result = rootView.depthFirstSearch { view in
            view is UITextView
        }
        XCTAssertNotNil(result)
        XCTAssertEqual(result?.superview, rootView)
    }

    func test_noMatch() {
        let result = rootView.depthFirstSearch { view in
            view is UIProgressView
        }
        XCTAssertNil(result)
    }

    func test_rootBeIncluded() {
        let result = rootView.depthFirstSearch { view in
            view === rootView
        }
        XCTAssertNotNil(result)
    }
}

final class SequenceHolder_BreadthFirstSearchTests: XCTestCase {
    private var rootView: UIView!
    private var stackView: UIStackView!
    private var secondStackView: UIStackView!

    override func setUp() {
        super.setUp()

        rootView = UIView()
        stackView = UIStackView()
        secondStackView = UIStackView()

        rootView.addSubview(stackView)
        rootView.addSubview(UIImageView())
        rootView.addSubview(UIButton())
        stackView.addArrangedSubview(UIButton())
        stackView.addArrangedSubview(UILabel())
        stackView.addArrangedSubview(secondStackView)
        secondStackView.addArrangedSubview(UILabel())
        secondStackView.addArrangedSubview(UITextField())
    }

    func test_match_variant1() {
        let result = rootView.breadthFirstSearch { view in
            view is UILabel
        }
        XCTAssertNotNil(result)
        XCTAssertEqual(result?.superview, stackView)
    }

    func test_match_variant2() {
        let result = rootView.breadthFirstSearch { view in
            view is UITextField
        }
        XCTAssertNotNil(result)
        XCTAssertEqual(result?.superview, secondStackView)
    }

    func test_match_variant3() {
        let result = rootView.breadthFirstSearch { view in
            view is UIImageView
        }
        XCTAssertNotNil(result)
        XCTAssertEqual(result?.superview, rootView)
    }

    func test_noMatch() {
        let result = rootView.breadthFirstSearch { view in
            view is UIProgressView
        }
        XCTAssertNil(result)
    }

    func test_rootBeIncluded() {
        let result = rootView.breadthFirstSearch { view in
            view === rootView
        }
        XCTAssertNotNil(result)
    }
}

#endif
