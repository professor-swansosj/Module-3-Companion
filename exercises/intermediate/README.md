# Intermediate API Exercises

These exercises introduce stateful API interactions using the Deck of Cards API. You'll learn about managing API state, chaining requests, and handling more complex data.

---

## Exercise 1: Your First Deck

**Objective:** Create a deck and understand stateful API concepts.

**Task:** Create a new shuffled deck and examine the response.

**Instructions:**

1. Create a new deck:

   ```bash
   curl https://deckofcardsapi.com/api/deck/new/shuffle/?deck_count=1
   ```

2. Look at the response carefully

**Questions:**

1. What fields are in the response?
2. What is the `deck_id` used for?
3. How many cards are `remaining` in a new deck?
4. What does `shuffled: true` mean?

**Key Concept:** The `deck_id` is crucial - you'll need it for all future operations with this deck!

---

## Exercise 2: Saving and Using the Deck ID

**Objective:** Learn to save data from one API request to use in another.

**Task:** Create a deck, save its ID, and then get information about it.

**Instructions:**

1. Create a deck and save the ID to a variable:

   ```bash
   DECK_ID=$(curl -s https://deckofcardsapi.com/api/deck/new/shuffle/?deck_count=1 | jq -r '.deck_id')
   echo "My deck ID is: $DECK_ID"
   ```

2. Get information about your deck:

   ```bash
   curl "https://deckofcardsapi.com/api/deck/$DECK_ID/"
   ```

**Questions:**

1. Did the second request return the same `deck_id`?
2. What information can you get about a deck without drawing cards?
3. Why is it important to save the `deck_id`?

**Challenge:** What happens if you use an invalid deck_id? Try it!

---

## Exercise 3: Drawing Your First Cards

**Objective:** Learn to draw cards from a deck and examine the response structure.

**Task:** Draw 2 cards from your deck and analyze the response.

**Instructions:**

1. Using your saved `DECK_ID`, draw 2 cards:

   ```bash
   curl "https://deckofcardsapi.com/api/deck/$DECK_ID/draw/?count=2"
   ```

2. Format the response nicely:

   ```bash
   curl -s "https://deckofcardsapi.com/api/deck/$DECK_ID/draw/?count=2" | jq
   ```

**Questions:**

1. What information is provided for each card?
2. How many cards are now `remaining` in the deck?
3. What is a card's `code` and how is it formatted?
4. What's the difference between `value` and `code`?

**Card Code Format:**

- `AS` = Ace of Spades
- `KH` = King of Hearts  
- `10D` = Ten of Diamonds
- `2C` = Two of Clubs

---

## Exercise 4: Extracting Card Information

**Objective:** Practice extracting specific data from complex JSON responses.

**Task:** Draw cards and display them in a readable format.

**Instructions:**

1. Draw 5 cards and show only their descriptions:

   ```bash
   curl -s "https://deckofcardsapi.com/api/deck/$DECK_ID/draw/?count=5" | jq -r '.cards[] | "\(.value) of \(.suit)"'
   ```

2. Try different formatting options:

   ```bash
   curl -s "https://deckofcardsapi.com/api/deck/$DECK_ID/draw/?count=3" | jq -r '.cards[] | "\(.code): \(.value) of \(.suit)"'
   ```

**Questions:**

1. What does `.cards[]` do in jq?
2. How does the pipe `|` work in jq expressions?
3. How would you show just the card codes?

**Challenge:** Create a format that shows: "Card 1: AS (Ace of Spades)"

---

## Exercise 5: Checking Deck Status

**Objective:** Learn to monitor API state changes.

**Task:** Track how your deck changes as you draw cards.

**Instructions:**

1. Check your current deck status:

   ```bash
   curl -s "https://deckofcardsapi.com/api/deck/$DECK_ID/" | jq
   ```

2. Draw some cards:

   ```bash
   curl -s "https://deckofcardsapi.com/api/deck/$DECK_ID/draw/?count=10" > /dev/null
   ```

3. Check the status again:

   ```bash
   curl -s "https://deckofcardsapi.com/api/deck/$DECK_ID/" | jq
   ```

**Questions:**

1. How did the `remaining` count change?
2. Does drawing cards change the `deck_id`?
3. What happens to the `shuffled` status?

**Challenge:** Write a one-liner that shows just the number of remaining cards.

---

## Exercise 6: The Empty Deck Problem

**Objective:** Learn to handle edge cases and API limitations.

**Task:** Draw all cards from a deck and see what happens.

**Instructions:**

1. Keep drawing cards until the deck is empty:

   ```bash
   # Draw remaining cards (check status first)
   curl -s "https://deckofcardsapi.com/api/deck/$DECK_ID/" | jq '.remaining'
   
   # Draw all remaining cards
   curl -s "https://deckofcardsapi.com/api/deck/$DECK_ID/draw/?count=52" | jq
   ```

