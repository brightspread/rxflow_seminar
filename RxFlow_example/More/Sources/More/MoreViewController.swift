import UIKit
import Combine
import SnapKit
import Then
import Extension

public final class MoreViewController: UIViewController {

    private var viewModel: MoreViewModel
    
    private var centerLabel = UILabel().then {
        $0.text = "More View"
        $0.textColor = .white
    }
    
    private var alertButton = UIButton().then {
        $0.setTitle(" Alert ", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.backgroundColor = .systemBlue
    }
    
    private var cancellables = Set<AnyCancellable>()

    public init(viewModel: MoreViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("[init](coder:) has not been implemented")
    }
    
    public override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        if isMovingFromParent {
            Task {
                await viewModel.send(.dismiss)
            }
        }
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        bindActions()
    }
    
    private func setupLayout() {
        view.backgroundColor = .green.withAlphaComponent(0.3)
        view.addSubview(centerLabel)
        view.addSubview(alertButton)

        centerLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        
        alertButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(centerLabel.snp.bottom).offset(50)
        }

    }
    
    private func bindActions() {
        alertButton.tapPublisher()
            .sink {
                Task { [weak self] in
                    self?.viewModel.send(.alertTapped)
                }
            }.store(in: &cancellables)
        
        /*
        alertButton.tapPublisher()
            .receive(on: DispatchQueue.main)
            .sink { [weak self] in
                let alert = UIAlertController(title: "Alert", message: "from More", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default))
                self?.present(alert, animated: true)
            }.store(in: &cancellables)
         */

    }
    
}

import SwiftUI
#Preview {
    let viewModel = MoreViewModel()
    MoreViewController(viewModel: viewModel)
}



