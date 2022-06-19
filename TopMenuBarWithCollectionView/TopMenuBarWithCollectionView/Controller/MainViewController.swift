//
//  MainViewController.swift
//  TopMenuBarWithCollectionView
//
//  Created by 윤병일 on 2022/06/19.
//

import UIKit
import SnapKit


class MainViewController : UIViewController {
  //MARK: - Properties
  private lazy var topMenuBar : TopMenuBar = {
    let menuBar = TopMenuBar()
    menuBar.didTap = { [weak self] index, title in
      guard let self = self else { return }
    }
    menuBar.configure(titles: ["한국","일본","중국","미국","캐나다","멕시코","독일","프랑스","스위스","호주"])
    return menuBar
  }()
  
  //MARK: - Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    setupLayout()
  }
  
  //MARK: - Functions
  private func setupLayout() {
    view.backgroundColor = .white
    
    [topMenuBar].forEach {
      view.addSubview($0)
    }
    
    topMenuBar.snp.makeConstraints {
      $0.top.equalTo(view.safeAreaLayoutGuide)
      $0.leading.trailing.equalToSuperview()
      $0.height.equalTo(40)
    }
  }
  
  //MARK: - @objc func
  
}
