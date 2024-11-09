//
//  HomeDetailViewController.swift
//  Home
//
//  Created by Leo on 11/3/24.
//

import UIKit
import Combine
import SnapKit
import Then

public final class HomeDetailViewController: UIViewController {
    
    private var viewModel: HomeDetailViewModel
    
    private var centerLabel = UILabel().then {
        $0.text = "Home Detail View"
        $0.textColor = .white
    }
    
    private var alertButton = UIButton().then {
        $0.setTitle(" Alert ", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.backgroundColor = .systemBlue
    }
    
    private var cancellables = Set<AnyCancellable>()
    
    public init(viewModel: HomeDetailViewModel) {
        print("[init] HomeDetailViewController")
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("[init](coder:) has not been implemented")
    }
    
    deinit {
        print("[deinit] HomeDetailViewController")
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        bindActions()
    }
    
    public override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        if isMovingFromParent {
            Task {
                await viewModel.send(action: .dismiss)
            }
        }
    }
    
    private func setupLayout() {
        view.backgroundColor = .systemBlue.withAlphaComponent(0.2)
        view.addSubview(centerLabel)
        view.addSubview(alertButton)

        centerLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        alertButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(centerLabel.snp.bottom).offset(50)
        }
    }
    
    private func bindActions() {
        alertButton.tapPublisher()
            .sink { [weak self] in
                Task {
                    self?.viewModel.send(action: .alertTapped)
                }
            }.store(in: &cancellables)
        
        /*
        alertButton.tapPublisher()
            .receive(on: DispatchQueue.main)
            .sink { [weak self] in
                let alert = UIAlertController(title: "Alert", message: "from HomeDetail", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default))
                self?.present(alert, animated: true)
            }.store(in: &cancellables)
         */

    }
    
}

import SwiftUI
#Preview {
    let vm = HomeDetailViewModel()
    HomeDetailViewController(viewModel: vm)
}
