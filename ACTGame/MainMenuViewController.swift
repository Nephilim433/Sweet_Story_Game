
import UIKit
import SnapKit

class MainMenuViewController: UIViewController {

    lazy var backgroundImage = UIImageView(image: UIImage(named: "background"))
    lazy var lolipop = UIImageView(image: UIImage(named: "lollipop"))
    lazy var playButton = CustomButton(title: "PLAY")
    lazy var rulesButton = CustomButton(title: "GAME RULES")
    lazy var settingsButton = CustomButton(title: "SETTINGS")
    lazy var privacyButton = CustomButton(title: "PRIVACY POLICY")

    override func viewDidLoad() {
        view.addSubview(backgroundImage)
        view.addSubview(lolipop)
        view.addSubview(playButton)
        view.addSubview(rulesButton)
        view.addSubview(settingsButton)
        view.addSubview(privacyButton)

        playButton.addTarget(self, action: #selector(didTapPlay), for: .touchUpInside)
        rulesButton.addTarget(self, action: #selector(didTapRules), for: .touchUpInside)
        settingsButton.addTarget(self, action: #selector(didTapSettings), for: .touchUpInside)

        setupViews()
    }

    @objc func didTapSettings() {
        let vc = SettingsViewController()
        vc.modalPresentationStyle = .custom
        vc.transitioningDelegate = self

        self.present(vc, animated: true, completion: nil)
    }
    @objc func didTapPlay() {
        let vc = LevelsViewController()
        vc.modalPresentationStyle = .custom
        vc.transitioningDelegate = self
        self.present(vc, animated: true, completion: nil)
    }
    @objc func didTapRules() {

    }

    private func setupViews() {
        backgroundImage.snp.makeConstraints { make in
            make.left.top.right.bottom.equalToSuperview()
        }
        let loliheight = ((view.frame.width-40)/350)*233
        lolipop.snp.makeConstraints { make in
            make.top.lessThanOrEqualTo(view.snp_topMargin).offset(20)
            make.right.equalToSuperview().offset(-20)
            make.left.equalToSuperview().offset(20)
            make.height.equalTo(loliheight)
        }
        playButton.snp.makeConstraints { make in
            make.top.equalTo(lolipop.snp_bottomMargin).offset(40)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.height.equalTo(Constants.buttonHeight)
        }
        rulesButton.snp.makeConstraints { make in
            make.top.equalTo(playButton.snp_bottomMargin).offset(20)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.height.equalTo(Constants.buttonHeight)
        }

        settingsButton.snp.makeConstraints { make in
            make.top.equalTo(rulesButton.snp_bottomMargin).offset(20)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.height.equalTo(Constants.buttonHeight)
        }

        privacyButton.snp.makeConstraints { make in
            make.top.equalTo(settingsButton.snp_bottomMargin).offset(20)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.height.equalTo(Constants.buttonHeight)
        }
    }
    override var prefersStatusBarHidden: Bool {
        return true
    }
}

extension MainMenuViewController: UIViewControllerTransitioningDelegate {

    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return PresentTransition()
    }

    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return DismissTransition()
    }
}
