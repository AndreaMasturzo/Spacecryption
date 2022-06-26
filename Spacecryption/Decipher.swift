//
//  Dechiper.swift
//  SkipJump
//
//  Created by Edoardo Troianiello on 26/06/22.
//

import Foundation

import Base64

class Dechiper {

    let plainAlphabet = ["A", "B", "C", "D", "E", ",F", "G", "H", "I", "J", "K", "L", "M", "N" ,"O", "P", "Q", "R", "S", "T", "U", "V", "W" ,"X", "Y", "Z", "a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z", "1", "2", "3", "4", "5" ,"6", "7", "8", "9","0"," ","!",",",".",]

    
    func reverse(string: String) -> String{

        return String(string.reversed())

    }

    
    /// Decoding Base64
    func base64Decoding(string : String) -> String {

        

        let bytes = string.makeBytes()

        let decodedBytes = try Base64.decode(bytes)

        var decodedString : String = ""

        do{

            decodedString = try String(decodedBytes)

        }catch{

            print("Test")

        }

        return decodedString

    }
    
    /// Encoding Base64
    func base64Encoding(string : String) -> String{
            let stringUTF8 = string.data(using: .utf8)
            var base64Decoded : String = ""
            if let base64Encoded = stringUTF8?.base64EncodedString(options: Data.Base64EncodingOptions(rawValue: 0)) {
                print("Encoded: \(base64Encoded)")
                if base64Decoded == Data(base64Encoded: base64Encoded, options: Data.Base64DecodingOptions(rawValue: 0))
                .map({ String(data: $0, encoding: .utf8) }) {
                    // Convert back to a string
                    print("Decoded: \(base64Decoded ?? "")")
                }
            }
            return base64Decoded
        }

    

    

    

    func generateCipherAlphabet(shift:Int)->[String]{

        var newPlainAlphabet = plainAlphabet

        

        for _ in 0...shift-1

        {

            newPlainAlphabet.append(newPlainAlphabet.remove(at: 0))

        }

        return newPlainAlphabet

    }

    
    /// Caesar Decryption
    func cesarDecrypt(message plainText: String, cesarShift: Int)->String

    {

        let cipherAlphabet = generateCipherAlphabet(shift: plainAlphabet.count - cesarShift)

        var cipherText = ""

        if cesarShift < 0

        {

            print("Shift must be positive")

            return plainText

        }

        for letter in plainText

        {

            let letterIndex = plainAlphabet.firstIndex(of: String(letter))

            if letterIndex == nil

            {

                cipherText = cipherText + String(letter)

            }

            else{

                cipherText = cipherText + cipherAlphabet[letterIndex!]

            }

            

        }

        return cipherText

    }
    
    
    /// Caesar Encryption
    func cesarEncrypt(message: String, cesarShift: Int) -> String {
            let cipherAlphabet = generateCipherAlphabet(shift: plainAlphabet.count + cesarShift)
            var cryptedText = ""
            if cesarShift < 0 {
                print("Shift must be positive")
                return cryptedText
            }
            for letter in message{
                let letterIndex = plainAlphabet.firstIndex(of: String(letter))
                if letterIndex == nil {
                    cryptedText = cryptedText + String(letter)
                } else {
                    cryptedText = cryptedText + cipherAlphabet[letterIndex!]
                }
            }
            return cryptedText
        }
    

    

    
    /// Skip Decryption
    func skipCipherDecryption(string:String, jump:Int)-> String{

        var lenght = string.count
        print(lenght)
        var array : [Character]
        array = Array(repeating: "a", count: lenght)
        for (index, char) in string.enumerated() {

            //            if (index * jump) % lenght >= 0 {

            print((index  * jump) % lenght)

            array[(index  * jump) % lenght] = char

            //            }

            //            else {

            //                array[((index - 1 * jump) % lenght) * -1] = char

            //            }

        }

        var string : String = ""

        array.map{string.append($0)}

        return string

    }
    
    /// Skip Encryption
    func skipCipherEncryption(string:String, jump:Int)->String{
            let lenght = string.count
    //        var array : [Character]
    //        array = Array(repeating: "a", count: lenght)
            var repeatingString : String = ""
            var resultString : String = ""
            for i in 1...jump*lenght{
                repeatingString.append(string)
            }
            for i in 0 ... lenght-1 {
                
                var char = repeatingString[repeatingString.index(repeatingString.startIndex, offsetBy: jump * i)]
                resultString.append(char)
            }
            return resultString
            
        }

}
