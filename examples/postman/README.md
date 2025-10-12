# Postman Setup and Usage Instructions

This guide will help you set up and use Postman with the Module 3 API Collection.

---

## Installing Postman

### Desktop Application (Recommended)

1. Visit [postman.com](https://www.postman.com/downloads/)
2. Download the desktop app for your operating system
3. Install and create a free account
4. Launch Postman

### Web Version (Alternative)

- Access Postman through your browser at [web.postman.co](https://web.postman.co)
- Sign in with your account
- Note: Some features may be limited in the web version

---

## Importing the Module 3 Collection

### Step 1: Import the Collection File

1. Open Postman
2. Click the **Import** button (top left)
3. Drag and drop the `Module-3-API-Collection.json` file from the `examples/postman/` folder
4. Or click **Upload Files** and browse to select the file
5. Click **Import**

### Step 2: Verify Import

You should see a new collection called **"Module 3 - API Learning Collection"** in your sidebar with two folders:

- Dad Jokes API
- Deck of Cards API

---

## Understanding Collection Structure

### Dad Jokes API Folder

Contains 3 requests demonstrating:

- JSON vs. plain text responses
- Header usage
- Path parameters

### Deck of Cards API Folder  

Contains 7 requests showing:

- Deck creation and management
- Card drawing operations
- Variable usage and automation
- Custom deck creation

---

## Using Variables in Postman

### Collection Variables

The collection includes pre-configured variables:

- `{{deck_id}}` - Automatically set when creating a deck
- `{{partial_deck_id}}` - Set when creating custom decks

### How Variables Work

1. Variables are enclosed in double curly braces: `{{variable_name}}`
2. They're automatically replaced with actual values in requests
3. Variables can be set manually or through test scripts

### Viewing Variables

1. Click on the collection name
2. Select the **Variables** tab
3. See current values and manage variables

---

## Step-by-Step Walkthrough

### Part 1: Dad Jokes API

1. **Get Random Dad Joke (JSON)**
   - Click on this request
   - Notice the `Accept: application/json` header
   - Click **Send**
   - Examine the JSON response

2. **Get Random Dad Joke (Plain Text)**
   - Notice the different `Accept` header
   - Click **Send**  
   - Compare the response format

3. **Get Specific Dad Joke by ID**
   - Copy a joke ID from a previous response
   - Replace `R7UfaahVfFd` in the URL with your ID
   - Click **Send**

### Part 2: Deck of Cards API (Important: Follow Order!)

1. **Create New Shuffled Deck**
   - Click **Send**
   - Check the **Tests** tab to see the automation script
   - Look at the **Console** (bottom panel) for logged messages
   - The `deck_id` is automatically saved for you

2. **Draw Cards from Deck**
   - Notice the `{{deck_id}}` variable in the URL
   - Click **Send**
   - The test script will format and display your cards nicely

3. **Check Deck Status**
   - Click **Send** to see remaining cards
   - Notice how the count has changed

4. **Draw More Cards (5 cards)**
   - Click **Send**
   - Check the Console for formatted card display

5. **Reshuffle Deck**
   - Click **Send**
   - Verify all 52 cards are back

6. **Create Partial Deck (Face Cards Only)**
   - Click **Send**
   - This creates a new deck with only face cards
   - A new `partial_deck_id` variable is set

7. **Draw from Partial Deck**
   - Uses the `{{partial_deck_id}}` variable
   - You should only get face cards (J, Q, K)

---

## Understanding Test Scripts

### What Are Tests?

- JavaScript code that runs after each request
- Located in the **Tests** tab of each request
- Used for automation, validation, and data extraction

### Key Functions Used

```javascript
// Get JSON response data
var jsonData = pm.response.json();

// Set collection variable
pm.collectionVariables.set("deck_id", jsonData.deck_id);

// Test assertions
pm.test("Status code is 200", function () {
    pm.response.to.have.status(200);
});

// Console logging
console.log("Deck ID: " + jsonData.deck_id);
```

### Viewing Test Results

1. Click **Send** on any request
2. Scroll down to see **Test Results**
3. Green checkmarks indicate passing tests
4. Red X marks indicate failing tests

---

## Using the Console

### Opening the Console

1. Click the **Console** button at the bottom of Postman
2. Or use View → Show Postman Console

### What You'll See

- Request and response details
- Console.log output from test scripts
- Error messages and debugging information
- Network timing information

---

## Customizing Requests

### Modifying Headers

1. Click on a request
2. Go to the **Headers** tab
3. Add, modify, or disable headers
4. Toggle headers on/off with checkboxes

### Changing Parameters

1. For query parameters: Use the **Params** tab
2. For path parameters: Edit directly in the URL
3. For body data: Use the **Body** tab (for POST requests)

### Example Modifications

Try these changes:

- Remove the `Accept` header from Dad Jokes requests
- Change card count in draw requests
- Modify the cards parameter in custom deck creation

---

## Creating Your Own Requests

### Adding a New Request

1. Right-click on a folder
2. Select **Add Request**
3. Name your request
4. Configure the method, URL, headers, etc.

### Practice Requests to Try

1. **Dad Jokes**: Create a request that gets a specific joke by ID
2. **Deck of Cards**: Create a request that draws just 1 card
3. **Custom**: Create a deck with only red cards

---

## Working with Environments

### What Are Environments?

- Sets of variables that can be switched between
- Useful for different API endpoints (dev, test, production)

### Creating an Environment

1. Click the gear icon (top right)
2. Select **Manage Environments**
3. Click **Add**
4. Name it "Module 3 Practice"
5. Add variables like:
   - `base_url_jokes`: `https://icanhazdadjoke.com/`
   - `base_url_cards`: `https://deckofcardsapi.com/api/deck/`

### Using Environment Variables

Replace hardcoded URLs with `{{base_url_jokes}}` and `{{base_url_cards}}`

---

## Troubleshooting Common Issues

### Variables Not Working

- Check that the collection is selected in the environment dropdown
- Verify variable names match exactly (case-sensitive)
- Look for typos in `{{variable_name}}` syntax

### Test Scripts Not Running  

- Check for JavaScript syntax errors in the Tests tab
- Look at the Console for error messages
- Verify the response format matches what the script expects

### Request Failing

- Check the URL is complete and correct
- Verify required headers are included
- Look at the response status code and body for error messages

### Import Issues

- Ensure the JSON file is valid and complete
- Try importing individual requests if the collection fails
- Check file permissions and location

---

## Best Practices

### Organization

- Keep related requests in folders
- Use descriptive names for requests
- Add documentation in request descriptions

### Variables

- Use collection variables for data shared across requests
- Use environment variables for configuration that changes
- Set variables programmatically when possible

### Testing

- Add basic status code checks to all requests
- Use tests to validate response structure
- Log important data to the console for debugging

### Documentation

- Add descriptions to requests explaining their purpose
- Include example responses
- Document any setup steps required

---

## Keyboard Shortcuts

| Action | Windows/Linux | Mac |
|--------|---------------|-----|
| Send Request | Ctrl+Enter | Cmd+Enter |
| New Request | Ctrl+N | Cmd+N |
| Save Request | Ctrl+S | Cmd+S |
| Open Console | Alt+Ctrl+C | Option+Cmd+C |

---

## Next Steps

### After Mastering the Collection

1. **Create your own collection** for a different API
2. **Write advanced test scripts** with conditional logic
3. **Set up automated tests** using Postman's collection runner
4. **Export and share** your collections with classmates

### Advanced Features to Explore

- **Collection Runner**: Automate entire workflows
- **Mock Servers**: Create fake APIs for testing
- **Monitors**: Schedule regular API health checks
- **Documentation**: Generate beautiful API docs from collections

---

## Getting Help

### Postman Resources

- [Postman Learning Center](https://learning.postman.com/)
- [Postman Community Forum](https://community.postman.com/)
- Built-in help (? icon in Postman)

### Course Resources

- Check the troubleshooting guide in this repository
- Review the cURL examples for comparison
- Ask questions in the course discussion forum

---

*Remember: Postman is a powerful tool with many features. Don't try to learn everything at once - focus on the basics first, then gradually explore advanced capabilities as needed.*
