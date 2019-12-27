//
//  TestShapes.swift
//  Swift VectorBoolean
//
//  Created by Leslie Titze on 2015-07-12.
//  Copyright (c) 2015 Starside Softworks. All rights reserved.
//

import UIKit

protocol SampleShapeMaker {
    func topShape() -> UIBezierPath
    func otherShapes() -> UIBezierPath
}

class TestShape {
    var label : String
    fileprivate var _top : UIBezierPath?
    fileprivate var _other : UIBezierPath?
    
    var boundsOfPaths : CGRect {
        return top().bounds.union(other().bounds)
    }
    
    var unionDesiredString:String?
    var differenceDesiresString:String?
    var intersectDesiredString:String?
    
    init(label:String) {
        self.label = label
    }
    
    func top() -> UIBezierPath {
        if let top = _top {
            return top
        } else {
            if let maker = self as? SampleShapeMaker {
                _top = maker.topShape()
            } else {
                _top = UIBezierPath()
            }
            return _top!
        }
    }
    
    func other() -> UIBezierPath {
        if let other = _other {
            return other
        } else {
            if let maker = self as? SampleShapeMaker {
                _other = maker.otherShapes()
            } else {
                _other = UIBezierPath()
            }
            return _other!
        }
    }
}

class TestShapeData {
    
    var count : Int {
        return shapes.count
    }
    let shapes : [TestShape] = [
        Wolf(),
        TestShape_Circle_Overlapping_Rectangle(),     // 1
        TestShape_Circle_in_Rectangle(),              // 2
        TestShape_Rectangle_in_Circle(),              // 3
        TestShape_Circle_on_Rectangle(),              // 4
        TestShape_Rect_Over_Rect_w_Hole(),            // 5
        TestShape_Circle_Over_Two_Rects(),            // 6
        TestShape_Circle_Over_Circle(),               // 7
        TestShape_Complex_Shapes(),                   // 8
        TestShape_Complex_Shapes2(),                  // 9
        TestShape_Triangle_Inside_Rectangle(),        // 10
        TestShape_Rectangle_Overlap_Rectangle(),      // 11
        TestShape_Rectangle_Overlap_Side_Rounded(),
        TestShape_Rectangle_Overlap_Side_Pill(),
        TestShape_Diamond_Overlapping_Rectangle(),    // 12
        TestShape_Diamond_Inside_Rectangle(),         // 13
        TestShape_Non_Overlapping_Contours(),         // 14
        TestShape_More_Non_Overlapping_Contours(),    // 15
        TestShape_Concentric_Contours(),              // 16
        TestShape_More_Concentric_Contours(),         // 17
        TestShape_Circle_Overlapping_Hole(),          // 18
        TestShape_Rect_w_Hole_Over_Rect_w_Hole(),     // 19
        TestShape_Curve_Overlapping_Rectangle(),      // 20
        TestShape_Debug(),
        TestShape_DebugQuadCurve(),
        TestShape_Debug001(),
        TestShape_Debug002(),
        TestShape_Debug003(),
        TestShape_Rectangle_Sharing_Edge_With_Rectangle(),
        TestShape_Rectangle_Overlapping_Rectangle(),
        TestShape_Tiny_Rectangle_Overlapping_Rectangle()
    ]
}

// =================================================
// MARK: The set of bezier test case classes
// =================================================

class TestShape_Circle_Overlapping_Rectangle : TestShape, SampleShapeMaker {
    
    init() {
        super.init(label: "Circle Overlapping Rectangle")
        
        unionDesiredString = "M350,115.098 L350,50 L50,50 L50,250 L230.394,250 C235.489,314.36 289.33,365 355,365 C424.036,365 480,309.036 480,240 C480,170.964 424.036,115 355,115 C353.325,115 351.659,115.033 350,115.098 Z "
        intersectDesiredString = "M350,115.098 C283.282,117.723 230,172.639 230,240 C230,243.366 230.133,246.701 230.394,250 L350,250 L350,115.098 Z "
        differenceDesiresString = "M350,115.098 L350,50 L50,50 L50,250 L230.394,250 C230.133,246.701 230,243.366 230,240 C230,172.639 283.282,117.723 350,115.098 Z "
    }
    
    func otherShapes() -> UIBezierPath {
        return UIBezierPath(rect: CGRect(x: 50, y: 50, width: 300, height: 200))
    }
    
    func topShape() -> UIBezierPath {
        let circle = UIBezierPath()
        addCircleAtPoint(CGPoint(x: 355, y: 240), withRadius: 125.0, toPath: circle)
        return circle
    }
    
}

class TestShape_Circle_in_Rectangle : TestShape, SampleShapeMaker {
    
    init() {
        super.init(label: "Circle in Rectangle")
        
        unionDesiredString = "M50,50 L50,350 L400,350 L400,50 L50,50 Z "
        intersectDesiredString = "M85,200 C85,269.036 140.964,325 210,325 C279.036,325 335,269.036 335,200 C335,130.964 279.036,75 210,75 C140.964,75 85,130.964 85,200 Z "
        differenceDesiresString = "M50,50 L50,350 L400,350 L400,50 L50,50 Z M85,200 C85,130.964 140.964,75 210,75 C279.036,75 335,130.964 335,200 C335,269.036 279.036,325 210,325 C140.964,325 85,269.036 85,200 Z "
    }
    
    func otherShapes() -> UIBezierPath {
        return UIBezierPath(rect: CGRect(x: 50, y: 50, width: 350, height: 300))
    }
    
    func topShape() -> UIBezierPath {
        let circle = UIBezierPath()
        addCircleAtPoint(CGPoint(x: 210, y: 200), withRadius: 125.0, toPath: circle)
        return circle
    }
}

class TestShape_Rectangle_in_Circle : TestShape, SampleShapeMaker {
    
    init() {
        super.init(label: "Rectangle in Circle")
        
        unionDesiredString = "M25,200 C25,302.173 107.827,385 210,385 C312.173,385 395,302.173 395,200 C395,97.8273 312.173,15 210,15 C107.827,15 25,97.8273 25,200 Z "
        intersectDesiredString = "M150,150 L150,300 L300,300 L300,150 L150,150 Z "
        differenceDesiresString = "M25,200 C25,302.173 107.827,385 210,385 C312.173,385 395,302.173 395,200 C395,97.8273 312.173,15 210,15 C107.827,15 25,97.8273 25,200 Z M150,150 L300,150 L300,300 L150,300 L150,150 Z "
    }
    
    func otherShapes() -> UIBezierPath {
        let circle = UIBezierPath()
        addCircleAtPoint(CGPoint(x: 210, y: 200), withRadius: 185.0, toPath: circle)
        return circle
    }
    
    func topShape() -> UIBezierPath {
        return UIBezierPath(rect: CGRect(x: 150, y: 150, width: 150, height: 150))
    }
}

// TODO: Track down why this is so messed up

class TestShape_Circle_on_Rectangle : TestShape, SampleShapeMaker {
    
    init() {
        super.init(label: "Circle on Rectangle")
        
        unionDesiredString = "M200,15 L15,15 L15,200 C15,200 15,200 15,200 C15,200 15,200 15,200 L15,385 L200,385 C200,385 200,385 200,385 C200,385 200,385 200,385 L385,385 L385,200 C385,200 385,200 385,200 C385,200 385,200 385,200 L385,15 L200,15 C200,15 200,15 200,15 C200,15 200,15 200,15 Z "
        intersectDesiredString = "M200,15 C97.8274,15 15.0001,97.8272 15,200 L15,200 C15,302.173 97.8273,385 200,385 L200,385 C302.173,385 385,302.173 385,200 L385,200 C385,97.8273 302.173,15 200,15 L200,15 Z "
        differenceDesiresString = "M200,15 L15,15 L15,200 C15.0001,97.8272 97.8274,15 200,15 Z M200,15 C302.173,15 385,97.8273 385,200 L385,15 L200,15 Z M385,200 C385,302.173 302.173,385 200,385 L385,385 L385,200 Z M200,385 C97.8273,385 15,302.173 15,200 L15,385 L200,385 Z "
    }
    
