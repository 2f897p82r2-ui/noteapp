import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = NotesViewModel()
    
    var body: some View {
        NavigationView {
            List(viewModel.notes) { note in
                Text(note.content)
            }
            .navigationTitle("Notes")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        viewModel.addNote(Note(content: "New Note"))
                    }) {
                        Image(systemName: "plus")
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
