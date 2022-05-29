//
//  ViewController.swift
//  Softgames Test
//
//  Created by Eniola Anthony on 25.05.2022.
//

import UIKit
import WebKit

class ViewController: UIViewController, WKScriptMessageHandler {
  
  var b : String?
  func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
    b = message.body as? String
    guard let b = b else {return}
    print(b)
      if message.name == mNativeToWebHandler {
       
      
       // print(message.body)
        var f = formView.titleTextField.text
        f = message.body as? String
      }
  }
  
 
  
  var mNativeToWebHandler : String = "jsMessageHandler"
  var mWebPageName : String = "sampleweb"
  
  var mWebPageExtension : String = "html"


  let formView = FormView()
 
  override func loadView() {
    view = formView
  }
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
    view.backgroundColor = .white
    loadWebKit()
  }

  func loadWebKit() {
    if let indexURL = Bundle.main.url(forResource: "index",
                                      withExtension: "html") {
      
        formView.webView.loadFileURL(indexURL,
                                 allowingReadAccessTo: indexURL)
    }
    
    let contentController = WKUserContentController()
    
    formView.webView.configuration.userContentController = contentController
    
    formView.webView.configuration.userContentController.add(self, name: mNativeToWebHandler)
  }

}

