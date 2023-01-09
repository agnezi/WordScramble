//
//  ContentView.swift
//  WordScramble
//
//  Created by itsjagnezi on 25/08/22.
//

import SwiftUI

struct ContentView: View {
	
	@State private var usedWords = [String]()
	@State private var rootWord = ""
	@State private var newWord = ""
	
	@State private var errorTitle = ""
	@State private var errorMessage = ""
	@State private var showingError = false
	@State private var userScore = 0
	
	
	var body: some View {
		NavigationView {
			Form {
				List {
					Section{
						TextField("Enter your word", text: $newWord)
							.autocapitalization(.none)
					}
					
					Section {
						ForEach(usedWords, id: \.self) {word in
							HStack {
								Image(systemName: "\(word.count).circle.fill")
								Text(word)
							}
							.accessibilityElement()
							.accessibilityLabel("\(word), \(word.count) letters")
						}
					}
				}
				.navigationTitle(rootWord)
				.onSubmit(addNewWord)
				.onAppear(perform: startGame)
				.alert(errorTitle, isPresented: $showingError) {
					Button("OK", role: .cancel) {}
				} message: {
					Text(errorMessage)
				}
				.toolbar {
					Button("Restart game", action: restartGame)
				}
				
				Section("Score") {
					Text(userScore, format: .number)
						.font(.title)
				}
			}
		}
	}
	
	func addNewWord() {
		let answer = newWord.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
		guard answer.count > 0 else { return }
		
		guard isOriginal(word: answer) else {
			wordError(title: "Word used already", message: "Be more original!")
			return
		}
		
		guard isPossible(word: answer) else {
			wordError(title: "Word not possible", message: "You can't spell that word from '\(rootWord)'!")
			return
		}
		
		guard isReal(word: answer) else {
			wordError(title: "Word not recognized", message: "You can't just make them up, you know!")
			return
		}
		
		guard isNotShort(word: answer) else {
			wordError(title: "Short word!", message: "The word must be length than 3 characters!")
			return
		}
		
		withAnimation {
			usedWords.insert(answer, at: 0)
			userScore += answer.count
		}
		newWord = ""
	}
	
	func startGame() {
		if let startWordsURL = Bundle.main.url(forResource: "start", withExtension: "txt") {
			if let startWords = try? String(contentsOf: startWordsURL) {
				let allWords = startWords.components(separatedBy: "\n")
				rootWord = allWords.randomElement() ?? "silkworm"
				return
			}
		}
		fatalError("Could not load start.txt from bundle.")
	}
	
	func restartGame() {
		usedWords = []
		rootWord = ""
		newWord = ""
		errorTitle = ""
		errorMessage = ""
		showingError = false
		userScore = 0
		startGame()
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
	
	func isNotShort(word: String) -> Bool {
		if word.count > 3 {
			return true
		} else {
			return false
		}
	}
	
	func wordError(title: String, message: String) {
		errorTitle = title
		errorMessage = message
		showingError = true
		userScore -= 2
	}
	
}

struct ContentView_Previews: PreviewProvider {
	static var previews: some View {
		ContentView()
	}
}
