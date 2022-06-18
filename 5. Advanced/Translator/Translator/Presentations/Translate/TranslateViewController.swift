//
//  TranslateViewController.swift
//  Translator
//
//  Created by Sang hun Lee on 2022/06/17.
//

import SnapKit
import UIKit

enum LanguageButtonType {
    case source
    case target
}

final class TranslateViewController: UIViewController {
    private var sourceLanguage: Language = .korean
    private var targetLanguage: Language = .english
    
    private lazy var sourceLanguageButton: UIButton = {
        let button = UIButton()
        button.setTitle(sourceLanguage.title, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 15.0, weight: .semibold)
        button.setTitleColor(UIColor.label, for: .normal)
        button.backgroundColor = .systemBackground
        button.layer.cornerRadius = 9.0
        button.addTarget(self, action: #selector(didTapSourceLanguageButton), for: .touchUpInside)
        return button
    }()
    
    private lazy var targetLanguageButton: UIButton = {
        let button = UIButton()
        button.setTitle(targetLanguage.title, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 15.0, weight: .semibold)
        button.setTitleColor(UIColor.label, for: .normal)
        button.backgroundColor = .systemBackground
        button.layer.cornerRadius = 9.0
        button.addTarget(self, action: #selector(didTapTargetLanguageButton), for: .touchUpInside)
        return button
    }()
    
    private lazy var buttonStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 8.0
        [sourceLanguageButton, targetLanguageButton].forEach {
            stackView.addArrangedSubview($0)
        }
        return stackView
    }()
    
    private lazy var resultBaseView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    private lazy var resultLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 24.0, weight: .bold)
        label.textColor = .mainTintColor
        label.text = "Hello"
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var resultBookmarkButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "bookmark"), for: .normal)
        return button
    }()
    
    private lazy var resultCopyButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "doc.on.doc"), for: .normal)
        return button
    }()
    
    private lazy var sourceLabelBaseButton: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBackground
        // 제스쳐 설정 - 다양한 인터렉션 동작에 대한 지원
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapSourceLabelBaseButton))
        view.addGestureRecognizer(tapGesture)
        
        return view
    }()
    
    private lazy var sourceLabel: UILabel = {
        let label = UILabel()
        // TODO: sourceLabel에 입력 값이 추가되면, placeHolder 스타일 해제
        label.textColor = .tertiaryLabel
        label.text = "텍스트 입력"
        
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 23.0, weight: .semibold)
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .secondarySystemBackground
        setupView()
    }
}

extension TranslateViewController: SourceTextViewControllerDelegate {
    func didEnterText(_ sourceText: String) {
        if sourceText.isEmpty { return }
        
        sourceLabel.text = sourceText
        sourceLabel.textColor = .label
    }
}

private extension TranslateViewController {
    func setupView() {
        [
            buttonStackView,
            resultBaseView,
            resultLabel,
            resultBookmarkButton,
            resultCopyButton,
            sourceLabelBaseButton,
            sourceLabel
        ].forEach { view.addSubview($0) }
        
        let defaultSpacing: CGFloat = 16.0
        
        buttonStackView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.equalToSuperview().inset(defaultSpacing)
            $0.trailing.equalToSuperview().inset(defaultSpacing)
            $0.height.equalTo(50.0)
        }
        
        resultBaseView.snp.makeConstraints {
            $0.top.equalTo(buttonStackView.snp.bottom).offset(defaultSpacing)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(resultBookmarkButton.snp.bottom).offset(defaultSpacing)
        }
        
        resultLabel.snp.makeConstraints {
            $0.top.equalTo(resultBaseView.snp.top).inset(24.0)
            $0.leading.equalTo(resultBaseView).inset(24.0)
            $0.trailing.equalTo(resultBaseView).inset(24.0)
        }
        
        resultBookmarkButton.snp.makeConstraints {
            $0.leading.equalTo(resultLabel)
            $0.top.equalTo(resultLabel.snp.bottom).offset(24.0)
            $0.width.height.equalTo(40)
        }
        
        resultCopyButton.snp.makeConstraints {
            $0.leading.equalTo(resultBookmarkButton.snp.trailing).inset(8.0)
            $0.top.equalTo(resultBookmarkButton)
            $0.width.height.equalTo(40)
        }
        
        sourceLabelBaseButton.snp.makeConstraints {
            $0.top.equalTo(resultBaseView.snp.bottom).offset(defaultSpacing)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(8.0)
            // $0.bottom.equalToSuperview().inset(tabBarController?.tabBar.frame.height ?? 0)
        }
        
        sourceLabel.snp.makeConstraints {
            $0.top.equalTo(sourceLabelBaseButton).inset(24.0)
            $0.leading.equalTo(sourceLabelBaseButton).inset(24.0)
            $0.trailing.equalTo(sourceLabelBaseButton).inset(24.0)
        }
    }
    
    @objc func didTapSourceLabelBaseButton() {
        let viewController = SourceTextViewController(delegate: self)
        present(viewController, animated: true)
    }
    
    @objc func didTapSourceLanguageButton() {
        didTapLanguageButton(.source)
    }
    
    @objc func didTapTargetLanguageButton() {
        didTapLanguageButton(.target)
    }
    
    func didTapLanguageButton(_ type: LanguageButtonType) {
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        Language.allCases.forEach { language in
            let action = UIAlertAction(title: language.title, style: .default) { [weak self] _ in
                switch type {
                case .source:
                    self?.sourceLanguage = language
                    self?.sourceLanguageButton.setTitle(language.title, for: .normal)
                case .target:
                    self?.targetLanguage = language
                    self?.targetLanguageButton.setTitle(language.title, for: .normal)
                }
            }
            alertController.addAction(action)
        }
        
        let cancelAction = UIAlertAction(title: "취소하기", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        present(alertController, animated: true, completion: nil)
    }
}
