//
//  SignInViewController.swift
//  GB_VK
//
//  Created by Anatoliy on 08.11.2021.
//

import UIKit
import FirebaseAuth

class SignInViewController: UIViewController {
    
    let auth = FirebaseAuth.Auth.auth()
    
    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addGradient()
        
        loginTextField.text = "tolik@getnada.com"
        passwordTextField.text = "123456"
    }
    
    //для анвинд сегвея
    @IBAction func logOutTapped(segue: UIStoryboardSegue) {
    }
    
    @IBAction func loginTapped(_ sender: UIButton) {
        
        guard let email = loginTextField.text, !email.isEmpty, let password = passwordTextField.text, !password.isEmpty
        else {
            print("Введите логин = tolik@getnada.com и пароль = 123456")
            return
        }
        loginUser(email: email, password: password)
    }
    
    private func loginUser(email: String, password: String) {
        auth.signIn(withEmail: email, password: password) { [weak self] result, error in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            self?.performSegue(withIdentifier: "OpenBrowser", sender: nil)
        }
    }
    
    private func addGradient() {
        let gradient = CAGradientLayer()
        gradient.frame = view.bounds
        gradient.colors = [UIColor.systemRed.cgColor, UIColor.systemBlue.cgColor]
        gradient.startPoint = CGPoint(x: 0, y: 1)
        gradient.endPoint = CGPoint(x: 1, y: 0)
        
        view.layer.insertSublayer(gradient, at: 0)
        showAnimatingDotsInImageView()
    }

    func showAnimatingDotsInImageView() {
            
            let lay = CAReplicatorLayer()
            lay.frame = CGRect(x: 100, y: 100, width: 15, height: 7) //тут трём точками нужно задать размер, не до конца понял
            let circle = CALayer()
            circle.frame = CGRect(x: 0, y: 0, width: 7, height: 7)
            circle.cornerRadius = circle.frame.width / 2
        circle.backgroundColor = UIColor(red: 110/255.0, green: 110/255.0, blue: 110/255.0, alpha: 1).cgColor//lightGray.cgColor //UIColor.black.cgColor
            lay.addSublayer(circle)
            lay.instanceCount = 3
            lay.instanceTransform = CATransform3DMakeTranslation(10, 0, 0)
            let anim = CABasicAnimation(keyPath: #keyPath(CALayer.opacity))
            anim.fromValue = 1.0
            anim.toValue = 0.2
            anim.duration = 1
            anim.repeatCount = .infinity
            circle.add(anim, forKey: nil)
            lay.instanceDelay = anim.duration / Double(lay.instanceCount)
            
          //  view.layer.addSublayer(lay) - тут эти точки добавляются на твою вьху
        }
}

