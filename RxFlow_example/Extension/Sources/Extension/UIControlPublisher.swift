//
//  UIControlPublisher.swift
//  Extension
//
//  Created by Leo on 11/2/24.
//

import UIKit
import Combine

@available(iOS 13.0, *)
public extension UIControl {
    @MainActor
    final class EventSubscription<S: Subscriber>: Subscription, @unchecked Sendable where S.Input == Void, S.Failure == Never {
        private var subscriber: S?
        private weak var control: UIControl?
        private let event: UIControl.Event

        init(subscriber: S, control: UIControl, event: UIControl.Event) {
            self.subscriber = subscriber
            self.control = control
            self.event = event

            control.addTarget(self, action: #selector(eventHandler), for: event)
        }

        nonisolated public func request(_ demand: Subscribers.Demand) {
            // 추가 작업 없음
        }

        nonisolated public func cancel() {
            Task { @MainActor [weak self] in
                guard let self = self else { return }
                self.control?.removeTarget(self, action: #selector(eventHandler), for: .allEvents)
                self.subscriber = nil
            }
        }

        @objc private func eventHandler() {
            _ = subscriber?.receive(())
        }
    }

    func publisher(for event: UIControl.Event) -> AnyPublisher<Void, Never> {
        return EventPublisher(control: self, event: event)
            .eraseToAnyPublisher()
    }

    struct EventPublisher: @preconcurrency Publisher {
        public typealias Output = Void
        public typealias Failure = Never

        weak var control: UIControl?
        let event: UIControl.Event

        @MainActor public func receive<S>(subscriber: S) where S : Subscriber, Never == S.Failure, Void == S.Input {
            if let control = control {
                let subscription = EventSubscription(subscriber: subscriber, control: control, event: event)
                subscriber.receive(subscription: subscription)
            }
        }
    }
}

@available(iOS 13.0, *)
public extension UIButton {
    func tapPublisher() -> AnyPublisher<Void, Never> {
        return publisher(for: .touchUpInside)
    }
}
