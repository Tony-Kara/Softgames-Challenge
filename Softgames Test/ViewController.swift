//
//  ViewController.swift
//  Softgames Test
//
//  Created by Eniola Anthony on 25.05.2022.
//

import UIKit
import WebKit

protocol StepByDelegate : class {
    func updateUI(enable:Bool)
    
}

class ViewController: UIViewController, UIWebViewDelegate {
  
  
 
  weak var  delegate : StepByDelegate?
  var jsonString = String()
  var mNativeToWebHandler : String = "sumbitToiOS"
  var NativeToWebHandlerAynsc : String = "sumbitToiOSAsync"


  let formView = FormView()
 
  override func loadView() {
    view = formView
  }
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
    view.backgroundColor = .white
    formView.webView.navigationDelegate = self
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
    formView.webView.configuration.userContentController.add(self, name: NativeToWebHandlerAynsc)
  }

}

//MARK: - Web view method to handle call backs

extension ViewController : WKScriptMessageHandler {
    
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        print(message.body)
        let dict = message.body as? Dictionary<String, String>
        print(dict)
        
        let userdata = UserData((dict?["firstName"])!, (dict?["lastName"])!, (dict?["dob"])!)
       
        if message.name == "sumbitToiOS" {
            self.sumbitToiOS(user: userdata)
        }
      
      else if message.name == "sumbitToiOSAsync" {
        self.sumbitToiOSAsync(user: userdata)
      }
        
    }
    
    
    func sumbitToiOS(user:UserData){
        //refresh token
        print("sumbitToiOSSync")
        formView.webToiOSSync(data: user)
        
    }
  
  func sumbitToiOSAsync(user:UserData){
      //refresh token
      print("sumbitToiOSAsync")
    formView.webToiOSAysnc(data: user)
      
  }
    
    func endCurrentChat(isEnded: Bool){
        self.navigationController?.popViewController(animated: true)
    }
    
    
}

//MARK: - Web view delegate methods

extension ViewController : WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
   
        print("didFinish")
    }
    
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        print(error.localizedDescription)
    }
    
    
    
}
