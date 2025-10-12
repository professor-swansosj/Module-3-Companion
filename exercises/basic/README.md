# Basic API Exercises

These exercises will help you practice the fundamental concepts of working with APIs using cURL and the Dad Jokes API.

---

## Exercise 1: Your First API Call

**Objective:** Make your first successful API request and understand the response.

**Task:** Get a random dad joke using cURL.

**Instructions:**

1. Open your terminal/command prompt
2. Run the following command:

   ```bash
   curl https://icanhazdadjoke.com/
   ```

3. Observe the response

**Questions:**

1. What format did the response come in?
2. Did you get a complete joke or just text?
3. Was there any additional information in the response?

**Expected Output:** You should see a plain text dad joke.

---

## Exercise 2: JSON Response Format

**Objective:** Learn to request specific response formats using headers.

**Task:** Get the same dad joke but in JSON format.

**Instructions:**

1. Run this command:

   ```bash
   curl -H "Accept: application/json" https://icanhazdadjoke.com/
   ```

2. Compare the response to Exercise 1

**Questions:**

1. What's different about this response?
2. What additional information do you get in JSON format?
3. What does the "status" field tell you?

**Expected Output:** JSON object with id, joke, and status fields.

---

## Exercise 3: Pretty Printing with jq

**Objective:** Learn to format JSON responses for better readability.

**Task:** Use jq to format the JSON response nicely.

**Prerequisites:** Make sure jq is installed (see troubleshooting guide if needed).

**Instructions:**

1. Run this command:

   ```bash
   curl -s -H "Accept: application/json" https://icanhazdadjoke.com/ | jq
   ```

2. Note the `-s` flag (what do you think it does?)

**Questions:**

1. How does the output differ from Exercise 2?
2. What does the `-s` flag do? (Try without it to see)
3. Why might pretty-printed JSON be useful?

**Challenge:** Can you make the same request and format it on separate lines?

---

## Exercise 4: Extracting Specific Data

**Objective:** Learn to extract specific fields from JSON responses.

**Task:** Get only the joke text, without the surrounding JSON structure.

**Instructions:**

1. Extract just the joke text:

   ```bash
   curl -s -H "Accept: application/json" https://icanhazdadjoke.com/ | jq -r '.joke'
   ```

2. Extract just the joke ID:

   ```bash
   curl -s -H "Accept: application/json" https://icanhazdadjoke.com/ | jq -r '.id'
   ```

**Questions:**

1. What does the `-r` flag do in jq? (Try without it)
2. What does the `.joke` syntax mean?
3. How would you get both the ID and joke on separate lines?

**Challenge:** Can you create a command that outputs: "Joke ID: [id] - [joke text]"?

---

## Exercise 5: Saving Responses

**Objective:** Learn to save API responses to files for later analysis.

**Task:** Save a dad joke response to a file and examine it.

**Instructions:**

1. Save a JSON response to a file:

   ```bash
   curl -s -H "Accept: application/json" https://icanhazdadjoke.com/ -o my_joke.json
   ```

2. View the file contents:

   ```bash
   cat my_joke.json
   ```

3. Format the file contents:

   ```bash
   cat my_joke.json | jq
   ```

**Questions:**

1. What does the `-o` flag do?
2. Why might you want to save API responses?
3. What's the difference between viewing the raw file vs. using jq?

**Challenge:** Save 5 different jokes to separate files named joke1.json, joke2.json, etc.

---

## Exercise 6: Using Verbose Mode

**Objective:** Understand what happens "behind the scenes" in an API call.

**Task:** Make a verbose API call to see all the HTTP details.

**Instructions:**

1. Run this command:

   ```bash
   curl -v -H "Accept: application/json" https://icanhazdadjoke.com/
   ```

2. Study the output carefully

**Questions:**

1. What happens before the actual HTTP request?
2. What headers does cURL send by default?
3. What response headers does the server send back?
4. How long did the request take?

**Look for these details:**

- DNS resolution
- Connection establishment  
- SSL/TLS handshake
- Request headers (lines starting with `>`)
- Response headers (lines starting with `<`)

