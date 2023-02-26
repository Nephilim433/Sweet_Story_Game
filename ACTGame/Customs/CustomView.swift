
import UIKit

class CustomView: UIView {

    var label : CustomLabel!
    let backColor = UIView()

    init(frame:CGRect, string: String, fontSize: Int) {

        label = CustomLabel(title: string, fontSize: fontSize, outlineWidth: 6)
        super.init(frame: frame)
        self.backgroundColor = .clear
        self.addSubview(backColor)
        backColor.backgroundColor = .white

        self.addSubview(label)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        backColor.frame = self.bounds
        self.layer.cornerRadius = self.frame.height/2
        self.clipsToBounds = true
        label.frame = self.bounds
        
        self.gradientBorder(width: 5, colors: [Constants.upperColor,Constants.bottomColor], startPoint:.unitCoordinate(.top) , endPoint: .unitCoordinate(.bottom), andRoundCornersWithRadius: 25)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
