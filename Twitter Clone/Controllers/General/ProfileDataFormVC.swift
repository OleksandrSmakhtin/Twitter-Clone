//
//  ProfileDataForm.swift
//  Twitter Clone
//
//  Created by Oleksandr Smakhtin on 14.05.2023.
//

import UIKit
import Combine
import PhotosUI

class ProfileDataFormVC: UIViewController {
    
    //MARK: - viewModel
    private var viewModel = ProfileDataFormViewViewModel()
    private var subscriptions: Set<AnyCancellable> = []

    //MARK: - UI Objects
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.alwaysBounceVertical = true
        scrollView.keyboardDismissMode = .onDrag
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private let hintLbl: UILabel = {
        let lbl = UILabel()
        lbl.text = "Fill in your data"
        lbl.textColor = .label
        lbl.font = .systemFont(ofSize: 32, weight: .bold)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    private let avatarPlaceHolderView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 60
        imageView.backgroundColor = .lightGray
        imageView.image = UIImage(systemName: "camera.fill")
        imageView.tintColor = .gray
        imageView.isUserInteractionEnabled = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let displayNameTextField: UITextField = {
        let textField = UITextField()
        textField.keyboardType = .default
        textField.backgroundColor = .secondarySystemFill
        textField.leftViewMode = .always
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        textField.layer.masksToBounds = true
        textField.layer.cornerRadius = 8
        textField.attributedPlaceholder = NSAttributedString(string: "Display Name", attributes: [NSAttributedString.Key.foregroundColor : UIColor.gray])
        textField.addTarget(self, action: #selector(didChangeDislayName), for: .editingChanged)
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private let usernameTextField: UITextField = {
        let textField = UITextField()
        textField.keyboardType = .default
        textField.backgroundColor = .secondarySystemFill
        textField.leftViewMode = .always
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        textField.layer.masksToBounds = true
        textField.layer.cornerRadius = 8
        textField.attributedPlaceholder = NSAttributedString(string: "Username", attributes: [NSAttributedString.Key.foregroundColor : UIColor.gray])
        textField.addTarget(self, action: #selector(didChangeUsername), for: .editingChanged)
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private let bioTextView: UITextView = {
        let textView = UITextView()
        textView.keyboardType = .default
        textView.backgroundColor = .secondarySystemFill
        textView.layer.masksToBounds = true
        textView.layer.cornerRadius = 8
        textView.textContainerInset = UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15)
        textView.text = "Tell the world about yourself"
        textView.font = .systemFont(ofSize: 16)
        textView.textColor = .gray
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    private let submitBtn: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Submit", for: .normal)
        btn.tintColor = .white
        btn.titleLabel?.font = .systemFont(ofSize: 16, weight: .bold)
        btn.backgroundColor = UIColor(red: 29/255, green: 161/255, blue: 242/255, alpha: 1)
        btn.layer.masksToBounds = true
        btn.layer.cornerRadius = 25
        btn.addTarget(self, action: #selector(didTapSubmit), for: .touchUpInside)
        btn.translatesAutoresizingMaskIntoConstraints = false
        
        btn.isEnabled = false
        
        return btn
    }()
    
    
    //MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        // bg color
        view.backgroundColor = .systemBackground
        // disable dissmissing
        isModalInPresentation = true
        // add subviews
        addSubviews()
        // apply constraints
        applyConstraints()
        // apply delegates
        applyTextViewDelegate()
        applyTextFieldDelegates()
        // add gesture for avatar
        avatarPlaceHolderView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapAvatar)))
        // bind views
        bindViews()
    }
    
    
    //MARK: - bind views
    private func bindViews() {
        viewModel.$isFormValid.sink { [weak self] state in
            self?.submitBtn.isEnabled = state
        }.store(in: &subscriptions)
    }
    
    
    
    //MARK: - Actions
    @objc private func didTapSubmit() {
        viewModel.uploadAvatar()
        print(viewModel.url)
    }
    
    @objc private func didChangeDislayName() {
        viewModel.displayName = displayNameTextField.text
        viewModel.validateUserProfileForm()
    }
    
    @objc private func didChangeUsername() {
        viewModel.username = usernameTextField.text
        viewModel.validateUserProfileForm()
    }
    
    @objc private func dissmissAction() {
        view.endEditing(true)
    }
    
    @objc private func didTapAvatar() {
        // set photo picker
        var config = PHPickerConfiguration()
        config.filter = .images
        config.selectionLimit = 1
        
        let picker = PHPickerViewController(configuration: config)
        picker.delegate = self
        present(picker, animated: true)
    }

    //MARK: - Add subviews
    private func addSubviews() {
        view.addSubview(scrollView)
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(dissmissAction)))
        scrollView.addSubview(hintLbl)
        scrollView.addSubview(avatarPlaceHolderView)
        scrollView.addSubview(displayNameTextField)
        scrollView.addSubview(usernameTextField)
        scrollView.addSubview(bioTextView)
        scrollView.addSubview(submitBtn)
    }
    
    //MARK: - Apply constraints
    private func applyConstraints() {
        // scrollView constraints
        let scrollViewConstraints = [
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ]
        
        // hintLbl constraints
        let hintLblConstraints = [
            hintLbl.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            hintLbl.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 30)
        ]
        
        // avatarPlaceHolderView constraints
        let avatarPlaceHolderViewConstraints = [
            avatarPlaceHolderView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            avatarPlaceHolderView.heightAnchor.constraint(equalToConstant: 120),
            avatarPlaceHolderView.widthAnchor.constraint(equalToConstant: 120),
            avatarPlaceHolderView.topAnchor.constraint(equalTo: hintLbl.bottomAnchor, constant: 30)
        ]
        
        // displayNameTextField constraints
        let displayNameTextFieldConstraints = [
            displayNameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            displayNameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            displayNameTextField.topAnchor.constraint(equalTo: avatarPlaceHolderView.bottomAnchor, constant: 40),
            displayNameTextField.heightAnchor.constraint(equalToConstant: 50)
        ]
        
        // usernameTextField constraints
        let usernameTextFieldConstraints = [
            usernameTextField.leadingAnchor.constraint(equalTo: displayNameTextField.leadingAnchor),
            usernameTextField.trailingAnchor.constraint(equalTo: displayNameTextField.trailingAnchor),
            usernameTextField.topAnchor.constraint(equalTo: displayNameTextField.bottomAnchor, constant: 20),
            usernameTextField.heightAnchor.constraint(equalToConstant: 50)
        ]
        
        // bioTextView constraints
        let bioTextViewConstraints = [
            bioTextView.leadingAnchor.constraint(equalTo: displayNameTextField.leadingAnchor),
            bioTextView.trailingAnchor.constraint(equalTo: displayNameTextField.trailingAnchor),
            bioTextView.topAnchor.constraint(equalTo: usernameTextField.bottomAnchor, constant: 20),
            bioTextView.heightAnchor.constraint(equalToConstant: 150)
        ]
        
        // submitBtn constraints
        let submitBtnConstraints = [
            submitBtn.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            submitBtn.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            submitBtn.heightAnchor.constraint(equalToConstant: 50),
            submitBtn.bottomAnchor.constraint(equalTo: view.keyboardLayoutGuide.topAnchor, constant: -20)
        ]
        
        // activate constraints
        NSLayoutConstraint.activate(scrollViewConstraints)
        NSLayoutConstraint.activate(hintLblConstraints)
        NSLayoutConstraint.activate(avatarPlaceHolderViewConstraints)
        NSLayoutConstraint.activate(displayNameTextFieldConstraints)
        NSLayoutConstraint.activate(usernameTextFieldConstraints)
        NSLayoutConstraint.activate(bioTextViewConstraints)
        NSLayoutConstraint.activate(submitBtnConstraints)
        
        
    }

}


