//
//  RankView.swift
//  EduMini
//
//  Created by Paulina Wyskiel on 14/11/2023.
//

import SwiftUI

struct RankView: View {
    @ObservedObject private var rankingVM = RankViewModel()

    var body: some View {
        NavigationView {
            
            List {
                Section {
                    ForEach(rankingVM.users, id: \.uid) { user in
                        HStack() {
                            Text(rankingVM.place(for: user.uid))
                                .font(Font.custom("BalsamiqSans-Bold", size: UIScreen.main.bounds.width * 0.1))
                                .foregroundColor(Color("DarkBabyBlueColor"))
                                .cornerRadius(5.0)
                                
                            VStack {
                                HStack {
                                    Text("\(user.nick)")
                                        .font(Font.custom("BalsamiqSans-Regular", size: UIScreen.main.bounds.width * 0.06))
                                    if user.uid == rankingVM.loggedInUserID {
                                        Image(systemName: "star.fill")
                                            .foregroundColor(.yellow)
                                    }
                                    
                                    Spacer()
                                    
                                    Text("Punkty: \(user.points)")
                                        .font(Font.custom("BalsamiqSans-Regular", size: UIScreen.main.bounds.width * 0.04))
                                }
                                
                            }
                        }
                        .padding(.horizontal)
                        .background(user.uid == rankingVM.loggedInUserID ? Color.yellow.opacity(0.3) : Color.clear)
                        .cornerRadius(25)
                        
                    }
                } header: {
                    Text("Ranking")
                        .font(Font.custom("BalsamiqSans-Regular", size: UIScreen.main.bounds.width * 0.1))
                        .foregroundColor(Color.white)
                        .textCase(.none)
                        .shadow(radius: 2)

                }
            }
            .scrollContentBackground(.hidden)
            .background(
                Image("profileBG")
                    .resizable()
                    .scaledToFill()
                    .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
                    .edgesIgnoringSafeArea(.all)
                    .background(Color.clear)
            )
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarTitle("")
            .onAppear {
                rankingVM.fetchAndSortUsers()
            }
        }
    }
}

struct RankView_Previews: PreviewProvider {
    static var previews: some View {
        RankView()
    }
}
