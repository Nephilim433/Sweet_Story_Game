
import UIKit
import SnapKit

class LevelComplited: UIView {

    let label = CustomLabel(title: "LEVEL COMPLETED", fontSize: 64, outlineWidth: 20)
    let imageView = UIImageView(image: UIImage(named: "completed"))
    let timeView : CustomView = CustomView(frame: .zero, string: "TIME: 00:44", fontSize: 34)
    let bestTimeView : CustomView = CustomView(frame: .zero, string: "BEST TIME: 01:02", fontSize: 34)
    let transparent = UIView()
    lazy var reloadButton : UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "reloadButtonBig"), for: .normal)
        button.addTarget(self, action: #selector(selfHide), for: .touchUpInside)
        return button
    }()
    lazy var houseButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "houseButton"), for: .normal)
        button.addTarget(self, action: #selector(selfHide), for: .touchUpInside)
        return button
    }()
    lazy var arrowButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "grayArrowButton"), for: .normal)
        return button
    }()
    lazy var actions = UIImageView(image: UIImage(named: "actionsWin"))
    
    @objc func selfHide() {
        self.isHidden = true
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(transparent)
        transparent.backgroundColor = .black
        transparent.alpha = 0.7

        addSubview(imageView)
        addSubview(label)
        label.numberOfLines = 2
        addSubview(timeView)
        addSubview(bestTimeView)
        addSubview(reloadButton)
        addSubview(houseButton)
        addSubview(arrowButton)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        transparent.frame = self.bounds

        let threeButtons = (Constants.buttonHeight*3)
        var padding = ((self.frame.height-label.frame.maxY - threeButtons)-30)/3
        padding = padding < 5 ? 5 : padding
        padding = padding > 22 ? 22 : padding

        let labelHeight = DynamicLableSize.heightForZeroLines(text: label.text, font: label.font, width: self.frame.width-20)
        let y = (self.frame.height/2) - ((labelHeight/2))
        label.frame = CGRect(x: 10, y: y, width: self.frame.width-20, height: labelHeight)

        let imageSize = CGSize(width: self.frame.width, height: (self.frame.width/390)*347)
        imageView.frame = CGRect(x: 0, y: label.center.y-imageView.frame.height, width: imageSize.width, height: imageSize.height)

        let timeViewy = label.frame.maxY+padding
        let width = self.frame.width-40
        timeView.frame = CGRect(x: 20, y: timeViewy, width: width, height: Constants.buttonHeight)
        let midpadding = (padding/2) < 5 ? 5 : padding/2
        let bestTimeViewy2 = timeView.frame.maxY+(midpadding)
        bestTimeView.frame = CGRect(x: 20, y: bestTimeViewy2, width: width, height: Constants.buttonHeight)

        let reloadY = bestTimeView.frame.maxY+padding
        let w = (self.frame.width)/2
        let reloadX =  w - (Constants.buttonHeight/2)
        let size = CGSize(width: Constants.buttonHeight, height: Constants.buttonHeight)
        let reloadButtonOrigin = CGPoint(x: reloadX, y: reloadY)
        reloadButton.frame = CGRect(origin: reloadButtonOrigin, size: size)

        let houseButtonOrigin = CGPoint(x: 60, y: reloadButton.frame.minY)
        houseButton.frame = CGRect(origin: houseButtonOrigin, size: size)
        let arrowX = (self.frame.width  - (Constants.buttonHeight + 60))
        let arrowButtonOrigin = CGPoint(x: arrowX, y: reloadButton.frame.minY)
        arrowButton.frame = CGRect(origin: arrowButtonOrigin, size: size)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
