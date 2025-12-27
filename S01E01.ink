# title: The Curious Case of the Meat Jerky Theft
# author: Keith

// SCOPE AND VISION
// You are: Detective Beans
// Have it be an adventure in the house where the character encounters each of the pets, including the various aliases of the cats, and an adventure plays out. Solving some sort of mystery?
//  Have moving around the space be true to the actual layout of the house.
//  It could be tiny and episodic and be an advent calendar experiment for one year.
//  Make it a bit like the real world but warped in a Calvin and Hobbes sort of way e.g. the cat police evidence lockers are under the stairs.

// INITIAL OUTLINE
// You need to find a series of clues in and around the dining room to solve the case and find the missing meat jerky.
// The story ends on a cliffhanger with the jerky being found, but it's been chewed - so you send it off to kitty forensics (Kitty Crime Lab?) for analysis.
// (And maybe you "Have a nap" a few times and the results come back pointing a paw at The Naughty Kitty?)
// You can't just find the meat jerky, it only appears once you have all of the clues. (Scavenger hunt-style)
// It's somewhere you can't get to initially and hidden behind options that only appear once a certain knowledge state is reached.
// The jerky is behind and under a pile of presents at the back of the tree. To get to it, you need to declare a crime scene, use your SnootInspect to sniff it out, push (smash) some presents, and then finally reveal it.
// You can't declare a crime scene until you've exhausted searching other locations. If you do, the other police cats admonish you for sloppy police work.
// Each location grants your a clue in the form of knowledge gained. Collecting all of the clues enables the "Declare crime scene" option around the Christmas tree.
// The PERPETRATOR is The Naughty Kitty, but we can't apprehend them as they've disappeared

// TODO - Optional
// - Phonebook a witness
// - Encounter the other cats and have pictures of them (incl. 'finger ears') appear as they're introduced
// - Additional Seasonal Head options: Random chance of Mina, Choose violence, Jump on top and gain embarrassed
// - Add under the stairs as a location
// - Browse Ink docs for ideas for other mechanics to add

// TODO - Episode 2
// - How will we share functions and core logic/structure between stories? (e.g. given the locations will be re-used and added to over time e.g. given that some functions like 'groom yourself' will also be shared)
// - How will we save state and transfer between episodes?

// LOCATIONS (Initial outline - not all locations used in the final story)
// - The Christmas Tree
//      - Around the base
//      - Underneath
//      - The top (climbing)
//      - Try to announce you've solved the case (Scarlett stops you with different text depending on how many clues you’ve got so far)
// - The Dining Room Table
//      - Underneath
//          : SnootSense: Paw prints coming from the hallway!
//          : SnootInspect: Lego boxes
//          : SnootInspect: Companion Cube Head
//      - The top (jumping)
//          : SnootInspect: Some bottles. Perchance, Baileys later?
//          : SnootSense: Paw prints leading down the hallway!
//          : Push: Smash! How satisfying.
//              : (Future: May lead to other things like Shards and Ants.)
// - The Companion Cube Head
//      - Inside
//          : ChooseViolence: You await...Bat bat bat!
//          : Snooze: You curl up, tail around your nose, and rest after some tiring invesitgation.
//          : WakeUp: You slowly blink your eyes open, wondering about biscuits.
//      - On Top
//          > It collapses and you are embarrassed.
// - The Bar
//      - Underneath
//      - A shelf (jump)
// - The box of bags
//      : SnootInspect: Afeared
//      : PawAt: Bags fall onto the ground
//      : Come across a witness and try to phonebook them; but you can’t because you don’t have your Cert IV yet
// - Under the stairs
//      - Bottles, many bottles
//      - Taking nip from the evidence locker (Snööts stops you)
//      - Cold storage for Snoot's corposes (the fridge)

// Conclusion: The PERPETRATOR is The Naughty Kitty, but we can't apprehend them as they've disappeared


INCLUDE Functions.ink
INCLUDE Samples.ink

-> ChristmasTree.Intro

//
//  System: items can have various states
//  Some are general, some specific to particular items
//

VAR DEBUG = false

VAR GENDERTERM = "kiddo"

LIST OffOn = off, on
LIST SeenUnseen = unseen, seen

LIST GlassState = (none), steamed, steam_gone
LIST BedState = (made_up), covers_shifted, covers_off, bloodstain_visible

LIST CatState = (never_embarrassed), embarrassed, still_embarrassed, has_been_embarrassed

LIST DiningRoomFloorState = (safe), shards, being_cleaned, cleaned

VAR SeasonalHeadState = "empty"

VAR CatTowerState = "unoccupied"

VAR CatNapState = "no_nap"

VAR CatTreatState = "no_treats"