---

## Exercise 7: Custom Headers

**Objective:** Learn to add custom headers to your requests.

**Task:** Add a custom User-Agent header to identify your requests.

**Instructions:**

1. Make a request with a custom User-Agent:

   ```bash
   curl -H "Accept: application/json" -H "User-Agent: MyApp/1.0 Learning Client" https://icanhazdadjoke.com/
   ```

2. Use verbose mode to see your custom header being sent

**Questions:**

1. Why might you want to set a custom User-Agent?
2. How can you add multiple headers to a request?
3. What's the default User-Agent that cURL sends?

**Challenge:** Create a request with three custom headers: Accept, User-Agent, and a custom "X-Student-Name" header with your name.

---

## Exercise 8: Getting a Specific Joke

**Objective:** Learn to use path parameters in API requests.

**Task:** Retrieve a specific joke by its ID.

**Instructions:**

1. First, get a random joke and note its ID:

   ```bash
   curl -s -H "Accept: application/json" https://icanhazdadjoke.com/ | jq '.id'
   ```

2. Use that ID to get the specific joke:

   ```bash
   curl -H "Accept: application/json" https://icanhazdadjoke.com/j/YOUR_JOKE_ID_HERE
   ```

**Questions:**

1. Did you get the same joke both times?
2. What happens if you use an invalid joke ID?
3. How is this different from getting a random joke?

**Challenge:** Write a script that gets a random joke, saves its ID, then retrieves that specific joke again.

---

## Exercise 9: Error Handling

**Objective:** Learn how APIs respond to invalid requests.

**Task:** Intentionally make invalid requests and observe the responses.

**Instructions:**

1. Try an invalid endpoint:

   ```bash
   curl -H "Accept: application/json" https://icanhazdadjoke.com/invalid
   ```

2. Try an invalid joke ID:

   ```bash
   curl -H "Accept: application/json" https://icanhazdadjoke.com/j/invalid-id
   ```

3. Try a non-existent domain:

   ```bash
   curl https://this-domain-does-not-exist.com/
   ```

**Questions:**

1. What HTTP status code do you get for each error?
2. How does the response differ for each type of error?
3. How long does each request take? Why?

**Challenge:** Use the `-f` flag with cURL and see how it changes error handling.

---

## Exercise 10: Automation with Variables

**Objective:** Learn to use shell variables for API automation.

**Task:** Create a script that saves and reuses data from API responses.

**Instructions:**

1. Save a joke ID to a variable:

   ```bash
   JOKE_ID=$(curl -s -H "Accept: application/json" https://icanhazdadjoke.com/ | jq -r '.id')
   echo "Saved joke ID: $JOKE_ID"
   ```

2. Use that variable in another request:

   ```bash
   curl -H "Accept: application/json" "https://icanhazdadjoke.com/j/$JOKE_ID"
   ```

**Questions:**

1. How does the `$()` syntax work?
2. Why is this useful for API automation?
3. What happens if the first request fails?

**Challenge:** Create a complete script that:

- Gets a random joke
- Extracts and displays the joke ID  
- Retrieves that specific joke again
- Displays both the original and retrieved joke to confirm they match

---

## Self-Assessment Checklist

After completing these exercises, you should be able to:

- [ ] Make basic GET requests with cURL
- [ ] Request specific response formats using headers
- [ ] Format JSON responses with jq
- [ ] Extract specific fields from JSON
- [ ] Save API responses to files
- [ ] Use verbose mode to debug requests
- [ ] Add custom headers to requests
- [ ] Use path parameters in API calls
- [ ] Handle and interpret API errors
- [ ] Use shell variables for API automation

---

## Next Steps

Once you've mastered these basic exercises, you're ready to move on to:

- **Intermediate Exercises**: Working with the Deck of Cards API
- **Advanced Exercises**: Building complete automation scripts

---

## Solutions

Need help? Check the `examples/curl/` directory for working examples, or refer to the troubleshooting guide if you encounter issues.

Remember: The best way to learn APIs is by doing! Don't just read the exercises - actually run the commands and experiment with variations.