//MARK: - TextViewDelegate
extension ProfileDataFormVC: UITextViewDelegate {
    private func applyTextViewDelegate() {
        bioTextView.delegate = self
    }
    // did begin editing
    func textViewDidBeginEditing(_ textView: UITextView) {
        scrollView.setContentOffset(CGPoint(x: 0, y: textView.frame.origin.y - 100), animated: true)
        if textView.textColor == .gray {
            textView.textColor = .label
            textView.text = ""
        }
    }
    // did end editing
    func textViewDidEndEditing(_ textView: UITextView) {
        scrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
        if textView.text == "" {
            textView.text = "Tell the world about yourself"
            textView.textColor = .gray
        }
    }
    
    func textViewDidChange(_ textView: UITextView) {
        viewModel.bio = textView.text
        viewModel.validateUserProfileForm()
    }
    
}


//MARK: - TextFieldDelegate
extension ProfileDataFormVC: UITextFieldDelegate {
    private func applyTextFieldDelegates() {
        displayNameTextField.delegate = self
        usernameTextField.delegate = self
    }
    // did begin editing
    func textFieldDidBeginEditing(_ textField: UITextField) {
        scrollView.setContentOffset(CGPoint(x: 0, y: textField.frame.origin.y - 100), animated: true)
    }
    
    // did end editing
    func textFieldDidEndEditing(_ textField: UITextField) {
        scrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
    }
}

//MARK: - PHPickerViewControllerDelegate
extension ProfileDataFormVC: PHPickerViewControllerDelegate {
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        picker.dismiss(animated: true)
        for result in results {
            result.itemProvider.loadObject(ofClass: UIImage.self) { [weak self] object, error in
                if let image = object as? UIImage {
                    DispatchQueue.main.async {
                        self?.avatarPlaceHolderView.image = image
                        self?.viewModel.imageData = image
                    }
                }
            }
        }
    }
    
     
}
