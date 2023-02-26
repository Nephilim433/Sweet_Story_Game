
import UIKit

class LevelsViewController: UIViewController {

    var collectionView : UICollectionView?
    lazy var titleLabel = CustomLabel(title: "LEVELS", fontSize: 34, outlineWidth: 10)
    lazy var backgroundImage = UIImageView(image: UIImage(named: "background"))
    lazy var backButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "backButton"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        return button
    }()
    lazy var layout : UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        let size = (view.frame.width-60)/3
        layout.itemSize = CGSize(width: size, height: size)
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 5
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 10, right: 0)
        return layout
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(backgroundImage)
        view.addSubview(titleLabel)
        view.addSubview(backButton)

        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        guard let collectionView = collectionView else {
            return
        }
        view.addSubview(collectionView)

        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.isScrollEnabled = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false

        collectionView.backgroundColor = .clear
        collectionView.register(LevelCell.self, forCellWithReuseIdentifier: LevelCell.identifier)
        setupViews()
    }

    @objc func backButtonTapped() {
        self.dismiss(animated: true, completion: nil)
    }

    private func setupViews() {

        let size = view.frame.width-40
        let sizeSmall = view.frame.width-148
        let padding = (view.frame.height-44-size-sizeSmall-22)/4
        backgroundImage.snp.makeConstraints { make in
            make.top.left.right.bottom.equalToSuperview()
        }

        backButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(padding+22)
            make.left.equalToSuperview().offset(20)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalTo(backButton.snp.centerY)
            make.width.equalTo(170)
        }

        collectionView?.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(30)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.bottom.equalToSuperview().offset(-20)
        }
    }
}

extension LevelsViewController: UICollectionViewDelegate,UICollectionViewDataSource {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 12
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LevelCell.identifier, for: indexPath) as? LevelCell else { return UICollectionViewCell() }
        cell.configure(with: indexPath.row+1)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: false)
        let vc = LevelViewController(level: indexPath.row+1)
        vc.modalPresentationStyle = .custom
        vc.transitioningDelegate = self
        self.present(vc, animated: true, completion: nil)
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
}

extension LevelsViewController: UIViewControllerTransitioningDelegate {

    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return PresentTransition()
    }

    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return DismissTransition()
    }
}
