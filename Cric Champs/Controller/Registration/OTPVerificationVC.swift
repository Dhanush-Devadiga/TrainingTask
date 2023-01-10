//
//  OTPVerificationVC.swift
//  Cricket
//
//  Created by Preetam G on 09/12/22.
//

import UIKit

protocol ResetPassword {
    func showSetPasswordView()
}

class OTPVerificationVC: UIViewController {

    @IBOutlet weak var otpTextField: UITextField!
    @IBOutlet weak var verifyButton: UIButton!
    var registerVM: RegistrationViewModel?
    var isForgotPassword = false
    var resetPasswordDelagate: ResetPassword?

    @IBOutlet weak var resendOtpButton: UIButton!
    var endTimer = Date(timeIntervalSinceNow: 21)
    var timer = Timer()
    override func viewDidLoad() {
        super.viewDidLoad()
        _ = self.verifyButton.applyGradient( colours: [ #colorLiteral(red: 1, green: 0.7294117647, blue: 0.5490196078, alpha: 1), #colorLiteral(red: 0.9960784314, green: 0.3607843137, blue: 0.4156862745, alpha: 1)], cornerRadius: 4)
        resendOtpButton.setTitle("0:20", for: .normal)
        resendOtpButton.isEnabled = false
        resendOtpButton.showsTouchWhenHighlighted = true
        
    }
    override func viewWillAppear(_ animated: Bool) {
        timer = .scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
    @objc func updateTimer(_ timer: Timer) {
        let remaining = endTimer.timeIntervalSinceNow
        resendOtpButton.setTitle(remaining.time, for: .normal)
           if remaining <= 1 {
            resendOtpButton.isEnabled = true
            resendOtpButton.setTitle("Resend OTP", for: .normal)
           }
       }
    
    @IBAction func onVerifyButtonClick(_ sender: Any) {
        if isForgotPassword {
            otpVerificationForResetPassword()
        } else {
            otpVerificationForRegistration()
        }
    }
    
    private func otpVerificationForRegistration() {
        guard let vc = storyboard?.instantiateViewController(identifier: "SuccessFailViewController") as? SuccessFailViewController else {alertAction(controller: self, message: "Retry registration");return}
        guard let currentEmail = registerVM?.currentUser.email else {
            vc.didSuccessfullyRegister = false
            navigationController?.pushViewController(vc, animated: true)
            return
        }
        registerVM?.currentUserEmail = currentEmail
        registerVM?.otp = Int(otpTextField.text ?? "055111") ?? 055111
        registerVM?.verifyOTP() { isSuccess in
            if isSuccess {
                vc.didSuccessfullyRegister = true
            } else {
                vc.didSuccessfullyRegister = false
            }
        }
        DispatchQueue.main.async {
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    private func otpVerificationForResetPassword() {
        guard let currentEmail = registerVM?.currentUserEmail else {
            return
        }
        registerVM?.currentUserEmail = currentEmail
        registerVM?.otp = Int(otpTextField.text ?? "055111") ?? 055111
        registerVM?.resetPasswordOtpVerification { isSucces in
            DispatchQueue.main.async {
                if isSucces {
                    self.resetPasswordDelagate?.showSetPasswordView()
                    self.navigationController?.popViewController(animated: true)
                } else {
                    guard let vc = self.storyboard?.instantiateViewController(identifier: "SuccessFailViewController") as? SuccessFailViewController else {alertAction(controller: self, message: "Retry registration");return}
                    vc.didSuccessfullyRegister = false
                    self.navigationController?.pushViewController(vc, animated: true)
                }
            }
        }
        
    }
    
    @IBAction func resendOTPButton(_ sender: Any) {
        resendOtpButton.blink()
        if !isForgotPassword {
            registerVM?.sendOTP(completion: { (isSuccess) in
            print("resent OTP")
            })
        } else {
            registerVM?.resetPassword(completion: {
                (isSuccess) in
                print("resent OTP")
            })
        }
    }
    
    @IBAction func onBackTapped(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
}
extension TimeInterval {
    var time: String {
        String(format: "%01d:%02d", Int(0), Int(truncatingRemainder(dividingBy: 60)))
    }
}
extension UIView{
     func blink() {
        self.alpha = 0.2
        UIView.animate(withDuration: 0.3, delay: 0.0, options: UIView.AnimationOptions.curveEaseOut, animations: {

            self.alpha = 1.0

        }, completion: nil)
     }
}
