
import UIKit

class LevelCell: UICollectionViewCell {

    static let identifier = "LevelCell"
    var isOpen = false

    private let imageView : UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(imageView)
    }

    override func layoutSubviews() {
        imageView.frame = contentView.bounds
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(with number: Int) {
        isOpen = number == 1
        let str = isOpen ? "level\(number)miniOpen" : "level\(number)miniClosed"
        imageView.image = UIImage(named: str)
    }
}
