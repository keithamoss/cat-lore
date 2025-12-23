// Source:
// https://docs.unfold.studio/user_guide/ink.html

// Using nested gathers
// If the player chooses the “murder” option, they’ll have two choices in a row on their sub-branch
// -   (test) "Well, Poirot? Murder or suicide?"
//         *   "Murder!"
//             "And who did it?"
//             * *     "Detective-Inspector Japp!"
//             * *     "Captain Hastings!"
//             * *     "Myself!"
//             - -     "You must be joking!"
//             * *     "Mon ami, I am deadly serious."
//             * *     "If only..."
//         *   "Suicide!"
//             "Really, Poirot? Are you quite sure?"
//             * *     "Quite sure."
//             * *     "It is perfectly obvious."
//         -   Mrs. Christie lowered her manuscript a moment. The rest of the writing group sat, open-mouthed.

// NPC questioning with loops
// - (opts)
//     *   'Can I get a uniform from somewhere?'[] you ask the cheerful guard.
//         'Sure. In the locker.' He grins. 'Don't think it'll fit you, though.'
//     *   'Tell me about the security system.'
//         'It's ancient,' the guard assures you. 'Old as coal.'
//     *   'Are there dogs?'
//         'Hundreds,' the guard answers, with a toothy grin. 'Hungry devils, too.'
//     // We require the player to ask at least one question
//     *   {loop} [Enough talking]
//         -> done
// - (loop)
//     // loop a few times before the guard gets bored
//     { -> opts | -> opts | }
//     He scratches his head.
//     'Well, can't stand around talking all day,' he declares.
// - (done)
//     You thank the guard, and move away.