VAR CocktailGlassState = "whole"

//
// System: inventory
//

LIST Inventory = (none), cane, knife

//
// System: positioning things
// Items can be put in and on places
//

LIST Supporters = on_desk, on_floor, on_bed, under_bed, held, with_joe

// System: Incremental knowledge.
// Each list is a chain of facts. Each fact supersedes the fact before 
//

VAR knowledgeState = ()

//
// Set up the game
//

VAR bedroomLightState = (off, on_desk)

VAR knifeState = (under_bed)

//
// Knowledge chains
//

LIST BedKnowledge = neatly_made, crumpled_duvet, hastily_remade, body_on_bed, murdered_in_bed, murdered_while_asleep

LIST KnifeKnowledge = prints_on_knife, joe_seen_prints_on_knife, joe_wants_better_prints, joe_got_better_prints

LIST WindowKnowledge = steam_on_glass, fingerprints_on_glass, fingerprints_on_glass_match_knife

LIST ClueKnowledge = clue1, clue2, clue3, clue4


//
// Story content
//

// === CleanYourself(-> backto)
//     You think about cleaning yourself. But where to start?
    
//     - -     (opts)
//         + +     (paws) {TURNS_SINCE(-> paws) == -1 or TURNS_SINCE(-> paws) >= 10} [Paws]
//                 Paws cleaning.
        
//         * *     (face) {TURNS_SINCE(-> face) == -1 or TURNS_SINCE(-> face) >= 10} [Face]
//                 Face cleaning.
        
//         * *     (belly) {TURNS_SINCE(-> belly) == -1 or TURNS_SINCE(-> belly) >= 10} [Belly]
//                 Belly cleaning.
        
//         * *     (butt) {TURNS_SINCE(-> butt) == -1 or TURNS_SINCE(-> butt) >= 10} [Butt]
//                 You contort your body to form your favourite shape, a pentagram, and clean your butt.
        
//         * *     (tail) {TURNS_SINCE(-> tail) == -1 or TURNS_SINCE(-> tail) >= 10} [Tail]
//                 Tail cleaning.
    
//         + + {CHOICE_COUNT() == 0} -> squeaky_clean
         
//     - -     (loop)
//         // loop a few times before the guard gets bored
//         { -> opts | -> opts | }
//         He scratches his head.
//         'Well, can't stand around talking all day,' he declares.
    
//     - -     (squeaky_clean) Words...
//             -> backto
            
//     - -     (done)
//             You're done here.
//             -> backto


=== Nap(-> backto)
    -> DoNap(backto)
    
= DoNap(-> backto)
    You close your eyes, relax, and power down your SnootSense™.
    ~ CatNapState = "is_napping"
    
    - (top)
    +   (dream) {CatNapState == "is_napping"} [Dream]
        You're in the laundry with the Biscuit Buffet and Luxury Fountain Experience.
        
        Except something seems...wrong somehow.
        
        You approach the Biscuit Buffet...
        ~ CatNapState = "is_dreaming_stage1"
        
    +   (dream_again) {CatNapState == "is_dreaming_stage1"} [Keep dreaming]
        You peer over the edge of the Biscuit Buffet and a sight of true, unambiguous, horror is staring you in the face...
        
        You can see the Bottom of the Bowl!
        
        At at least three different points, between plentiful piles of biscuits, you can see the shiny metallic surface of the Bottom of the Bowl!
        ~ CatNapState = "is_dreaming_stage2"
        
    +   (dream_yet_again) {CatNapState == "is_dreaming_stage2"} [Keep dreaming]
        What horror.
        
        You pace in circles, calling for help, for backup, for anyone.
        
        One of the staff hears your calls and comes to investigate.
        
        'Blah blah blah BISCUITS. Blah blah blah THINK blah blah, blah BUFFET?' mutters the staff member.
        ~ CatNapState = "is_dreaming_stage3"
        
    +   {CatNapState == "is_dreaming_stage1"} [Wake up]
        You blink, yawn, and shake your head.
        
        You're not sure what terrible thing you were about to find at the Biscuit Buffet, so it's probably a good thing you woke up.
        
        You don't feel particularly rested after that four hour nap. Better try to get back to the case, I guess?
        -> backto
        
    +   {CatNapState == "is_dreaming_stage2" or CatNapState == "is_dreaming_stage3"} [Wake up]
        You blink slowly and let out the biggest yawn.
        
        What a terrible nightmare, you still feel mildly shaken by it.
        
        Fancy being able to see the bottom of the Biscuit Buffet.
        
        The horror, the horror.
        
        Nightmares aside, you feel well rested and ready to take on the case again.
        ~ CatNapState = "had_nap"
        -> backto
    
    - -> top