    func otherShapes() -> UIBezierPath {
        return UIBezierPath(rect: CGRect(x: 15, y: 15, width: 370, height: 370))
    }
    
    func topShape() -> UIBezierPath {
        //  return UIBezierPath(ovalInRect: CGRect(x: 15, y: 15, width: 370, height: 370))
        let circle = UIBezierPath()
        addCircleAtPoint(CGPoint(x: 200, y: 200), withRadius: 185, toPath: circle)
        return circle
    }
}

class TestShape_Rect_Over_Rect_w_Hole : TestShape, SampleShapeMaker {
    
    init() {
        super.init(label: "Rect Over Rect with Hole")
        
        unionDesiredString = "M180,50 L50,50 L50,350 L180,350 L180,405 L280,405 L280,350 L400,350 L400,50 L280,50 L280,5 L180,5 L180,50 Z M180,321.377 C125.454,307.94 85,258.694 85,200 C85,141.306 125.454,92.06 180,78.6232 L180,321.377 Z M280,303.577 L280,96.4233 C313.188,118.896 335,156.901 335,200 C335,243.099 313.188,281.104 280,303.577 Z "
        intersectDesiredString = "M180,50 L180,78.6232 C189.611,76.2558 199.659,75 210,75 C235.937,75 260.028,82.8993 280,96.4233 L280,50 L180,50 Z M280,350 L280,303.577 C260.028,317.101 235.937,325 210,325 C199.659,325 189.611,323.744 180,321.377 L180,350 L280,350 Z "
        differenceDesiresString = "M180,50 L50,50 L50,350 L180,350 L180,321.377 C125.454,307.94 85,258.694 85,200 C85,141.306 125.454,92.06 180,78.6232 L180,50 Z M280,50 L280,96.4233 C313.188,118.896 335,156.901 335,200 C335,243.099 313.188,281.104 280,303.577 L280,350 L400,350 L400,50 L280,50 Z "
    }
    
    func otherShapes() -> UIBezierPath {
        let holeyRectangle = UIBezierPath()
        holeyRectangle.append(UIBezierPath(rect: CGRect(x: 50, y: 50, width: 350, height: 300)))
        addCircleAtPoint(CGPoint(x: 210, y: 200), withRadius: 125, toPath: holeyRectangle)
        return holeyRectangle
    }
    
    func topShape() -> UIBezierPath {
        return UIBezierPath(rect: CGRect(x: 180, y: 5, width: 100, height: 400))
    }
}

class TestShape_Circle_Over_Two_Rects : TestShape, SampleShapeMaker {
    
    init() {
        super.init(label: "Circle Overlapping Two Rects")
        
        unionDesiredString = "M150,21.8359 L150,5 L50,5 L50,91.6949 C27.9793,122.14 15,159.554 15,200 C15,240.446 27.9793,277.86 50,308.305 L50,405 L150,405 L150,378.164 C165.904,382.618 182.674,385 200,385 C261.727,385 316.393,354.769 350,308.305 L350,405 L450,405 L450,5 L350,5 L350,91.6949 C316.393,45.231 261.727,15 200,15 C182.674,15 165.904,17.3818 150,21.8359 Z "
        intersectDesiredString = "M150,21.8359 C109.244,33.2501 74.1739,58.273 50,91.6949 L50,308.305 C74.1739,341.727 109.244,366.75 150,378.164 L150,21.8359 Z M350,308.305 C372.021,277.86 385,240.446 385,200 C385,159.554 372.021,122.14 350,91.6949 L350,308.305 Z "
        differenceDesiresString = "M150,21.8359 L150,5 L50,5 L50,91.6949 C74.1739,58.273 109.244,33.2501 150,21.8359 Z M150,378.164 C109.244,366.75 74.1739,341.727 50,308.305 L50,405 L150,405 L150,378.164 Z M350,308.305 L350,405 L450,405 L450,5 L350,5 L350,91.6949 C372.021,122.14 385,159.554 385,200 C385,240.446 372.021,277.86 350,308.305 Z "
    }
    
    func otherShapes() -> UIBezierPath {
        let rectangles = UIBezierPath()
        rectangles.append(UIBezierPath(rect: CGRect(x:  50, y: 5, width: 100, height: 400)))
        rectangles.append(UIBezierPath(rect: CGRect(x: 350, y: 5, width: 100, height: 400)))
        return rectangles
    }
    
    func topShape() -> UIBezierPath {
        let circle = UIBezierPath()
        addCircleAtPoint(CGPoint(x: 200, y: 200), withRadius: 185, toPath: circle)
        return circle
    }
}

class TestShape_Circle_Over_Circle : TestShape, SampleShapeMaker {
    
    init() {
        super.init(label: "Circle Overlapping Circle")
        
        unionDesiredString = "M309.068,123.709 C309.683,119.227 310,114.651 310,110 C310,54.7715 265.228,10 210,10 C154.772,10 110,54.7715 110,110 C110,165.228 154.772,210 210,210 C218.417,210 226.592,208.96 234.402,207.002 C231.532,217.514 230,228.578 230,240 C230,309.036 285.964,365 355,365 C424.036,365 480,309.036 480,240 C480,170.964 424.036,115 355,115 C338.783,115 323.287,118.088 309.068,123.709 Z "
        intersectDesiredString = "M309.068,123.709 C303.498,164.339 273.521,197.192 234.402,207.002 C244.802,168.903 272.774,138.056 309.068,123.709 Z "
        differenceDesiresString = "M309.068,123.709 C303.498,164.339 273.521,197.192 234.402,207.002 C231.532,217.514 230,228.578 230,240 C230,309.036 285.964,365 355,365 C424.036,365 480,309.036 480,240 C480,170.964 424.036,115 355,115 C338.783,115 323.287,118.088 309.068,123.709 Z "
    }
    
    func otherShapes() -> UIBezierPath {
        let circle = UIBezierPath()
        addCircleAtPoint(CGPoint(x: 355, y: 240), withRadius: 125, toPath: circle)
        return circle
    }
    
    func topShape() -> UIBezierPath {
        let circle = UIBezierPath()
        addCircleAtPoint(CGPoint(x: 210, y: 110), withRadius: 100, toPath: circle)
        return circle
    }
}

class TestShape_Complex_Shapes : TestShape, SampleShapeMaker {
    
    init() {
        super.init(label: "Complex Shapes")
        
        unionDesiredString = "M180,50 L50,50 L50,350 L180,350 L180,405 L280,405 L280,350 L400,350 L400,50 L280,50 L280,5 L180,5 L180,50 L180,50 Z M180,321.377 C125.454,307.94 85,258.694 85,200 C85,141.306 125.454,92.06 180,78.6232 L180,321.377 L180,321.377 Z M280,303.577 L280,96.4233 C313.188,118.896 335,156.901 335,200 C335,243.099 313.188,281.104 280,303.577 L280,303.577 Z "
        intersectDesiredString = "M190,110 C190,121.046 198.954,130 210,130 C221.046,130 230,121.046 230,110 C230,98.9543 221.046,90 210,90 C198.954,90 190,98.9543 190,110 Z "
        differenceDesiresString = "M180,50 L50,50 L50,350 L180,350 L180,405 L280,405 L280,350 L400,350 L400,50 L280,50 L280,5 L180,5 L180,50 L180,50 Z M180,321.377 C125.454,307.94 85,258.694 85,200 C85,141.306 125.454,92.06 180,78.6232 L180,321.377 L180,321.377 Z M280,303.577 L280,96.4233 C313.188,118.896 335,156.901 335,200 C335,243.099 313.188,281.104 280,303.577 L280,303.577 Z M190,110 C190,98.9543 198.954,90 210,90 C221.046,90 230,98.9543 230,110 C230,121.046 221.046,130 210,130 C198.954,130 190,121.046 190,110 Z "
        
    }
    
