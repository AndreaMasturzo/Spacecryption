//

//  Dechiper.swift

//  SkipJump

//

import Foundation

class Dechiper {

    let plainAlphabet = ["A", "B", "C", "D", "E", ",F", "G", "H", "I", "J", "K", "L", "M", "N" ,"O", "P", "Q", "R", "S", "T", "U", "V", "W" ,"X", "Y", "Z","a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z", "1", "2", "3", "4", "5" ,"6", "7", "8", "9","0"," ","!",",",".",]


           func generateCipherAlphabet(shift:Int)->[String]

       {

           var newPlainAlphabet = plainAlphabet

           

           for _ in 0...shift-1

           {

               newPlainAlphabet.append(newPlainAlphabet.remove(at: 0))

           }

           return newPlainAlphabet

       }

       

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

    

    

    func skipCipher(string:String, jump:Int)-> String{

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

}
