# Troubleshooting Guide

This guide helps you diagnose and fix common issues when working with APIs, cURL, and Postman.

---

## Common cURL Issues

### 1. "Command not found: curl"

**Problem:** cURL is not installed or not in your PATH.

**Solutions:**

**Ubuntu/Debian:**

```bash
sudo apt update
sudo apt install curl
```

**CentOS/RHEL:**

```bash
sudo yum install curl
# or for newer versions
sudo dnf install curl
```

**Windows:**

- cURL comes pre-installed with Windows 10 (version 1803+)
- If missing, download from <https://curl.se/windows/>
- Or install via PowerShell: `winget install curl`

**Verify installation:**

```bash
curl --version
```

---

### 2. SSL Certificate Errors

**Problem:** SSL certificate verification failures.

**Error Messages:**

```bash
curl: (60) SSL certificate problem: unable to get local issuer certificate
curl: (35) SSL connect error
```

**Solutions:**

**Temporary fix (not recommended for production):**

```bash
curl -k https://api.example.com/data
```

**Proper fixes:**

```bash
# Update certificate store (Ubuntu/Debian)
sudo apt update && sudo apt install ca-certificates

# Update certificate store (CentOS/RHEL)
sudo yum update ca-certificates

# Specify certificate bundle
curl --cacert /path/to/cacert.pem https://api.example.com/data
```

---

### 3. JSON Parsing Errors with jq

**Problem:** jq command not found or JSON parsing issues.

**Install jq:**

**Ubuntu/Debian:**

```bash
sudo apt install jq
```

**CentOS/RHEL:**

```bash
sudo yum install epel-release
sudo yum install jq
```

**Windows:**

```bash
winget install jqlang.jq
```

**Common jq Usage:**

```bash
# Pretty print JSON
curl -s https://icanhazdadjoke.com/ | jq '.'

# Extract specific field
curl -s https://icanhazdadjoke.com/ | jq '.joke'

# Raw output (remove quotes)
curl -s https://icanhazdadjoke.com/ | jq -r '.joke'

# Handle arrays
curl -s https://api.example.com/users | jq '.[0].name'
```

---

### 4. Special Characters in URLs

**Problem:** URLs with spaces or special characters cause errors.

**Error Example:**

```bash
# This will fail
curl https://api.example.com/search?q=hello world
```

**Solutions:**

```bash
# Method 1: URL encode manually
curl "https://api.example.com/search?q=hello%20world"

# Method 2: Use quotes to protect spaces
curl "https://api.example.com/search?q=hello world"

# Method 3: Use --data-urlencode for complex queries
curl -G --data-urlencode "q=hello world & more" https://api.example.com/search
```

**Common URL Encodings:**

- Space: `%20` or `+`
- `&`: `%26`
- `?`: `%3F`
- `#`: `%23`
- `%`: `%25`

---

### 5. Authentication Issues

**Problem:** 401 Unauthorized or 403 Forbidden errors.

**Check Authentication Method:**

```bash
# API Key in header
curl -H "X-API-Key: your-key" https://api.example.com/data

# API Key in query parameter
curl "https://api.example.com/data?api_key=your-key"

# Bearer token
curl -H "Authorization: Bearer your-token" https://api.example.com/data

# Basic authentication
curl -u username:password https://api.example.com/data
```

**Debugging Authentication:**

```bash
# Check what headers you're sending
curl -v -H "Authorization: Bearer your-token" https://api.example.com/data

# Test with a simple endpoint first
curl -v https://api.example.com/public/status
```

---

## Common API Response Issues

### 1. Empty or No Response

**Possible Causes:**

- Wrong URL or endpoint
- Network connectivity issues
- Server is down

**Debugging Steps:**

```bash
# Check basic connectivity
curl -I https://api.example.com/

# Use verbose output to see what's happening
curl -v https://api.example.com/data

# Check DNS resolution
nslookup api.example.com

# Test with a simpler request
curl https://httpbin.org/get
```

---

### 2. Unexpected Response Format

**Problem:** Expected JSON but got HTML or plain text.

**Example Error Response:**

```html
<html>
<head><title>404 Not Found</title></head>
<body>Page not found</body>
</html>
```

