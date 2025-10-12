# HTTP Protocol Reference Guide

## Overview

The Hypertext Transfer Protocol (HTTP) is the foundation of data communication on the World Wide Web. This guide covers the essential concepts you need to understand when working with APIs.

---

## HTTP Methods

HTTP methods (also called verbs) indicate the desired action to be performed on a resource.

### Common HTTP Methods

| Method | Purpose | Safe | Idempotent | Has Body |
|--------|---------|------|------------|----------|
| GET    | Retrieve data | ✅ | ✅ | ❌ |
| POST   | Create new resource | ❌ | ❌ | ✅ |
| PUT    | Update/Replace resource | ❌ | ✅ | ✅ |
| PATCH  | Partial update | ❌ | ❌ | ✅ |
| DELETE | Remove resource | ❌ | ✅ | ❌ |

#### GET

- **Purpose**: Retrieve information from a server
- **Example**: `GET /api/users/123` - Get user with ID 123
- **Characteristics**:
  - Should not modify server state
  - Can be cached
  - Parameters sent in URL query string

#### POST  

- **Purpose**: Create new resources or submit data
- **Example**: `POST /api/users` - Create a new user
- **Characteristics**:
  - Can modify server state
  - Data sent in request body
  - Not cacheable

#### PUT

- **Purpose**: Create or completely replace a resource
- **Example**: `PUT /api/users/123` - Replace user 123 entirely
- **Characteristics**:
  - Idempotent (same request can be made multiple times)
  - Complete replacement of resource

#### PATCH

- **Purpose**: Partially update a resource
- **Example**: `PATCH /api/users/123` - Update specific fields of user 123
- **Characteristics**:
  - Only sends changed fields
  - More efficient than PUT for partial updates

#### DELETE

- **Purpose**: Remove a resource
- **Example**: `DELETE /api/users/123` - Delete user 123
- **Characteristics**:
  - Idempotent
  - May return confirmation in response body

---

## HTTP Status Codes

Status codes indicate the result of an HTTP request. They are grouped into five categories:

### 1xx - Informational

| Code | Message | Meaning |
|------|---------|---------|
| 100  | Continue | Server received request headers, client should send body |
| 101  | Switching Protocols | Server is switching protocols per client request |

### 2xx - Success

| Code | Message | Meaning | When Used |
|------|---------|---------|-----------|
| 200  | OK | Request succeeded | Standard successful response |
| 201  | Created | Resource created successfully | After POST creates new resource |
| 202  | Accepted | Request accepted for processing | Async operations |
| 204  | No Content | Success, but no content to return | After DELETE operations |

### 3xx - Redirection

| Code | Message | Meaning | When Used |
|------|---------|---------|-----------|
| 301  | Moved Permanently | Resource permanently moved | URL has changed forever |
| 302  | Found | Resource temporarily moved | Temporary redirect |
| 304  | Not Modified | Resource hasn't changed | Caching scenarios |

### 4xx - Client Errors

| Code | Message | Meaning | Common Causes |
|------|---------|---------|---------------|
| 400  | Bad Request | Malformed request | Invalid JSON, missing parameters |
| 401  | Unauthorized | Authentication required | Missing/invalid API key |
| 403  | Forbidden | Access denied | Valid auth but insufficient permissions |
| 404  | Not Found | Resource doesn't exist | Wrong URL or deleted resource |
| 405  | Method Not Allowed | HTTP method not supported | Using POST on GET-only endpoint |
| 409  | Conflict | Request conflicts with current state | Duplicate creation attempts |
| 422  | Unprocessable Entity | Request understood but contains errors | Validation failures |
| 429  | Too Many Requests | Rate limit exceeded | Too many API calls |

### 5xx - Server Errors

| Code | Message | Meaning | Common Causes |
|------|---------|---------|---------------|
| 500  | Internal Server Error | Server encountered an error | Database issues, code bugs |
| 502  | Bad Gateway | Invalid upstream response | Gateway/proxy issues |
| 503  | Service Unavailable | Server temporarily unavailable | Maintenance, overload |
| 504  | Gateway Timeout | Upstream server didn't respond | Network issues, slow backend |

---

## HTTP Headers

Headers provide additional information about requests and responses.

### Common Request Headers

#### Accept

Specifies the media types that the client can handle.

```bash
Accept: application/json
Accept: text/plain
Accept: application/json, text/plain, */*
```

#### Content-Type (Request)

Indicates the media type of the request body.

```bash
Content-Type: application/json
Content-Type: application/x-www-form-urlencoded
Content-Type: multipart/form-data
```

#### Authorization

Contains credentials for authenticating the client.

```bash
Authorization: Bearer eyJhbGciOiJIUzI1NiIs...
Authorization: Basic dXNlcm5hbWU6cGFzc3dvcmQ=
Authorization: API-Key abc123def456
```

#### User-Agent

Identifies the client application.

```bash
User-Agent: curl/7.68.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64)
User-Agent: MyApp/1.0 (Learning Client)
```

#### Host

Specifies the domain name of the server.

