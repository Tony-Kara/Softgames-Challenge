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
    
    formView.sumbitButtonAction = { userdata in
        
        self.createJsonToPass(email: userdata.email , firstName: userdata.username , lastName: userdata.lastname)
      self.formView.webView.evaluateJavaScript("fillDetails('\(self.jsonString)')") { (any, error) in
                           
            print("Error : \(error)")
        }
    }
  }

  
  func createJsonToPass(email : String , firstName : String = "" , lastName : String = "" ) {
      
      let data = ["email": email ,"firstName": firstName , "lastName": lastName] as [String : Any]
      self.jsonString = createJsonForJavaScript(for: data)
      
  }
  
  func createJsonForJavaScript(for data: [String : Any]) -> String {
      var jsonString : String?
      do {
          let jsonData = try JSONSerialization.data(withJSONObject: data, options: .prettyPrinted)
          // here "jsonData" is the dictionary encoded in JSON data
          
          jsonString = String(data: jsonData, encoding: .utf8)!
          jsonString = jsonString?.replacingOccurrences(of: "\n", with: "").replacingOccurrences(of: "\\", with: "")
          
      } catch {
          print(error.localizedDescription)
      }
      print(jsonString!)
      return jsonString!
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

//MARK: - Web view method to handle call backs

extension ViewController : WKScriptMessageHandler {
    
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        print(message.body)
        let dict = message.body as? Dictionary<String, String>
        print(dict)
        
        let userdata = UserData((dict?["firstName"])!, (dict?["email"])!, (dict?["lastName"])!)
        
        if message.name == "sumbitToiOS" {
            self.sumbitToiOS(user: userdata)
        }
        
    }
    
    
    func sumbitToiOS(user:UserData){
        //refresh token
        print("sumbitToiOS")
        formView.webToiOSDataTransfer(data: user)
        
    }
    
    func endCurrentChat(isEnded: Bool){
        self.navigationController?.popViewController(animated: true)
    }
    
    
}
