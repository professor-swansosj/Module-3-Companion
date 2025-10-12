# API Endpoints Documentation

This document provides detailed information about the APIs used in Module 3 examples.

---

## Dad Jokes API

A simple, fun API for retrieving dad jokes. Perfect for learning API basics.

### Base URL (Dad Jokes API)

```bash
https://icanhazdadjoke.com/
```

### Authentication

- **Type**: None required
- **Rate Limiting**: No published limits, but be respectful

### Endpoints (Dad Jokes API)

#### 1. Get Random Dad Joke

**Endpoint:** `GET /`

**Description:** Retrieves a random dad joke from the database.

**Parameters:** None

**Headers:**

- `Accept` (optional): Specify response format
  - `application/json` - JSON response (recommended)
  - `text/plain` - Plain text response (default)

**Example Requests:**

```bash
# JSON format
curl -H "Accept: application/json" https://icanhazdadjoke.com/

# Plain text format  
curl https://icanhazdadjoke.com/
```

**Response Examples:**

JSON Response:

```json
{
  "id": "R7UfaahVfFd",
  "joke": "My dog used to chase people on a bike a lot. It got so bad I had to take his bike away.",
  "status": 200
}
```

Plain Text Response:

```bash
I invented a new word: Plagiarism!
```

**Response Codes:**

- `200 OK` - Success

---

#### 2. Get Specific Dad Joke by ID

**Endpoint:** `GET /j/{joke_id}`

**Description:** Retrieves a specific joke by its unique identifier.

**Parameters:**

- `joke_id` (path parameter, required): The unique ID of the joke

**Headers:**

- `Accept` (optional): Specify response format

**Example Request:**

```bash
curl -H "Accept: application/json" https://icanhazdadjoke.com/j/R7UfaahVfFd
```

**Response Example:**

```json
{
  "id": "R7UfaahVfFd", 
  "joke": "My dog used to chase people on a bike a lot. It got so bad I had to take his bike away.",
  "status": 200
}
```

**Response Codes:**

- `200 OK` - Success
- `404 Not Found` - Joke ID doesn't exist

---

## Deck of Cards API

A stateful API for simulating card games and deck operations.

### Base URL (Deck of Cards API)

```bash
https://deckofcardsapi.com/api/deck/
```

### Authentication (Types)

- **Type**: None required
- **Rate Limiting**: No published limits

### Key Concepts

- **Stateful**: Each deck has a unique `deck_id` that persists across requests
- **Persistent**: Deck state is maintained server-side
- **Realistic**: Follows real card game rules (no duplicate cards until reshuffled)

### Endpoints (Deck of Cards API)

#### 1. Create New Deck

**Endpoint:** `GET /new/`

**Description:** Creates a new deck of cards (unshuffled).

**Query Parameters:**

- `deck_count` (optional): Number of standard decks to combine (default: 1)
- `cards` (optional): Specific cards to include (comma-separated codes)
- `jokers_enabled` (optional): Include jokers (default: false)

**Example Requests:**

```bash
# Standard single deck
curl https://deckofcardsapi.com/api/deck/new/

# Two decks combined
curl https://deckofcardsapi.com/api/deck/new/?deck_count=2

# Custom deck with specific cards
curl "https://deckofcardsapi.com/api/deck/new/?cards=AS,KS,QS,JS,10S"
```

**Response Example:**

```json
{
    "success": true,
    "deck_id": "3p40paa87x90",
    "shuffled": false,
    "remaining": 52
}
```

---

#### 2. Create New Shuffled Deck

**Endpoint:** `GET /new/shuffle/`

**Description:** Creates a new deck of cards and shuffles it.

**Query Parameters:**

- `deck_count` (optional): Number of decks (default: 1)
- `cards` (optional): Specific cards to include

**Example Request:**

```bash
curl https://deckofcardsapi.com/api/deck/new/shuffle/?deck_count=1
```

**Response Example:**

```json
{
    "success": true,
    "deck_id": "3p40paa87x90", 
    "shuffled": true,
    "remaining": 52
}
```

**Response Codes:**

- `200 OK` - Deck created successfully

---

#### 3. Get Deck Information

**Endpoint:** `GET /{deck_id}/`

**Description:** Retrieves information about an existing deck without drawing cards.

**Path Parameters:**

- `deck_id` (required): The unique identifier of the deck

**Example Request:**

```bash
curl https://deckofcardsapi.com/api/deck/3p40paa87x90/
```

**Response Example:**

```json
{
    "success": true,
    "deck_id": "3p40paa87x90",
    "shuffled": true,
    "remaining": 47
}
```

**Response Codes:**

- `200 OK` - Success
- `404 Not Found` - Deck ID doesn't exist

---

#### 4. Draw Cards from Deck

**Endpoint:** `GET /{deck_id}/draw/`

**Description:** Draws cards from the specified deck.

**Path Parameters:**

- `deck_id` (required): The deck to draw from

**Query Parameters:**

- `count` (optional): Number of cards to draw (default: 1)

**Example Requests:**

```bash
# Draw one card
curl https://deckofcardsapi.com/api/deck/3p40paa87x90/draw/

# Draw five cards  
curl https://deckofcardsapi.com/api/deck/3p40paa87x90/draw/?count=5
```

**Response Example:**

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

**Card Object Properties:**

