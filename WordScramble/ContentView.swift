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
        TextField(
          "Enter your word",
          text: $newWord,
          onCommit: addNewWord
        )
        .textFieldStyle(RoundedBorderTextFieldStyle())
        .padding()
        .autocapitalization(.none)

        List(usedWords, id: \.self) {
          Image(systemName: "\($0.count).circle")
          Text($0)
        }
      }
      .navigationBarTitle(rootWord)
    }
  }

  func addNewWord() {
    let answer = newWord.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
    guard !answer.isEmpty else {
      return
    }

    usedWords.insert(answer, at: 0)
    newWord = ""
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
