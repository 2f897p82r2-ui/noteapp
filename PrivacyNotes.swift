import SwiftUI
import LocalAuthentication

@main
struct PrivacyNotes: App {
    @State private var isAuthenticated = false
    @State private var isUnlocked = false
    
    func authenticate() {
        let context = LAContext()
        var error: NSError?
        
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: "Authenticate to access your notes") { success, authenticationError in
                DispatchQueue.main.async {
                    if success {
                        self.isAuthenticated = true
                        self.isUnlocked = true
                    } else {
                        // Handle authentication failure
                    }
                }
            }
        } else {
            // Fallback to device passcode
            context.evaluatePolicy(.deviceOwnerAuthentication, localizedReason: "Authenticate to access your notes") { success, authenticationError in
                DispatchQueue.main.async {
                    if success {
                        self.isAuthenticated = true
                        self.isUnlocked = true
                    } else {
                        // Handle authentication failure
                    }
                }
            }
        }
    }
    
    var body: some Scene {
        WindowGroup {
            if isAuthenticated && isUnlocked {
                ContentView()
            } else {
                VStack {
                    Text("PrivacyNotes")
                        .font(.largeTitle)
                        .padding()
                    
                    Button(action: authenticate) {
                        HStack {
                            Image(systemName: "faceid")
                                .imageScale(.large)
                                .foregroundColor(.accentColor)
                            Text("Unlock with Face ID")
                                .font(.headline)
                        }
                        .padding()
                        .background(Color.accentColor)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color(UIColor.systemGroupedBackground))
            }
        }
    }
}
