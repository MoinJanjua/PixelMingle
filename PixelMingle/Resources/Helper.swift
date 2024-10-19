//
//  Helper.swift
//  ImageEditot
//
//  Created by Unique Consulting Firm on 24/04/2024.
//

import Foundation
import UIKit

class HeartImageView: UIImageView {
    
    override func layoutSubviews() {
        super.layoutSubviews()
        applyHeartShape()
    }
    
    func applyHeartShape() {
        let heartPath = UIBezierPath()
       
            let width = self.bounds.width
            let height = self.bounds.height
       
           // Start from the bottom center of the heart
           heartPath.move(to: CGPoint(x: width / 2, y: height))
       
           // Draw the left curve
           heartPath.addCurve(to: CGPoint(x: 0, y: height / 4),
                              controlPoint1: CGPoint(x: width / 2, y: height * 3 / 4),
                              controlPoint2: CGPoint(x: 0, y: height / 2))
       
           // Draw the left top arc
           heartPath.addArc(withCenter: CGPoint(x: width / 4, y: height / 4),
                            radius: width / 4,
                            startAngle: CGFloat.pi,
                            endAngle: 0,
                            clockwise: true)
       
           // Draw the right top arc
           heartPath.addArc(withCenter: CGPoint(x: width * 3 / 4, y: height / 4),
                            radius: width / 4,
                            startAngle: CGFloat.pi,
                            endAngle: 0,
                            clockwise: true)
       
           // Draw the right curve
           heartPath.addCurve(to: CGPoint(x: width / 2, y: height),
                              controlPoint1: CGPoint(x: width, y: height / 2),
                              controlPoint2: CGPoint(x: width / 2, y: height * 3 / 4))
       
           // Close the path
           heartPath.close()
       
           // Create a shape layer for the heart
           let mask = CAShapeLayer()
           mask.path = heartPath.cgPath
        self.layer.mask = mask
    }
}
func applyHexagonMask(to imageView: UIImageView) {
    let path = hexagonPath(for: imageView.bounds)
    let mask = CAShapeLayer()
    mask.path = path.cgPath
    imageView.layer.mask = mask
}

func hexagonPath(for rect: CGRect) -> UIBezierPath {
    let path = UIBezierPath()
    let sideLength = rect.width / 2
    let center = CGPoint(x: rect.midX, y: rect.midY)
    let angle = CGFloat.pi / 3  // 60 degrees in radians
    
    for i in 0..<6 {
        let x = center.x + sideLength * cos(angle * CGFloat(i))
        let y = center.y + sideLength * sin(angle * CGFloat(i))
        if i == 0 {
            path.move(to: CGPoint(x: x, y: y))
        } else {
            path.addLine(to: CGPoint(x: x, y: y))
        }
    }
    path.close()
    
    return path
}
class ZigzagViewL: UIImageView {
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        // Define the zigzag path
        let path = UIBezierPath()
        let zigzagHeight: CGFloat = 10.0
        let zigzagWidth: CGFloat = rect.height / 10
        
        path.move(to: CGPoint(x: 0, y: 0))
        
        var isRight = true
        for i in stride(from: 0, to: rect.height, by: zigzagWidth) {
            let nextPoint = CGPoint(x: isRight ? zigzagHeight : 0, y: i)
            path.addLine(to: nextPoint)
            isRight.toggle()
        }
        
        path.addLine(to: CGPoint(x: 0, y: rect.height))
        
        // Set the stroke color and width
        UIColor.black.setStroke()
        path.lineWidth = 2.0
        path.stroke()
    }
}
extension UIImageView {
    func applyCustomStyle(cornerRadius: CGFloat, shadowColor: UIColor, shadowOffset: CGSize, shadowOpacity: Float, shadowRadius: CGFloat, backgroundOpacity: CGFloat) {
        self.layer.cornerRadius = cornerRadius
        self.layer.masksToBounds = false
        self.layer.shadowColor = shadowColor.cgColor
        self.layer.shadowOffset = shadowOffset
        self.layer.shadowOpacity = shadowOpacity
        self.layer.shadowRadius = shadowRadius
        self.alpha = backgroundOpacity
    }
}

@IBDesignable extension UIButton {    
    func applyCustomStyle(cornerRadius: CGFloat = 15, shadowColor: UIColor = .black, shadowOffset: CGSize = CGSize(width: 0, height: 2), shadowOpacity: Float = 0.3, shadowRadius: CGFloat = 4.0, backgroundOpacity: CGFloat = 1.0) {
        
        // Set corner radius
        self.layer.cornerRadius = cornerRadius
        
        // Set up shadow properties
        self.layer.shadowColor = shadowColor.cgColor
        self.layer.shadowOffset = shadowOffset
        self.layer.shadowOpacity = shadowOpacity
        self.layer.shadowRadius = shadowRadius
        self.layer.masksToBounds = false
        
        // Set background opacity
        self.alpha = backgroundOpacity // Adjust opacity as needed
    }
    @IBInspectable var borderWidth: CGFloat {
        set {
            layer.borderWidth = newValue
        }
        get {
            return layer.borderWidth
        }
    }

