

import UIKit
import SnapKit

class LevelViewController: UIViewController {

    var level: Int?
    let levelTitleView: CustomView!
    let timeView = CustomView(frame: .zero, string: "02:55", fontSize: 24)
    lazy var bigPuzzleImage = UIImageView()
    lazy var smallPuzzleImage = UIImageView()
    lazy var backgroundImage = UIImageView(image: UIImage(named: "background"))
    lazy var reloadButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "reloadButtonSmall"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(reloadButtonTapped), for: .touchUpInside)
        return button
    }()
    lazy var backButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "backButtonSmall"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        return button
    }()
    lazy var complitedView : LevelComplited = {
        let view = LevelComplited()
        view.isHidden = true
        return view
    }()
    lazy var failedView : LevelFailed = {
        let view = LevelFailed()
        view.isHidden = true
        return view
    }()

    init(level: Int) {
        self.level = level
        levelTitleView = CustomView(frame: .zero, string: "LVL-\(level)", fontSize: 24)
//        timeView.label.text = "3:00"
//        timeView.label.text = "0:00"
//        updateTime()
        counter = 180-((level-1)*10)

        super.init(nibName: nil, bundle: nil)
        updateTime()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    var timer : Timer!
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(backgroundImage)
        view.addSubview(levelTitleView)
        view.addSubview(timeView)
        view.addSubview(reloadButton)
        view.addSubview(backButton)

        view.addSubview(bigPuzzleImage)
        view.addSubview(smallPuzzleImage)
        if level == 1 {
            bigPuzzleImage.image = UIImage(named: "unpazzled")
            smallPuzzleImage.image = UIImage(named: "puzzle1small")
        } else {
            let str = String(level!)
            bigPuzzleImage.image = UIImage(named: "puzzle\(str)")
            smallPuzzleImage.image = UIImage(named: "puzzle\(str)small")
        }

        let bigTap = UITapGestureRecognizer(target: self, action: #selector(bigImageTapped))
        bigPuzzleImage.addGestureRecognizer(bigTap)
        bigPuzzleImage.isUserInteractionEnabled = true

        let smallTap = UITapGestureRecognizer(target: self, action: #selector(smallImageTapped))
        smallPuzzleImage.addGestureRecognizer(smallTap)
        smallPuzzleImage.isUserInteractionEnabled = true

        view.addSubview(failedView)
        view.addSubview(complitedView)

        setupViews()

    }

    override func viewDidAppear(_ animated: Bool) {

        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
    }


    var counter: Int

    @objc func updateTime() {
        if counter > 0 {
            let time = getTime(time: counter)
            timeView.label.text = time
        counter -= 1
        } else {
            timer.invalidate()
            smallImageTapped()
            timeView.label.text = "0:00"
        }

    }


    @objc func bigImageTapped() {
        complitedView.isHidden = false
    }

    @objc func smallImageTapped() {
        failedView.isHidden = false
    }

    @objc func backButtonTapped() {
        self.dismiss(animated: true, completion: nil)
    }
    @objc func reloadButtonTapped() {
        failedView.isHidden = false
    }


    private func setupViews() {
        backgroundImage.snp.makeConstraints { make in
            make.top.left.right.bottom.equalToSuperview()
        }
        let size = view.frame.width-40
        let sizeSmall = view.frame.width-148
        let padding = (view.frame.height-44-size-sizeSmall-22)/4
        levelTitleView.snp.makeConstraints { make in
            make.centerX.equalTo(view.snp.centerX)
            make.top.equalToSuperview().offset(padding+22)
            make.height.equalTo(44)
            make.width.equalTo(110)
        }
        timeView.snp.makeConstraints { make in
            make.centerY.equalTo(levelTitleView.snp.centerY)
            make.left.equalTo(levelTitleView.snp_rightMargin).offset(20)
            make.height.equalTo(44)
            make.width.equalTo(110)
        }

        //MARK: - WTF?
        reloadButton.snp.makeConstraints { make in
            make.centerY.equalTo(levelTitleView.snp.centerY)
            make.right.equalTo(levelTitleView.snp.left).offset(-20)
            make.height.width.equalTo(44)
        }

        backButton.snp.makeConstraints { make in
            make.centerY.equalTo(levelTitleView.snp.centerY)
            make.right.equalTo(reloadButton.snp.left).offset(-10)
            make.height.width.equalTo(44)
        }

        bigPuzzleImage.snp.makeConstraints { make in
            make.top.equalTo(levelTitleView.snp.bottom).offset(padding)
            make.right.equalToSuperview().offset(-20)
            make.left.equalToSuperview().offset(20)
            make.height.equalTo(size)
        }

        smallPuzzleImage.snp.makeConstraints { make in
            make.top.equalTo(bigPuzzleImage.snp.bottom).offset(padding)
            make.right.equalToSuperview().offset(-74)
            make.left.equalToSuperview().offset(74)
            make.height.equalTo(sizeSmall)
            make.bottom.equalToSuperview().offset(-padding)
        }
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        failedView.frame = view.bounds
        complitedView.frame = view.bounds
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }

    func secsToMins(_ seconds: Int) -> (Int, Int) {
        return ((seconds % 3600) / 60, (seconds % 3600) % 60)
    }
    func getTime(time: Int) -> String {
        let interval = TimeInterval(time)
        let minute = Int(interval) / 60 % 60
        let second = Int(interval)  % 60
        return String(format: "%02i:%02i", minute,second)
    }
 }





