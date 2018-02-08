//
//  CreatePostVC.swift
//  breakpoint
//
//  Created by Serena Lambert on 07/02/2018.
//  Copyright © 2018 Serena Lambert. All rights reserved.
//

import UIKit
import  Firebase

class CreatePostVC: UIViewController {

    // Outlets
    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var emailLbl: UILabel!
    @IBOutlet weak var messageTxtView: UITextView!
    @IBOutlet weak var sendBtn: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        messageTxtView.text = ""
        sendBtn.bindToKeyboard()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.emailLbl.text = Auth.auth().currentUser?.email
    }
    
    
    @IBAction func sendBtnPressed(_ sender: Any) {
        if messageTxtView.text != nil && messageTxtView.text != "Say something..." {
            sendBtn.isEnabled = false
            DataService.instance.uploadPost(withMessage: messageTxtView.text, forUID: (Auth.auth().currentUser?.uid)!, withGroupKey: nil, sendComplete: { (isComplete) in
                if isComplete {
                    self.sendBtn.isEnabled = true
                    self.dismiss(animated: true, completion: nil)
                }
            })
        }
    }
    
    @IBAction func closeBtnPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    

}


extension CreatePostVC: UITextViewDelegate {
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        textView.text = ""
    }
}

