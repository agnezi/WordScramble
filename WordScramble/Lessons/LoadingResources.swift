//
//  LoadingResources.swift
//  LoadingResources
//
//  Created by itsjagnezi on 26/08/22.
//

import SwiftUI

struct LoadingResources: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
	
	func loadFile() {
		if let fileUrl = Bundle.main.url(forResource: "start", withExtension: "txt") {
			if let fileContents = try? String(contentsOf: fileUrl) {
				fileContents
			}
		}
	}
	
}

struct WordScramble_Previews: PreviewProvider {
    static var previews: some View {
        LoadingResources()
    }
}
