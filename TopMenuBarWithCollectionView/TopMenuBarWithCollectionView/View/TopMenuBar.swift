//
//  TopMenuBar.swift
//  TopMenuBarWithCollectionView
//
//  Created by 윤병일 on 2022/06/19.
//

import UIKit
import SnapKit

class TopMenuBar : UIScrollView {
  
  //MARK: - Property
  private let stackView : UIStackView = {
    let stackView = UIStackView()
    stackView.spacing = 20
    return stackView
  }()
  
  private let underLineView : UIView = {
    let view = UIView()
    view.backgroundColor = .blue
    return view
  }()
  
  var didTap : ((Int, String?) -> Void)?
  
  //MARK: - Init
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupViews()
    setupLayout()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  //MARK: - Functions
  private func setupViews() {
    backgroundColor = .white
    showsHorizontalScrollIndicator = false
    
    [stackView, underLineView].forEach {
      self.addSubview($0)
    }
  }
  
  private func setupLayout() {
    stackView.snp.makeConstraints {
      $0.edges.equalToSuperview()
    }
    
    underLineView.snp.makeConstraints {
      $0.leading.bottom.equalToSuperview()
      $0.height.equalTo(5)
      $0.width.equalTo(10)
    }
  }
  
  func configure(titles : [String]) {
    titles.enumerated().forEach { (index, title) in
      stackView.addArrangedSubview(createButtons(title: title, tag: index))
    }
    layoutIfNeeded()
    
    if stackView.arrangedSubviews.count > 0, let first = stackView.arrangedSubviews.first as? UIButton {
      handleTap(first)
    }
  }
  
  private func createButtons(title : String, tag : Int) -> UIButton {
    let button = UIButton()
    button.setTitle(title, for: .normal)
    button.setTitleColor(.black, for: .normal)
    button.addTarget(self, action: #selector(handleTap), for: .touchUpInside)
    button.tag = tag
    return button
  }
  
  //MARK: - @objc func
  @objc private func handleTap(_ sender : UIButton) {
    
    didTap?(sender.tag, sender.titleLabel?.text)
    
    underLineView.snp.updateConstraints {
      $0.leading.equalTo(sender.frame.origin.x)
      $0.width.equalTo(sender.bounds.width)
    }
    
//    if sender.tag >= 3 && sender.tag <= 5{
//      print("하하 여길탄다")
//      self.setContentOffset(CGPoint(x: self.bounds.width / 2, y: 0), animated: true)
//    }
    
    UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {
      self.layoutIfNeeded()
    }, completion: nil)
  }
}
