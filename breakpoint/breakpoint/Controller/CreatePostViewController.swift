//
//  CreatePostViewController.swift
//  breakpoint
//
//  Created by Emmanuel Olivo on 20/02/18.
//  Copyright © 2018 Con Dos Emes. All rights reserved.
//

import UIKit
import Firebase

class CreatePostViewController: UIViewController, UITextViewDelegate {
    
    //MARK: Outlets
    @IBOutlet weak var userLabel: UILabel!
    @IBOutlet weak var postTextView: UITextView!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var sendButton: UIButton!
    
    // MARK: Funtions
    override func viewDidLoad() {
        super.viewDidLoad()

        // Set self as textview delegate
        postTextView.delegate = self
        
        // Set bind to keyboard extension to send button
        sendButton.bindToKeyboard()
        
    }
    
    // Set userLabel to be the email of current user
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        userLabel.text = Auth.auth().currentUser?.email
    }

    // MARK: Delegate methods
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        postTextView.text = ""
        
    }
    
    // MARK: Actions
    
    @IBAction func closeButtonPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func sendButtonPressed(_ sender: Any) {
        if postTextView.text != nil && postTextView.text != "Say something here..." {
            sendButton.isEnabled = false
            DataService.instance.uploadPost(withMessage: postTextView.text, forUID: (Auth.auth().currentUser?.uid)!, withGroupKey: nil, sendComplete: { (success) in
                if success {
                    self.sendButton.isEnabled = true
                    self.dismiss(animated: true, completion: nil)
                } else {
                    self.sendButton.isEnabled = true
                    print("There was an error uploading post")
                }
            })
        }
    }
    
}
