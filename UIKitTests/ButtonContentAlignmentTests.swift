//
//  ButtonContentAlignmentTests.swift
//  UIKitTests
//
//  Created by Chris on 12.07.17.
//  Copyright © 2017 flowkey. All rights reserved.
//

import XCTest
#if os(iOS)
    import UIKit
#else
    @testable import UIKit
#endif

class ButtonContentAlignmentTests: XCTestCase {
    let testButton = Button(frame: .zero)
    let buttonFrameSize = CGSize(width: 200, height: 100)
    let testImageSize = CGSize(width: 40, height: 40)

    override func setUp() {
        super.setUp()
        #if os(iOS)
            loadCustomFont(name: "Roboto-Medium", fontExtension: "ttf")
        #endif
    }
    
    override func tearDown() {
        super.tearDown()
    }

    func testContentAlignmentSetsCorrectly() {
        testButton.contentHorizontalAlignment = .left
        testButton.contentVerticalAlignment = .top
        XCTAssertEqual(testButton.contentHorizontalAlignment, .left)
        XCTAssertEqual(testButton.contentVerticalAlignment, .top)

        testButton.contentHorizontalAlignment = .right
        testButton.contentVerticalAlignment = .bottom
        XCTAssertEqual(testButton.contentHorizontalAlignment, .right)
        XCTAssertEqual(testButton.contentVerticalAlignment, .bottom)

        testButton.contentHorizontalAlignment = .center
        testButton.contentVerticalAlignment = .center
        XCTAssertEqual(testButton.contentHorizontalAlignment, .center)
        XCTAssertEqual(testButton.contentVerticalAlignment, .center)
    }

    func testDefaultContentAlignmentWithOnlyLabel() {
        testButton.setTitle(shortButtonText, for: .normal)
        testButton.titleLabel!.font = UIFont(name: "Roboto-Medium", size: smallFontSize)!
        testButton.frame = CGRect(origin: testButton.frame.origin, size: buttonFrameSize)
        testButton.layoutSubviews()

        XCTAssertEqual(testButton.contentHorizontalAlignment, .center)
        XCTAssertEqual(testButton.contentVerticalAlignment, .center)
        XCTAssertEqualWithAccuracy(testButton.titleLabel!.frame.origin.x, buttonFrameSize.width / 2 - testButton.titleLabel!.frame.width / 2, accuracy: 0.01)
        XCTAssertEqualWithAccuracy(testButton.titleLabel!.frame.origin.y, buttonFrameSize.height / 2 - testButton.titleLabel!.frame.height / 2, accuracy: 0.18)
    }

    func testTopLeftContentAlignmentWithOnlyLabel() {
        testButton.setTitle(shortButtonText, for: .normal)
        testButton.titleLabel!.font = UIFont(name: "Roboto-Medium", size: smallFontSize)!
        testButton.frame = CGRect(origin: testButton.frame.origin, size: buttonFrameSize)

        testButton.contentHorizontalAlignment = .left
        testButton.contentVerticalAlignment = .top
        testButton.layoutSubviews()

        XCTAssertEqual(testButton.titleLabel!.frame.origin.x, 0.0)
        XCTAssertEqual(testButton.titleLabel!.frame.origin.y, 0.0)
    }

    func testBottomRightContentAlignmentWithOnlyLabel() {
        testButton.setTitle(shortButtonText, for: .normal)
        testButton.titleLabel!.font = UIFont(name: "Roboto-Medium", size: smallFontSize)!
        testButton.frame = CGRect(origin: testButton.frame.origin, size: buttonFrameSize)

        testButton.contentHorizontalAlignment = .right
        testButton.contentVerticalAlignment = .bottom
        testButton.layoutSubviews()

        XCTAssertEqual(testButton.titleLabel!.frame.origin.x, buttonFrameSize.width - testButton.titleLabel!.frame.width)
        XCTAssertEqual(testButton.titleLabel!.frame.origin.y, buttonFrameSize.height - testButton.titleLabel!.frame.height)
    }

    func testDefaultContentAlignmentWithOnlyImage() {
        testButton.setImage(createTestImage(ofSize: testImageSize), for: .normal)
        testButton.frame = CGRect(origin: testButton.frame.origin, size: buttonFrameSize)
        testButton.layoutSubviews()

        XCTAssertEqual(testButton.contentHorizontalAlignment, .center)
        XCTAssertEqual(testButton.contentVerticalAlignment, .center)
        XCTAssertEqual(testButton.imageView!.frame.origin.x, buttonFrameSize.width / 2 - testImageSize.width / 2)
        XCTAssertEqual(testButton.imageView!.frame.origin.y, buttonFrameSize.height / 2 - testImageSize.height / 2)
    }

