
import Foundation
import UIKit

class CustomButton: UIButton {

    private lazy var gradientLayer: CAGradientLayer = {
        let gradient = CAGradientLayer()
        gradient.frame = self.bounds
        let upper = Constants.upperColor.cgColor
        let bottom = Constants.bottomColor.cgColor
        gradient.colors = [upper, bottom]
        gradient.startPoint = .unitCoordinate(.top)
        gradient.endPoint = .unitCoordinate(.bottom)
        gradient.cornerRadius = 16
        layer.insertSublayer(gradient, at: 0)
        return gradient
    }()

    init(title: String) {
        super.init(frame: .zero)
        self.layer.borderWidth = 5
        self.layer.borderColor = UIColor.white.cgColor
        self.layer.cornerRadius = 25
        self.clipsToBounds = true

        let label = UILabel()
        label.text = title
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = UIFont(name: "Knewave", size: 34)
        label.textColor = .white
        self.addSubview(label)
        label.snp.makeConstraints { make in
            make.center.equalTo(self.snp.center)
            make.width.equalTo(self.snp.width)
        }
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = self.bounds
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
