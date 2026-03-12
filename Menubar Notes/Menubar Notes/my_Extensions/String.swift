//
//  String.swift
//  Menubar Notes
//
//  Created by Shayan Eivaz Khani on 2025-02-26.
//




extension String {
    /***
        Why:
             func insertingLineBreaks(every n: Int) -> String
             
             a view have a .help(Text("\(p4TaskItem.taskNAME)")) on it so that when a mouse hovers on then it displays the massage,
             now i want to take that string and put a \n newline character at every 50th character so the displayed massage gets a standardised format
             
             You can achieve this by inserting a newline (\n) every 50 characters in p4TaskItem.taskNAME.
         
         Usage:
                 Text("Hover over me")
                     .help(Text(p4TaskItem.taskNAME.insertingLineBreaks(every: 50)))
         
         Explanation:
             The insertingLineBreaks(every:) function:
                 Iterates through each character in the string.
                 When it reaches 50 characters and encounters a space, it inserts a \n to avoid breaking words in the middle.
                 Resets the counter after inserting a newline.
     */
    func insertingLineBreaks(every n: Int) -> String {
        var result = ""
        var currentLineLength = 0

        for char in self {
            //if (currentLineLength >= n && char == " ") {
            if (currentLineLength >= n && (char == " " || char == "\n")) {
                result.append("\n")
                currentLineLength = 0
            } else {
                result.append(char)
                currentLineLength += 1
            }
        }
        return result
    }
    
    
    /***
        Why:
            func truncatedToLines(_ maxLines: Int = 20) -> String
             
            function in String extension that will cutof the string and put "..." at the end if the ammount of lines is more than 20
         
         Usage:
             let longText = """
                         Line 1
                         Line 2
                         Line 3
                         ...
                         Line 21
                         Line 22
             """

             print(longText.truncatedToLines())
         
         Explanation:
             Splits the string into an array of lines using .components(separatedBy: "\n").
             Checks if the line count exceeds maxLines (default is 20).
             Joins only the first 20 lines back into a string and appends "..." if necessary.
     */
    func truncatedToLines(_ maxLines: Int = 30) -> String {
        let lines = self.components(separatedBy: "\n") // Split string into lines
        
        if lines.count > maxLines {
            return lines.prefix(maxLines).joined(separator: "\n") + "\n..."
        }
        
        return self // Return original if within the limit
    }
    
}
