import SwiftUI

extension View {
    func popup<T: View>(isPresented: Binding<Bool>, @ViewBuilder content: () -> T) -> some View {
        self.modifier(Popup(isPresented: isPresented, content: content))
    }
}

struct Popup<T: View>: ViewModifier {
    let popup: T
    @Binding var isPresented: Bool

    init(isPresented: Binding<Bool>, @ViewBuilder content: () -> T) {
        self._isPresented = isPresented
        popup = content()
    }

    func body(content: Content) -> some View {
        content
            .overlay {
                popupContent()
            }
    }

    @ViewBuilder private func popupContent() -> some View {
        GeometryReader { geometry in
            if isPresented {
                popup
                    .frame(width: geometry.size.width, height: geometry.size.height)
            }
        }
    }
}
