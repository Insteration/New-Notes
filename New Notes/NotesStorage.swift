//
//  NotesStorage.swift
//  New Notes
//
//  Created by Artem Karmaz on 2/7/19.
//  Copyright © 2019 Johansson Group. All rights reserved.
//

import Foundation

struct Storage {
     var notes = [
        Note(text: "What notes can do?\r\r 1. two ~ for beatiful headline \r 2. two * for bold font \r 3. two spacebar for ALERT \r 4. two - for crossed out text\r 5. two _ for titled text\r 6. number with . for enumerations\r 7. Cool searchbar in main menu"),
        Note(text: "~SHOPPING LIST~\r\r1. Apple watch\r2. iPhone 8\r3. iMac new\r4. IMPORTANT Cash for going out!\r5. -macbook pro-\r6. *money?*\r8. _A present for mum_"),
        Note(text: "Car\rA My car is very beatiful!"),
        Note(text: "iOS12 \n\niOS12 More faster than iOS 11\r 1. -Install iOS12-"),
        Note(text: "Notes on Swift\nThis new language from Apple is changing iOS development as we know it!"),
        Note(text: "A collection of thoughts\rWhy do birds sing? Why is the sky blue? Why is it so hard to create good test data?\r DAMN "),
        Note(text: "*Call Jonny*\r-saturday- \r_sunday_")
    ]
}
