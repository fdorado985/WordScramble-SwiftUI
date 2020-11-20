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
      .onAppear(perform: startGame)
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

  func startGame() {
    if let startWordsURL = Bundle.main.url(forResource: "start", withExtension: "txt") {
      if let startWords = try? String(contentsOf: startWordsURL) {
        let allWords = startWords.components(separatedBy: "\n")
        rootWord = allWords.randomElement() ?? "silkworm"
      }
    }
  }

  func isOriginal(word: String) -> Bool {
    !usedWords.contains(word)
  }

  func isPossible(word: String) -> Bool {
    var tempWord = rootWord

    for letter in word {
      if let pos = tempWord.firstIndex(of: letter) {
        tempWord.remove(at: pos)
      } else {
        return false
      }
    }

    return true
  }

  func isReal(word: String) -> Bool {
    let checker = UITextChecker()
    let range = NSRange(location: 0, length: word.utf16.count)
    let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")

    return misspelledRange.location == NSNotFound
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
