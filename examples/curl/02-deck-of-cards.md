# Deck of Cards API Examples

## Introduction

The Deck of Cards API allows you to simulate card games by creating decks, shuffling, and drawing cards. This API demonstrates stateful operations where you need to save and reuse data from previous requests.

**API Base URL**: `https://deckofcardsapi.com/api/deck/`

---

## Example 1: Create a New Shuffled Deck

Create and shuffle a new deck of cards:

```bash
curl https://deckofcardsapi.com/api/deck/new/shuffle/?deck_count=1
```

**Expected JSON Response:**

```json
{
    "success": true,
    "deck_id": "3p40paa87x90",
    "shuffled": true,
    "remaining": 52
}
```

**Important:** Save the `deck_id` - you'll need it for subsequent requests!

---

## Example 2: Draw Cards from a Deck (Manual deck_id)

Replace `YOUR_DECK_ID` with the actual deck_id from Example 1:

```bash
curl https://deckofcardsapi.com/api/deck/YOUR_DECK_ID/draw/?count=2
```

**Example with actual deck_id:**

```bash
curl https://deckofcardsapi.com/api/deck/3p40paa87x90/draw/?count=2
```

**Expected Response:**

```json
{
    "success": true,
    "deck_id": "3p40paa87x90",
    "cards": [
        {
            "code": "6H",
            "image": "https://deckofcardsapi.com/static/img/6H.png",
            "images": {
                "svg": "https://deckofcardsapi.com/static/img/6H.svg",
                "png": "https://deckofcardsapi.com/static/img/6H.png"
            },
            "value": "6",
            "suit": "HEARTS"
        },
        {
            "code": "9S",
            "image": "https://deckofcardsapi.com/static/img/9S.png",
            "images": {
                "svg": "https://deckofcardsapi.com/static/img/9S.svg",
                "png": "https://deckofcardsapi.com/static/img/9S.png"
            },
            "value": "9",
            "suit": "SPADES"
        }
    ],
    "remaining": 50
}
```

---

## Example 3: Automated - Save deck_id and Draw Cards

This example shows how to save the deck_id from the first request and use it in a second request:

### Step 1: Create deck and save deck_id to variable (Bash)

```bash
# Create new deck and extract deck_id
DECK_ID=$(curl -s https://deckofcardsapi.com/api/deck/new/shuffle/?deck_count=1 | jq -r '.deck_id')

echo "Created deck with ID: $DECK_ID"
```

### Step 2: Draw cards using the saved deck_id

```bash
# Draw 2 cards from the deck
curl "https://deckofcardsapi.com/api/deck/$DECK_ID/draw/?count=2"
```

### Complete Script Example

```bash
#!/bin/bash

# Create a new shuffled deck
echo "Creating new deck..."
DECK_ID=$(curl -s https://deckofcardsapi.com/api/deck/new/shuffle/?deck_count=1 | jq -r '.deck_id')
echo "Deck ID: $DECK_ID"

# Draw first hand (2 cards)
echo -e "\nDrawing first hand (2 cards)..."
curl -s "https://deckofcardsapi.com/api/deck/$DECK_ID/draw/?count=2" | jq

# Draw second hand (3 cards)
echo -e "\nDrawing second hand (3 cards)..."
curl -s "https://deckofcardsapi.com/api/deck/$DECK_ID/draw/?count=3" | jq

# Check remaining cards
echo -e "\nChecking deck status..."
curl -s "https://deckofcardsapi.com/api/deck/$DECK_ID/" | jq
```

---

## Example 4: Extract Specific Card Information

Get just the card codes and values:

```bash
DECK_ID=$(curl -s https://deckofcardsapi.com/api/deck/new/shuffle/?deck_count=1 | jq -r '.deck_id')

# Draw cards and show only codes and values
curl -s "https://deckofcardsapi.com/api/deck/$DECK_ID/draw/?count=5" | \
jq -r '.cards[] | "\(.code): \(.value) of \(.suit)"'
```

**Expected Output:**

```bash
6H: 6 of HEARTS
9S: 9 of SPADES
AS: ACE of SPADES
2D: 2 of DIAMONDS
KH: KING of HEARTS
```

---

## Example 5: Check Deck Information

Check how many cards remain in a deck:

```bash
curl https://deckofcardsapi.com/api/deck/$DECK_ID/
```

**Response:**

```json
{
    "success": true,
    "deck_id": "3p40paa87x90",
    "shuffled": true,
    "remaining": 47
}
```

---

## Example 6: Create Partial Deck

Create a deck with only specific cards:

```bash
curl "https://deckofcardsapi.com/api/deck/new/shuffle/?cards=AS,2S,KS,AD,2D,KD,AC,2C,KC,AH,2H,KH"
```

This creates a deck with only Aces, Twos, and Kings.

---

## Example 7: Reshuffle Existing Deck

Reshuffle all cards back into an existing deck:

```bash
curl https://deckofcardsapi.com/api/deck/$DECK_ID/shuffle/
```

---

## PowerShell Examples (Windows)

For Windows users using PowerShell:

```powershell
# Create new deck and save deck_id
$response = Invoke-RestMethod -Uri "https://deckofcardsapi.com/api/deck/new/shuffle/?deck_count=1"
$deckId = $response.deck_id
Write-Host "Deck ID: $deckId"

# Draw cards
$drawResponse = Invoke-RestMethod -Uri "https://deckofcardsapi.com/api/deck/$deckId/draw/?count=2"
$drawResponse | ConvertTo-Json -Depth 5
```

---

## Common API Endpoints

- `GET /api/deck/new/` - Create new deck
- `GET /api/deck/new/shuffle/` - Create and shuffle new deck
- `GET /api/deck/{deck_id}/` - Get deck information
- `GET /api/deck/{deck_id}/draw/?count={count}` - Draw cards
- `GET /api/deck/{deck_id}/shuffle/` - Reshuffle deck

## Key Learning Points

1. **Stateful APIs**: The deck_id maintains state between requests
2. **Data Persistence**: You must save and reuse the deck_id
3. **URL Parameters**: Use `?count=X` to specify number of cards
4. **JSON Extraction**: Use jq to extract specific fields
5. **Scripting**: Combine multiple API calls in scripts

## Practice Exercises

1. Create a deck and draw all 52 cards one by one
2. Create a deck with only face cards (J, Q, K)
3. Draw 5 cards and display them in a formatted table
4. Create a simple "War" card game simulator

## Complete Working Examples

Save these as `.sh` files and run them:

### simple-draw.sh

```bash
#!/bin/bash
DECK_ID=$(curl -s https://deckofcardsapi.com/api/deck/new/shuffle/ | jq -r '.deck_id')
echo "Drawing 5 cards from deck $DECK_ID"
curl -s "https://deckofcardsapi.com/api/deck/$DECK_ID/draw/?count=5" | jq -r '.cards[] | "\(.value) of \(.suit)"'
```

### check-deck.sh

```bash
#!/bin/bash
if [ $# -eq 0 ]; then
    echo "Usage: $0 <deck_id>"
    exit 1
fi

DECK_ID=$1
curl -s "https://deckofcardsapi.com/api/deck/$DECK_ID/" | jq
```
