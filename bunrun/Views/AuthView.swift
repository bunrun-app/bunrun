//
//  AuthView.swift
//  bunrun
//
//  Created by dorin flocos on 2/6/25.
//

import SwiftUI

struct AuthView: View {
    @EnvironmentObject var session: Session
    @State private var viewModel = AuthViewModel()

    @State private var hasAccount = true

    @State private var firstName = ""
    @State private var lastName = ""
    @State private var email = ""
    @State private var password = ""
    @State private var errorMsg: String?

    var body: some View {
        VStack {
            Text("bunrun")
                .fontWeight(.bold)
                .font(.largeTitle)

            VStack {
                if !hasAccount {
                    HStack {
                        TextField("First", text: $firstName)
                            .autocapitalization(.none)
                            .autocorrectionDisabled()
                            .textFieldStyle(.roundedBorder)

                        TextField("Last", text: $lastName)
                            .autocapitalization(.none)
                            .autocorrectionDisabled()
                            .textFieldStyle(.roundedBorder)
                    }
                }

                VStack {
                    TextField("Email", text: $email)
                        .autocapitalization(.none)
                        .autocorrectionDisabled()
                        .textFieldStyle(.roundedBorder)

                    SecureField("Password", text: $password)
                        .autocapitalization(.none)
                        .autocorrectionDisabled()
                        .textFieldStyle(.roundedBorder)
                }
            }
            .padding(.vertical)

            Button(action: {
                errorMsg = ""
                session.status = .loading

                let handleAuthAttempt: (Bool, String?) -> Void = { success, error in
                    if !success {
                        errorMsg = hasAccount ? "Incorrect username or password" : error
                        print(error!)
                    }
                    session.validate()
                }

                if hasAccount {
                    viewModel.signInUser(email: email, password: password, completion: handleAuthAttempt)
                } else {
                    viewModel.signUpUser(firstName: firstName, lastName: lastName, email: email, password: password, completion: handleAuthAttempt)
                }
            }) {
                Text(hasAccount ? "Sign in" : "Sign up")
                    .frame(maxWidth: .infinity)
            }
            .buttonStyle(.borderedProminent)
            .disabled(session.status == .loading)

            if let errorMsg = errorMsg {
                Text(errorMsg)
                    .font(.footnote)
                    .foregroundColor(.red)
            }

            HStack {
                Text(hasAccount ?  "Don't have an account?" : "Already have an account?")
                    .font(.footnote)

                Button(action: {
                    errorMsg = ""
                    password = ""
                    hasAccount = !hasAccount
                }) {
                    Text(hasAccount ? "Sign up" : "Sign in")
                        .font(.footnote)
                        .underline()
                }
            }
            .foregroundStyle(.gray)
            .padding(.vertical)
        }
        .padding(40)
    }
}

#Preview {
    ContentView()
        .environmentObject(Session())
}
