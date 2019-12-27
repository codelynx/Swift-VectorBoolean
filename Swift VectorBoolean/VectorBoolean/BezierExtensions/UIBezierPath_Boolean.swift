//
//  UIBezierPath_Boolean.swift
//  Swift VectorBoolean for iOS
//
//  Based on NSBezierPath+Boolean - Created by Andrew Finnell on 5/31/11.
//  Copyright 2011 Fortunate Bear, LLC. All rights reserved.
//
//  Created by Leslie Titze on 2015-05-19.
//  Copyright (c) 2015 Leslie Titze. All rights reserved.

import UIKit

public extension UIBezierPath {
    
    // 15
    //- (NSBezierPath *) fb_union:(NSBezierPath *)path
    @objc func fb_union(_ path: UIBezierPath) -> UIBezierPath {
        let thisGraph = FBBezierGraph(path: self)
        let otherGraph = FBBezierGraph(path: path)
        
        let resultGraph = thisGraph.unionWithBezierGraph(otherGraph)!
        
        let result = resultGraph.bezierPath(usesEvenOddFillRule:usesEvenOddFillRule)
        result.fb_copyAttributesFrom(self)
        return result
    }
    
    // 24
    //- (NSBezierPath *) fb_intersect:(NSBezierPath *)path
    @objc func fb_intersect(_ path: UIBezierPath) -> UIBezierPath {
        let thisGraph = FBBezierGraph(path: self)
        let otherGraph = FBBezierGraph(path: path)
        
        let result = thisGraph.intersectWithBezierGraph(otherGraph).bezierPath(usesEvenOddFillRule:usesEvenOddFillRule)
        result.fb_copyAttributesFrom(self)
        return result
    }
    
    // 33
    //- (NSBezierPath *) fb_difference:(NSBezierPath *)path
    @objc func fb_difference(_ path: UIBezierPath) -> UIBezierPath {
        let thisGraph = FBBezierGraph(path: self)
        let otherGraph = FBBezierGraph(path: path)
        
        let result = thisGraph.differenceWithBezierGraph(otherGraph).bezierPath(usesEvenOddFillRule:usesEvenOddFillRule)
        result.fb_copyAttributesFrom(self)
        return result
    }
    
    // 42
    //- (NSBezierPath *) fb_xor:(NSBezierPath *)path
    @objc func fb_xor(_ path: UIBezierPath) -> UIBezierPath {
        let thisGraph = FBBezierGraph(path: self)
        let otherGraph = FBBezierGraph(path: path)
        
        let result = thisGraph.xorWithBezierGraph(otherGraph).bezierPath(usesEvenOddFillRule:usesEvenOddFillRule)
        result.fb_copyAttributesFrom(self)
        return result
    }
    
    // returns a split version of this graph (holes stay attatched to the contour they cut and count as 1)
    @objc func fb_splitPath() -> [UIBezierPath] {
        let thisGraph = FBBezierGraph(path: self)
        return thisGraph.splitBezierPath()
    }
    
    // returns the number of paths this path can be split into (holes stay attatched to the contour they cut and count as 1)
    @objc func fb_numPaths() -> Int {
        let thisGraph = FBBezierGraph(path: self)
        return thisGraph.numberOfFilledContours()
    }
    
    // returns the number of contours (holes and fills count as seperate)
    @objc func fb_numContours() -> Int {
        let thisGraph = FBBezierGraph(path: self)
        return thisGraph.contours.count
    }
    
}
