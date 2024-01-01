//
//  Extension + UIViewController.swift
//  Custom UIComponents
//
//  Created by Farhana Khan on 01/01/24.
//

import UIKit

extension UIViewController {

    func curvedShapeFor(view: UIImageView, curvedPercent:CGFloat) ->UIBezierPath
    {
        let path = UIBezierPath()
        path.move(to: CGPoint(x:0, y:0))
        path.addLine(to: CGPoint(x:view.bounds.size.width, y:0))
        path.addLine(to: CGPoint(x:view.bounds.size.width, y:view.bounds.size.height - (view.bounds.size.height*curvedPercent)))
        path.addQuadCurve(to: CGPoint(x:0, y:view.bounds.size.height - (view.bounds.size.height*curvedPercent)), controlPoint: CGPoint(x:view.bounds.size.width/2, y:view.bounds.size.height))
        path.addLine(to: CGPoint(x:0, y:0))
        path.close()

        return path
    }
    
}
