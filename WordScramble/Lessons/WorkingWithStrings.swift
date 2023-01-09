//
//  WorkingWithStrings.swift
//  WordScramble
//
//  Created  26/08/22.
//

import SwiftUI

struct WorkingWithStrings: View {
	var body: some View {
		Text(test())
	}
	
	func test() -> String {
		let input = """
a
b
c
"""
		let letters = input.components(separatedBy: "\n")
		let letter = letters.randomElement()
		let trimmed = letter?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
		
		
		
		
		let word = "swift"
		let checker = UITextChecker()
		
		let range = NSRange(location: 0, length: word.utf16.count)
		let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
		return "swift"
	}
}

struct WorkingWithStrings_Previews: PreviewProvider {
	static var previews: some View {
		WorkingWithStrings()
	}
}
