//
//  ViewController.swift
//  MenuBarWithScrollView
//
//  Created by 윤병일 on 2022/05/22.
//

import UIKit
import SnapKit

class ViewController: UIViewController {

  //MARK: - Properties
  private let titleLabel : UILabel = {
    let label = UILabel()
    label.textColor = .black
    return label
  }()
  
  private lazy var scrollView : MenuBarScrollView = {
    let scrollView = MenuBarScrollView()
    scrollView.didTap = { [weak self] index, title in
      guard let self = self else { return }
      self.titleLabel.text = title
    }
    scrollView.configure(titles: ["한국","일본","중국","미국","캐나다","멕시코","독일","프랑스","스위스","호주"])
    return scrollView
  }()
  
  //MARK: - LifeCycle
  override func viewDidLoad() {
    super.viewDidLoad()
    self.setupView()
    self.setupLayout()
  }

  //MARK: - Functions
  private func setupView() {
    view.backgroundColor = .white
    
    [titleLabel, scrollView].forEach {
      view.addSubview($0)
    }
  }
  
  private func setupLayout() {
    titleLabel.snp.makeConstraints {
      $0.centerX.centerY.equalToSuperview()
    }
    
    scrollView.snp.makeConstraints {
      $0.top.equalTo(titleLabel.snp.bottom)
      $0.leading.trailing.equalToSuperview()
      $0.height.equalTo(40)
    }
  }
}

