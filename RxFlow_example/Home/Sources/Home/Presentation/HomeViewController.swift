//
//  HomeViewController.swift
//  Home
//
//  Created by Leo on 11/2/24.
//

import UIKit
import Combine
import SnapKit
import Then
import Extension

@available(iOS 13.0, *)
public final class HomeViewController: UIViewController {

    var viewModel: HomeViewModel
    private var cancellables = Set<AnyCancellable>()
    
    private var centerLabel = UILabel().then {
        $0.text = "Home View"
        $0.textColor = .white
    }
    
    private var homeDetailViewButton = UIButton().then {
        $0.setTitle(" Navigate To HomeDetail ", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.backgroundColor = .systemBlue
    }

    private var moreViewButton = UIButton().then {
        $0.setTitle(" Navigate To More ", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.backgroundColor = .systemBlue
    }

    private var alertButton = UIButton().then {
        $0.setTitle(" Alert ", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.backgroundColor = .systemBlue
    }
    
    public init(viewModel: HomeViewModel) {
        print("[init] HomeViewController")
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("[init](coder:) has not been implemented")
    }
    
    deinit {
        print("[deinit] HomeViewController")
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        bindActions()
    }
    
    private func setupLayout() {
        view.backgroundColor = .orange.withAlphaComponent(0.3)
        view.addSubview(centerLabel)
        view.addSubview(homeDetailViewButton)
        view.addSubview(moreViewButton)
        view.addSubview(alertButton)
        
        centerLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        homeDetailViewButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(100)
        }
        
        moreViewButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(homeDetailViewButton.snp.bottom).offset(50)
        }
        
        alertButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(moreViewButton.snp.bottom).offset(50)
        }
    }
    
    private func bindActions() {
        homeDetailViewButton.tapPublisher()
            .sink { [weak self] in
                Task {
                    await self?.viewModel.send(.detailTapped)
                }
            }.store(in: &cancellables)
        
        /*
        homeDetailViewButton.tapPublisher()
            .sink { [weak self] in
                let homeDetailVC = HomeDetailViewController(viewModel: .init())
                self?.navigationController?.pushViewController(homeDetailVC, animated: true)
            }.store(in: &cancellables)
         */
        
        moreViewButton.tapPublisher()
            .sink { [weak self] in
                Task {
                    await self?.viewModel.send(.moreTapped)
                }
            }.store(in: &cancellables)
        
        alertButton.tapPublisher()
            .sink { [weak self] in
                Task {
                    await self?.viewModel.send(.alertTapped)
                }
            }.store(in: &cancellables)
        
        /*
        alertButton.tapPublisher()
            .receive(on: DispatchQueue.main)
            .sink { [weak self] in
                let alert = UIAlertController(title: "Alert", message: "from Home", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default))
                self?.present(alert, animated: true)
            }.store(in: &cancellables)
         */

    }
    
}

import SwiftUI
#Preview {
    HomeViewController(viewModel: .init())
}
