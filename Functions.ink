// Helper function: popping elements from lists
=== function pop(ref list)
   ~ temp x = LIST_MIN(list) 
   ~ list -= x 
   ~ return x

=== function get(x)
    ~ Inventory += x

=== function move_to_supporter(ref item_state, new_supporter) ===
    ~ item_state -= LIST_ALL(Supporters)
    ~ item_state += new_supporter

=== function reached (x) 
   ~ return knowledgeState ? x 

=== function between(x, y) 
   ~ return knowledgeState? x && not (knowledgeState ^ y)

=== function reach(statesToSet) 
   ~ temp x = pop(statesToSet)
   {
   - not x: 
      ~ return false 

   - not reached(x):
      ~ temp chain = LIST_ALL(x)
      ~ temp statesGained = LIST_RANGE(chain, LIST_MIN(chain), x)
      ~ knowledgeState += statesGained
      ~ reach (statesToSet) 	// set any other states left to set
      ~ return true  	       // and we set this state, so true
 
    - else:
      ~ return false || reach(statesToSet) 
    }

=== function has_all_clues()
    ~ return ClueKnowledge == LIST_ALL(ClueKnowledge)