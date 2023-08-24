//
//  ProfileView.swift
//  monarch
//
//  Created by Student16 on 23/08/23.
//

import SwiftUI

struct ProfileView: View {
    @State var description: String = ""
    @State var showGreeting = true
    
    var body: some View {
        NavigationStack {
            ZStack {
                LinearGradient(gradient: Gradient(colors: [.blue, .white]), startPoint: .top, endPoint: .bottom)
                    .ignoresSafeArea()
                
                VStack {
                    Text("My Profile")
                        .foregroundColor(.black)
                        .bold()
                        .padding(.top)
                    
                    HStack {
                        Spacer()
                        VStack {
                            // IMAGE
                            Image("picture")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 200, height: 175)
                                .clipShape(Circle())
                                .shadow(color: Color.black.opacity(0.5), radius: 6, x: 0, y: 3)
                                .clipped()
                                .padding(.top, 40.0)
                            
                            // USER
                            Text("@notfarchi")
                                .font(.system(size: 18))
                                .shadow(color: Color.gray.opacity(0.5), radius: 6, x: 0, y: 3)
                                .foregroundColor(.black)
                            
                            // NAME
                            Text("Joao Victor Farchi")
                                .font(.system(size: 20))
                                .bold()
                                .foregroundColor(.black)
                                .padding(.top, -5)
                            
                            
                            HStack {
                                
                                Image("engrenagem")
                                    .resizable()
                                    .frame(width: 25, height: 25)
                                Text("Settings")
                                    .bold()
                                
                                
                                Text("|")
                                
                                
                                Image("eyeon")
                                    .resizable()
                                    .frame(width: 25, height: 25)
                                Toggle("Visible:", isOn: $showGreeting)
                                    .toggleStyle(SwitchToggleStyle(tint: .green))
                                    .bold()
                                    .frame(width: 120)
                                
                                
                                // FRIENDS
                                //NavigationLink(destination: FriendsView()){
                                /*     Image("friends_1500455")
                                 .resizable()
                                 .frame(width: 25, height: 25)
                                 Text("Friends") */
                                // }
                                
                                // EVENTS
                                // NavigationLink(destination: EventoView()){
                                /*   Image("calendar")
                                 .resizable()
                                 .frame(width: 25, height: 25)
                                 Text("Events") */
                                // }
                                // CONTACT
                                
                                
                            }
                            
                            HStack {
                                
                                Image("message")
                                    .resizable()
                                    .frame(width: 25, height: 25)
                                Text("About me:    ")
                                    .bold()
                                
                            }
                            
                            HStack {
                                
                                TextField("How are you feeling today?", text: $description)
                                    .keyboardType(.decimalPad)
                                    .padding()
                                    .background(Color.gray.opacity(0.15))
                                    .cornerRadius(10)
                                    .frame(width: 300, height: 40)
                                    .multilineTextAlignment(.center)
                                
                            }
                            
                            Text("")
                            
                            HStack {
                                
                                Image("telephone")
                                    .resizable()
                                    .frame(width: 25, height: 25)
                                Text("Telephone Number:")
                                    .bold()
                            }
                            
                            HStack {
                                
                                Text("+55 35 99853-2121                           ")
                                    .keyboardType(.decimalPad)
                                    .padding()
                                    .background(Color.gray.opacity(0.15))
                                    .cornerRadius(10)
                                    .frame(width: 400, height: 40)
                                    .multilineTextAlignment(.center)
                                
                            }
                        }
                        Spacer()
                    }
                    Spacer()
                }
            }
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