=== GainClue(clue)
    {LIST_COUNT(ClueKnowledge):
        - 0:
            <- ClueSuccess(clue)
            
        - 1:
            {CatTreatState:
                - "has_treats":
                    <- ClueSuccess(clue)
                - else:
                    <- ClueFailure(clue)
            }
            
        - 2:
            <- ClueSuccess(clue)
            
        - 3:
            {CatNapState:
                - "had_nap":
                    <- ClueSuccess(clue)
                - else:
                    <- ClueFailure(clue)
            }
    }
    
    {DEBUG:
        - true:
            {ClueKnowledge} ({LIST_COUNT(ClueKnowledge)})
            {CatNapState}
            {CatTreatState}
    }
    
    - -> DONE

=== ClueFailure(clue)
    {LIST_COUNT(ClueKnowledge):
        // The player needs to have eaten some treats to gain the second clue
        - 1:
            Your SnootSense™ sparkles a bit, detecting the faintest whiff of something.
                    
            You snoot harder, trying to tease out what it is...
            
            But no, it's no good - all of this investigating is hard work and you haven't eaten for at least half an hour.
            
            Maybe with a treat or two in your belly you'll be able to work it out?
        
        // The player needs to have had a nap to gain the fourth and last clue
        - 3:
            Your SnootSense™ twitches...there's something there.
                    
            You snoot harder and try again.
            
            No. Nothing.
            
            You're just too tired. All of this detecting is hard work.
            
            Maybe you'll be OK after a nap?
    }
    
    - -> DONE

=== ClueSuccess(clue)
    ~ ClueKnowledge += clue
        
    {
      // Chewed Grass (Location = Under the Christmas Tree)
      - clue == clue1:
        Your SnootSense™ picks up something odd, just sticking out from behind the bag containing the jerky.
            
        It's green, partly chewed, and looks like it's been partly chewed.
        
        You get closer and sniff at it.
        
        It's smells like grass. But it's been chewed, why would anyone want to eat grass?
        
        But that's a mystery for another day. You bag it up and label it.
        
        That's our first clue, is it enough to crack the case? Better run it past DI Scarlett.
        
      // Lonk Cat (Location = On top of the dining room table)
      - clue == clue2:
        Your SnootSense™ revs up to 11 as you observe the crime scene from above.
        
        From this angle, you see just how tall the bag is, and just how far down the meat jerk is.
        
        The criminal would need to have been unusually tall, with exceptionally long paws, to be able to stand up and reach inside to snag the jerky.
        
        So we're after a tall criminal with a penchant for eating grass?
        
        Surely that's enough to make DI Scarlett happy? Only one way to find out...
        
        // Force the player to have a nap after the second and third clues, even if they've already had one
        ~ CatNapState = "no_nap"
        
      // Paw Prints (Location = Underneath the dining room table)
      - clue == clue3:
        Your SnootSense™ tingles as you inspect the ground around you.
            
        Something is off...
        
        You switch to your Snoot-o-Vision™ and there it is!
        
        A trail of paw prints heading from the hallway to the tree, and from the tree back down the hallway.
        
        So our tall criminal with a penchant for eating grass came from the hallway, eh?
        
        Is this enough to close the case? Better see what DI Scarlett thinks.
        
        // Force the player to have a nap after the second and third clues, even if they've already had one
        ~ CatNapState = "no_nap"
        
      // Black Fuzz (Location = On top of the Cat Tower)
      - clue == clue4:
        Your SnootSense™ twitches...and this time you latch on to something.
                    
        You snoot hard and...yes, there it is!
        
        A suspicious piece of black fuzz on the edge of the Cat Tower.
        
        So our tall criminal, who came from the hallway and has a penchant for eating grass, has black fur!
        
        That's it, you've surely got enough now to point your beans at the perp.
        
        Better go let DI Scarlett know you've cracked the case!
    }
    
    - -> DONE


=== ClueDebug
It's clue debug.
-> Debug

= Debug

- (top)
{ClueKnowledge} ({LIST_COUNT(ClueKnowledge)})
{CatNapState}
{CatTreatState}

+   {ClueKnowledge !? clue1} [Clue 1]
        <- GainClue(clue1)
      
+   {ClueKnowledge !? clue2} [Clue 2]
        <- GainClue(clue2)
      
+   {ClueKnowledge !? clue3} [Clue 3]
        <- GainClue(clue3)
      
+   {ClueKnowledge !? clue4} [Clue 4]
        <- GainClue(clue4)

+   {CatTreatState !? "has_treats"} [Treats]
    ~ CatTreatState = "has_treats"

+   {CatNapState !? "had_nap"} [Nap]
    ~ CatNapState = "had_nap"
        