    func otherShapes() -> UIBezierPath {
        let holeyRectangle = UIBezierPath()
        holeyRectangle.append(UIBezierPath(rect: CGRect(x: 50, y: 50, width: 350, height: 300)))
        addCircleAtPoint(CGPoint(x: 210, y: 200), withRadius: 125, toPath: holeyRectangle)
        
        let rectangle = UIBezierPath(rect: CGRect(x: 180, y: 5, width: 100, height: 400))
        //let allParts = holeyRectangle.fb_intersect(rectangle)
        let allParts = holeyRectangle.fb_union(rectangle)
        
        return allParts
    }
    
    func topShape() -> UIBezierPath {
        let circle = UIBezierPath()
        addCircleAtPoint(CGPoint(x: 210, y: 110), withRadius: 20, toPath: circle)
        return circle
    }
}

class TestShape_Complex_Shapes2 : TestShape, SampleShapeMaker {
    
    init() {
        super.init(label: "More Complex Shapes")
        
        unionDesiredString = "M150,21.8359 L150,5 L50,5 L50,91.6949 C27.9793,122.14 15,159.554 15,200 C15,240.446 27.9793,277.86 50,308.305 L50,405 L150,405 L150,378.164 C165.904,382.618 182.674,385 200,385 C261.727,385 316.393,354.769 350,308.305 L350,405 L450,405 L450,5 L350,5 L350,91.6949 C316.393,45.231 261.727,15 200,15 C182.674,15 165.904,17.3818 150,21.8359 L150,21.8359 Z "
        intersectDesiredString = "M150,21.8359 C109.244,33.2501 74.1739,58.273 50,91.6949 L50,308.305 C74.1739,341.727 109.244,366.75 150,378.164 L150,21.8359 L150,21.8359 Z M350,308.305 C372.021,277.86 385,240.446 385,200 C385,159.554 372.021,122.14 350,91.6949 L350,308.305 L350,308.305 Z "
        differenceDesiresString = "M150,21.8359 L150,5 L50,5 L50,91.6949 C27.9793,122.14 15,159.554 15,200 C15,240.446 27.9793,277.86 50,308.305 L50,405 L150,405 L150,378.164 C165.904,382.618 182.674,385 200,385 C261.727,385 316.393,354.769 350,308.305 L350,405 L450,405 L450,5 L350,5 L350,91.6949 C316.393,45.231 261.727,15 200,15 C182.674,15 165.904,17.3818 150,21.8359 L150,21.8359 Z M150,21.8359 L150,21.8359 L150,378.164 C109.244,366.75 74.1739,341.727 50,308.305 L50,91.6949 C74.1739,58.273 109.244,33.2501 150,21.8359 Z M350,308.305 L350,308.305 L350,91.6949 C372.021,122.14 385,159.554 385,200 C385,240.446 372.021,277.86 350,308.305 Z "
    }
    func common() -> (rectangles: UIBezierPath, circle: UIBezierPath) {
        let rectangles = UIBezierPath()
        rectangles.append(UIBezierPath(rect: CGRect(x:  50, y: 5, width: 100, height: 400)))
        rectangles.append(UIBezierPath(rect: CGRect(x: 350, y: 5, width: 100, height: 400)))
        
        let circle = UIBezierPath()
        addCircleAtPoint(CGPoint(x: 200, y: 200), withRadius: 185, toPath: circle)
        return (rectangles: rectangles, circle: circle)
    }
    
    func otherShapes() -> UIBezierPath {
        let (rectangles, circle) = common()
        
        return rectangles.fb_union(circle)
    }
    
    func topShape() -> UIBezierPath {
        let (rectangles, circle) = common()
        
        return rectangles.fb_intersect(circle)
    }
}

class TestShape_Triangle_Inside_Rectangle : TestShape, SampleShapeMaker {
    
    init() {
        super.init(label: "Triangle Inside Rectangle")
        
        unionDesiredString = "M100,100 L100,400 L400,400 L400,100 L100,100 Z "
        intersectDesiredString = "M100,400 L400,400 L250,250 L100,400 Z "
        differenceDesiresString = "M100,100 L100,400 L400,400 L400,100 L100,100 Z M100,400 L250,250 L400,400 L100,400 Z "
    }
    
    func otherShapes() -> UIBezierPath {
        return UIBezierPath(rect: CGRect(x: 100, y: 100, width: 300, height: 300))
    }
    
    func topShape() -> UIBezierPath {
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 100, y: 400))
        path.addLine(to: CGPoint(x: 400, y: 400))
        path.addLine(to: CGPoint(x: 250, y: 250))
        path.addLine(to: CGPoint(x: 100, y: 400))
        path.close()
        return path
    }
}

class TestShape_Rectangle_Overlap_Rectangle : TestShape, SampleShapeMaker {
    
    init() {
        super.init(label: "Rectangle Overlap Rectangle")
        
        unionDesiredString = "M325,100 L100,100 L100,400 L325,400 L550,400 L550,100 L325,100 Z "
        intersectDesiredString = "M325,100 L250,100 L250,400 L325,400 L400,400 L400,100 L325,100 Z "
        differenceDesiresString = "M325,100 L100,100 L100,400 L325,400 L250,400 L250,100 L325,100 Z "
    }
    
    func otherShapes() -> UIBezierPath {
        return UIBezierPath(rect: CGRect(x: 100, y: 100, width: 300, height: 300))
    }
    
    func topShape() -> UIBezierPath {
        return UIBezierPath(rect: CGRect(x: 250, y: 100, width: 300, height: 300))
    }
}

class TestShape_Rectangle_Overlap_Side_Rounded : TestShape, SampleShapeMaker {
    
    init() {
        super.init(label: "Rectangle Overlap Side Rounded")
        
        unionDesiredString = "M2.13163e-14,22.1517 L2.13163e-14,22.1517 L22.1517,22.1517 C34.3934,22.1517 44.3034,12.2417 44.3034,-4.61853e-14 C44.3034,-12.2417 34.3934,-22.1517 22.1517,-22.1517 L3.55271e-14,-22.1517 L3.55271e-14,-22.1517 L-45.5097,-22.1517 L-45.5097,22.1517 L1.68754e-14,22.1517 Z "
        intersectDesiredString = "M1.68754e-14,22.1517 L9.90146,22.1517 L9.90146,-22.1517 L3.55271e-14,-22.1517 L2.13163e-14,22.1517 Z "
        differenceDesiresString = "M2.13163e-14,22.1517 L3.55271e-14,-22.1517 L-45.5097,-22.1517 L-45.5097,22.1517 L1.68754e-14,22.1517 Z "
    }
    
    func otherShapes() -> UIBezierPath {
        let bezierPath = UIBezierPath()
        bezierPath.move(to: CGPoint(x: -45.509708, y: 22.151699))
        bezierPath.addLine(to: CGPoint(x: 9.9014597, y: 22.151699))
        bezierPath.addLine(to: CGPoint(x: 9.9014597, y: -22.151699))
        bezierPath.addLine(to: CGPoint(x: -45.509708, y: -22.151699))
        bezierPath.addLine(to: CGPoint(x: -45.509708, y: 22.151699))
        bezierPath.close()
        return bezierPath
    }
    
