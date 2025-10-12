#!/bin/bash

# Dad Jokes API Demo Script
# This script demonstrates basic API interactions with the Dad Jokes API

echo "====================================="
echo "    Dad Jokes API Demo Script"
echo "====================================="
echo ""

# Function to pause for user interaction
pause() {
    read -p "Press Enter to continue..."
    echo ""
}

# 1. Basic request (plain text)
echo "1. Getting a dad joke (plain text format):"
echo "Command: curl https://icanhazdadjoke.com/"
echo ""
curl https://icanhazdadjoke.com/
echo ""
echo ""
pause

# 2. JSON format request
echo "2. Getting a dad joke (JSON format):"
echo "Command: curl -H \"Accept: application/json\" https://icanhazdadjoke.com/"
echo ""
curl -H "Accept: application/json" https://icanhazdadjoke.com/
echo ""
echo ""
pause

# 3. Formatted JSON with jq
echo "3. Getting a dad joke with pretty-printed JSON:"
echo "Command: curl -s -H \"Accept: application/json\" https://icanhazdadjoke.com/ | jq"
echo ""
curl -s -H "Accept: application/json" https://icanhazdadjoke.com/ | jq
echo ""
pause

# 4. Extract just the joke text
echo "4. Extracting just the joke text:"
echo "Command: curl -s -H \"Accept: application/json\" https://icanhazdadjoke.com/ | jq -r '.joke'"
echo ""
JOKE=$(curl -s -H "Accept: application/json" https://icanhazdadjoke.com/ | jq -r '.joke')
echo "Joke: $JOKE"
echo ""
pause

# 5. Save response to file
echo "5. Saving response to file:"
echo "Command: curl -s -H \"Accept: application/json\" https://icanhazdadjoke.com/ -o joke.json"
echo ""
curl -s -H "Accept: application/json" https://icanhazdadjoke.com/ -o joke.json
echo "Response saved to joke.json"
echo "File contents:"
cat joke.json | jq
echo ""
pause

# 6. Show multiple jokes
echo "6. Getting 3 different jokes:"
for i in {1..3}; do
    echo "Joke $i:"
    curl -s -H "Accept: application/json" https://icanhazdadjoke.com/ | jq -r '.joke'
    echo ""
    sleep 1  # Be nice to the API
done

echo "====================================="
echo "         Demo Complete!"
echo "====================================="
echo ""
echo "Files created:"
echo "- joke.json (last joke response)"
echo ""
echo "Try running individual commands from the examples!"

# Clean up
rm -f joke.json 2>/dev/null