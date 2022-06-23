
import SwiftUI
import UIKit

extension View {

    public func readableContent(_ edges: Edge.Set = .all) -> some View {
        modifier(ReadableContent(edges: edges))
    }
}

private struct ReadableContent: ViewModifier {

    let edges: Edge.Set
    @State private var insets = EdgeInsets()

    func body(content: Content) -> some View {
        content
            .padding(.top, edges.contains(.top) ? insets.top : 0)
            .padding(.bottom, edges.contains(.bottom) ? insets.bottom : 0)
            .padding(.leading, edges.contains(.leading) ? insets.leading : 0)
            .padding(.trailing, edges.contains(.trailing) ? insets.trailing : 0)
            .background(ReadableContentGuideReader { insets = $0 })
    }
}

private struct ReadableContentGuideReader: UIViewRepresentable {

    let readableContentDidChange: (EdgeInsets) -> Void

    func makeUIView(context: Context) -> ReadableContentGuideView {
        ReadableContentGuideView(readableContentDidChange: readableContentDidChange)
    }

    func updateUIView(_ uiView: ReadableContentGuideView, context: Context) {}
}

private final class ReadableContentGuideView: UIView {

    let readableContentDidChange: (EdgeInsets) -> Void

    init(readableContentDidChange: @escaping (EdgeInsets) -> Void) {
        self.readableContentDidChange = readableContentDidChange
        super.init(frame: .zero)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutMarginsDidChange() {
        super.layoutMarginsDidChange()
        checkReadableContentGuide()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        checkReadableContentGuide()
    }

    override func traitCollectionDidChange(_ previous: UITraitCollection?) {
        super.traitCollectionDidChange(previous)
        guard traitCollection.layoutDirection != previous?.layoutDirection else { return }
        checkReadableContentGuide()
    }

    private var previousInsets: EdgeInsets? = nil

    private func checkReadableContentGuide() {

        let layoutFrame = readableContentGuide.layoutFrame
        let minX = layoutFrame.minX - bounds.minX
        let maxX = -(layoutFrame.maxX - bounds.maxX)
        let minY = layoutFrame.minY - bounds.minY
        let maxY = -(layoutFrame.maxY - bounds.maxY)

        let newInsets: EdgeInsets
        switch traitCollection.layoutDirection {
        case .leftToRight, .unspecified:
            newInsets = EdgeInsets(top: minY, leading: minX, bottom: maxY, trailing: maxX)
        case .rightToLeft:
            newInsets = EdgeInsets(top: minY, leading: maxX, bottom: maxY, trailing: minX)
        @unknown default:
            newInsets = EdgeInsets(top: minY, leading: minX, bottom: maxY, trailing: maxX)
        }

        guard previousInsets != newInsets else { return }
        readableContentDidChange(newInsets)
        previousInsets = newInsets
    }
}