2. Try to draw from the empty deck:

   ```bash
   curl -s "https://deckofcardsapi.com/api/deck/$DECK_ID/draw/?count=1" | jq
   ```

**Questions:**

1. What happens when you try to draw more cards than available?
2. What does the `cards` array look like when empty?
3. Does the API return an error, or handle it gracefully?

---

## Exercise 7: Reshuffling - Resetting State

**Objective:** Learn to reset API state and understand deck lifecycle.

**Task:** Reshuffle your empty deck to get all cards back.

**Instructions:**

1. Reshuffle your deck:

   ```bash
   curl "https://deckofcardsapi.com/api/deck/$DECK_ID/shuffle/"
   ```

2. Check the deck status:

   ```bash
   curl -s "https://deckofcardsapi.com/api/deck/$DECK_ID/" | jq
   ```

3. Draw some cards to verify it works:

   ```bash
   curl -s "https://deckofcardsapi.com/api/deck/$DECK_ID/draw/?count=3" | jq -r '.cards[] | .code'
   ```

**Questions:**

1. How many cards are available after reshuffling?
2. Did the `deck_id` change after reshuffling?
3. Are the cards in a different order now?

**Key Concept:** Reshuffling resets the deck state but keeps the same `deck_id`.

---

## Exercise 8: Creating Custom Decks

**Objective:** Learn to use API parameters to customize behavior.

**Task:** Create decks with specific cards only.

**Instructions:**

1. Create a deck with only Aces:

   ```bash
   curl "https://deckofcardsapi.com/api/deck/new/shuffle/?cards=AS,AH,AD,AC"
   ```

2. Create a deck with only face cards:

   ```bash
   FACE_DECK_ID=$(curl -s "https://deckofcardsapi.com/api/deck/new/shuffle/?cards=JS,JH,JD,JC,QS,QH,QD,QC,KS,KH,KD,KC" | jq -r '.deck_id')
   echo "Face cards deck: $FACE_DECK_ID"
   ```

3. Draw all cards from the face deck:

   ```bash
   curl -s "https://deckofcardsapi.com/api/deck/$FACE_DECK_ID/draw/?count=12" | jq -r '.cards[] | .code'
   ```

**Questions:**

1. How many cards are in each custom deck?
2. What happens if you use an invalid card code?
3. Can you mix different suits in custom decks?

**Challenge:** Create a deck with only red cards (Hearts and Diamonds).

---

## Exercise 9: Building a Card Game Script

**Objective:** Combine multiple API calls into a cohesive automation script.

**Task:** Create a script that simulates dealing poker hands.

**Instructions:**

1. Create this script (save as `poker.sh`):

   ```bash
   #!/bin/bash
   
   echo "=== Poker Hand Dealer ==="
   
   # Create new deck
   DECK_ID=$(curl -s https://deckofcardsapi.com/api/deck/new/shuffle/ | jq -r '.deck_id')
   echo "Created deck: $DECK_ID"
   echo ""
   
   # Deal hands to 4 players
   for player in {1..4}; do
       echo "Player $player hand:"
       curl -s "https://deckofcardsapi.com/api/deck/$DECK_ID/draw/?count=5" | \
       jq -r '.cards[] | "  \(.value) of \(.suit)"'
       echo ""
   done
   
   # Show remaining cards
   REMAINING=$(curl -s "https://deckofcardsapi.com/api/deck/$DECK_ID/" | jq '.remaining')
   echo "Cards remaining in deck: $REMAINING"
   ```

2. Make it executable and run:

   ```bash
   chmod +x poker.sh
   ./poker.sh
   ```

**Questions:**

1. How many cards should remain after dealing 4 hands of 5 cards each?
2. What would happen if you tried to deal 15 hands?
3. How could you modify this to deal different games (like Blackjack)?

---

## Exercise 10: Error Handling and Validation

**Objective:** Learn to handle API errors and validate responses.

**Task:** Build robust scripts that handle various error conditions.

**Instructions:**

1. Test what happens with an expired/invalid deck_id:

   ```bash
   curl -s "https://deckofcardsapi.com/api/deck/invalid123/draw/?count=1" | jq
   ```

2. Create a script with error checking:

   ```bash
   #!/bin/bash
   
   # Create deck with error checking
   RESPONSE=$(curl -s https://deckofcardsapi.com/api/deck/new/shuffle/)
   SUCCESS=$(echo "$RESPONSE" | jq -r '.success')
   
   if [ "$SUCCESS" = "true" ]; then
       DECK_ID=$(echo "$RESPONSE" | jq -r '.deck_id')
       echo "✓ Deck created successfully: $DECK_ID"
   else
       echo "✗ Failed to create deck"
       exit 1
   fi
   
   # Draw cards with validation
   DRAW_RESPONSE=$(curl -s "https://deckofcardsapi.com/api/deck/$DECK_ID/draw/?count=2")
   DRAW_SUCCESS=$(echo "$DRAW_RESPONSE" | jq -r '.success')
   
   if [ "$DRAW_SUCCESS" = "true" ]; then
       echo "✓ Drew cards successfully"
       echo "$DRAW_RESPONSE" | jq -r '.cards[] | "  \(.code): \(.value) of \(.suit)"'
   else
       echo "✗ Failed to draw cards"
       echo "$DRAW_RESPONSE" | jq
   fi
   ```