+   [Done here, head back to the tree]
    -> ChristmasTree.Main
    
- -> top


// #####################################
//          The Christmas Tree
// 
// - Intro
// - Main
// - Investigate
// - PresentToScarlett
// - Finale
// #####################################

=== ChristmasTree ===
    // * *   'Can I get a uniform from somewhere?'[] you ask the cheerful guard.
        // 'Sure. In the locker.' He grins. 'Don't think it'll fit you, though.'

= Intro
    Sunlight streams through the window, striking the Christmas Tree and causing reflections to scatter all about the room.
        
    This is where it happened.
    
    This is where the Great Meat Jerky Heist played out.
    
    'Why am I here? Why did I get the case?' you muse to yourself, a sense of mild trepidation creeping in to your thoughts.
    
    'What if I'm not up to it? Fresh out of CATPOL Detective Training School and this is the first case they give you? What if..'
    
    'QUACK!'
    
    You pop straight up in the air, exclaim a few rather less than savoury words with your ears, and look behind you.
    
    It's the famous Detective Inspector Scarlett! (Some say she's infamous, which you understand means 'really famous'.)
    
    The most decorated, most effective, and biggest butted Detective there's even been in CATPOL.
    
    'Oh biscuits!' DI Scarlett won't be impressed that you're late. 
    
    - (top)
    * [Greet DI Scarlett]
        # IMAGE: media/scarlett_not_impressed.jpeg
        
        'What time do you call this, {GENDERTERM}?'
        
        'Nevermind, get out your notebook and go have a look around for clues - do some real police work for a change, not just all of that theoretical bullshit.'
        
        'Come back to me whenever you've got something to show from the investigation.'
        
        -> Main
        
    // @TODO Add some initial back-and-forth dialogue with Scarlett?
    // * {greet >= 1} [Foobar]
   
    // @TODO Add the dialogue for this   
    // *   [Clean yourself]
    //     <- CleanYourself(-> top)
    
    -   -> DONE
    
    // - -> top

= Main
    {|Detective Scarlett is still sitting meditatively next to the crime scene. Seemingly just enjoying being with?}
    
    Better crack on with the case. We don't want to disappoint DI Scarlett.
    
    - (top)
    * *     {DEBUG == true} [** Clue debug **]
            -> ClueDebug
    
    + +     [Talk to DI Scarlett]
            {has_all_clues() == false: -> PresentToScarlett|-> Finale}
    
    + +     [Look around]
            -> Investigate
   
    // + +     [Clean yourself] 
    //         <- CleanYourself(-> Main)
            
    + +     [Head to the dining room table]
            -> DiningRoomTable
            
    + +     [Head to the bag pouffe]
            -> BagPouffe
            
    + +     [Head to the cat tower]
            -> CatTower
    
    - -     -> DONE

= Investigate
    You apply your keen SnootSense™ to the task and carefully observe the crime scene and its surrounds.
    
    There's the crime scene itself (neatly taped off), piles of colourful presents and, looming over the whole scene, the Christmas Tree.
    
    - - (lookhub)
    * *   [Check out the crime scene]
            A lowly orange beat cop lifts the tape around the crime scene and waves you through.
            
            'It's always an orange, isn't it?' you muse to yourself.
            
            There's a large brown paper bag at the centre of the scene, a piece of meat jerky hanging over the edge. Other smaller pieces of jerky are scattered on the ground, some showing distinct signs of having been chewed by something.
            
            Dr Snegele and her minions are dusting for prints and bagging up the jerky shreds for analysis back at the Snoot Crime Lab.
            
            You won't get much more from here until the forensic results come in. Better get out there and check the surrounds.
        
    * *   [Investigate the presents]
            The presents are stacked up in large piles, some around the base of the tree, others tucked underneath and spreading up the stairs.
            
            You sniff at a few, but can't detect any more signs of meat jerky.
            
            The largest of the presents is in a tall box. It's wrapped in red paper and looks like it would have excellent clawfeel...
    
    // @TODO Scratch present, consequences
        
    * *   [Investigate the ornaments]
            The tree is covered in ornaments of all kinds - sparkly, reflective, wood, wool, and more.
            
            Closest to the ground are the Bhutan Pony ornaments, from the as yet unsolved case.
            
            You're surprised they've been allowed out again while the criminal remains at large.
            
            'Focus! We're here to solve the jerky case. Bhutan Pony will have to wait for another day.
    
    // @TODO Bat ornament, consequences
    
    // @TODO Climb tree. Chaos - some shards.
    // * *   [Climb the tree]
    //         You take an action. Chaos. Some shards.
            
    + +   {ClueKnowledge !? clue1} [SnootSense™ for clues]
          <- GainClue(clue1)
        
    + +   [Take a step back and look at the whole area]
            -> ChristmasTree.Main

    - -     -> lookhub