```bash
Host: api.example.com
Host: icanhazdadjoke.com
```

### Common Response Headers

#### Content-Type (Response)

Indicates the media type of the response body.

```bash
Content-Type: application/json; charset=utf-8
Content-Type: text/html; charset=utf-8
```

#### Content-Length

The size of the response body in bytes.

```bash
Content-Length: 1234
```

#### Server

Information about the server software.

```bash
Server: nginx/1.18.0
Server: Apache/2.4.41
Server: cloudflare
```

#### Date

The date and time when the response was generated.

```bash
Date: Thu, 12 Oct 2023 15:30:45 GMT
```

#### Cache-Control

Directives for caching mechanisms.

```bash
Cache-Control: no-cache
Cache-Control: max-age=3600
Cache-Control: public, max-age=86400
```

---

## URL Structure

Understanding URL components is crucial for API work:

```bash
https://api.example.com:443/v1/users/123?active=true&sort=name#section1
│    │ │              │ │   │         │   │                    │
│    │ │              │ │   │         │   └─ Fragment (anchor)
│    │ │              │ │   │         └─ Query parameters  
│    │ │              │ │   └─ Path parameters
│    │ │              │ └─ Path
│    │ │              └─ Port (optional, defaults: 80 for HTTP, 443 for HTTPS)
│    │ └─ Host/Domain
│    └─ Scheme/Protocol
```

### Query Parameters

Used to pass data in GET requests:

```bash
# Single parameter
GET /api/users?name=john

# Multiple parameters  
GET /api/users?name=john&age=25&active=true

# URL encoding for special characters
GET /api/search?q=hello%20world  # "hello world"
```

### Path Parameters

Part of the URL path itself:

```bash
GET /api/users/123        # 123 is a path parameter
GET /api/decks/abc123/draw  # abc123 is the deck_id parameter
```

---

## Content Types (MIME Types)

Common content types you'll encounter:

| Content-Type | Extension | Description |
|--------------|-----------|-------------|
| `application/json` | .json | JSON data format |
| `application/xml` | .xml | XML data format |
| `text/plain` | .txt | Plain text |
| `text/html` | .html | HTML markup |
| `text/css` | .css | CSS stylesheets |
| `image/jpeg` | .jpg | JPEG images |
| `image/png` | .png | PNG images |
| `application/pdf` | .pdf | PDF documents |

---

## Authentication Methods

### API Keys

Simple authentication using a key:

```bash
# Header-based
curl -H "X-API-Key: your-api-key-here" https://api.example.com/data

# Query parameter
curl "https://api.example.com/data?api_key=your-api-key-here"
```

### Bearer Tokens

Common for JWT and OAuth:

```bash
curl -H "Authorization: Bearer eyJhbGciOiJIUzI1NiIs..." https://api.example.com/data
```

### Basic Authentication

Username and password (base64 encoded):

```bash
curl -u username:password https://api.example.com/data
# or
curl -H "Authorization: Basic dXNlcm5hbWU6cGFzc3dvcmQ=" https://api.example.com/data
```

---

## Best Practices

### Request Headers

1. Always include `Accept` header to specify desired response format
2. Set appropriate `Content-Type` for request body
3. Include `User-Agent` to identify your application
4. Use proper authentication headers

### Error Handling

1. Check status codes before processing response
2. Handle common error codes appropriately:
   - 401: Refresh authentication
   - 429: Implement retry with backoff
   - 500: Retry after delay or report issue

### Rate Limiting

1. Respect API rate limits
2. Implement exponential backoff for retries
3. Monitor rate limit headers if provided

### Security

1. Always use HTTPS for sensitive data
2. Never expose API keys in client-side code
3. Validate and sanitize all input data
4. Use proper authentication methods

---

## Debugging HTTP Requests

### Using cURL with Verbose Output

```bash
curl -v -H "Accept: application/json" https://api.example.com/data
```

### Common Debugging Flags

- `-v` : Verbose output (shows headers and SSL handshake)
- `-i` : Include response headers in output
- `-I` : HEAD request only (headers only)
- `-w` : Custom output format for timing information

### Useful cURL Variables

```bash
curl -w "Time: %{time_total}s\nStatus: %{http_code}\n" https://api.example.com/data
```

---

## Quick Reference Card

### Essential cURL Commands

```bash
# Basic GET request
curl https://api.example.com/data

# GET with headers
curl -H "Accept: application/json" https://api.example.com/data

# POST with JSON data
curl -X POST -H "Content-Type: application/json" -d '{"name":"John"}' https://api.example.com/users

# Save response to file
curl -o response.json https://api.example.com/data

# Follow redirects
curl -L https://api.example.com/data

# Verbose output for debugging
curl -v https://api.example.com/data
```

### Status Code Quick Check

- **2xx**: Success ✅
- **3xx**: Redirection ↩️
- **4xx**: Client error ❌ (check your request)
- **5xx**: Server error 🔥 (not your fault)

---

*Use this guide as a reference while working with the Dad Jokes API and Deck of Cards API examples!*
