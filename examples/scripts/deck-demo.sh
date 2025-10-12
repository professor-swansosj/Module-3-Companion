#!/bin/bash

# Deck of Cards API Demo Script
# This script demonstrates stateful API interactions

echo "====================================="
echo "   Deck of Cards API Demo Script"
echo "====================================="
echo ""

# Function to pause for user interaction
pause() {
    read -p "Press Enter to continue..."
    echo ""
}

# 1. Create a new shuffled deck
echo "1. Creating a new shuffled deck:"
echo "Command: curl https://deckofcardsapi.com/api/deck/new/shuffle/?deck_count=1"
echo ""

DECK_RESPONSE=$(curl -s https://deckofcardsapi.com/api/deck/new/shuffle/?deck_count=1)
echo "$DECK_RESPONSE" | jq

# Extract deck_id for future use
DECK_ID=$(echo "$DECK_RESPONSE" | jq -r '.deck_id')
echo ""
echo "✓ Saved deck_id: $DECK_ID"
echo ""
pause

# 2. Draw first hand
echo "2. Drawing first hand (2 cards):"
echo "Command: curl https://deckofcardsapi.com/api/deck/$DECK_ID/draw/?count=2"
echo ""

DRAW1_RESPONSE=$(curl -s "https://deckofcardsapi.com/api/deck/$DECK_ID/draw/?count=2")
echo "$DRAW1_RESPONSE" | jq

echo ""
echo "Cards drawn:"
echo "$DRAW1_RESPONSE" | jq -r '.cards[] | "- \(.value) of \(.suit)"'
echo ""
pause

# 3. Draw second hand
echo "3. Drawing second hand (3 cards):"
echo "Command: curl https://deckofcardsapi.com/api/deck/$DECK_ID/draw/?count=3"
echo ""

DRAW2_RESPONSE=$(curl -s "https://deckofcardsapi.com/api/deck/$DECK_ID/draw/?count=3")
echo "$DRAW2_RESPONSE" | jq

echo ""
echo "Cards drawn:"
echo "$DRAW2_RESPONSE" | jq -r '.cards[] | "- \(.value) of \(.suit)"'
echo ""
pause

# 4. Check deck status
echo "4. Checking remaining cards in deck:"
echo "Command: curl https://deckofcardsapi.com/api/deck/$DECK_ID/"
echo ""

DECK_STATUS=$(curl -s "https://deckofcardsapi.com/api/deck/$DECK_ID/")
echo "$DECK_STATUS" | jq

REMAINING=$(echo "$DECK_STATUS" | jq -r '.remaining')
echo ""
echo "✓ Cards remaining: $REMAINING"
echo ""
pause

# 5. Draw until deck is empty (but limit to 10 more draws)
echo "5. Drawing remaining cards (showing first 10 draws):"
echo ""

for i in {1..10}; do
    if [ $REMAINING -gt 0 ]; then
        echo "Draw $i:"
        CARDS_TO_DRAW=$((REMAINING > 5 ? 5 : REMAINING))
        DRAW_RESPONSE=$(curl -s "https://deckofcardsapi.com/api/deck/$DECK_ID/draw/?count=$CARDS_TO_DRAW")
        
        SUCCESS=$(echo "$DRAW_RESPONSE" | jq -r '.success')
        if [ "$SUCCESS" == "true" ]; then
            echo "$DRAW_RESPONSE" | jq -r '.cards[] | "  \(.code): \(.value) of \(.suit)"'
            REMAINING=$(echo "$DRAW_RESPONSE" | jq -r '.remaining')
            echo "  Remaining: $REMAINING"
        else
            echo "  No more cards to draw!"
            break
        fi
        echo ""
        sleep 1
    else
        break
    fi
done

echo ""
pause

# 6. Try to draw from empty deck
echo "6. Attempting to draw from empty deck:"
echo "Command: curl https://deckofcardsapi.com/api/deck/$DECK_ID/draw/?count=1"
echo ""

EMPTY_DRAW=$(curl -s "https://deckofcardsapi.com/api/deck/$DECK_ID/draw/?count=1")
echo "$EMPTY_DRAW" | jq

echo ""
pause

# 7. Reshuffle the deck
echo "7. Reshuffling the deck:"
echo "Command: curl https://deckofcardsapi.com/api/deck/$DECK_ID/shuffle/"
echo ""

SHUFFLE_RESPONSE=$(curl -s "https://deckofcardsapi.com/api/deck/$DECK_ID/shuffle/")
echo "$SHUFFLE_RESPONSE" | jq

echo ""
echo "✓ Deck reshuffled! All 52 cards are back."
echo ""
pause

# 8. Final demonstration - draw 5 cards from reshuffled deck
echo "8. Drawing 5 cards from the reshuffled deck:"
echo ""

FINAL_DRAW=$(curl -s "https://deckofcardsapi.com/api/deck/$DECK_ID/draw/?count=5")
echo "Your hand:"
echo "$FINAL_DRAW" | jq -r '.cards[] | "🂠 \(.value) of \(.suit)"'

FINAL_REMAINING=$(echo "$FINAL_DRAW" | jq -r '.remaining')
echo ""
echo "Cards remaining in deck: $FINAL_REMAINING"

echo ""
echo "====================================="
echo "         Demo Complete!"
echo "====================================="
echo ""
echo "Key concepts demonstrated:"
echo "1. ✓ Creating a deck and saving the deck_id"
echo "2. ✓ Using deck_id in subsequent requests"
echo "3. ✓ Tracking state (remaining cards)"
echo "4. ✓ Handling empty deck scenarios"
echo "5. ✓ Reshuffling to reset state"
echo ""
echo "Your final deck_id: $DECK_ID"
echo "You can continue using this deck_id in other requests!"