**Solutions:**

```bash
# Always check the Content-Type header
curl -I https://api.example.com/data

# Check the Accept header you're sending
curl -H "Accept: application/json" https://api.example.com/data

# Verify the endpoint URL is correct
curl -v https://api.example.com/correct/endpoint
```

---

### 3. Rate Limiting (429 Too Many Requests)

**Problem:** Getting 429 status codes.

**Example Response:**

```json
{
  "error": "Rate limit exceeded",
  "retry_after": 60
}
```

**Solutions:**

```bash
# Add delays between requests
curl https://api.example.com/data
sleep 1
curl https://api.example.com/data

# Check rate limit headers
curl -I https://api.example.com/data
```

**Common Rate Limit Headers:**

- `X-RateLimit-Limit`: Maximum requests allowed
- `X-RateLimit-Remaining`: Requests remaining
- `X-RateLimit-Reset`: When the limit resets
- `Retry-After`: Seconds to wait before retrying

---

## Postman Issues

### 1. Request Not Working in Postman

**Check These Settings:**

1. **Method:** Ensure you're using the correct HTTP method (GET, POST, etc.)

2. **URL:** Verify the complete URL including protocol (https://)

3. **Headers:** Check that required headers are set:
   - `Content-Type: application/json` for JSON requests
   - `Accept: application/json` for JSON responses
   - Authentication headers

4. **Body:** For POST/PUT requests, ensure:
   - Body type is set correctly (JSON, form-data, etc.)
   - JSON syntax is valid

---

### 2. Variables Not Working

**Problem:** `{{variable_name}}` not being replaced.

**Solutions:**

1. **Check Variable Scope:**
   - Collection variables: Available to all requests in the collection
   - Environment variables: Available when environment is active
   - Global variables: Available everywhere

2. **Set Variables in Test Scripts:**

   ```javascript
   // Set collection variable
   pm.collectionVariables.set("deck_id", jsonData.deck_id);
   
   // Set environment variable
   pm.environment.set("api_key", "your-key");
   
   // Set global variable
   pm.globals.set("base_url", "https://api.example.com");
   ```

3. **Use Variables in Requests:**

   ```bash
   URL: {{base_url}}/api/deck/{{deck_id}}/draw/
   Header: Authorization: Bearer {{auth_token}}
   ```

---

### 3. Test Scripts Not Running

**Problem:** Test scripts in the "Tests" tab not executing.

**Common Issues:**

1. **JavaScript Syntax Errors:**

   ```javascript
   // Wrong - missing semicolon
   pm.test("Status is 200", function() {
       pm.response.to.have.status(200)
   })
   
   // Correct
   pm.test("Status is 200", function() {
       pm.response.to.have.status(200);
   });
   ```

2. **Accessing Response Data:**

   ```javascript
   // Get JSON response
   var jsonData = pm.response.json();
   
   // Get text response
   var textData = pm.response.text();
   
   // Get headers
   var contentType = pm.response.headers.get("Content-Type");
   ```

---

### 4. Collection Import Issues

**Problem:** Can't import the provided collection file.

**Solutions:**

1. **Check File Format:** Ensure it's a valid JSON file

2. **Import Steps:**
   - Open Postman
   - Click "Import" button
   - Drag and drop the `.json` file or browse to select it
   - Click "Import"

3. **Update Collection URLs:** If URLs are outdated, update them manually

---

## Deck of Cards API Specific Issues

### 1. Deck ID Not Found (404)

**Problem:** Getting 404 errors when using deck_id.

**Causes:**

- Deck has expired (inactive for 2 weeks)
- Wrong deck_id format
- Typo in deck_id

**Solutions:**

```bash
# Create a new deck and save the ID properly
DECK_ID=$(curl -s https://deckofcardsapi.com/api/deck/new/shuffle/ | jq -r '.deck_id')
echo "New deck ID: $DECK_ID"

# Verify the deck exists
curl "https://deckofcardsapi.com/api/deck/$DECK_ID/"

# Always check the success field in responses
curl -s "https://deckofcardsapi.com/api/deck/$DECK_ID/" | jq '.success'
```

---

### 2. No Cards Drawn from Deck

**Problem:** Drawing cards returns empty array.

**Example Response:**

```json
{
    "success": true,
    "deck_id": "3p40paa87x90",
    "cards": [],
    "remaining": 0
}
```

**Cause:** All cards have been drawn from the deck.

**Solutions:**

```bash
# Check remaining cards first
curl -s "https://deckofcardsapi.com/api/deck/$DECK_ID/" | jq '.remaining'

# Reshuffle all cards back into deck
curl "https://deckofcardsapi.com/api/deck/$DECK_ID/shuffle/"

# Or create a new deck
DECK_ID=$(curl -s https://deckofcardsapi.com/api/deck/new/shuffle/ | jq -r '.deck_id')
```

---

### 3. Invalid Card Codes

**Problem:** Error when creating custom deck with specific cards.

**Error Response:**

```json
{
    "success": false,
    "error": "Invalid card code provided."
}
```

**Valid Card Code Format:**

- Value: `A`, `2`-`10`, `J`, `Q`, `K`  
- Suit: `S` (Spades), `H` (Hearts), `D` (Diamonds), `C` (Clubs)
- Examples: `AS`, `KH`, `10D`, `2C`

**Correct Usage:**

```bash
# Valid card codes
curl "https://deckofcardsapi.com/api/deck/new/?cards=AS,KH,QD,JC"

# Invalid - will cause error
curl "https://deckofcardsapi.com/api/deck/new/?cards=A1,K5,XY"
```

---

## General Debugging Tips

### 1. Use Verbose Mode

**cURL Verbose Output:**

```bash
curl -v https://api.example.com/data
```

**What to look for:**

- DNS resolution: `* Trying 104.21.66.125:443...`
- Connection: `* Connected to api.example.com`  
- SSL handshake: `* SSL connection using TLSv1.3`
- Request headers: `> GET / HTTP/1.1`
- Response headers: `< HTTP/1.1 200 OK`

---

### 2. Test with Simple Endpoints

**Start with basic requests:**

```bash
# Test basic connectivity
curl https://httpbin.org/get

# Test our APIs
curl https://icanhazdadjoke.com/
curl https://deckofcardsapi.com/api/deck/new/
```

---

### 3. Check Status Codes

**Always verify the HTTP status code:**

```bash
# Get just the status code
curl -s -o /dev/null -w "%{http_code}" https://api.example.com/data

# Include status code with response
curl -w "HTTP Status: %{http_code}\n" https://api.example.com/data
```

---

### 4. Save Responses for Analysis

```bash
# Save response to file
curl -s https://api.example.com/data > response.json

# Save response with headers
curl -s -D headers.txt https://api.example.com/data > response.json

# View the files
cat headers.txt
cat response.json | jq
```

---

### 5. Use Online Tools

**Helpful Online Tools:**

- **httpbin.org**: Test HTTP requests and responses
- **jsonlint.com**: Validate JSON syntax
- **curl.trillworks.com**: Convert cURL commands to other languages
- **postman-echo.com**: Postman's testing service

**Example Tests:**

```bash
# Test POST request
curl -X POST -H "Content-Type: application/json" \
     -d '{"test": "data"}' \
     https://httpbin.org/post

# Test headers
curl -H "Custom-Header: test-value" https://httpbin.org/headers

# Test authentication
curl -u testuser:testpass https://httpbin.org/basic-auth/testuser/testpass
```

---

## Getting Help

### 1. Check Documentation

- API documentation for endpoints and parameters
- cURL manual: `man curl` or `curl --help`
- jq manual: `man jq` or visit <https://stedolan.github.io/jq/>

### 2. Error Message Analysis

- Read error messages carefully
- Search for specific error codes
- Check HTTP status code meanings

### 3. Community Resources

- Stack Overflow for programming questions
- API-specific forums or GitHub issues
- Postman Community forum

### 4. Course Resources

- Review the examples in this repository
- Check the documentation files
- Ask questions in the course discussion forum

---

*Remember: Most API issues are due to simple mistakes like typos in URLs, missing headers, or incorrect authentication. Always start with the basics and work your way up to more complex debugging.*