    func topShape() -> UIBezierPath {
        
        let bezierPath = UIBezierPath()
        bezierPath.move(to: CGPoint(x: 2.1316282e-14, y:22.1517))
        bezierPath.addLine(to: CGPoint(x: 3.5527137e-14, y: -22.1517))
        bezierPath.addLine(to: CGPoint(x: 22.1517, y: -22.1517))
        bezierPath.addCurve(to: CGPoint(x: 44.3034, y: -4.6185278e-14), controlPoint1: CGPoint(x: 34.393429, y:-22.1517), controlPoint2: CGPoint(x: 44.3034, y: -12.241729))
        bezierPath.addLine(to: CGPoint(x: 44.3034, y: -4.6185278e-14))
        bezierPath.addCurve(to: CGPoint(x: 22.1517, y: 22.1517), controlPoint1: CGPoint(x: 44.3034, y: 12.241727), controlPoint2: CGPoint(x: 34.393429, y: 22.1517))
        bezierPath.addLine(to: CGPoint(x: 2.1316282e-14, y: 22.1517))
        bezierPath.close()
        
        return bezierPath
    }
}

class TestShape_Rectangle_Overlap_Side_Pill : TestShape, SampleShapeMaker {
    
    init() {
        super.init(label: "Rectangle Overlap Side Pill")
        
        unionDesiredString = "M31.4985,32.1234 L48.2964,32.1234 C52.5176,32.1234 55.9643,28.6767 55.9643,24.4555 C55.9643,20.2343 52.5176,16.7876 48.2964,16.7876 L28.4149,16.7876 L-60.4745,16.7876 L-60.4745,32.1451 L31.4985,32.1451 L31.4985,32.1234 Z "
        intersectDesiredString = "M31.4985,32.1234 L31.4985,16.7876 L28.4149,16.7876 L25.3313,16.7876 C21.11,16.7876 17.6633,20.2343 17.6633,24.4555 C17.6633,28.6767 21.11,32.1234 25.3313,32.1234 L31.4985,32.1234 Z "
        differenceDesiresString = "M31.4985,32.1234 L25.3313,32.1234 C21.11,32.1234 17.6633,28.6767 17.6633,24.4555 C17.6633,20.2343 21.11,16.7876 25.3313,16.7876 L28.4149,16.7876 L-60.4745,16.7876 L-60.4745,32.1451 L31.4985,32.1451 L31.4985,32.1234 Z "
        
    }
    
    func otherShapes() -> UIBezierPath {
        let bezierPath = UIBezierPath()
        bezierPath.move(to: CGPoint(x: 31.498467, y: 32.145078))
        bezierPath.addLine(to: CGPoint(x: 31.498467, y: 16.787565))
        bezierPath.addLine(to: CGPoint(x: -60.474535, y: 16.787565))
        bezierPath.addLine(to: CGPoint(x: -60.474535, y: 32.145078))
        bezierPath.addLine(to: CGPoint(x: 31.498467, y: 32.145078))
        bezierPath.close()
        return bezierPath
    }
    
    func topShape() -> UIBezierPath {
        
        let bezierPath = UIBezierPath()
        bezierPath.move(to: CGPoint(x: 17.663327, y:24.455505))
        bezierPath.addLine(to: CGPoint(x: 17.663327, y: 24.455505))
        bezierPath.addCurve(to: CGPoint(x: 25.331267, y: 32.123445 ), controlPoint1: CGPoint(x: 17.663327, y:28.676745), controlPoint2: CGPoint(x: 21.110028, y: 32.123445))
        bezierPath.addLine(to: CGPoint(x: 48.296361, y: 32.123445))
        bezierPath.addCurve(to: CGPoint(x: 55.964303, y: 24.455505), controlPoint1: CGPoint(x: 52.517602, y: 32.123445), controlPoint2: CGPoint(x: 55.964303, y: 28.676745))
        bezierPath.addLine(to: CGPoint(x: 55.964303, y: 24.455505))
        bezierPath.addCurve(to: CGPoint(x: 48.296361, y:16.787565 ), controlPoint1: CGPoint(x: 55.964303, y:20.234265), controlPoint2: CGPoint(x: 52.517602, y:16.787565))
        bezierPath.addLine(to: CGPoint(x: 25.331267, y:16.787565))
        bezierPath.addCurve(to: CGPoint(x: 17.663327, y:24.455505), controlPoint1: CGPoint(x: 21.110028, y:16.787565), controlPoint2: CGPoint(x: 17.663327, y:20.234265))
        bezierPath.close()
        
        return bezierPath
    }
}

class TestShape_Diamond_Overlapping_Rectangle : TestShape, SampleShapeMaker {
    
    init() {
        super.init(label: "Diamond Overlapping Rectangle")
        
        unionDesiredString = "M250,250 L250,50 L50,50 L50,250 L150,400 L250,250 Z "
        intersectDesiredString = "M250,250 L150,100 L50,250 L250,250 Z "
        differenceDesiresString = "M250,250 L250,50 L50,50 L50,250 L150,100 L250,250 Z "
    }
    
    func otherShapes() -> UIBezierPath {
        return UIBezierPath(rect: CGRect(x: 50, y: 50, width: 200, height: 200))
    }
    
    func topShape() -> UIBezierPath {
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 50, y: 250))
        path.addLine(to: CGPoint(x: 150, y: 400))
        path.addLine(to: CGPoint(x: 250, y: 250))
        path.addLine(to: CGPoint(x: 150, y: 100))
        path.addLine(to: CGPoint(x: 50, y: 250))
        path.close()
        
        return path
    }
}

class TestShape_Diamond_Inside_Rectangle : TestShape, SampleShapeMaker {
    
    init() {
        super.init(label: "Diamond Inside Rectangle")
        
        unionDesiredString = "M100,100 L100,400 L400,400 L400,100 L100,100 Z "
        intersectDesiredString = "M100,250 L250,400 L400,250 L250,100 L100,250 Z "
        differenceDesiresString = "M100,100 L100,400 L400,400 L400,100 L100,100 Z M100,250 L250,100 L400,250 L250,400 L100,250 Z "
    }
    
    func otherShapes() -> UIBezierPath {
        return UIBezierPath(rect: CGRect(x: 100, y: 100, width: 300, height: 300))
    }
    
    func topShape() -> UIBezierPath {
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 100, y: 250))
        path.addLine(to: CGPoint(x: 250, y: 400))
        path.addLine(to: CGPoint(x: 400, y: 250))
        path.addLine(to: CGPoint(x: 250, y: 100))
        path.addLine(to: CGPoint(x: 100, y: 250))
        path.close()
        
        return path
    }
}

class TestShape_Non_Overlapping_Contours : TestShape, SampleShapeMaker {
    
    init() {
        super.init(label: "Non-overlapping Contours")
        
        unionDesiredString = "M100,200 L100,400 L300,400 L300,200 L100,200 Z M115,95 C115,141.944 153.056,180 200,180 C246.944,180 285,141.944 285,95 C285,48.0558 246.944,10 200,10 C153.056,10 115,48.0558 115,95 Z "
        intersectDesiredString = "M115,300 C115,346.944 153.056,385 200,385 C246.944,385 285,346.944 285,300 C285,253.056 246.944,215 200,215 C153.056,215 115,253.056 115,300 Z "
        differenceDesiresString = "M100,200 L100,400 L300,400 L300,200 L100,200 Z M115,300 C115,253.056 153.056,215 200,215 C246.944,215 285,253.056 285,300 C285,346.944 246.944,385 200,385 C153.056,385 115,346.944 115,300 Z "
    }
    