- `code`: Short code (e.g., "AS" for Ace of Spades)
- `value`: Card value ("ACE", "2", "3"..."10", "JACK", "QUEEN", "KING")
- `suit`: Card suit ("SPADES", "HEARTS", "DIAMONDS", "CLUBS")
- `image`: URL to PNG image of the card
- `images.svg`: URL to SVG image
- `images.png`: URL to PNG image

**Response Codes:**

- `200 OK` - Cards drawn successfully
- `404 Not Found` - Deck ID doesn't exist

**Special Cases:**

- If you try to draw more cards than remaining, you'll get all remaining cards
- Drawing from an empty deck returns an empty `cards` array

---

#### 5. Reshuffle Deck

**Endpoint:** `GET /{deck_id}/shuffle/`

**Description:** Shuffles all cards back into the deck (including previously drawn cards).

**Path Parameters:**

- `deck_id` (required): The deck to reshuffle

**Query Parameters:**

- `remaining` (optional): Only shuffle remaining cards (default: false)

**Example Requests:**

```bash
# Reshuffle all cards back into deck
curl https://deckofcardsapi.com/api/deck/3p40paa87x90/shuffle/

# Shuffle only remaining cards
curl https://deckofcardsapi.com/api/deck/3p40paa87x90/shuffle/?remaining=true
```

**Response Example:**

```json
{
    "success": true,
    "deck_id": "3p40paa87x90",
    "shuffled": true,
    "remaining": 52
}
```

**Response Codes:**

- `200 OK` - Deck reshuffled successfully
- `404 Not Found` - Deck ID doesn't exist

---

## Card Codes Reference

Understanding card codes is essential for working with the Deck of Cards API.

### Card Values

- `A` or `ACE` - Ace
- `2` through `10` - Number cards
- `J` or `JACK` - Jack
- `Q` or `QUEEN` - Queen  
- `K` or `KING` - King

### Suits

- `S` - Spades ♠
- `H` - Hearts ♥
- `D` - Diamonds ♦
- `C` - Clubs ♣

### Card Code Examples

- `AS` - Ace of Spades
- `KH` - King of Hearts
- `10D` - Ten of Diamonds
- `2C` - Two of Clubs
- `QS` - Queen of Spades

### Creating Custom Decks

You can create decks with specific cards by providing comma-separated codes:

```bash
# Only Aces
curl "https://deckofcardsapi.com/api/deck/new/?cards=AS,AH,AD,AC"

# Face cards only
curl "https://deckofcardsapi.com/api/deck/new/?cards=JS,JH,JD,JC,QS,QH,QD,QC,KS,KH,KD,KC"

# Red cards only
curl "https://deckofcardsapi.com/api/deck/new/?cards=AH,2H,3H,4H,5H,6H,7H,8H,9H,10H,JH,QH,KH,AD,2D,3D,4D,5D,6D,7D,8D,9D,10D,JD,QD,KD"
```

---

## Error Handling

### Common Error Responses

#### Deck Not Found (404)

```json
{
    "success": false,
    "error": "Deck ID does not exist."
}
```

**Causes:**

- Invalid deck_id
- Deck has expired (decks expire after 2 weeks of inactivity)

**Solutions:**

- Check that you're using the correct deck_id
- Create a new deck if the old one has expired

#### Invalid Parameters (400)

```json
{
    "success": false,
    "error": "Invalid card code provided."
}
```

**Causes:**

- Invalid card codes in custom deck creation
- Invalid query parameters

**Solutions:**

- Check card code format (e.g., "AS", "KH", "10D")
- Verify parameter names and values

---

## Best Practices

### Working with Deck IDs

1. **Always save the deck_id**: You'll need it for all subsequent operations
2. **Use environment variables**: Store deck_id in variables for scripting
3. **Handle expiration**: Be prepared to create new decks if old ones expire

### Efficient Card Drawing

1. **Draw multiple cards**: Use `count` parameter instead of multiple single draws
2. **Check remaining count**: Monitor `remaining` field to avoid empty deck draws
3. **Reshuffle when needed**: Reset deck when you need all cards back

### Error Prevention

1. **Validate deck_id format**: Should be alphanumeric string
2. **Check success field**: Always verify `success: true` in responses
3. **Handle empty decks**: Plan for when `remaining: 0`

### Example Workflow Script

```bash
#!/bin/bash

# 1. Create and save deck
DECK_ID=$(curl -s https://deckofcardsapi.com/api/deck/new/shuffle/ | jq -r '.deck_id')
echo "Created deck: $DECK_ID"

# 2. Draw poker hand
echo "Drawing poker hand..."
HAND=$(curl -s "https://deckofcardsapi.com/api/deck/$DECK_ID/draw/?count=5")
echo "$HAND" | jq -r '.cards[] | "\(.value) of \(.suit)"'

# 3. Check remaining cards
REMAINING=$(curl -s "https://deckofcardsapi.com/api/deck/$DECK_ID/" | jq -r '.remaining')
echo "Cards remaining: $REMAINING"

# 4. Reshuffle if needed
if [ $REMAINING -lt 10 ]; then
    echo "Reshuffling deck..."
    curl -s "https://deckofcardsapi.com/api/deck/$DECK_ID/shuffle/" > /dev/null
    echo "Deck reshuffled!"
fi
```

---

*This documentation covers all the endpoints you'll use in the Module 3 examples. Refer back to this guide when working through the exercises!*
