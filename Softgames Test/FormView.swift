//
//  FormView.swift
//  Softgames Test
//
//  Created by Eniola Anthony on 25.05.2022.

import Foundation
import UIKit
import WebKit

class FormView: UIView {
  
  // MARK: - Private properties
  
  var firstName : String?
  var lastName : String?
  var dateOfBirth : String?
  var result : String?
  let queue = DispatchQueue.global(qos: .userInitiated)
   
    private lazy var titleTextField:UITextField = {
    let textField = UITextField()
    textField.translatesAutoresizingMaskIntoConstraints = false
    textField.placeholder = "Result field * Softgames *"
    textField.keyboardType = UIKeyboardType.default
    textField.returnKeyType = UIReturnKeyType.done
    textField.autocorrectionType = UITextAutocorrectionType.no
    textField.font = UIFont.systemFont(ofSize: 13)
    textField.borderStyle = UITextField.BorderStyle.roundedRect
    textField.clearButtonMode = UITextField.ViewMode.whileEditing;
    textField.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
    return textField
  }()
  
  // MARK: - Public property
  
  var webView: WKWebView = {
    let webConfiguration = WKWebViewConfiguration()
    let webView = WKWebView(frame: .zero, configuration: webConfiguration)
    webView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    webView.scrollView.isScrollEnabled = false
    webView.scrollView.bounces = false
    webView.translatesAutoresizingMaskIntoConstraints = false
    return webView
  }()
  
  // MARK: - Init
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupInitialLayout()
    backgroundColor = .white
    webView.isOpaque = false
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - Private functions
  
  private func setupInitialLayout() {
    addSubview(webView)
    addSubview(titleTextField)
    titleTextField.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 100).isActive = true
    titleTextField.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
    titleTextField.widthAnchor.constraint(equalToConstant: 300).isActive = true
    titleTextField.heightAnchor.constraint(equalToConstant: 100).isActive = true
    
    webView.topAnchor.constraint(equalTo: titleTextField.bottomAnchor, constant: 5).isActive = true
    webView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
    webView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
    webView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor).isActive = true
  }
  
  // MARK: - Public functions
  
  func webToiOSSync(data: UserData) {
    self.firstName = data.firstName
    self.lastName = data.lastname
    guard let firstName = firstName, let lastName = lastName else {  return }
    
    queue.sync {
      // Since i am performing a single task, i choosed not to use dispatch work item and since a user is tapping the button, i preferred using .userInitiated qos
      self.result = firstName + " " + lastName
      DispatchQueue.main.async {
        self.titleTextField.text = self.result
      }
    }
  }
  
  func webToiOSAysnc(data: UserData) {
    self.dateOfBirth = data.dob
    guard let dateOfBirth = dateOfBirth else { return }
    DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
      self.titleTextField.text = dateOfBirth
    }
  }
}