    func otherShapes() -> UIBezierPath {
        return UIBezierPath(rect: CGRect(x: 100, y: 200, width: 200, height: 200))
    }
    
    func topShape() -> UIBezierPath {
        
        let circles = UIBezierPath()
        addCircleAtPoint(CGPoint(x: 200, y: 300), withRadius: 85, toPath: circles)
        addCircleAtPoint(CGPoint(x: 200, y: 95), withRadius: 85, toPath: circles)
        
        return circles
    }
}

class TestShape_More_Non_Overlapping_Contours : TestShape, SampleShapeMaker {
    
    init() {
        super.init(label: "More Non-overlapping Contours")
        
        unionDesiredString = "M100,200 L100,400 L300,400 L300,200 L100,200 Z M115,95 C115,141.944 153.056,180 200,180 C246.944,180 285,141.944 285,95 C285,48.0558 246.944,10 200,10 C153.056,10 115,48.0558 115,95 Z "
        intersectDesiredString = "M175,70 L175,120 L225,120 L225,70 L175,70 Z M115,300 C115,346.944 153.056,385 200,385 C246.944,385 285,346.944 285,300 C285,253.056 246.944,215 200,215 C153.056,215 115,253.056 115,300 Z "
        differenceDesiresString = "M100,200 L100,400 L300,400 L300,200 L100,200 Z M115,300 C115,253.056 153.056,215 200,215 C246.944,215 285,253.056 285,300 C285,346.944 246.944,385 200,385 C153.056,385 115,346.944 115,300 Z "
        
    }
    
    func otherShapes() -> UIBezierPath {
        let rectangles = UIBezierPath()
        rectangles.append(UIBezierPath(rect: CGRect(x:  100, y: 200, width: 200, height: 200)))
        rectangles.append(UIBezierPath(rect: CGRect(x: 175, y: 70, width: 50, height: 50)))
        
        return rectangles
    }
    
    func topShape() -> UIBezierPath {
        let circles = UIBezierPath()
        addCircleAtPoint(CGPoint(x: 200, y: 300), withRadius: 85, toPath: circles)
        addCircleAtPoint(CGPoint(x: 200, y: 95), withRadius: 85, toPath: circles)
        
        return circles
    }
}

class TestShape_Concentric_Contours : TestShape, SampleShapeMaker {
    
    init() {
        super.init(label: "Concentric Contours")
        
        unionDesiredString = "M50,50 L50,350 L400,350 L400,50 L50,50 Z "
        intersectDesiredString = "M85,200 C85,130.964 140.964,75 210,75 C279.036,75 335,130.964 335,200 C335,269.036 279.036,325 210,325 C140.964,325 85,269.036 85,200 Z M70,200 C70,277.32 132.68,340 210,340 C287.32,340 350,277.32 350,200 C350,122.68 287.32,60 210,60 C132.68,60 70,122.68 70,200 Z "
        differenceDesiresString = "M50,50 L50,350 L400,350 L400,50 L50,50 Z M70,200 C70,122.68 132.68,60 210,60 C287.32,60 350,122.68 350,200 C350,277.32 287.32,340 210,340 C132.68,340 70,277.32 70,200 Z "
        
    }
    
    func otherShapes() -> UIBezierPath {
        let holeyRectangle = UIBezierPath()
        holeyRectangle.append(UIBezierPath(rect: CGRect(x: 50, y: 50, width: 350, height: 300)))
        addCircleAtPoint(CGPoint(x: 210, y: 200), withRadius: 125, toPath: holeyRectangle)
        return holeyRectangle
    }
    
    func topShape() -> UIBezierPath {
        let circle = UIBezierPath()
        addCircleAtPoint(CGPoint(x: 210, y: 200), withRadius: 140, toPath: circle)
        return circle
    }
}

class TestShape_More_Concentric_Contours : TestShape, SampleShapeMaker {
    
    init() {
        super.init(label: "More Concentric Contours")
        
        unionDesiredString = "M50,50 L50,350 L400,350 L400,50 L50,50 Z M85,200 C85,130.964 140.964,75 210,75 C279.036,75 335,130.964 335,200 C335,269.036 279.036,325 210,325 C140.964,325 85,269.036 85,200 Z M140,200 C140,238.66 171.34,270 210,270 C248.66,270 280,238.66 280,200 C280,161.34 248.66,130 210,130 C171.34,130 140,161.34 140,200 Z "
        intersectDesiredString = ""
        differenceDesiresString = "M50,50 L50,350 L400,350 L400,50 L50,50 Z M85,200 C85,130.964 140.964,75 210,75 C279.036,75 335,130.964 335,200 C335,269.036 279.036,325 210,325 C140.964,325 85,269.036 85,200 Z "
        
    }
    
    func otherShapes() -> UIBezierPath {
        let holeyRectangle = UIBezierPath()
        holeyRectangle.append(UIBezierPath(rect: CGRect(x: 50, y: 50, width: 350, height: 300)))
        addCircleAtPoint(CGPoint(x: 210, y: 200), withRadius: 125, toPath: holeyRectangle)
        return holeyRectangle
    }
    
    func topShape() -> UIBezierPath {
        let circle = UIBezierPath()
        addCircleAtPoint(CGPoint(x: 210, y: 200), withRadius: 70, toPath: circle)
        return circle
    }
}

class TestShape_Circle_Overlapping_Hole : TestShape, SampleShapeMaker {
    
    init() {
        super.init(label: "Circle Overlapping Hole")
        
        unionDesiredString = "M126.46,292.986 C142.689,300.69 160.841,305 180,305 C249.036,305 305,249.036 305,180 C305,143.079 288.993,109.897 263.54,87.0141 C305.788,107.07 335,150.123 335,200 C335,269.036 279.036,325 210,325 C177.885,325 148.6,312.889 126.46,292.986 Z M50,50 L50,350 L400,350 L400,50 L50,50 Z "
        intersectDesiredString = "M126.46,292.986 C101.007,270.103 85,236.921 85,200 C85,130.964 140.964,75 210,75 C229.159,75 247.311,79.3103 263.54,87.0141 C241.4,67.1107 212.115,55 180,55 C110.964,55 55,110.964 55,180 C55,229.877 84.2119,272.93 126.46,292.986 Z "
        differenceDesiresString = "M126.46,292.986 C84.2119,272.93 55,229.877 55,180 C55,110.964 110.964,55 180,55 C212.115,55 241.4,67.1107 263.54,87.0141 C305.788,107.07 335,150.123 335,200 C335,269.036 279.036,325 210,325 C177.885,325 148.6,312.889 126.46,292.986 Z M50,50 L50,350 L400,350 L400,50 L50,50 Z "
        
    }
    
    func otherShapes() -> UIBezierPath {
        let holeyRectangle = UIBezierPath()
        holeyRectangle.append(UIBezierPath(rect: CGRect(x: 50, y: 50, width: 350, height: 300)))
        addCircleAtPoint(CGPoint(x: 210, y: 200), withRadius: 125, toPath: holeyRectangle)
        return holeyRectangle
    }
    
    func topShape() -> UIBezierPath {
        let circle = UIBezierPath()
        addCircleAtPoint(CGPoint(x: 180, y: 180), withRadius: 125, toPath: circle)
        return circle
    }
}

class TestShape_Rect_w_Hole_Over_Rect_w_Hole : TestShape, SampleShapeMaker {
    
