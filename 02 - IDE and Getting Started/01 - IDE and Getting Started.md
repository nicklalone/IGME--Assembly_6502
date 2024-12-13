---------------- Table of Contents ---------------- 

1. [Welcome](#welcome)
2. [Logistics](#logistics)
3. [TLDR](#tldr)
4. [Day 1](#day1)
5. [Day 2](#day2)

---------------- Table of Contents ---------------- 

# <a id = "day1"></a>Day 1
So we're writing code for a 50 year old console that is 4kb at most without memory banking. How hard can it be? Well, instead of writing game logic for a translator or compiler, we're essentially writing machine code directly to a chip set. This means that you're going to have to translate your game loop for the limits and then translate your translation for Assembly. You can also read the actual machine language should you wish.



IDEs and Ways to Code
## Stella
Stella Debugger - https://stella-emu.github.io/docs/debugger.html
![](/images/StellaUI.png)
**Upper Right** = RAM + location of the scan line and what cycle it's on. This is important as all your registers are there (PC, SP, A, X, Y, PS) and what is currently in them. We'll talk more about them when we get into [[Process Flags]] and [[Registers]]. In the case of the PS line, this is [Processor Status](http://www.6502.org/users/obelisk/6502/registers.html). We'll get into those soon but know CAPS = Negative, lower case = Positive.
PC = Program Counter
SP = Stack Pointer or the thing that points to the memory positions. 
A = Accumulator
X/Y = Registers

**Upper Left** = Current position of the scanline.

**Lower Right** = Disassembly or what is being stored everywhere. Not that at the start, we disable interrupts (sei) and then define the code origin, followed by then disabling the HCD decimal math mode, load X with a register, then send it to the stack pointer. You can walk through this with the "STEP" on the upper right. 

**Lower left** = your log but also you can  look at the TIA chip as well as the RIOT and Audio portions of your machine.

Red also means something changed whereas remaining white means it did not.

The more important thing, or perhaps the thing that is often missing in literally all CS stuff. In the lower right, we see a solid line followed by 78, d8, a2 ff. This is the "Op Code" or actual machine language.

One thing to note about how this debugger works. Mostly, we'll work backward as we begin at 0 and work up to maximum. So, look at the RAM and how the lower right is FF whereas the upper left is 08. 

Original Guide is at: https://atarihq.com/danb/files/stella.pdf

## 8 Bit Workshop
We're going to be using [8-bit Workshop's IDE](https://8bitworkshop.com/v3.11.0/) for a lot of in-class demos and work so I don't have to figure out the legality of installing Stella or any of the other emulators for the Atari. It has everything you'll need to write, compile, and debug your code. It also has a variety of amazing features like Github Integration as well as being an IDE for just about all older systems including early Computers like the Apple ]\[+  and Commodore 64. So, it can be of use elsewhere which is something i'll try and make sure we do with most of our tools.

I'm going to go through the IDE and the various tools that are available to us. For documentation, please refer to Hugg's growing documentation page: https://8bitworkshop.com/docs/docs.html
### Github Integration
Speaking of, there is an enormous amount of content for the Atari 2600 on Github. As you get your games going, I will ask you to submit public Github links that give me your current codebase. 

This course is also available for you to fork via Github so you can have the content you need. Our IDE, [8-bit Workshop](https://8bitworkshop.com/v3.11.0/) allows you to push everything you do to a private scratch space. Just follow the directions by clicking the hamburger menu and then go here: 

![](8bitwork-git.png)
And it will walk you through everything you need. In this way, you can work on the code in your editor of choice, push and pull and publish as needed. Learning how to do this stuff is important as file maintenance is a very necessary skill for all game development projects and you can't just rely on a different IDE like Unity or Unreal to do it for you. 

### User Interface
Let's walk through this user interface. We'll situate it below: 
![](8bitwork-ide.png)
So, let's take a tour from the top line and then Left to Right. 

Menus and tools available to view. You'll see on the top bard what file you're working on followed by a number of "step" or "run to here" buttons. These are much the same as those of Stella. Below that, you'll see a list of files being used in the current file (dependencies as well as the actual file you're using). We will constantly use VCS.h and macro.h as they help provide some useful context for us in the modern era. 

To the right of the files and tools, you'll see Program Lines as well as the main coding window. Here, you'll see the line and if anything is happening in it with regard to machine code and the memory being invoked. As we get more familiar with OpCodes, this should become a bit more readable and can provide some valuable quick debugging. 

To the right of that is our actual render. Right now, i've got a simple "Hello World" invoked here. We'll slowly disconnect this and make it start falling around the screen but we have to do some coding exercises first.

Let's take a tour of the debugging tools next. 
### Disassembly
![](/images/8bit/8bitwork-disas.png)
From the documentation, we learned that this tool, "Disassembles the program at the current Program Counter." But what does that mean?
### Memory Browser
![](/images/8bit/8bitwork-membrowse.png)
From the documentation, we learned that this tool, "Displays a dump of all CPU memory." But what does that mean?
### Memory Map
![](/images/8bit/8bitwork-memmap.png)
From the documentation, we learned that this tool, "Displays a handy memory map of the system. Certain tools (like linkers) will give additional segment info here.." But what does that mean?
### Memory Probe
![](/images/8bit/8bitwork-memprobe.png)
From the documentation, we learned that this tool, "Shows a bitmap representing read/write activity across system memory" But what does that mean?
### CRT Probe
![](/images/8bit/8bitwork-crtprobe.png)
From the documentation, we learned that this tool, "Like the Memory Probe, but follows the sweep of the electron beam (for raster displays)" But what does that mean?
### Probe Log
![](/images/8bit/8bitwork-probelog.png)
From the documentation, we learned that this tool, "Shows a textual log of CPU/memory activity." But what does that mean?
### Scanline I/O
![](/images/8bit/8bitwork-scanline.png)
From the documentation, we learned that this tool, "Like the Memory Probe, but follows the sweep of the electron beam (for raster displays)" But what does that mean?
### Symbol Profiler
![](/images/8bit/8bitwork-symprof.png)
From the documentation, we learned that this tool, "Shows a list of symbols, with read/write counts." But what does that mean?
### Asset Editor
![](/images/8bit/8bitwork-asset.png)
From the documentation, we learned that this tool, "Parses assets (like bitmaps and palettes) and allows editing." But what does that mean?

We won't use this a lot as we don't actually have assets to manage. However, it will sometimes show the memory allocation of named entities like missiles and balls that we'll be able to adjust manually. Over time, we might end up coming back to this depending on if I can figure out how to force assets to end up there.
# Terms

