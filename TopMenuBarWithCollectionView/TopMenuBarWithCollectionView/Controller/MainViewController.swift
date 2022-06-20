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
  
  let data : [String] = ["한국","일본","중국","미국","캐나다","멕시코","독일","프랑스","스위스","호주"]
  
  private lazy var topMenuBar : TopMenuBar = {
    let menuBar = TopMenuBar()
    menuBar.didTap = { [weak self] index, title, originX in
      guard let self = self else { return }
      DispatchQueue.main.async {
        self.bottomCollectionView.scrollToItem(at: IndexPath(item: index, section: .zero), at: .centeredHorizontally, animated: true)
      }
      
    }
    menuBar.configure(titles: data)
    return menuBar
  }()
  
  lazy var bottomCollectionView : UICollectionView = {
    let layout = UICollectionViewFlowLayout()
    layout.scrollDirection = .horizontal
    return UICollectionView(frame: .zero, collectionViewLayout: layout)
  }()
  
  private let colorData : [UIColor] = [.yellow, .blue, .red, .black, .purple, .systemPink, .brown, .cyan, .darkGray, .green]
  
  //MARK: - Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    setupLayout()
    configureUI()
  }
  
  //MARK: - Functions
  private func setupLayout() {
    view.backgroundColor = .white
    
    [topMenuBar, bottomCollectionView].forEach {
      view.addSubview($0)
    }
    
    topMenuBar.snp.makeConstraints {
      $0.top.equalTo(view.safeAreaLayoutGuide)
      $0.leading.trailing.equalToSuperview()
      $0.height.equalTo(40)
    }
    
    bottomCollectionView.snp.makeConstraints {
      $0.top.equalTo(topMenuBar.snp.bottom)
      $0.leading.trailing.bottom.equalToSuperview()
    }
  }
  
  private func configureUI() {
    bottomCollectionView.backgroundColor = .white
    bottomCollectionView.delegate = self
    bottomCollectionView.dataSource = self
    bottomCollectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "collectionView")
    bottomCollectionView.isPagingEnabled = true
  }
}

  //MARK: - Extension UICollectionViewDataSource
extension MainViewController : UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return data.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionView", for: indexPath)
    cell.backgroundColor = colorData[indexPath.row]
    return cell
  }
}

  //MARK: - Extension UICollectionViewDelegate
extension MainViewController : UICollectionViewDelegate {
  func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {

  }
}

  //MARK: - Extension UICollectionViewDelegateFlowLayout
extension MainViewController : UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    let width = self.view.frame.size.width
    let height = self.bottomCollectionView.frame.size.height // 그전에는 self.view.frame.size.height 로 했는데 잘 동작하지 않음 -> 항목 높이는 UICollectionView의 높이에서 섹션 삽입 상단 및 하단 값에서 콘텐츠 삽입 상단 및 하단 값을 뺀 값보다 작아야 합니다.
    return CGSize(width: width, height: height)
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
    return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    return 0
  }
}
