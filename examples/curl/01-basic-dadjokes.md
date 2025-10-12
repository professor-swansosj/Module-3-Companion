# Basic Dad Jokes API Examples

## Introduction

The Dad Jokes API is a simple REST API that provides random dad jokes. It's perfect for learning basic API concepts because it requires no authentication and returns simple responses.

**API Base URL**: `https://icanhazdadjoke.com/`

---

## Example 1: Basic Request (Plain Text)

The simplest way to get a dad joke:

```bash
curl https://icanhazdadjoke.com/
```

**Expected Output:**

```bash
I invented a new word: Plagiarism!
```

---

## Example 2: Request JSON Format

To get a structured JSON response instead of plain text:

```bash
curl -H "Accept: application/json" https://icanhazdadjoke.com/
```

**Expected JSON Output:**

```json
{
  "id": "R7UfaahVfFd",
  "joke": "My dog used to chase people on a bike a lot. It got so bad I had to take his bike away.",
  "status": 200
}
```

---

## Example 3: Verbose Request (See Headers and Details)

Use the `-v` flag to see the full HTTP conversation:

```bash
curl -v -H "Accept: application/json" https://icanhazdadjoke.com/
```

**What you'll see:**

- DNS resolution
- TCP connection establishment
- SSL/TLS handshake
- HTTP request headers
- HTTP response headers
- Response body

**Sample Verbose Output:**

```bash
* Trying 104.21.66.125:443...
* Connected to icanhazdadjoke.com (104.21.66.125) port 443 (#0)
* ALPN, offering h2
* ALPN, offering http/1.1
* successfully set certificate verify locations:
...
> GET / HTTP/1.1
> Host: icanhazdadjoke.com
> User-Agent: curl/7.68.0
> Accept: application/json
>
< HTTP/1.1 200 OK
< Date: Thu, 12 Oct 2023 15:30:45 GMT
< Content-Type: application/json
< Content-Length: 103
< Connection: keep-alive
...
{
  "id": "abc123",
  "joke": "Why don't scientists trust atoms? Because they make up everything!",
  "status": 200
}
```

---

## Example 4: Pretty Print JSON with jq

Combine curl with jq to format JSON output nicely:

```bash
curl -s -H "Accept: application/json" https://icanhazdadjoke.com/ | jq
```

**Note:** The `-s` flag makes curl silent (no progress meter)

---

## Example 5: Extract Specific Fields with jq

Get only the joke text:

```bash
curl -s -H "Accept: application/json" https://icanhazdadjoke.com/ | jq -r '.joke'
```

Get only the joke ID:

```bash
curl -s -H "Accept: application/json" https://icanhazdadjoke.com/ | jq -r '.id'
```

**Expected Output:**

```bash
My dog used to chase people on a bike a lot. It got so bad I had to take his bike away.
```

---

## Example 6: Save Response to File

Save the JSON response to a file:

```bash
curl -s -H "Accept: application/json" https://icanhazdadjoke.com/ -o joke.json
```

Then view the file:

```bash
cat joke.json | jq
```

---

## Example 7: Get a Specific Joke by ID

You can retrieve a specific joke if you know its ID:

```bash
curl -H "Accept: application/json" https://icanhazdadjoke.com/j/R7UfaahVfFd
```

---

## Common Headers Used

- `Accept: application/json` - Request JSON format
- `Accept: text/plain` - Request plain text format (default)
- `User-Agent: MyApp/1.0` - Identify your application

## Key Learning Points

1. **Default Response Format**: Plain text unless you specify otherwise
2. **Content Negotiation**: Use `Accept` header to request different formats
3. **HTTP Status Codes**: 200 means success
4. **JSON Parsing**: Use jq to extract and format JSON data
5. **Verbose Mode**: Use `-v` to see the complete HTTP transaction

## Practice Commands

Try these commands and observe the differences:

```bash
# 1. Basic request
curl https://icanhazdadjoke.com/

# 2. JSON format
curl -H "Accept: application/json" https://icanhazdadjoke.com/

# 3. With pretty printing
curl -s -H "Accept: application/json" https://icanhazdadjoke.com/ | jq

# 4. Extract just the joke
curl -s -H "Accept: application/json" https://icanhazdadjoke.com/ | jq -r '.joke'

# 5. Verbose output to see headers
curl -v -H "Accept: application/json" https://icanhazdadjoke.com/
```
