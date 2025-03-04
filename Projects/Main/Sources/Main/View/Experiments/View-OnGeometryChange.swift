public import SwiftUI

extension View {

    // MARK: View - OnGeometryChange

    public func _onGeometryChange<Value: Equatable>(
        for valueType: Value.Type,
        of transform: @escaping (_ geometry: GeometryProxy) -> Value,
        action onGeometryChange: @escaping (_ value: Value) -> Void
    ) -> some View {
        self
            .modifier(
                OnGeometryChangeViewModifier(
                    transform: transform,
                    onGeometryChange: onGeometryChange
                )
            )
    }
}

internal struct OnGeometryChangeViewModifier<Value: Equatable> {

    // MARK: OnGeometryChangeViewModifier - Initialization

    internal init(
        transform: @escaping (_ geometry: GeometryProxy) -> Value,
        onGeometryChange: @escaping (_ value: Value) -> Void
    ) {
        self.transform = transform
        self.onGeometryChange = onGeometryChange
    }

    // MARK: OnGeometryChangeViewModifier - Representation

    private let transform: (_ geometry: GeometryProxy) -> Value
    private let onGeometryChange: (_ value: Value) -> Void
    @State private var value: Value?
}

extension OnGeometryChangeViewModifier: ViewModifier {

    // MARK: ViewModifier - Body

    internal func body(content: Content) -> some View {
        content
            .background {
                GeometryReader { geometry in
                    DispatchQueue.main.async {
                        let value = transform(geometry)
                        guard self.value != value else { return }
                        self.value = value
                    }
                    return Color.clear
                }
            }
            .onChange(of: value) {
                guard let value else { return }
                onGeometryChange(value)
            }
    }
}
