---
title: "Attending my first Hackathon with Plymouth University"
date: "2016-11-24T20:30:46-07:00"
author: "Dan Oak"
description: "Attending my first Hackathon"
draft: false
ShowReadingTime: true
ShowBreadCrumbs: true
ShowPostNavLinks: true
ShowWordCount: true
cover:
    image: "fig6-trophy.webp" # image path/url
    alt: "IBM Hackathon Winning" # alt text
    caption: "Attending my first Hackathon" # display caption under cover
    relative: true # when using page bundles set this to true
    hidden: false # only hide on current single page
---

# Intro
On Friday the 18th of November I embarked on a journey to Luton for IBM’s first Hackathon for the Hyperledger fabric and Blockchain technology. My initial interest in this event came from my lecturer when I was approached by her, and she asked if I’d like to attend. It’s worth mentioning here that I’d never attended a hackathon before the weekend of the 18th, but I knew of what they were and I had been interested in attending one for a long while, so I was keen. Same kind of story for blockchain, I knew of the technology, I mean for anyone that’s heard of Bitcoin will also know of the term blockchain so this also sparked my interest. I think now would be a good time to explain a bit about the technologies that were involved during the hacakthon event for those that may be a bit in the dark at this point, so if you already know about Hyperledger and blockchain technologies feel free to scroll past the explanations.

# Blockchain
From what I understood over the weekend, a blockchain network is essentially a distributed (decentralised) database of information which everyone on the network has a copy of. This database holds many many records which are known as blocks in the context of a blockchain network. These blocks can hold any information you want but once you put the information into the block and send it to the network, it needs to be consented by (you guessed it..) consenters which builds (once again you guessed it..) a consensus model. Once you get past the consenters and your block is sent to the network, everyone who is connected to the network will receive the updated database with the new appended block to it, if your copy of the database is the most recent copy. Now the network determines who is has the most up to date copy by a verifier on the network who checks the new database against at least 4 other peers and if it sees that the new database is in fact the most up to date and distributes your block and it’s there forever more. The blocks themselves once they’re added to the network are queryable so you can get data back out of the chain but it can never be erased, which is key! The data is stored in what’s called a “world state” which is just a key, value pair store which you query in the same way you would any other key, value store.

This kind of technology is really useful for things such as supply chains. For example say you wanted to verify that some meat you bought had come from a legit butcher who doesn’t deal with halal or anything like that, you can follow the transactions of that particular piece of meat from farm to butcher on a trusted network, which you know hasn’t been modified or changed because it’s impossible to do so, because of the way the network has been set up and the various different consensus models and verifiers which can quarantine any malicious activity.

{{< figure src="./fig1-architecture.webp" caption="Figure 1 - Hyperledger / Blockchain architecture." >}}