    init() {
        super.init(label: "Rect w/Hole Over Rect w/Hole")
        
        unionDesiredString = "M332.5,225 C320.918,282.056 270.474,325 210,325 C140.964,325 85,269.036 85,200 C85,130.964 140.964,75 210,75 C215.076,75 220.082,75.3026 225,75.8907 L225,225 L332.5,225 Z M334.972,202.693 C326.003,207.361 315.81,210 305,210 C269.101,210 240,180.899 240,145 C240,122.022 251.923,101.83 269.919,90.2702 C308.7,111.492 335,152.675 335,200 C335,200.9 334.99,201.797 334.972,202.693 Z M50,50 L50,350 L400,350 L400,50 L50,50 Z "
        intersectDesiredString = "M332.5,225 L385,225 L385,65 L225,65 L225,75.8907 C241.115,77.818 256.288,82.8111 269.919,90.2702 C280.039,83.7701 292.079,80 305,80 C340.899,80 370,109.101 370,145 C370,170.089 355.786,191.857 334.972,202.693 C334.81,210.316 333.967,217.771 332.5,225 Z "
        differenceDesiresString = "M332.5,225 C320.918,282.056 270.474,325 210,325 C140.964,325 85,269.036 85,200 C85,130.964 140.964,75 210,75 C215.076,75 220.082,75.3026 225,75.8907 L225,65 L385,65 L385,225 L332.5,225 Z M334.972,202.693 C355.786,191.857 370,170.089 370,145 C370,109.101 340.899,80 305,80 C292.079,80 280.039,83.7701 269.919,90.2702 C308.7,111.492 335,152.675 335,200 C335,200.9 334.99,201.797 334.972,202.693 Z M50,50 L50,350 L400,350 L400,50 L50,50 Z "
        
    }
    
    func otherShapes() -> UIBezierPath {
        let holeyRectangle = UIBezierPath()
        holeyRectangle.append(UIBezierPath(rect: CGRect(x: 50, y: 50, width: 350, height: 300)))
        addCircleAtPoint(CGPoint(x: 210, y: 200), withRadius: 125, toPath: holeyRectangle)
        return holeyRectangle
    }
    
    func topShape() -> UIBezierPath {
        let holeyRectangle = UIBezierPath()
        holeyRectangle.append(UIBezierPath(rect: CGRect(x: 225, y: 65, width: 160, height: 160)))
        addCircleAtPoint(CGPoint(x: 305, y: 145), withRadius: 65, toPath: holeyRectangle)
        return holeyRectangle
    }
}

class TestShape_Curve_Overlapping_Rectangle : TestShape, SampleShapeMaker {
    
    init() {
        super.init(label: "Curve Overlapping Rectangle")
        
        unionDesiredString = "M245.744,118.333 C242.056,126.472 240,135.479 240,145 C240,181 269,210 305,210 C316,210 326,207 335,203 C335,202 335,201 335,200 C335,169.101 323.763,140.364 304.982,118.333 L410,118.333 L410,50 L40,50 L40,118.333 L245.744,118.333 Z "
        intersectDesiredString = "M245.744,118.333 L304.982,118.333 C295.196,106.853 283.361,97.1943 270,90 C259.451,97.0324 250.963,106.812 245.744,118.333 Z "
        differenceDesiresString = "M245.744,118.333 C250.963,106.812 259.451,97.0324 270,90 C283.361,97.1943 295.196,106.853 304.982,118.333 L410,118.333 L410,50 L40,50 L40,118.333 L245.744,118.333 Z "
        
    }
    
    func otherShapes() -> UIBezierPath {
        let top : CGFloat = 65.0 + 160.0 / 3.0
        
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 40, y: top))
        path.addLine(to: CGPoint(x: 410, y: top))
        path.addLine(to: CGPoint(x: 410, y: 50))
        path.addLine(to: CGPoint(x: 40, y: 50))
        path.addLine(to: CGPoint(x: 40, y: top))
        path.close()
        
        return path
    }
    
    func topShape() -> UIBezierPath {
        let curvyShape = UIBezierPath()
        curvyShape.move(to: CGPoint(x: 335, y: 203))
        curvyShape.addCurve(to: CGPoint(x: 335, y: 200),
                            controlPoint1: CGPoint(x: 335, y: 202),
                            controlPoint2: CGPoint(x: 335, y: 201))
        curvyShape.addCurve(to: CGPoint(x: 270, y: 90),
                            controlPoint1: CGPoint(x: 335, y: 153),
                            controlPoint2: CGPoint(x: 309, y: 111))
        curvyShape.addCurve(to: CGPoint(x: 240, y: 145),
                            controlPoint1: CGPoint(x: 252, y: 102),
                            controlPoint2: CGPoint(x: 240, y: 122))
        curvyShape.addCurve(to: CGPoint(x: 305, y: 210),
                            controlPoint1: CGPoint(x: 240, y: 181),
                            controlPoint2: CGPoint(x: 269, y: 210))
        curvyShape.addCurve(to: CGPoint(x: 335, y: 203),
                            controlPoint1: CGPoint(x: 316, y: 210),
                            controlPoint2: CGPoint(x: 326, y: 207))
        curvyShape.close()
        
        return curvyShape
    }
}

/* Template for creating more
 class TestShape_ : TestShape, SampleShapeMaker {
 
 init() {
 super.init(label: "AAAAAAAAAAAAAAAAAAA")
 }
 
 func otherShapes() -> UIBezierPath {
 }
 
 func topShape() -> UIBezierPath {
 }
 }
 */


// MARK: My extra debug shapes not from Andy Finnel's example


class TestShape_Debug : TestShape, SampleShapeMaker {
    
    init() {
        super.init(label: "- Debug -")
        
        unionDesiredString = "M300,152.5 L300,50 L50,50 L50,250 L152.5,250 C150.861,258.078 150,266.438 150,275 C150,344.036 205.964,400 275,400 C344.036,400 400,344.036 400,275 C400,214.526 357.056,164.082 300,152.5 L300,152.5 Z "
        intersectDesiredString = "M190,110 C190,121.046 198.954,130 210,130 C221.046,130 230,121.046 230,110 C230,98.9543 221.046,90 210,90 C198.954,90 190,98.9543 190,110 Z "
        differenceDesiresString = "M300,152.5 L300,50 L50,50 L50,250 L152.5,250 C150.861,258.078 150,266.438 150,275 C150,344.036 205.964,400 275,400 C344.036,400 400,344.036 400,275 C400,214.526 357.056,164.082 300,152.5 L300,152.5 Z M190,110 C190,98.9543 198.954,90 210,90 C221.046,90 230,98.9543 230,110 C230,121.046 221.046,130 210,130 C198.954,130 190,121.046 190,110 Z "
        
    }
    
    func otherShapes() -> UIBezierPath {
        let rect1 = UIBezierPath(rect: CGRect(x: 50, y: 50, width: 250, height: 200))
        let circle = UIBezierPath()
        addCircleAtPoint(CGPoint(x: 150+125, y: 150+125), withRadius: 125, toPath: circle)
        
        let joinedU = rect1.fb_union(circle)
        //var joinedD = rect1.fb_difference(circle)
        //var joinedI = rect1.fb_intersect(circle)
        //var joinedX = rect1.fb_xor(circle)
        
        return joinedU
    }
    
    func topShape() -> UIBezierPath {
        let circle = UIBezierPath()
        addCircleAtPoint(CGPoint(x: 210, y: 110), withRadius: 20, toPath: circle)
        //        var circle = UIBezierPath(ovalInRect: CGRect(x: 210-125, y: 200-125, width: 250, height: 250))
        return circle
    }
}

class TestShape_DebugQuadCurve : TestShape, SampleShapeMaker {
    