= PresentToScarlett
    {LIST_COUNT(ClueKnowledge):
        - 0:
            { stopping:
                - 'DI Scarlett, I think I've got it!'
            
                    'This is clearly an open and shut case. The perp was...'
                    
                    \*THWACK\*
                    
                    A heavy paw comes down on your shoulder.
                    
                    # IMAGE: media/scarlett_paw_on_snoots.jpeg
                    
                    'Steady on there, {GENDERTERM}. You can't just pin a crime on someone with no evidence - not like we could back in QPOL in the 80s.'
                    
                    'Those were the days - good, simple, and ragingly corrupt policing. None of this Professional Standards Unit bullshit.'
                    
                    She gives you a hefty shove away from the crime scene.
                    
                    'Come back to me when you've got some clues and we'll talk.'
                
                - <- ScarlettBusy
            }
        - 1:
            { stopping:
                - 'OK, I've got a clue now. This clearly pins it on...'
            
                    \*THWACK THWACK\*
                    
                    An old phonebook lands on your head. Repeatedly.
                    
                    # IMAGE: media/scarlett_paw_in_air.jpeg
                    
                    'This is all you've got? Really? The Cat Director of Public Prosecutions will laugh us out of her office for this.'
                    
                    'Keep trying, {GENDERTERM}. Come back when you've got more clues'
                    
                    (Where did she even get a phone book like this in this day and age? Does she get them handmade?)
                    
                - <- ScarlettBusy
            }
        - 2:
            { stopping:
                - 'How about this? Surely two whole pieces of very solid and not at all ambiguous evidence is enough?' 
            
                    # IMAGE: media/scarlett_on_wine_boxes.jpeg
                    
                    DI Scarlett somehow managed to find some "evidence" at the crime scene and is guarding it.
                    
                    She's just giving you a blank expression, saying nothing.
                    
                    Is this still not enough evidence?
                    
                    Has she been drinking?
                    
                    DI Scarlett continues to say nothing. You shrug your shoulders and head back out to try again.
                    
                - <- ScarlettBusy
            }
        - 3:
            { stopping:
                - Before you can even announce your latest find, DI Scarlett interrupts you.
                
                    # IMAGE: media/scarlett_licking_shoe.jpeg
                    
                    'Hey, get a load of this other evidence I found. This is prime stuff - it will definitely blow the case wide open just as soon as we can get it back to the station for some really thorough "forensic" testing.'
                    
                    She continues licking the evidence.
                    
                    You admit it does seem to smell good, but you're not entirely sure how it helps with this case.
                    
                    Oh well, with all of those decorations for meritorious service you can't really questions DI Scarlett's methods.
                    
                - <- ScarlettBusy
            }
    }
    
    -> ChristmasTree.Main.top

= ScarlettBusy
    DI Scarlett peers closely at you.
    
    'Back again, huh {GENDERTERM}?'
    
    'Do you have anything new to show me?'
    
    'Uhh...no, not yet' you admit, rather sheepishly.
    
    \*HISS!\*
    
    'Then sod off, {GENDERTERM}. I've got very important CATPOL business to be getting on with.' she says, as she returns to staring meditatively into space.
    
    You don't mind, you know she doesn't really mean it.
    
    - -> DONE

= Finale
    # IMAGE: media/scarlett_on_deck.jpeg
    
    'OK, {GENDERTERM}, what have you got for me?' says DI Scarlett.
    
    You carefully lay out the clues you've pulled together.
    
    - (top)
    * (accuse) [Accuse The Naughty Kitty]
        'Ma'am, this all clearly points to that local nuisance - THE NAUGHTY KITTY! They're often seen around these parts, and with these clues...'
        
        'Stow the narrative, {GENDERTERM} - I've seen a few clues in my time. Let's see what you've got.'
        
        'Eh, you reckon they were a lonk cat just because they could reach the jerk in the bottom of the bag? Have you never heard of Bean Extenders™? Gods, spare me!'
        
        'Hmm, some half-chewed grass...? Yeah, could work if Dr Snegele can ensure the Snoot Crime Lab gets the correct result.'
        
        She bats at the black fuzz.
        
        'What are you, a racist? Nah, too obvious - even for CATPOL. They'll see right through that ham-fisted attempt to frame her.'
        
        'And you reckon you've got some paw prints heading down the hallway too?'
        
        'Hmm, pretty flimsy stuff stuff all up...'
        
        Do you even know where The Naughty Kitty is right now?
    
    * (uhh_well) {accuse > 0} 'Uhh, well...'[]
        'No, not really' you admit
    
        DI Scarlett looks thoughful for a moment and then...quacks...at you?
        
        'Look, I like you {GENDERTERM} - you've got the makings of a good Cat Police. I'm catching up with the Cat Judge for a very important conference at the Cat and Fiddle later on. I'll put in a good word for you and she'll see that the jury makes the right decision.'
        
        'And don't worry about apprehending the perp. We all know where The Naughty Kitty lives, I'll send TRG around to pay her a little visit.'
    
    * {uhh_well > 0} 'Oh! We can do that? What about...'[]
        
        You hear a sound coming from the Projects Room. Before you can say anything further, DI Scarlett runs off at high speed - it must be time for fresh litter.
        
        You can't believe that you cracked your first case. And all it tooks was some good honest cat police work and some low grade corruption.
        
        You saunter off in search of some well deserved wet food, wondering what you next case might be...
        
        # CLASS: end
        The End
        
        -> END
    
    - -> top

