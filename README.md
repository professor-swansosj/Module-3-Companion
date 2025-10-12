# Module 3 Companion - Introduction to APIs

## Software Defined Networking Course

### Florida State College at Jacksonville

---

## 📚 Module Overview

This companion repository supports Module 3 of the Software Defined Networking course, which introduces students to Application Programming Interfaces (APIs) and their role in network automation. Students will learn to interact with APIs using various tools and understand the HTTP protocol that underlies most modern web APIs.

### 🎯 Learning Objectives

By the end of this module, students will be able to:

- Understand what APIs are and their importance in network automation
- Comprehend the HTTP protocol including methods, status codes, and headers
- Use cURL to make API requests and parse responses
- Utilize Postman for API testing and development
- Work with real-world APIs to retrieve and manipulate data
- Save and reuse API response data in subsequent requests

### 📋 Prerequisites

- Linux+ certification knowledge
- Introduction to Python (completed)
- Cisco 1, 2, 3 courses (completed)
- Basic understanding of networking concepts

---

## 📖 Table of Contents

1. **Introduction to APIs**
   - What are APIs?
   - REST API fundamentals
   - API authentication basics

2. **The HTTP Protocol**
   - HTTP Methods (GET, POST, PUT, DELETE)
   - HTTP Status Codes (200, 404, 500, etc.)
   - HTTP Headers and their purposes

3. **Introduction to cURL**
   - Basic cURL syntax
   - Command-line options
   - Output formatting

4. **cURL API Interactions**
   - Making basic requests to Dad Jokes API
   - Verbose requests for debugging
   - JSON response handling
   - Using jq for JSON parsing

5. **Introduction to Postman**
   - Creating request collections
   - Building and organizing requests
   - Environment variables

6. **Hands-on with Deck of Cards API**
   - Drawing cards with cURL
   - Drawing cards with Postman
   - Saving and reusing deck_id values

7. **Advanced Techniques**
   - Saving API responses to variables
   - Chaining API requests
   - Error handling and debugging

---

## 🗂️ Repository Structure

```bash
Module-3-Companion/
├── README.md                          # This file
├── examples/
│   ├── curl/                          # cURL command examples
│   ├── postman/                       # Postman collection exports
│   └── scripts/                       # Automation scripts
├── sample-data/
│   ├── json/                          # Sample JSON responses
│   ├── yaml/                          # YAML configuration examples
│   ├── xml/                           # XML response samples
│   └── csv/                           # CSV data files
├── documentation/
│   ├── http-reference.md              # HTTP methods and status codes
│   ├── api-endpoints.md               # API documentation summaries
│   └── troubleshooting.md             # Common issues and solutions
└── exercises/
    ├── basic/                         # Beginner exercises
    ├── intermediate/                  # Intermediate challenges
    └── advanced/                      # Advanced projects
```

---

## 🚀 Getting Started

1. **Clone this repository** to your local machine
2. **Install required tools**:
   - cURL (usually pre-installed on Linux/Mac)
   - jq JSON processor
   - Postman (desktop application)
3. **Follow along** with the instructional video
4. **Practice** with the provided examples
5. **Complete** the exercises to reinforce learning

### Tool Installation

**For Ubuntu/Debian:**

```bash
sudo apt update
sudo apt install curl jq
```

**For CentOS/RHEL:**

```bash
sudo yum install curl jq
```

**Postman:**

- Download from [postman.com](https://www.postman.com/downloads/)
- Install the desktop application

---

## 🔗 APIs Used in This Module

### 1. Dad Jokes API

- **URL**: `https://icanhazdadjoke.com/`
- **Purpose**: Learning basic API requests
- **Authentication**: None required
- **Response Format**: JSON/Plain text

### 2. Deck of Cards API

- **URL**: `https://deckofcardsapi.com/`
- **Purpose**: Working with stateful APIs and data persistence
- **Authentication**: None required
- **Response Format**: JSON

---

## 📝 Quick Reference

### Common HTTP Status Codes

- `200 OK` - Successful request
- `201 Created` - Resource created successfully
- `400 Bad Request` - Client error in request
- `401 Unauthorized` - Authentication required
- `404 Not Found` - Resource not found
- `500 Internal Server Error` - Server error

### Essential cURL Options

- `-X` : Specify HTTP method
- `-H` : Add headers
- `-d` : Send data (for POST requests)
- `-v` : Verbose output
- `-o` : Save output to file
- `-s` : Silent mode

### Useful jq Commands

- `.` : Pretty print JSON
- `.field` : Extract specific field
- `.[0]` : Get first array element
- `keys` : Show all keys in object

---

## 🎓 Learning Path

1. Start with the **examples/curl/basic/** directory
2. Progress through **documentation/http-reference.md**
3. Import **examples/postman/collections/** into Postman
4. Practice with **exercises/basic/** challenges
5. Advance to **exercises/intermediate/** and **exercises/advanced/**

---

## 🤝 Support

If you encounter issues:

1. Check the **documentation/troubleshooting.md** guide
2. Review the **examples/** for reference
3. Consult the course discussion board
4. Contact your instructor

---

## 📜 License

This educational content is provided under the terms specified in the LICENSE file.

---