# HyperLedger
HyperLedger is an open source initiative which basically houses the blockchain code that we were working on over the weekend. Using both Docker and IBM’s very own infrastructure IBM Z servers running LinuxOne we were able to deploy our blockchain code to this HyperLedger fabric. We were able to communicate with the chain code that was running within the fabric with some REST API calls that were supplied by the HyperLedger toolkit which once we worked out the kinks wasn’t too hard to use at all. It’s worth noting that during this weekend we used version 0.6 of the fabric, as version 1 is deprecating the REST API and moving over to a node SDK instead for those that might be interested in playing around with the technology. As a direct quote from the [hyperledger.org](https://hyperledger.org) website on this technology:

> “Not since the Web itself has a technology promised broader and more fundamental revolution than blockchain technology. A blockchain is a peer-to-peer distributed ledger forged by consensus, combined with a system for “smart contracts” and other assistive technologies. Together these can be used to build a new generation of transactional applications that establishes trust, accountability and transparency at their core, while streamlining business processes and legal constraints.”

# My Weekend
So with those explanations out the way let’s talk about the weekend! The weekend really kicked off on the Friday night where we had some brief introductions to the HyperLedger fabric, and the core concepts of what a blockchain is and what kind of real world problems it’s helped to solve. It really was an educational experience for me not just the first day but the weekend as a whole, and incredible to witness what the technology can really do. So upon my arrival, I came without a team so there was just general socialising going on seeing who was without a team and starting to form teams of 5. Knowing that in order to be successful at a hackathon you need an ideas man, someone with some level of programming capabilities and someone who can pitch the idea and really sell it! The team forming didn’t happen right away since there were still people due to arrive on the Saturday so after having a play around with the IBM Z servers on Friday night, almost everyone retired to their hotels/sleeping quarters on campus and the event was put on a temporary pause for the time being.

# Saturday
Saturday swung around and the campus was a hive of activity with talks of people getting into teams and some real programming was to begin. I was placed with 4 other guys, Andrei, a student of Computer Science at UCL, David, a developer from the finance, Alok, a part time freelance contracter (yep another programmer) and Sam ,an independent from the Luton area with again some programming experience. So I quickly came to realise that my team was very programmer heavy. Further on that morning we started to brainstorm ideas for what we wanted to create and submit to the judges for the hackathon.

The first idea that came out of our discussion on Saturday morning was a photograph owner blockchain network, the idea being that a photographer will be able to submit their images to the network and if a visitor to the network wanted to use an image, they would have to get permission from the artist (whether that’s via some kind of payment or just on good will) before they could get the image.

The second of our ideas (this was mine, so don’t laugh) was a meme creator ownership blockchain, the idea behind this one wasn’t to generate revenue but as instead more of a bragging rights network to know that your meme went viral because it’s verified by the blockchain.

The next idea came from David, which was a more futuristic tackle of the problem. Conceptually his idea was that you could register self driving cars to the blockchain (Thinking far into the future), you as a person would be able to live on the blockchain network as an entity, you’d be able to call taxis from the block chain and pay the self driving taxi with the currency on the blockchain. As a team we decided that this was maybe a bit of a stretch for the time frame we had and getting our heads around the idea conceptually was fairly difficult also, so we felt like pitching the idea might not go as well as a more tangible idea.

The last of the initial ideas came from Andrei, who suggested that we allow programmers to have ownership of their software as intellectual property (You’d see it was theirs from when they registered it to the blockchain) and you could charge users of your code per execution almost like a VPS per hour type business model. Again due to time constraints we decided that it was maybe a little out of our reach, so we scoped it down to our final idea which was BlockCV!

{{< figure src="./fig2-smart-contract.webp" caption="Figure 2 - Initial Object Design." >}}

{{< figure src="./fig3-concept.webp" caption="Figure 3 - High level application design." >}}

BlockCV essentially was a blockchain that contained student entities which held their name, their date of birth, a list of qualifications, which was an array which could be initialised as empty and a list of employers which the student had granted access of his or her records to (See Figure 2). With the qualifications list containing an array of Qualification objects (Or structs as it is in GoLang), which held the properties of the University, and the nature of the course that the student completed. We then took this basic model and started to design the back end code/interfaces before implementing them and hooking a GUI to it all!

To briefly summarise what I got up to over the course of the weekend, I mostly focused on getting used to the GoLang environments and playing around with the IBM servers, while planning how I was going to pitch our business case. I tried to apply some of my own personal programming knowledge where my team mates were hitting walls with the different sections of the code base that they were working on. The source code for which can be found [here](http://github.com/andrei3131/BlockCV/) as we used Github to deploy our code on to the IBM servers.

{{< figure src="./fig4-ui.webp" caption="Figure 4 - GUI Web Application." >}}

For the front end Sam put together some bootstrap pages which were then hooked up to the node.js framework (…30 minutes before the presesntation), where the communication layer was written by David. A lot of the business logic is done within the node.js layer, hashing the students name and DoB together to a base64 encoded string as the Unique identifier for the student (Could be more unique, but hey … it was a hackathon!). The back-end of the application was written in GoLang. The back-end was basically a database layer that could store to, and retrieve from the blockchain. The only thing we sent to the blockchain was a serialised JSON object of the student object, which encapsulated all the information we needed to make a decent prototype. Once the structs and objects were in place to mirror one another from the back-end to the front-end and the business layer was finished, we pulled it all together and we were the first team to get a working blockchain prototype and that’s the moment we knew that we had a real good chance of winning this thing!

# Sunday — Judging Day!
When Sunday came around, we were told that judging would start at 3pm with lunch and refreshments being served at around 2pm. This gave us approximately 5 hours to scrub everything up and get the pitch strategy down. The slides that we put together can be found [here](https://docs.google.com/presentation/d/1XtP0U19_qNhLKRPTk36jVuMSWIsBrwYSybsxqh4OR8o/edit?usp=sharing). We (…well, Dave) even went so far as to register a domain for the project to add to its finesse. I delivered the pitch and Dave demo’d our prototype and overall at the time I thought it went well.

{{< figure src="./fig5-presentation.webp" caption="Figure 5 - Pitching BlockCV with the guys." >}}

but as they say, the proof was in the pudding and we’d done enough to secure the Trophy! It was a fantastic weekend and I learned a great deal about blockchain and going from problem to business case to solution in just 48 hours. I had the opportunity to network with some really intelligent people from industry, which was invaluable.

{{< figure src="./fig6-trophy.webp" caption="Figure 6 - Great Success! BlockCV had done it!." >}}

…And then I just had a really long train journey back to Plymouth, obviously with a big smile on my face. Who knows, maybe for the next Hackathon there might be a chance that I can find this team again to defend our title once more!

Cheers for reading!

