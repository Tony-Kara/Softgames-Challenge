//
//  FormView.swift
//  Softgames Test
//
//  Created by Eniola Anthony on 25.05.2022.

import Foundation
import UIKit
import WebKit

class FormView: UIView {
  
  // MARK: - Public properties
  
  func webToiOSSync(data: UserData) {
    titleTextField.text = data.firstName
//    emailTxtField.text = data.email
//    lastnameTxtField.text = data.lastname
    
  }
  
  func webToiOSAysnc(data: UserData) {
    titleTextField.text = data.firstName
//    emailTxtField.text = data.email
//    lastnameTxtField.text = data.lastname
    
  }
  
   var webView: WKWebView = {
      let webConfiguration = WKWebViewConfiguration()
      let webView = WKWebView(frame: .zero, configuration: webConfiguration)
      webView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
     webView.scrollView.isScrollEnabled = false
     webView.scrollView.bounces = false
     webView.translatesAutoresizingMaskIntoConstraints = false
      return webView
  }()
  
  lazy var titleTextField:UITextField = {
      let textField = UITextField()
      textField.translatesAutoresizingMaskIntoConstraints = false
     // textField.placeholder = "Title *"
    //  textField.keyboardType = UIKeyboardType.default
    //  textField.returnKeyType = UIReturnKeyType.done
     // textField.autocorrectionType = UITextAutocorrectionType.no
      textField.font = UIFont.systemFont(ofSize: 13)
      textField.borderStyle = UITextField.BorderStyle.roundedRect
    //  textField.clearButtonMode = UITextField.ViewMode.whileEditing;
    //  textField.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
      return textField
  }()
  
  lazy var displayLabel : UILabel = {
    let label = UILabel()
    label.font = UIFont.systemFont(ofSize: 15, weight: .medium)
    label.translatesAutoresizingMaskIntoConstraints = false
   // label.text = "hello Yoo!!"
    return label
  }()
  
  // MARK: - Init
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupInitialLayout()
     webView.isOpaque = false
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  private func setupInitialLayout() {
    addSubview(webView)
    addSubview(titleTextField)
    
    titleTextField.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 150).isActive = true
    titleTextField.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
    titleTextField.widthAnchor.constraint(equalToConstant: 300).isActive = true
    titleTextField.heightAnchor.constraint(equalToConstant: 100).isActive = true
    
    webView.topAnchor.constraint(equalTo: titleTextField.bottomAnchor, constant: 5).isActive = true
    webView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
    webView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
    webView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor).isActive = true
  
    
  }
  
}
