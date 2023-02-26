
import Foundation
import UIKit


public class CustomLabel: UILabel {


    init(title: String, fontSize: Int, outlineWidth: Int ) {
        super.init(frame: .zero)
        self.text = title
        self.translatesAutoresizingMaskIntoConstraints = false
        self.outlineWidth = CGFloat(outlineWidth)
        self.textAlignment = .center
        self.font = UIFont(name: "Knewave", size: CGFloat(fontSize))
        self.textColor = .white
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    internal var mOutlineColor:UIColor?
    internal var mOutlineWidth:CGFloat?

    var outlineColor: UIColor{
        get { return mOutlineColor ?? UIColor.clear }
        set { mOutlineColor = newValue }
    }

    var outlineWidth: CGFloat{
        get { return mOutlineWidth ?? 0 }
        set { mOutlineWidth = newValue }
    }

    func getGradientImage(bounds:CGRect) -> UIImage {
        let gradientLayer = CAGradientLayer()
        let upper = Constants.upperColor.cgColor
        let bottom = Constants.bottomColor.cgColor
        gradientLayer.colors = [upper, bottom]
        gradientLayer.bounds = bounds
        UIGraphicsBeginImageContextWithOptions(gradientLayer.bounds.size, true, 0.0)
        let context = UIGraphicsGetCurrentContext()
        gradientLayer.render(in: context!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }

    override public func drawText(in rect: CGRect) {
        let shadowOffset = self.shadowOffset
        let textColor = self.textColor

        let c = UIGraphicsGetCurrentContext()

        c?.setLineWidth(outlineWidth)
        c?.setLineJoin(.round)
        c?.setTextDrawingMode(.stroke)

        let image = getGradientImage(bounds: self.bounds)
        self.textColor = UIColor(patternImage: image)
        super.drawText(in:rect)
        gradientLayer.render(in: c!)
        c?.setTextDrawingMode(.fill)
        self.textColor = textColor
        self.shadowOffset = CGSize(width: 0, height: 0)
        super.drawText(in:rect)
        self.shadowOffset = shadowOffset
    }

    private let gradientLayer: CAGradientLayer = {
        let layer = CAGradientLayer()
        let upper = Constants.upperColor.cgColor
        let bottom = Constants.bottomColor.cgColor
        layer.colors = [upper, bottom]
        layer.startPoint = .unitCoordinate(.top)
        layer.endPoint = .unitCoordinate(.bottom)
        layer.cornerRadius = 16
        return layer
    }()
}