// @TODO Add accusing?
// - (top)
// * [Mina]
//     ...
// * [Snoots]
//     ...
// * [The Naughty Kitty]
//     ...
//     -> DONE
// * [The snakes]
//     ...
// // * [The pods]
// // * [The sticks]
// // * [The pedes]
// // * [The humans]
// - -> top


// #####################################
//      The Dining Room Table
// 
// - JumpingUp
// - DiningRoomTableTop
// - DiningRoomTableUnderneath
// - SeasonalHeadInside
// - SeasonalHeadInsideNap
// #####################################

=== DiningRoomTable ===
    The dining room table looms over you, occupying a large space at the centre of the room.
    
    Two benches are arranged either side, covered in books, bags, and an assortment of other things.
    
    You know from past experience that the table itself often contains many items of interest - LEGO (to scatter), beverages (to sniff), and sometimes baking (to steal).
    -> JumpingUp

= JumpingUp
+   {CatState == never_embarrassed} [Jump on top]
    You ready yourself, assume the jumping position, and take a flying leap up to reach the bench.
    
    Landing deftly on the bench, you quickly twist and leap again to reach the table top...
    
    Your front paws make it, but your back paws fail to follow through and you're left awkwardly hanging by your beans from the top of the table.
    
    You back paws scrabble for purchase on something, anything.
    
    Contorting yourself, you manage to get a paw on the bench and drop back down to the safety of the bench.
    
    Throughout all of this the staff are standing by, watching.
    
    'Blah blah blah AGILE. Blah blah blah PREDATOR, blah?'
    
    Well, that was embarrasing.
    ~ CatState = embarrassed
    
    - - (jumpfailhub)
    + +     [Better get back to the case]
            
            { CatState:
                - embarrassed:
                    You're in no state to be doing any investigating right now.
                    
                    You're too embarrassed.
                    
                    Fancy almost falling while the staff were watching?
                - still_embarrassed:
                    You feel a little more put together, but still have a lingering sense of deep shame and embarrassment.
                - else:
                    You feel as right as rain now and ready to take on the world.
                    -> JumpingUp
            }
    
    * *     [Groom yourself]
            You assume your tidiest, most nonchalant sitting position, and tentatively raise a paw to your mouth and begin grooming yourself.
            ~ CatState = still_embarrassed
            
    * *     {CatState == still_embarrassed} [Keep grooming]
            You keep grooming, working down from your head, to your shoulders, and down your flanks.
            
            It takes a while, but you begin to feel more yourself again.
            
            Who's a pretty kitty, eh?
            ~ CatState = has_been_embarrassed
            
    + +     (groom_yet_again) {CatState == has_been_embarrassed && groom_yet_again <= 1} [Keep grooming]
            {You make a start on your back paws - giving each bean a very careful and thorough cleaning.|You sit up and snoot at everything in sight. We can't very well spend all day grooming...or can we? Well, at least not while we're on duty.}
    
    - -     -> jumpfailhub

+   {CatState != never_embarrassed} [Jump on top]
    You ready yourself again, assume the jumping position, and take a flying leap.
    
    Got it! Now we're on top!
    -> DiningRoomTableTop

+   [Go underneath]
    -> DiningRoomTableUnderneath
        
+   [Head back to the Christmas Tree]
    -> ChristmasTree.Main

