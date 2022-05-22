//
//  MenuBarScrollView.swift
//  MenuBarWithScrollView
//
//  Created by 윤병일 on 2022/05/23.
//

import UIKit

class MenuBarScrollView : UIScrollView {

  //MARK: - Properties
  private let stackView : UIStackView = {
    let stackView = UIStackView()
    stackView.spacing = 20
    return stackView
  }()
  
  private let barView : UIView = {
    let view = UIView()
    view.backgroundColor = .red
    return view
  }()
  
  var didTap : ((Int, String?) -> ())?
  
  //MARK: - Init
  override init(frame: CGRect) {
    super.init(frame: frame)
    self.setupViews()
    self.setupLayout()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  //MARK: - Functions
  private func setupViews() {
    backgroundColor = .white
    showsHorizontalScrollIndicator = false
    
    [stackView, barView].forEach {
      self.addSubview($0)
    }
  }
  
  private func setupLayout() {
    stackView.snp.makeConstraints {
      $0.edges.equalToSuperview()
    }
    
    barView.snp.makeConstraints {
      $0.leading.bottom.equalToSuperview()
      $0.height.equalTo(8)
      $0.width.equalTo(10)
    }
  }
  
  func configure(titles : [String]) {
    titles.enumerated().forEach { (i , title) in
      stackView.addArrangedSubview(createButtons(title: title, tag: i))
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
    
    barView.snp.updateConstraints {
      $0.leading.equalTo(sender.frame.origin.x)
      $0.width.equalTo(sender.bounds.width)
    }
    
    UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {
      self.layoutIfNeeded()
    }, completion: nil)
  }
}