    @IBInspectable var cornerRadius: CGFloat {
        set {
            layer.cornerRadius = newValue
        }
        get {
            return layer.cornerRadius
        }
    }

    @IBInspectable var borderColor: UIColor? {
        set {
            guard let uiColor = newValue else { return }
            layer.borderColor = uiColor.cgColor
        }
        get {
            guard let color = layer.borderColor else { return nil }
            return UIColor(cgColor: color)
        }
    }
}

@IBDesignable extension UILabel {

    @IBInspectable var borderWidth2: CGFloat {
        set {
            layer.borderWidth = newValue
        }
        get {
            return layer.borderWidth
        }
    }

    @IBInspectable var cornerRadius2: CGFloat {
        set {
            layer.cornerRadius = newValue
        }
        get {
            return layer.cornerRadius
        }
    }

    @IBInspectable var borderColor2: UIColor? {
        set {
            guard let uiColor = newValue else { return }
            layer.borderColor = uiColor.cgColor
        }
        get {
            guard let color = layer.borderColor else { return nil }
            return UIColor(cgColor: color)
        }
    }
}

@IBDesignable extension UIView {

    @IBInspectable var borderWidth1: CGFloat {
        set {
            layer.borderWidth = newValue
        }
        get {
            return layer.borderWidth
        }
    }

    @IBInspectable var cornerRadius1: CGFloat {
        set {
            layer.cornerRadius = newValue
        }
        get {
            return layer.cornerRadius
        }
    }

    @IBInspectable var borderColor1: UIColor? {
        set {
            guard let uiColor = newValue else { return }
            layer.borderColor = uiColor.cgColor
        }
        get {
            guard let color = layer.borderColor else { return nil }
            return UIColor(cgColor: color)
        }
    }
}

func makeImageViewCircular(imageview:UIImageView) {
    imageview.layer.cornerRadius = imageview.frame.size.width / 2
    imageview.clipsToBounds = true
    }
func roundCorner(button:UIButton)
{
    button.layer.cornerRadius = button.frame.size.height/2
    button.clipsToBounds = true
}
func viewShadow (view:UIView)
{
    // Set up shadow properties
    view.layer.shadowColor = UIColor.black.cgColor
    view.layer.shadowOffset = CGSize(width: 0, height: 2)
    view.layer.shadowOpacity = 0.3
    view.layer.shadowRadius = 4.0
    view.layer.masksToBounds = false
      
      // Set background opacity
    //contentView.alpha = 0.9 // Adjust opacity as needed
}
func addDottedBorder(to imageView: UIImageView) {
     let dottedBorder = CAShapeLayer()
     
     // Set the shape of the dotted border
     dottedBorder.path = UIBezierPath(rect: imageView.bounds).cgPath
     
     // Set the frame and other properties of the border
     dottedBorder.frame = imageView.bounds
     dottedBorder.strokeColor = UIColor.systemBlue.cgColor  // Border color
     dottedBorder.lineDashPattern = [6, 3]  // 6 points line, 3 points space
     dottedBorder.lineWidth = 2  // Border width
     dottedBorder.fillColor = nil  // No fill color
     
     // Add the border to the image view
     imageView.layer.addSublayer(dottedBorder)
 }




struct Transaction: Codable,Equatable {
    var amount: String
    var type: String // "Income" or "Expense"
    var reason: String
    var dateTime: Date
    var budget:String
    
    static func == (lhs: Transaction, rhs: Transaction) -> Bool {
           return lhs.amount == rhs.amount &&
               lhs.type == rhs.type &&
               lhs.reason == rhs.reason &&
               lhs.dateTime == rhs.dateTime &&
               lhs.budget == rhs.budget
       }
}

var currency = ""

func formatAmount(_ amount: String) -> String {
    let formatter = NumberFormatter()
    formatter.numberStyle = .decimal
    formatter.minimumFractionDigits = 2
    formatter.maximumFractionDigits = 2
    
    // Convert amount to a number
    if let number = formatter.number(from: amount) {
        return formatter.string(from: number) ?? amount
    } else {
        // If conversion fails, assume there's no dot and add two zeros after it
        let amountWithDot = amount + ".00"
        return formatter.string(from: formatter.number(from: amountWithDot)!) ?? amountWithDot
    }
}

extension UIViewController
{
    func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
    
