//
//  ViewController.swift
//  Softgames Test
//
//  Created by Eniola Anthony on 25.05.2022.
//

import UIKit
import WebKit

class ViewController: UIViewController {
  
  // MARK: - private properties
  
  var mNativeToWebHandler : String = "sumbitToiOS"
  var NativeToWebHandlerAynsc : String = "sumbitToiOSAsync"
  let formView = FormView()
  
  // MARK: - Init
  
  override func loadView() {
    view = formView
  }
  override func viewDidLoad() {
    super.viewDidLoad()
    loadWebKit()
  }
  
  // MARK: - Private functions
  func loadWebKit() {
    if let indexURL = Bundle.main.url(forResource: "index",
                                      withExtension: "html") {
      formView.webView.loadFileURL(indexURL,
                                   allowingReadAccessTo: indexURL)
    }
    let contentController = WKUserContentController()
    formView.webView.configuration.userContentController = contentController
    formView.webView.configuration.userContentController.add(self, name: mNativeToWebHandler)
    formView.webView.configuration.userContentController.add(self, name: NativeToWebHandlerAynsc)
  }
}

//MARK: - Extensions

extension ViewController : WKScriptMessageHandler {
  func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
    print(message.body)
    let dict = message.body as? Dictionary<String, String>
    let userdata = UserData((dict?["firstName"])!, (dict?["lastName"])!, (dict?["dob"])!)
    if message.name == "sumbitToiOS" {
      self.sumbitToiOS(user: userdata)
    }
    else if message.name == "sumbitToiOSAsync" {
      self.sumbitToiOSAsync(user: userdata)
    }
  }
  
  func sumbitToiOS(user:UserData){
    formView.webToiOSSync(data: user)
  }
  
  func sumbitToiOSAsync(user:UserData){
    formView.webToiOSAysnc(data: user)
  }
}