    init() {
        super.init(label: "Quad Curve Test")
        
        unionDesiredString = "M110.025,123.995 C110.008,124.328 110,124.663 110,125 C110,136.046 118.954,145 130,145 C141.046,145 150,136.046 150,125 C150,117.988 146.391,111.818 140.93,108.248 C143.953,105.773 146.977,103.023 150,100 L150,50 L50,50 L50,100 C70.0083,120.008 90.0165,128.007 110.025,123.995 Z "
        intersectDesiredString = "M110.025,123.995 C120.326,121.93 130.628,116.681 140.93,108.248 C137.788,106.194 134.033,105 130,105 C119.291,105 110.548,113.416 110.025,123.995 Z "
        differenceDesiresString = "M110.025,123.995 C110.548,113.416 119.291,105 130,105 C134.033,105 137.788,106.194 140.93,108.248 C143.953,105.773 146.977,103.023 150,100 L150,50 L50,50 L50,100 C70.0083,120.008 90.0165,128.007 110.025,123.995 Z "
        
    }
    
    func otherShapes() -> UIBezierPath {
        
        let quadTest = UIBezierPath()
        quadTest.move(to: CGPoint(x: 50, y: 50))
        quadTest.addLine(to: CGPoint(x: 50, y: 100))
        quadTest.addQuadCurve(to: CGPoint(x: 150, y: 100), controlPoint: CGPoint(x: 100, y: 150))
        quadTest.addLine(to: CGPoint(x: 150, y: 50))
        quadTest.addLine(to: CGPoint(x: 50, y: 50))
        quadTest.close()
        
        return quadTest
    }
    
    func topShape() -> UIBezierPath {
        let circle = UIBezierPath()
        addCircleAtPoint(CGPoint(x: 130, y: 125), withRadius: 20, toPath: circle)
        return circle
    }
}

class TestShape_Debug001 : TestShape, SampleShapeMaker {
    
    init() {
        super.init(label: "Debug 001")
        
        unionDesiredString = "M300,150 L300,50 L50,50 L50,250 L150,250 L150,400 L400,400 L400,150 L300,150 Z "
        intersectDesiredString = "M190,110 C190,121.046 198.954,130 210,130 C221.046,130 230,121.046 230,110 C230,98.9543 221.046,90 210,90 C198.954,90 190,98.9543 190,110 Z "
        differenceDesiresString = "M300,150 L300,50 L50,50 L50,250 L150,250 L150,400 L400,400 L400,150 L300,150 Z M190,110 C190,98.9543 198.954,90 210,90 C221.046,90 230,98.9543 230,110 C230,121.046 221.046,130 210,130 C198.954,130 190,121.046 190,110 Z "
        
    }
    
    func otherShapes() -> UIBezierPath {
        let rect1 = UIBezierPath(rect: CGRect(x: 50, y: 50, width: 250, height: 200))
        let rect2 = UIBezierPath(rect: CGRect(x: 150, y: 150, width: 250, height: 250))
        
        let joinedU = rect1.fb_union(rect2)
        //var joinedD = rect1.fb_difference(rect2)
        //var joinedI = rect1.fb_intersect(rect2)
        //var joinedX = rect1.fb_xor(rect2)
        
        return joinedU
    }
    
    func topShape() -> UIBezierPath {
        let circle = UIBezierPath()
        addCircleAtPoint(CGPoint(x: 210, y: 110), withRadius: 20, toPath: circle)
        //        var circle = UIBezierPath(ovalInRect: CGRect(x: 210-125, y: 200-125, width: 250, height: 250))
        return circle
    }
}

class TestShape_Debug002 : TestShape, SampleShapeMaker {
    
    init() {
        super.init(label: "Debug 002")
        
        unionDesiredString = "M300,113.253 L300,250 L95.4011,250 C88.7112,234.688 85,217.778 85,200 C85,130.964 140.964,75 210,75 C245.345,75 277.264,89.6699 300,113.253 L300,113.253 C300,113.253 300,113.253 300,113.253 L300,50 L50,50 L50,250 L95.4011,250 C114.69,294.148 158.742,325 210,325 C279.036,325 335,269.036 335,200 C335,166.31 321.672,135.732 300,113.253 L300,113.253 Z M190,110 C190,121.046 198.954,130 210,130 C221.046,130 230,121.046 230,110 C230,98.9543 221.046,90 210,90 C198.954,90 190,98.9543 190,110 Z "
        intersectDesiredString = ""
        differenceDesiresString = "M300,113.253 L300,250 L95.4011,250 C88.7112,234.688 85,217.778 85,200 C85,130.964 140.964,75 210,75 C245.345,75 277.264,89.6699 300,113.253 L300,113.253 C300,113.253 300,113.253 300,113.253 L300,50 L50,50 L50,250 L95.4011,250 C114.69,294.148 158.742,325 210,325 C279.036,325 335,269.036 335,200 C335,166.31 321.672,135.732 300,113.253 L300,113.253 Z "
        
    }
    
    func otherShapes() -> UIBezierPath {
        
        let holeyRectangle = UIBezierPath()
        //holeyRectangle.appendPath(UIBezierPath(rect: CGRect(x: 50, y: 50, width: 350, height: 300)))
        holeyRectangle.append(UIBezierPath(rect: CGRect(x: 50, y: 50, width: 250, height: 200)))
        //addCircleAtPoint(CGPoint(x: 210, y: 200), withRadius: 125, toPath: holeyRectangle)
        //var circle = UIBezierPath(ovalInRect: CGRect(x: 210-125, y: 200-125, width: 250, height: 250))
        let circle = UIBezierPath(ovalIn: CGRect(x: 210-125, y: 200-125, width: 250, height: 250))
        //var allParts = holeyRectangle.fb_difference(circle)
        //var allParts = holeyRectangle.fb_union(circle)
        //var allParts = holeyRectangle.fb_intersect(circle)
        let allParts = holeyRectangle.fb_xor(circle)
        return allParts
        /*
         holeyRectangle.appendPath(circle)
         
         var rectangle = UIBezierPath(rect: CGRect(x: 180, y: 5, width: 100, height: 400))
         //var allParts = holeyRectangle.fb_union(rectangle)
         var allParts = holeyRectangle.fb_difference(rectangle)
         //var allParts = holeyRectangle.fb_intersect(rectangle)
         return holeyRectangle // allParts
         */
    }
    
    func topShape() -> UIBezierPath {
        let circle = UIBezierPath()
        addCircleAtPoint(CGPoint(x: 210, y: 110), withRadius: 20, toPath: circle)
        //        var circle = UIBezierPath(ovalInRect: CGRect(x: 210-125, y: 200-125, width: 250, height: 250))
        return circle
    }
}

class TestShape_Debug003 : TestShape, SampleShapeMaker {
    
    init() {
        super.init(label: "Debug 003")
        
        unionDesiredString = "M176.777,176.777 L250,250 C250,204.464 237.826,161.772 216.554,125 C237.826,88.2283 250,45.5359 250,0 L176.777,73.2233 C131.536,27.9822 69.0356,0 0,0 L125,125 L0,250 C69.0356,250 131.536,222.018 176.777,176.777 Z "
        intersectDesiredString = "M176.777,176.777 C192.177,161.377 205.577,143.977 216.554,125 C205.577,106.023 192.177,88.6234 176.777,73.2233 L125,125 L176.777,176.777 Z "
        differenceDesiresString = "M176.777,176.777 L125,125 L0,250 C69.0356,250 131.536,222.018 176.777,176.777 Z M216.554,125 C237.826,88.2283 250,45.5359 250,0 L176.777,73.2233 C192.177,88.6234 205.577,106.023 216.554,125 Z "
    }
    
