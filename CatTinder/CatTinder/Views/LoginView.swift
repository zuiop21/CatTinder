//
import SwiftUI
import FirebaseAuth

struct LoginView: View {
    @State private var email = ""
    @State private var password = ""
    @State private var userIsLoggedIn = UserDefaults.standard.bool(forKey: "isUserLoggedIn")

    var body: some View {
        if userIsLoggedIn {
            MenuView(userIsLoggedIn: $userIsLoggedIn)
        } else {
            content
        }
    }
    
    var content: some View {
        ZStack {
            Color("background")
                .onTapGesture {
                    hideKeyboard()
                }
            
            RoundedRectangle(cornerRadius: 30, style: .continuous)
                .foregroundStyle(.linearGradient(colors: [Color("selected")], startPoint: .topLeading, endPoint: .bottomTrailing))
                .frame(width: 1000, height:  400)
                .rotationEffect(.degrees(135))
                .offset(y: -350)
            
            VStack(spacing: 20) {
                Text("Welcome")
                    .foregroundColor(.white)
                    .font(.system(size: 40, weight: .bold, design: .rounded))
                    .offset(x: -100, y: -100)
                
                TextField("Email", text: $email)
                    .foregroundColor(.white)
                    .textFieldStyle(.plain)
                    .placeholder(when: email.isEmpty) {
                        Text("Email").foregroundColor(.white).bold()
                    }
                
                Rectangle()
                    .frame(width: 350, height: 1)
                    .foregroundColor(.white)
                
                SecureField("Password", text: $password)
                    .foregroundColor(.white)
                    .textFieldStyle(.plain)
                    .placeholder(when: password.isEmpty) {
                        Text("Password").foregroundColor(.white).bold()
                    }
                
                Rectangle()
                    .frame(width: 350, height: 1)
                    .foregroundColor(.white)
                
                Button {
                    register()
                } label: {
                    Text("Sign Up").bold().frame(width: 200, height: 40)
                        .background(RoundedRectangle(cornerRadius: 10, style: .continuous)
                                        .fill(.linearGradient(colors: [Color("selected")], startPoint: .top, endPoint: .bottomTrailing)))
                        .foregroundColor(.white)
                }
                .padding(.top)
                .offset(y: 110)
                
                Button {
                    login()
                } label: {
                    Text("Already have an account? Login").bold().foregroundColor(.white)
                }
                .padding(.top)
                .offset(y: 110)
            }
            .frame(width: 350)
            .onAppear {
                Auth.auth().addStateDidChangeListener { auth, user in
                    if user != nil {
                        self.userIsLoggedIn = true
                        UserDefaults.standard.set(true, forKey: "isUserLoggedIn") //
                    }
                }
            }
        }
        .ignoresSafeArea()
    }

    func login() {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if error != nil {
                print(error!.localizedDescription)
            } else {
                self.userIsLoggedIn = true
                UserDefaults.standard.set(true, forKey: "isUserLoggedIn")
            }
        }
    }
    
    func register() {
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if error != nil {
                print(error!.localizedDescription)
            } else {
                self.userIsLoggedIn = true
                UserDefaults.standard.set(true, forKey: "isUserLoggedIn")
            }
        }
    }
    
    
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

#Preview {
    LoginView()
}


extension View {
    func placeholder<Content: View>(
        when shouldShow: Bool,
        alignment: Alignment = .leading,
        @ViewBuilder placeholder: () -> Content) -> some View {

        ZStack(alignment: alignment) {
            placeholder().opacity(shouldShow ? 1 : 0)
            self
        }
    }
}

