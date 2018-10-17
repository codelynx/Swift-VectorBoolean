//
//  Swift_VectorBooleanTests.swift
//  Swift VectorBooleanTests
//
//  Created by Leslie Titze on 2015-07-07.
//  Copyright (c) 2015 Startside Softworks. All rights reserved.
//

import UIKit
import XCTest

extension CGPath {

    func forEach( body: @escaping @convention(block) (CGPathElement) -> Void) {
        typealias Body = @convention(block) (CGPathElement) -> Void
        let callback: @convention(c) (UnsafeMutableRawPointer, UnsafePointer<CGPathElement>) -> Void = { (info, element) in
            let body = unsafeBitCast(info, to: Body.self)
            body(element.pointee)
        }
        let unsafeBody = unsafeBitCast(body, to: UnsafeMutableRawPointer.self)
        self.apply(info: unsafeBody, function: unsafeBitCast(callback, to: CGPathApplierFunction.self))
    }
}

class Swift_VectorBooleanTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func convertToString(bezier:UIBezierPath) -> String {
        var pathString = ""
        
        let numFormat = "%.6g"
        
        bezier.cgPath.forEach { (element: CGPathElement) in



            switch element.type {
            case .moveToPoint:
                pathString += String(format: "M\(numFormat),\(numFormat) ", arguments: [element.points[0].x, element.points[0].y])
            case .addLineToPoint: // contains 1 point
                pathString += String(format: "L\(numFormat),\(numFormat) ", arguments: [element.points[0].x, element.points[0].y])
            case .addQuadCurveToPoint: // contains 2 points
                pathString += String(format: "Q\(numFormat),\(numFormat) \(numFormat),\(numFormat) ", arguments: [element.points[0].x, element.points[0].y, element.points[1].x, element.points[1].y])
            case .addCurveToPoint: // contains 3 points
                pathString += String(format: "C\(numFormat),\(numFormat) \(numFormat),\(numFormat) \(numFormat),\(numFormat) ", arguments: [element.points[0].x, element.points[0].y, element.points[1].x, element.points[1].y, element.points[2].x, element.points[2].y])
            case .closeSubpath:
                pathString += "Z "
            default:
                print("element type not supported")
                break
            }
        }
        
        return pathString
    }
    
    func testShapes() {
        let shapeData = TestShapeData()
        
        shapeData.shapes.forEach { (testShape) in
            print("Test Shape: " + testShape.label)
            
            let unionPath = testShape.other().fb_union(testShape.top())
            let unionString = convertToString(bezier: unionPath)
            
            if let unionDesiredString = testShape.unionDesiredString {
                XCTAssert(unionString == unionDesiredString, "Union Strings Don't Match")
            } else {
                print("Missing Reference Strings: ")
                print("---")
                print("unionDesiredString = \"" + unionString + "\"")
            }
            
            let intersectPath = testShape.other().fb_intersect(testShape.top())
            let intersectString = convertToString(bezier: intersectPath)
            
            if let intersectDesiredString = testShape.intersectDesiredString {
                XCTAssert(intersectString == intersectDesiredString, "Intersect Strings Don't Match")
            } else {
                print("intersectDesiredString = \"" + intersectString + "\"")
            }
            
            let differencePath = testShape.other().fb_difference(testShape.top())
            let differenceString = convertToString(bezier: differencePath)
            
            if let differenceDesiresString = testShape.differenceDesiresString {
                XCTAssert(differenceString == differenceDesiresString, "Difference Strings Don't Match")
            } else {
                print("differenceDesiresString = \"" + differenceString + "\"")
                print("---")
            }
        }
    }
}
