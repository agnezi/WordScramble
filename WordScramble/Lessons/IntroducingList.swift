//
//  IntroducingList.swift
//  WordScramble
//
//  Created by itsjagnezi on 25/08/22.
//

import SwiftUI

struct IntroducingList: View {
	let people = ["Jonas", "Francisco", "João"]
	var body: some View {
		List {
			
			Section("People") {
				
				ForEach(people, id: \.self) {
					Text($0)
				}
			}
			Section("Section 1") {
				Text("Static row 1")
			}
			
			Section("Section 2") {
				ForEach(0..<5) {
					Text("Dynamic row \($0)")
				}
			}
			
			Section("Section 3") {
				Text("Static row 3")
			}
		}
		.listStyle(.grouped)
	}
}

struct IntroducingList_Previews: PreviewProvider {
	static var previews: some View {
		IntroducingList()
	}
}
