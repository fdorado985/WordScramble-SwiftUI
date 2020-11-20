//
//  ContentView.swift
//  WordScramble
//
//  Created by Juan Francisco Dorado Torres on 18/11/20.
//

import SwiftUI

struct ContentView: View {
  @State private var usedWords: [String] = []
  @State private var rootWord = ""
  @State private var newWord = ""

  var body: some View {
    NavigationView {
      VStack {
        TextField("Enter your word", text: $newWord)
          .textFieldStyle(RoundedBorderTextFieldStyle())
          .padding()
        List(usedWords, id: \.self) {
          Text($0)
        }
      }
      .navigationBarTitle(rootWord)
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