= DiningRoomTableTop
    You survey the dining room table. It's covered in a collection of stuff - freshly baked Christmas Cakes (delicious), pills (pills!?), cocktail glasses (shiny), and a random assortment of other odds and ends.
    
    In the distance you can see The Holy Grail - the Best Small Bar in Mount Lawley.
    
    - (top)
    *   [Investigate the The Holy Grail]
        Training your SnootSense™ on the Best Small Bar in Mount Lawley, you see shelves upon shelves of glittering, colourful, and highly breakable glass bottles.
        
        Perchance, some Baileys later?
    
    *   (cocktails_seen) [Check out the cocktails]
        There are two glasses, both containing a golden brown liquid, both glittering tempting in the sunlight.
        
        You sniff the nearest one and rear back in shock.
        
        Your SnootSense™ is dialled up to 11 and you get a strong, firey, burning, whiff of the liquid.
        
        Why the staff drink these you'll never understand.
        
    *   (cocktails_batted_gently) {cocktails_seen >= 1} [Bat gently at the cocktail]
        Offended, you bat gently at the nearest cocktail.
        
        It rocks gently on its base, some liquid sloshes on the table, but it comes back to rest safely on the coaster.
        
        'Blah! Blah! Blah blah blah blah SHARDS.' exclaim the staff, excitedly.
        
    *   (cocktails_batted_forcefully) {cocktails_batted_gently >= 1} [Bat forcefully at the cocktail]
        You apply a more forceful bat this time.
        
        The cocktail glass, and its liquid contents, go sailing off the table and land on the ground.
        
        \*SMASH\*
        
        The cocktail itself smashes into hundreds of tiny pieces, the sticky golden brown liquid now covers the dining room floor.
        
        'BLAH! BLAH! WHY?! Blah blah blah!' shout the staff as they run around.
        
        You zoom away, further scattering everything else on the top of the table, and assume a position looking down on the scene from the stairs.
        
        You sit back smugly. You've made SHARDS.
        ~ DiningRoomFloorState = shards
    
    +   {ClueKnowledge !? clue2} [SnootSense™ for clues]
        <- GainClue(clue2)
        
    +   [We're done here, head back down to the ground]
        -> DiningRoomTable
    
    - -> top

= DiningRoomTableUnderneath
    You slink under the nearest bench and emerge underneath the table.
    
    There's a rug (good clawfeel), many boxes of LEGO (also good clawfeel), and...what's this?
    
    It's a new Seasonal Head!
    
    - (top)
    *   (scratch) [Scratch the rug]
        You stretch to your full length, extend your claws, and rip and tear at the rug.
        
        It's made of a tough material, which provides both excellent clawfeel and grip whilst also resisting even your most determined effort to pull it to shreds.
        
    *   {scratch >= 1} [Scratch the rug again]
        Why not?
        
        You flop on your side and engage the claws on both your front back paws, beginning to spin in circles.
        
        'Blah blah blah STOP blah blah. Blah SPRAY BOTTLE blah blah!' exclaims one of the staff.
        
        They seem awfully excited about something, but you're not sure about what. You shrug and figure they must be jealous - with those weird finger beans they've got way to really experience was good clawfeel is like.
        
        You aren't sure what a SPRAY BOTTLE is though. Does it help to improve the clawfeel?
    
    +   {ClueKnowledge !? clue3} [SnootSense™ for clues]
        <- GainClue(clue3)
    
    *   [Inspect the LEGO boxes]
        There are LEGO boxes, stacked several layers deep against one end of the table.
        
        The boxes themselves have fairly poor clawfeel, but the contents are great fun to walk over - the staff get very excited whenever you do that.
    
    *   (seasonal_head) [Inspect the Seasonal Head]
        The latest Seasonal Head is tucked under one of the benches. It's a smaller head, green all over and shaped like a Christmas tree, with multi-coloured bobbles, and a small sleeping area.
        
        You're just thankful it's a Christmas Seasonal Head, given how very unhealthy and dangerous it is to have Seasonal Heads stay out beyond their season.
        
        You approach the Seasonal Head with trepidation, extending yourself to your full length and setting Snoot Condition 5 throughout your whole body.
        
        It seems safe, and looks warm and cosy inside. Possibly even comfortable?
        
        As best you can tell it doesn't dispense treats, not like that broken Halloween Seasonal Head the staff acquired.
        
    +   {seasonal_head >= 1} [Enter the Seasonal Head]
        -> SeasonalHeadInside
        
    +   [We're done here, head out from underneath the table]
        -> DiningRoomTable
    
    - -> top

= SeasonalHeadInside
    You slink inside the Seasonal Head, walk around in circles several times, and settle down into the tiniest circle you can tuck yourself into.
    
    Yup. This is a rather good Seasonal Head. The staff have chosen well.
    ~ SeasonalHeadState = "occupied"
    
    - (top)
    +   {SeasonalHeadState == "occupied"} [Have a nap]
        -> SeasonalHeadInsideNap
    
    +   [Leave the Seasonal Head]
        You uncurl yourself and slink back out of the Seasonal Head and emerge underneath the dining room table once again.
        -> DiningRoomTableUnderneath.top
    
= SeasonalHeadInsideNap
    <- Nap(-> SeasonalHeadInside.top)
    -> DONE


// #####################################
//       The Bag Pouffe
// 
// - BagPouffeNap
// #####################################

=== BagPouffe ===
    A medium sized teal pouffe sits in the corner of the dining room.
    
    (Seriously, what is it with the staff and teal?)
    
    You hop up on it and survey the room.
    
    It has good pawfeel and is just the perfect size for both sitting and napping.
    
    It is also, very conveniently, right next to the Treat Buffet.
    
    - - (top)
    + +     (inspect_treats) {inspect_treats == 0} [Inspect the Treat Buffet]
            You recalibrate your SnootSense™ from DETECTING Mode to TREATS Mode.
    
            Yes, there's definitely several types of treats available today. Including your favourite CATNIP GREENIES.
            
            The staff must have stocked up recently.
            
            Very good.
    
    * *   (look_hungry) {inspect_treats >= 1} [Look hungry]
          You arrange your face into it's cutest and yet most starving expression and look over at the staff.
          
          Nothing happens.
          
          When you've literally never been fed in your whole life, how can they not recognise the plain truth that's staring them in the face? You're STARVING.
    
    * *   (meow_and_look_hungry) {look_hungry >= 1} [Meow and look hungry]
          You sit up straighter, clear your throat, and exclaim loudly.
          
          'OI! CUNTS! IT'S TREAT TIME!'
          
          The staff glance over at you, but still they don't stir.
    
    + +   (upstanding) {meow_and_look_hungry >= 1 && CatTreatState != "has_treats"} [Be up standing]
          You pop your front paws up on the kitchen bench and begin perusing the Treat Buffet.
          
          'BLAH! Blah blah THINK blah DOING?! Blah blah blah blah FUCKING BUFFET?!' shouts the nearest member of staff.
          
          {TURNS_SINCE(-> DiningRoomTable.DiningRoomTableTop.cocktails_batted_forcefully) != -1 && TURNS_SINCE(-> DiningRoomTable.DiningRoomTableTop.cocktails_batted_forcefully) <= 20:
                You sense you were about to get a treat, but the staff all seem busy with the delightful SHARDS you made on the dining room floor.
                
                Better check back later, once they've finished playing in the SHARDS.
          - else:
                One of the staff sighs.
                
                'Blah. Blah blah TREAT. Blah blah NOT blah BAD CAT.'
                
                You chow down on a small pile of your favourite treats: CATNIP GREENIES!
                
                Fortified and no longer starving, you feel ready to face the case and continue your investigation.
                ~ CatTreatState = "has_treats"
          }
    
    + +     [Sit]
            You bring your front paws together and assume your tidiest, most elegant, sitting position.
        
    + +     [Nap]
            -> BagPouffeNap

    + +     [We're done here, head back to the Christmas Tree]
            -> ChristmasTree.Main
    
    - -     -> top

= BagPouffeNap
    <- Nap(-> BagPouffe.top)
    -> DONE


// #####################################
//      The Cat Tower
// 
// - 
// #####################################

=== CatTower ===
    The Cat Tower looms over you as you approach.
    
    It's a multi-level construction of platforms (for snooting), balls (for ignoring), and a storage hole (also for ignoring).
    
    But mostly it's a convenient way for lazy cats to get from the stairs to the top of the dining room table.
    
    - (top)
    +  (on_top) {CatTowerState == "unoccupied"} [Jump on top]
        Readying yourself and positioning your back paws just so, you take a magjestic and graceful flying leap and land on top of the tower.
        
        Five stars, Margaret.
        
        From here, you have an excellent vantage point to survey the whole dining room.
        ~ CatTowerState = "occupied"
    
    +  {CatTowerState == "occupied" && ClueKnowledge !? clue4} [SnootSense™ for clues]
        <- GainClue(clue4)
        
    *  [Inspect the storage hole]
        You carefully snoot at the storage hole.
        
        It's dark inside and full of what it's always been full of: rejected toys and presents from the staff.
        
        Your SnootSense™ doesn't even so much as tingle.
        
    *  [Bat at a ball]
        You lift a paw, as if to bat at one of the balls hanging from the top of the tower...
        
        And then, at the last moment, you remember yourself and make as if you were always going to groom yourself.
        
        You know the policy. The staff must NOT see us interact with or enjoy the tower.
        
        It's a matter of Cat Policy.
        
        (And as everyone knows, cats are best placed to decide upon matters of Cat Policy.)
        
    +   [We're done here, head back to the Christmas Tree]
        ~ CatTowerState = "unoccupied"
        -> ChristmasTree.Main
    
    - -> top