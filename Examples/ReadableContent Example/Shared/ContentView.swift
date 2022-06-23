
import SwiftUI
import ReadableContent

struct ContentView: View {
    var body: some View {
        Color.blue
            .overlay { Text("Hello, world!") }
            .readableContent
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