    func otherShapes() -> UIBezierPath {
        let arc2 = UIBezierPath()
        arc2.move(to: CGPoint(x: 0, y: 250))
        arc2.addCurve(
            to: CGPoint(x: 250, y: 0),
            controlPoint1: CGPoint(x: 138.071198, y: 250),
            controlPoint2: CGPoint(x: 250, y: 138.071198)
        )
        arc2.close()
        
        //let checkMe = LRTBezierPathWrapper(circle)
        
        return arc2
    }
    
    func topShape() -> UIBezierPath {
        let arc1 = UIBezierPath()
        arc1.move(to: CGPoint(x: 250, y: 250))
        arc1.addCurve(
            to: CGPoint(x: 0, y: 0),
            controlPoint1: CGPoint(x: 250, y: 111.928802),
            controlPoint2: CGPoint(x: 138.071198, y: 0)
        )
        arc1.close()
        
        return arc1
    }
}

// TODO: Track down why this has an extra point (visible in Subtract)

class TestShape_Rectangle_Sharing_Edge_With_Rectangle : TestShape, SampleShapeMaker {
    
    init() {
        super.init(label: "Shared Edge")
        
        unionDesiredString = "M75,10 L10,10 L10,140 L110,140 L110,90 L160,90 L160,10 L75,10 Z "
        intersectDesiredString = "M75,10 L40,10 L40,90 L110,90 L110,10 L75,10 Z "
        differenceDesiresString = "M75,10 L10,10 L10,140 L110,140 L110,90 L40,90 L40,10 L75,10 Z "
        
    }
    
    func otherShapes() -> UIBezierPath {
        return UIBezierPath(rect: CGRect(x: 10, y: 10, width: 100, height: 130))
    }
    
    func topShape() -> UIBezierPath {
        return UIBezierPath(rect: CGRect(x: 40, y: 10, width: 120, height: 80))
    }
}

class TestShape_Rectangle_Overlapping_Rectangle : TestShape, SampleShapeMaker {
    
    init() {
        super.init(label: "Rectangle Overlapping Rectangle")
        
        unionDesiredString = "M350,115 L350,50 L50,50 L50,250 L230,250 L230,365 L480,365 L480,115 L350,115 Z "
        intersectDesiredString = "M350,115 L230,115 L230,250 L350,250 L350,115 Z "
        differenceDesiresString = "M350,115 L350,50 L50,50 L50,250 L230,250 L230,115 L350,115 Z "
        
    }
    
    func otherShapes() -> UIBezierPath {
        return UIBezierPath(rect: CGRect(x: 50, y: 50, width: 300, height: 200))
    }
    
    func topShape() -> UIBezierPath {
        return UIBezierPath(rect: CGRect(x: 230, y: 115, width: 250, height: 250))
    }
}

class TestShape_Tiny_Rectangle_Overlapping_Rectangle : TestShape, SampleShapeMaker {
    
    init() {
        super.init(label: "Tiny Rect Over Rect")
        
        unionDesiredString = "M73,50 L73,48 L48,48 L48,73 L50,73 L50,80 L80,80 L80,50 L73,50 Z "
        intersectDesiredString = "M73,50 L50,50 L50,73 L73,73 L73,50 Z "
        differenceDesiresString = "M73,50 L73,73 L50,73 L50,80 L80,80 L80,50 L73,50 Z "
        
    }
    
    func otherShapes() -> UIBezierPath {
        return UIBezierPath(rect: CGRect(x: 50, y: 50, width: 30, height: 30))
    }
    
    func topShape() -> UIBezierPath {
        return UIBezierPath(rect: CGRect(x: 48, y: 48, width: 25, height: 25))
    }
}

class Wolf : TestShape, SampleShapeMaker {
    
    init() {
        super.init(label: "Wolf")
    }
    
    func moveTo(_ path: UIBezierPath, _ x: CGFloat, _ y: CGFloat) {
        path.move(to: CGPoint(x: x, y: y))
    }
    
    func lineTo(_ path: UIBezierPath, _ x: CGFloat, _ y: CGFloat) {
        path.addLine(to: CGPoint(x: x, y: y))
    }
    
    func closePath(_ path: UIBezierPath) {
        path.close()
    }
    
    func otherShapes() -> UIBezierPath {
        let path = UIBezierPath()
        
        //        moveTo(path,230.979,545.5)
        //        lineTo(path,520.493,719.234)
        //        lineTo(path,523.066,714.946)
        //        lineTo(path,233.552,541.212)
        //        lineTo(path,230.979,545.5)
        //        closePath(path)
        moveTo(path,233.552,541.212)
        lineTo(path,230.979,545.5)
        lineTo(path,520.493,719.234)
        lineTo(path,523.066,714.946)
        lineTo(path,233.552,541.212)
        closePath(path)
        
        return path
    }
    
    func topShape() -> UIBezierPath {
        let path = UIBezierPath()
        
        moveTo(path,236.383,524.834)
        lineTo(path,267.251,543.358)
        lineTo(path,248.727,574.227)
        lineTo(path,217.859,555.703)
        closePath(path)
        
        return path
    }
}

// MARK: Extra functions

func addCircleAtPoint(_ center: CGPoint, withRadius radius: CGFloat, toPath circle: UIBezierPath)
{
    let FBMagicNumber: CGFloat = 0.55228475
    
    let controlPointLength = radius * FBMagicNumber
    circle.move(to: CGPoint(x: center.x - radius, y: center.y))
    //[circle moveToPoint:NSMakePoint(center.x - radius, center.y)];
    
    circle.addCurve(
        to: CGPoint(x: center.x, y: center.y + radius),
        controlPoint1: CGPoint(x: center.x - radius, y: center.y + controlPointLength),
        controlPoint2: CGPoint(x: center.x - controlPointLength, y: center.y + radius)
    )
    //  [circle curveToPoint:NSMakePoint(center.x, center.y + radius) controlPoint1:NSMakePoint(center.x - radius, center.y + controlPointLength) controlPoint2:NSMakePoint(center.x - controlPointLength, center.y + radius)];
    
    circle.addCurve(
        to: CGPoint(x: center.x + radius, y: center.y),
        controlPoint1: CGPoint(x: center.x + controlPointLength, y: center.y + radius),
        controlPoint2: CGPoint(x: center.x + radius, y: center.y + controlPointLength)
    )
    //  [circle curveToPoint:NSMakePoint(center.x + radius, center.y) controlPoint1:NSMakePoint(center.x + controlPointLength, center.y + radius) controlPoint2:NSMakePoint(center.x + radius, center.y + controlPointLength)];
    
    circle.addCurve(
        to: CGPoint(x: center.x, y: center.y - radius),
        controlPoint1: CGPoint(x: center.x + radius, y: center.y - controlPointLength),
        controlPoint2: CGPoint(x: center.x + controlPointLength, y: center.y - radius)
    )
    //  [circle curveToPoint:NSMakePoint(center.x, center.y - radius) controlPoint1:NSMakePoint(center.x + radius, center.y - controlPointLength) controlPoint2:NSMakePoint(center.x + controlPointLength, center.y - radius)];
    
    circle.addCurve(
        to: CGPoint(x: center.x - radius, y: center.y),
        controlPoint1: CGPoint(x: center.x - controlPointLength, y: center.y - radius),
        controlPoint2: CGPoint(x: center.x - radius, y: center.y - controlPointLength)
    )
    //  [circle curveToPoint:NSMakePoint(center.x - radius, center.y) controlPoint1:NSMakePoint(x: center.x - controlPointLength, y: center.y - radius) controlPoint2:NSMakePoint(x: center.x - radius, y: center.y - controlPointLength)];
}

