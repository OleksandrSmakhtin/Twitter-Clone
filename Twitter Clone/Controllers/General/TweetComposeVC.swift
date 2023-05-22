//
//  TweetComposeVC.swift
//  Twitter Clone
//
//  Created by Oleksandr Smakhtin on 19.05.2023.
//

import UIKit
import Combine

class TweetComposeVC: UIViewController {

    
    //MARK: - viewModel
    private var viewModel = TweetComposeViewViewModel()
    private var subscriptions: Set<AnyCancellable> = []
    
    //MARK: - UI Objects
    private let tweetBtn: UIButton = {
        let btn = UIButton(type: .system)
        btn.backgroundColor = .twitterBlueColor
        btn.setTitle("Tweet", for: .normal)
        btn.layer.cornerRadius = 20
        btn.clipsToBounds = true
        btn.titleLabel?.font = .systemFont(ofSize: 18, weight: .semibold)
        btn.tintColor = .white
        btn.isEnabled = false
        btn.addTarget(self, action: #selector(didTapTweet), for: .touchUpInside)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    private let tweetTextView: UITextView = {
        let textView = UITextView()
        textView.keyboardType = .default
        textView.layer.masksToBounds = true
        textView.layer.cornerRadius = 8
        textView.textContainerInset = UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15)
        textView.text = "What's happening?"
        textView.font = .systemFont(ofSize: 16)
        textView.textColor = .gray
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    
    //MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        // bg color
        view.backgroundColor = .systemBackground
        // configure nav bar
        configureNavBar()
        // add subviews
        addSubviews()
        // apply constraints
        applyConstraints()
        // apply delegates
        applyTextViewDelegate()
        // bind views
        bindViews()
    }
    
    //MARK: - viewWillAppear
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.getUserData()
    }
  
    
    //MARK: - Bind views
    private func bindViews() {
        viewModel.$isValidToTweet.sink { [weak self] validationState in
            self?.tweetBtn.isEnabled = validationState
        }.store(in: &subscriptions)
        
        
        viewModel.$shouldDissmisComposer.sink { [weak self] state in
            if state {
                self?.dismiss(animated: true)
            }
        }.store(in: &subscriptions)
    }
    
    
    //MARK: - Add subviews
    private func addSubviews() {
        view.addSubview(tweetBtn)
        view.addSubview(tweetTextView)
    }
    
    
    //MARK: - Apply constraints
    private func applyConstraints() {
        //tweetBtn Constraints
        let tweetBtnConstraints = [
            tweetBtn.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            tweetBtn.bottomAnchor.constraint(equalTo: view.keyboardLayoutGuide.topAnchor, constant: -10),
            tweetBtn.widthAnchor.constraint(equalToConstant: 120),
            tweetBtn.heightAnchor.constraint(equalToConstant: 40)
        ]
        
        // tweetTextView constraints
        let tweetTextViewConstraints = [
            tweetTextView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tweetTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            tweetTextView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            tweetTextView.bottomAnchor.constraint(equalTo: tweetBtn.topAnchor, constant: -10)
        ]
        
        // activate constraints
        NSLayoutConstraint.activate(tweetBtnConstraints)
        NSLayoutConstraint.activate(tweetTextViewConstraints)
    }
    
    
    //MARK: - Configure nav bar
    private func configureNavBar() {
        title = "Tweet"
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(didTapCancel))
    }
    
    //MARK: - Actions
    @objc private func didTapCancel() {
        dismiss(animated: true)
    }
    
    @objc private func didTapTweet() {
        viewModel.dispatchTweet()
    }
}

//MARK: - UITextViewDelegate
extension TweetComposeVC: UITextViewDelegate {
    private func applyTextViewDelegate() {
        tweetTextView.delegate = self
    }
    // did begin editing
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == .gray {
            textView.textColor = .label
            textView.text = ""
        }
    }
    // did end editing
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text == "" {
            textView.text = "What's happening?"
            textView.textColor = .gray
        }
    }
    
    func textViewDidChange(_ textView: UITextView) {
        viewModel.tweetContent = textView.text
        viewModel.validateToTweet()
    }
}
