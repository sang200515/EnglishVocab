//
//  Extesion+String.swift
//  EnglishLearningKit
//
//  Created by Em bé cute on 5/17/24.
//

import Foundation
import NaturalLanguage

extension String {
    var keywords: [String] {
        let tagger = NLTagger(tagSchemes: [.lexicalClass, .tokenType])
        tagger.string = self
        print(tagger.string)
        var results = [String]()
        tagger.enumerateTags(in: startIndex ..< endIndex, unit: .word, scheme: .lexicalClass) { tag, range in
            if let tag {
                let word = String(self[range])
                let posTag = tag.rawValue
                print("\(word): \(posTag)")
                if word.contains("'") {
                    if let lastWord = results.last {
                        results[results.count - 1] = "\(lastWord.trimmingCharacters(in: .whitespaces) + word.replacingOccurrences(of: "'", with: "\u{2019}")) "
                    }
                } else {
                    switch tag {
                    case .punctuation, .otherPunctuation:
                        if let lastWord = results.last {
                            results[results.count - 1] = lastWord.trimmingCharacters(in: .whitespaces) + word
                        } else {
                            results.append(word)
                        }
                    case .verb, .noun, .adjective, .adverb, .pronoun, .determiner, .particle, .conjunction, .idiom, .interjection, .number, .otherWord:
                        results.append("\(word) ")
                        print(word)
                    default:
                        break
                    }
                }
            }
            return true
        }
        return results
    }
}
extension String {
    subscript(safeIndex range: Range<Index>) -> String? {
        guard range.upperBound <= endIndex else {
            return nil
        }
        return String(self[range])
    }
    
    var nilIfEmpty: String? {
        if self.isEmpty {
            return nil
        } else {
            return self
        }
    }
}