    func testTopLeftContentAlignmentOnlyWithImage() {
        testButton.setImage(createTestImage(ofSize: testImageSize), for: .normal)
        testButton.frame = CGRect(origin: testButton.frame.origin, size: buttonFrameSize)
        testButton.layoutSubviews()

        testButton.contentHorizontalAlignment = .left
        testButton.contentVerticalAlignment = .top
        testButton.layoutSubviews()

        XCTAssertEqual(testButton.imageView!.frame.origin.x, 0.0)
        XCTAssertEqual(testButton.imageView!.frame.origin.y, 0.0)
    }

    func testBottomRightContentAlignmentOnlyWithImage() {
        testButton.setImage(createTestImage(ofSize: testImageSize), for: .normal)
        testButton.frame = CGRect(origin: testButton.frame.origin, size: buttonFrameSize)
        testButton.layoutSubviews()

        testButton.contentHorizontalAlignment = .right
        testButton.contentVerticalAlignment = .bottom
        testButton.layoutSubviews()

        XCTAssertEqual(testButton.imageView!.frame.origin.x, buttonFrameSize.width  - testImageSize.width)
        XCTAssertEqual(testButton.imageView!.frame.origin.y, buttonFrameSize.height - testImageSize.height)
    }
    

    func testContentAlignmentWithLabelAndImage() {
        testButton.setTitle(shortButtonText, for: .normal)
        testButton.titleLabel!.font = UIFont(name: "Roboto-Medium", size: smallFontSize)!
        testButton.setImage(createTestImage(ofSize: testImageSize), for: .normal)
        testButton.frame = CGRect(origin: testButton.frame.origin, size: buttonFrameSize)
        testButton.layoutSubviews()

        XCTAssertEqual(testButton.contentHorizontalAlignment, .center)
        XCTAssertEqual(testButton.contentVerticalAlignment, .center)
        XCTAssertEqualWithAccuracy(testButton.imageView!.frame.origin.x, (buttonFrameSize.width - (testImageSize.width + testButton.titleLabel!.frame.width)) / 2, accuracy: 0.001)
        XCTAssertEqual(testButton.imageView!.frame.origin.y, buttonFrameSize.height / 2 - testImageSize.height / 2)
        XCTAssertEqualWithAccuracy(testButton.titleLabel!.frame.origin.x, (buttonFrameSize.width - testButton.titleLabel!.frame.width + testImageSize.width) / 2, accuracy: 0.001)
        XCTAssertEqualWithAccuracy(testButton.titleLabel!.frame.origin.y, (buttonFrameSize.height - testButton.titleLabel!.frame.height) / 2, accuracy: 0.17)
    }

    func testTopLeftContentAlignmentWithLabelAndImage() {
        testButton.setTitle(shortButtonText, for: .normal)
        testButton.titleLabel!.font = UIFont(name: "Roboto-Medium", size: smallFontSize)!
        testButton.setImage(createTestImage(ofSize: testImageSize), for: .normal)
        testButton.frame = CGRect(origin: testButton.frame.origin, size: buttonFrameSize)
        testButton.layoutSubviews()

        testButton.contentHorizontalAlignment = .left
        testButton.contentVerticalAlignment = .top
        testButton.layoutSubviews()

        XCTAssertEqual(testButton.imageView!.frame.origin.x, 0.0)
        XCTAssertEqual(testButton.imageView!.frame.origin.y, 0.0)
        XCTAssertEqualWithAccuracy(testButton.titleLabel!.frame.origin.x, testImageSize.width, accuracy: 0.001)
        XCTAssertEqual(testButton.titleLabel!.frame.origin.y, 0.0)
    }

    func testBottomRightContentAlignmentWithLabelAndImage() {
        testButton.setTitle(shortButtonText, for: .normal)
        testButton.titleLabel!.font = UIFont(name: "Roboto-Medium", size: smallFontSize)!
        testButton.setImage(createTestImage(ofSize: testImageSize), for: .normal)
        testButton.frame = CGRect(origin: testButton.frame.origin, size: buttonFrameSize)
        testButton.layoutSubviews()

        testButton.contentHorizontalAlignment = .right
        testButton.contentVerticalAlignment = .bottom
        testButton.layoutSubviews()

        XCTAssertEqualWithAccuracy(testButton.imageView!.frame.origin.x, buttonFrameSize.width - testButton.titleLabel!.frame.width - testImageSize.width, accuracy: 0.1)
        XCTAssertEqual(testButton.imageView!.frame.origin.y, buttonFrameSize.height - testImageSize.height)
        XCTAssertEqual(testButton.titleLabel!.frame.origin.x, buttonFrameSize.width - testButton.titleLabel!.frame.width)
        XCTAssertEqual(testButton.titleLabel!.frame.origin.y, buttonFrameSize.height - testButton.titleLabel!.frame.height)
    }

}