    func showToast(message : String, font: UIFont) {
        
        let toastLabel = UILabel(frame: CGRect(x: self.view.frame.size.width/2 - 75, y: self.view.frame.size.height-100, width: 150, height: 35))
        toastLabel.backgroundColor = UIColor.purple
        toastLabel.textColor = UIColor.black
        toastLabel.font = font
        toastLabel.textAlignment = .center;
        toastLabel.text = message
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 10;
        toastLabel.clipsToBounds  =  true
        self.view.addSubview(toastLabel)
        UIView.animate(withDuration: 4.0, delay: 0.1, options: .curveEaseOut, animations: {
            toastLabel.alpha = 0.0
        }, completion: {(isCompleted) in
            toastLabel.removeFromSuperview()
        })
    }
}


extension UIView {
    func showToast(message: String, font: UIFont) {
        let toastLabel = UILabel(frame: CGRect(x: self.frame.size.width/2 - 75, y: self.frame.size.height - 100, width: 250, height: 35))
        toastLabel.backgroundColor = UIColor.purple
        toastLabel.textColor = UIColor.white
        toastLabel.font = font
        toastLabel.textAlignment = .center
        toastLabel.text = message
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 10
        toastLabel.clipsToBounds = true
        self.addSubview(toastLabel)
        UIView.animate(withDuration: 4.0, delay: 0.1, options: .curveEaseOut, animations: {
            toastLabel.alpha = 0.0
        }, completion: { _ in
            toastLabel.removeFromSuperview()
        })
    }
}

    

var layoutImages: [UIImage] = [UIImage(named: "square110")!,UIImage(named: "2")!,UIImage(named: "3")!,UIImage(named: "4")!,UIImage(named: "5")!,UIImage(named: "6")!,UIImage(named: "sq.Re")!,UIImage(named: "dynamic rect")!,UIImage(named: "love")!,UIImage(named: "2 rects")!,UIImage(named: "2")!,UIImage(named: "circles")!,UIImage(named: "rects")!,UIImage(named: "hexagona")!,UIImage(named: "rect")!]


//    var WallpapersList: [UIImage] = [UIImage(named: "1")!,UIImage(named: "2")!,UIImage(named: "three")!,UIImage(named: "four")!,UIImage(named: "five")!,UIImage(named: "six")!,UIImage(named: "7")!,UIImage(named: "8")!,UIImage(named: "9")!,UIImage(named: "10")!,UIImage(named: "11")!,UIImage(named: "12")!,UIImage(named: "13")!,UIImage(named: "14")!,UIImage(named: "15")!,UIImage(named: "16")!,UIImage(named: "17")!,UIImage(named: "18")!,UIImage(named: "19")!,UIImage(named: "20")!,UIImage(named: "21")!,UIImage(named: "22")!,UIImage(named: "23")!,UIImage(named: "24")!,UIImage(named: "25")!,UIImage(named: "26")!,UIImage(named: "27")!,UIImage(named: "28")!,UIImage(named: "29")!,UIImage(named: "30")!,UIImage(named: "31")!,UIImage(named: "32")!,UIImage(named: "33")!,UIImage(named: "34")!,UIImage(named: "35")!,UIImage(named: "36")!,UIImage(named: "37")!,UIImage(named: "38")!,UIImage(named: "39")!,UIImage(named: "40")!,UIImage(named: "41")!,UIImage(named: "42")!,UIImage(named: "43")!,UIImage(named: "44")!,UIImage(named: "45")!,UIImage(named: "46")!,UIImage(named: "47")!,UIImage(named: "48")!,UIImage(named: "49")!,UIImage(named: "50")!]


















// func applyHeartShape(to imageView: UIImageView) {
//    let heartPath = UIBezierPath()
//
//     let width = imageView.bounds.width
//     let height = imageView.bounds.height
//
//    // Start from the bottom center of the heart
//    heartPath.move(to: CGPoint(x: width / 2, y: height))
//
//    // Draw the left curve
//    heartPath.addCurve(to: CGPoint(x: 0, y: height / 4),
//                       controlPoint1: CGPoint(x: width / 2, y: height * 3 / 4),
//                       controlPoint2: CGPoint(x: 0, y: height / 2))
//
//    // Draw the left top arc
//    heartPath.addArc(withCenter: CGPoint(x: width / 4, y: height / 4),
//                     radius: width / 4,
//                     startAngle: CGFloat.pi,
//                     endAngle: 0,
//                     clockwise: true)
//
//    // Draw the right top arc
//    heartPath.addArc(withCenter: CGPoint(x: width * 3 / 4, y: height / 4),
//                     radius: width / 4,
//                     startAngle: CGFloat.pi,
//                     endAngle: 0,
//                     clockwise: true)
//
//    // Draw the right curve
//    heartPath.addCurve(to: CGPoint(x: width / 2, y: height),
//                       controlPoint1: CGPoint(x: width, y: height / 2),
//                       controlPoint2: CGPoint(x: width / 2, y: height * 3 / 4))
//
//    // Close the path
//    heartPath.close()
//
//    // Create a shape layer for the heart
//    let mask = CAShapeLayer()
//    mask.path = heartPath.cgPath
//     imageView.layer.mask = mask
//}
