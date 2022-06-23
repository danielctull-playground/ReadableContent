
import SwiftUI
import ReadableContent

struct ReadableContentTest: View {

    let edges: Edge.Set
    let name: String

    var body: some View {
        ZStack {
            Color.orange

            Color.yellow
                .readableContent(edges)

            Text(name)
                .foregroundColor(.black)
                .font(.title)
        }
    }
}

struct ContentView: View {
    var body: some View {
        VStack(spacing: 20) {
            ReadableContentTest(edges: .all, name: "all")
            ReadableContentTest(edges: .horizontal, name: "horizontal")
            ReadableContentTest(edges: .leading, name: "leading")
            ReadableContentTest(edges: .trailing, name: "trailing")
            ReadableContentTest(edges: .vertical, name: "vertical")
            ReadableContentTest(edges: .top, name: "top")
            ReadableContentTest(edges: .bottom, name: "bottom")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