**Questions:**

1. Why is it important to check the `success` field?
2. What other validation could you add?
3. How would you handle network errors (when curl fails)?

---

## Exercise 11: Performance and Optimization

**Objective:** Learn about API performance considerations.

**Task:** Measure and optimize API request performance.

**Instructions:**

1. Measure request timing:

   ```bash
   time curl -s "https://deckofcardsapi.com/api/deck/new/shuffle/" > /dev/null
   ```

2. Compare single vs. batch operations:

   ```bash
   # Create deck
   DECK_ID=$(curl -s https://deckofcardsapi.com/api/deck/new/shuffle/ | jq -r '.deck_id')
   
   # Time drawing 1 card 5 times
   echo "Drawing 1 card 5 times:"
   time for i in {1..5}; do
       curl -s "https://deckofcardsapi.com/api/deck/$DECK_ID/draw/?count=1" > /dev/null
   done
   
   # Time drawing 5 cards at once  
   echo "Drawing 5 cards at once:"
   time curl -s "https://deckofcardsapi.com/api/deck/$DECK_ID/draw/?count=5" > /dev/null
   ```

**Questions:**

1. Which approach is faster?
2. Why might batch operations be more efficient?
3. What are the trade-offs between multiple small requests vs. fewer large requests?

---

## Exercise 12: Real-world Integration

**Objective:** Simulate a realistic use case combining multiple concepts.

**Task:** Create a blackjack dealer that manages game state.

**Instructions:**

1. Create a blackjack simulator:

   ```bash
   #!/bin/bash
   
   # Blackjack Dealer Simulator
   
   calculate_hand_value() {
       local cards_json="$1"
       local total=0
       local aces=0
       
       # This is a simplified calculation - in real blackjack, 
       # Aces can be 1 or 11, face cards are 10
       echo "$cards_json" | jq -r '.cards[].value' | while read value; do
           case $value in
               "ACE") ((aces++)); ((total += 11));;
               "KING"|"QUEEN"|"JACK") ((total += 10));;
               *) ((total += value));;
           esac
       done
       
       # Handle aces (simplified)
       while [[ $total -gt 21 && $aces -gt 0 ]]; do
           ((total -= 10))
           ((aces--))
       done
       
       echo $total
   }
   
   # Create deck
   DECK_ID=$(curl -s https://deckofcardsapi.com/api/deck/new/shuffle/ | jq -r '.deck_id')
   echo "New game! Deck ID: $DECK_ID"
   echo ""
   
   # Deal initial hands
   echo "Dealing initial hands..."
   PLAYER_HAND=$(curl -s "https://deckofcardsapi.com/api/deck/$DECK_ID/draw/?count=2")
   DEALER_HAND=$(curl -s "https://deckofcardsapi.com/api/deck/$DECK_ID/draw/?count=2")
   
   echo "Player hand:"
   echo "$PLAYER_HAND" | jq -r '.cards[] | "  \(.value) of \(.suit)"'
   
   echo ""
   echo "Dealer showing:"
   echo "$DEALER_HAND" | jq -r '.cards[0] | "  \(.value) of \(.suit)"'
   echo "  [Hidden Card]"
   
   # Show remaining cards
   REMAINING=$(curl -s "https://deckofcardsapi.com/api/deck/$DECK_ID/" | jq '.remaining')
   echo ""
   echo "Cards remaining in deck: $REMAINING"
   ```

**Questions:**

1. How would you extend this to handle "hit" and "stand" actions?
2. What additional game state would you need to track?
3. How could you persist game state between script runs?

---

## Self-Assessment Checklist

After completing these exercises, you should be able to:

- [ ] Create and manage stateful API resources (decks)
- [ ] Save and reuse data from API responses
- [ ] Extract complex data from nested JSON structures
- [ ] Handle API edge cases (empty decks, errors)
- [ ] Build scripts that chain multiple API calls
- [ ] Validate API responses and handle errors
- [ ] Understand the performance implications of API design
- [ ] Create realistic applications using API data

---

## Next Steps

Ready for more? Try the **Advanced Exercises** which cover:

- Building complete applications
- Error recovery and retry logic
- Working with multiple APIs simultaneously
- Performance optimization techniques

---

## Troubleshooting

If you encounter issues:

1. Check that your `deck_id` is valid and saved correctly
2. Verify API responses have `"success": true`
3. Remember that decks expire after 2 weeks of inactivity
4. Use verbose mode (`curl -v`) to debug connection issues
5. Check the troubleshooting guide for common solutions

Remember: APIs are stateful! Always check your response data and handle the lifecycle of your resources properly.
