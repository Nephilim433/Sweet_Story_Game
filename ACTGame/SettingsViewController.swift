
import UIKit
import SnapKit

class SettingsViewController: UIViewController {
    lazy var backgroundImage = UIImageView(image: UIImage(named: "background"))
    lazy var titleLabel = CustomLabel(title: "SETTINGS", fontSize: 34, outlineWidth: 10)
    lazy var soundButton = CustomButton(title: "SOUND")
    lazy var vibroButton = CustomButton(title: "VIBRO")
    lazy var rateUsButton = CustomButton(title: "RATE US")

    lazy var backButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "backButton"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(didTapBack), for: .touchUpInside)
        return button
    }()
    lazy var checkboxYes: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "checked=yes"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    lazy var checkboxNo: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "checked=no"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    override func viewDidLoad() {
        view.addSubview(backgroundImage)
        view.addSubview(titleLabel)
        view.addSubview(backButton)
        view.addSubview(checkboxYes)
        view.addSubview(checkboxNo)
        view.addSubview(soundButton)
        view.addSubview(rateUsButton)
        view.addSubview(vibroButton)

        setupViews()
    }

    @objc func didTapBack() {
        self.dismiss(animated: true, completion: nil)
    }

    private func setupViews() {
        backgroundImage.snp.makeConstraints { make in
            make.top.left.right.bottom.equalToSuperview()
        }

        let size = view.frame.width-40
        let sizeSmall = view.frame.width-148
        let padding = (view.frame.height-44-size-sizeSmall-22)/4

        backButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(padding+22)
            make.left.equalToSuperview().offset(20)
        }

        titleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalTo(backButton.snp.centerY)
            make.width.equalTo(170)
        }

        checkboxYes.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(192)
            make.right.equalToSuperview().offset(-20)
            make.width.height.equalTo(60)
        }
        checkboxNo.snp.makeConstraints { make in
            make.top.equalTo(checkboxYes.snp_bottomMargin).offset(26)
            make.right.equalToSuperview().offset(-20)
            make.width.height.equalTo(60)
        }
        soundButton.snp.makeConstraints { make in
            make.bottom.equalTo(checkboxYes.snp.bottom)
            make.left.equalToSuperview().offset(20)
            make.right.equalTo(checkboxYes.snp_leftMargin).offset(-20)
            make.height.equalTo(Constants.buttonHeight)
        }
        vibroButton.snp.makeConstraints { make in
            make.bottom.equalTo(checkboxNo.snp.bottom)
            make.left.equalToSuperview().offset(20)
            make.right.equalTo(checkboxNo.snp_leftMargin).offset(-20)
            make.height.equalTo(Constants.buttonHeight)
        }
        rateUsButton.snp.makeConstraints { make in
            make.top.equalTo(vibroButton.snp.bottom).offset(20)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.height.equalTo(Constants.buttonHeight)
        }
    }
}



