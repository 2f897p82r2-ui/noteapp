import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            VStack {
                Text("Welcome to PrivacyNotes!")
                    .font(.largeTitle)
                    .padding()
                
                Button(action: {}) {
                    HStack {
                        Image(systemName: "pencil")
                            .imageScale(.large)
                            .foregroundColor(.accentColor)
                        Text("Create Note")
                            .font(.headline)
                    }
                    .padding()
                    .background(Color.accentColor)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                }
            }
            .navigationTitle("Notes")
        }
    }
}
