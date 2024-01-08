---
title: "CSharp Plays Bejeweled Blitz | Dan Oak - Software Engineer"
date: "2015-12-25T11:49:46-07:00"
author: "Dan Oak"
description: "How to use C# to play Bejeweled Blitz"
draft: false
ShowReadingTime: true
ShowBreadCrumbs: true
ShowPostNavLinks: true
ShowWordCount: true
cover:
    image: "./grid-1.png" # image path/url
    alt: "C# Plays Bejeweld Blitz" # alt text
    caption: "C# Plays Bejeweld Blitz" # display caption under cover
    relative: true # when using page bundles set this to true
    hidden: true # only hide on current single page
---

# C# Plays Bejeweled Blitz

{{< youtube LyR10G9UCzM >}}

As some of you reading this may or may not already know; over the past day or so I went from having the idea of creating a computer program that would essentially be able to play the popular arcade game Bejeweled Blitz on Facebook, to actually developing it. Now as hard as this problem sounds, it was surprisingly easy and fairly swift to solve. I broke it down into three main steps:

1. Identify the area in which the bejeweled game was being played.
1. Identify what colour was in what square.
1. Check for the possible directions you could move a colour to successfully make a line of three.

The first step was probably the most time consuming of them all as everything from there was just colour management. The Solution I came up with in the end for that was to take a screenshot of the entire screen, and then scan the image from top to bottom using a nested for loop until I found a funny shade of brown that only appears along the Top Edge of the bejeweled grid (for anyone wondering that colour is Color.FromArgb(255, 39, 19, 5)). Once this colour had been found using the bitmap.GetPixel(x, y) function, I broke out of both for loops and knew that was the point where the top left corner of the grid was. I could then use this to construct a rectangle which would extract the bejeweled grid from the full screenshot. The size of the rectangle was calculated using the size of the grid cells (40px², found that out using trusty old paint) multiplied by the amount of rows/columns there were (8, found that out using my eye balls). This resulted in the Rectangle size coming out at 320px².

{{< figure src="./grid-1.png" caption="Obtaining the playable grid." >}}

So the next step from here was to identify what colour resides in what square. To do that I started off by creating a 2 dimensional array of colours (Or Color’s to be politically correct) that was 8 rows and 8 columns to match that of the playable grid. I then systematically looped through the 2 dimensional array of colours in a nested for of x and y values assigning the array the colour of the pixel at the Location (x * 40) + 20, (y * 40) + 22. The x value was decided as it was half way through the gem and 22 was chosen for the y value as certain gems have a white center (Green and yellow) so 22 provided a more accurate reading. With this 2 dimensional array I was then able to generate a visual representation of what the computer was seeing when it was trying to figure out what colour was where.


{{< figure src="./translation.png" caption="Translating the Gems to Colours." >}}

As you can see from the above screenshot it’s able to identify what gem is what colour depending on what pixel is at that magic 20, 22 of the cell. Another thing I thought about before I finished this project to the state it’s in now is to prevent the application from trying to switch 2 empty cells (because one gem has just been blown up or something), I added all the known color codes to their own array and ask if the colour that’s in the 2d array also resides within the known colours list, if it does it will then evaluate whether it can be moved to a winning square, if not it’s ignored entirely.

I won’t bore you with the gory details of how I check if a gem can be moved, as instead [this](https://github.com/DanDecrypted/BejeweledBotDotNet/blob/master/BejeweledBotDotNet/BejeweledWindowManager.cs#L72) is a link to the beginning of the if statement in my [Open Source Github Project](https://github.com/DanDecrypted/BejeweledBotDotNet). From here the full source code can be viewed, commented on and even improved upon if you guys feel like I could do something obviously better.

Finally all that’s left to do by definition of this application is to actually move the Gems. This is done by making some Windows API calls to set the mouse location and simulate mouse clicks. Again the details of how to exactly do that are within the github project, but if I’ve kept your attention for this long all that’s left to say is thank you and if you have any further questions don’t hesitate to hit me up on here or twitter [CoderDan](https://twitter.com/CoderDan).

Thanks for reading.