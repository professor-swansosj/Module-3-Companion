# Module 3 Companion - Introduction to APIs and HTTP

## Software Defined Networking Course

> **Welcome to Your API Learning Journey!** This is a **companion lab** for your graded assignment. The more you practice here, the easier your graded lab will be! This repository is designed for experimentation - try things, break things, and learn from them.

## 🎯 What You'll Practice

Think of APIs as "digital messengers" that let different computer programs talk to each other. Just like how you might call a restaurant to order food, programs use APIs to request information or services from other programs.

In this module, you'll learn to:

- 🗣️ **Speak the language of the internet** - Understand how web services communicate
- 🔧 **Use powerful tools** - Master cURL and Postman for API interactions  
- 🎯 **Make real requests** - Get jokes and play card games through APIs
- 📊 **Handle responses** - Work with the data that comes back
- 🔗 **Chain operations** - Use results from one request in another

## 🌟 Why This Matters for Network Engineers

Modern networks aren't just cables and routers anymore. They're software-defined, automated, and programmable. APIs are how you'll:

- Configure network devices automatically
- Monitor network health and performance  
- Integrate different network tools and systems
- Build custom network management solutions

## 📋 Prerequisites

- Basic Linux command line usage
- Networking fundamentals (OSI model, TCP/IP)
- How web browsers work (you've used the internet!)
- **No programming experience required** - we'll start simple!

## 🚀 Quick Start - Make Your First API Call Right Now

Ready to try it? Let's get a joke from the internet using a single command:

```bash
curl https://icanhazdadjoke.com/
```

That's it! You just made your first API call. You should see a dad joke appear in your terminal.

**What just happened?** You asked the Dad Jokes API for a random joke, and it sent one back to you. This is exactly how apps on your phone get weather data, social media posts, or any other information from the internet.

## � Learning Path

### Phase 1: Understanding the Basics 🌱

Start here if you're new to APIs:

1. **[📖 What are APIs?](documentation/api-endpoints.md)** - Simple explanation of APIs and why they matter
2. **[🌐 HTTP Protocol Guide](documentation/http-reference.md)** - Learn the language of the web
3. **[🔧 First API Calls](examples/curl/01-basic-dadjokes.md)** - Make simple requests with cURL

### Phase 2: Hands-On Practice 🎯

Get your hands dirty with real APIs:

1. **[📝 Basic Exercises](exercises/basic/README.md)** - 10 guided exercises to build confidence
2. **[🃏 Stateful APIs](examples/curl/02-deck-of-cards.md)** - Learn about data persistence with card games
3. **[📝 Intermediate Exercises](exercises/intermediate/README.md)** - Complex scenarios and real-world patterns

### Phase 3: Professional Tools 🛠️

Learn industry-standard tools:

1. **[📮 Postman Basics](examples/postman/README.md)** - GUI tool for API development
2. **[📝 Advanced Exercises](exercises/advanced/README.md)** - Build complete applications

### Phase 4: Troubleshooting & Mastery 🚨

Become self-sufficient:

1. **[🔍 Troubleshooting Guide](documentation/troubleshooting.md)** - Fix common issues
2. **Practice Project** - Build your own API automation script

## � Table of Contents

### Documentation

- [HTTP Protocol Reference](documentation/http-reference.md) - Complete HTTP guide
- [API Endpoints Summary](documentation/api-endpoints.md) - Quick reference for our APIs  
- [Troubleshooting Guide](documentation/troubleshooting.md) - Solutions for common problems

### Examples & Tutorials

- [Basic Dad Jokes API](examples/curl/01-basic-dadjokes.md) - Simple GET requests
- [Deck of Cards API](examples/curl/02-deck-of-cards.md) - Stateful API interactions
- [Postman Collection](examples/postman/) - GUI-based API testing
- [Automation Scripts](examples/scripts/) - Complete working scripts

### Hands-On Exercises

- [Basic Exercises](exercises/basic/README.md) - 10 fundamental exercises
- [Intermediate Exercises](exercises/intermediate/README.md) - 12 advanced scenarios  
- [Advanced Exercises](exercises/advanced/README.md) - Real-world projects

### Sample Data

- [JSON Examples](sample-data/json/) - API response examples
- [CSV Data](sample-data/csv/) - Structured data samples
- [YAML Configs](sample-data/yaml/) - Configuration examples

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

## ⚙️ Setup Guide

### Step 1: Check What You Already Have

Most systems already have cURL installed. Let's check:

```bash
curl --version
```

If you see version information, you're ready for the Quick Start above! If not, follow the installation steps below.

### Step 2: Install Required Tools

**Ubuntu/Debian (Lab Environment):**

```bash
sudo apt update
sudo apt install curl jq
```

**CentOS/RHEL:**

```bash
sudo yum install curl jq
```

**Windows (PowerShell):**

```bash
# cURL comes with Windows 10+, but you can install jq:
winget install jqlang.jq
```

**MacOS:**

```bash
# cURL comes pre-installed, install jq:
brew install jq
```

### Step 3: Install Postman (Optional for Phase 3)

- Download from [postman.com](https://www.postman.com/downloads/)
- Install the desktop application
- **Note:** You don't need this immediately - focus on cURL first!

### Step 4: Verify Your Setup

Test that everything works:

```bash
# Test cURL
curl https://icanhazdadjoke.com/

# Test jq (should format the JSON nicely)
curl -s -H "Accept: application/json" https://icanhazdadjoke.com/ | jq
```

### Step 5: Start Learning

1. **Begin with the Quick Start** above to make your first API call
2. **Follow the Learning Path** in order
3. **Don't skip the basics** - they build on each other
4. **Practice, practice, practice** - run every command yourself

## 🎯 The APIs You'll Master

We use two fun, free APIs that teach real-world concepts without the complexity:

### 🤡 Dad Jokes API - Your First Friend

**Why start here?**

- **Simple**: Just ask for a joke, get a joke
- **Forgiving**: Hard to make mistakes  
- **Immediate results**: You'll see the response right away
- **No authentication**: Nothing to configure or break

**Try it now:**

```bash
curl https://icanhazdadjoke.com/
```

**What you'll learn:** Basic GET requests, headers, JSON responses, error handling

### 🃏 Deck of Cards API - Level Up Challenge  

**Why this matters for networking:**

- **Stateful operations**: Like network sessions that persist
- **Resource management**: Create, use, and manage resources (like VLANs)
- **Data persistence**: Results from one operation affect the next
- **Real-world patterns**: Similar to managing network device configurations

**Try it:**

```bash
# Create a deck (like creating a VLAN)
curl https://deckofcardsapi.com/api/deck/new/shuffle/
```

**What you'll learn:** Complex workflows, chaining requests, managing state

## 🎖 Quick Reference

### HTTP Status Codes (What the numbers mean)

- `200 OK` - ✅ Success! Everything worked
- `404 Not Found` - ❌ Wrong URL or resource doesn't exist
- `401 Unauthorized` - 🔒 Need to authenticate (like a password)  
- `429 Too Many Requests` - ⏱️ Slow down! You're asking too fast
- `500 Internal Server Error` - 💥 Server problem (not your fault)

### Essential cURL Commands

```bash
# Basic request
curl https://api.example.com/data

# Get JSON formatted nicely  
curl -s https://api.example.com/data | jq

# See what's happening (verbose)
curl -v https://api.example.com/data

# Save response to file
curl -o response.json https://api.example.com/data
```

### Useful jq Tricks

```bash
# Pretty print any JSON
... | jq

# Get just one field
... | jq '.joke'

# Get field without quotes
... | jq -r '.joke'

# Get first item from array
... | jq '.[0]'
```

## 💡 Learning Tips for Success

### Before You Start

- **Don't rush** - Take time to understand each concept
- **Type commands yourself** - Don't just copy/paste
- **Read error messages** - They usually tell you what's wrong
- **Experiment** - Try variations of the examples

### When You Get Stuck

1. **Check the [Troubleshooting Guide](documentation/troubleshooting.md)**
2. **Re-read the examples** - Make sure you're following them exactly
3. **Use verbose mode** (`curl -v`) to see what's happening
4. **Ask for help** - Use the course discussion board

## 🎉 Ready to Begin Your API Journey?

Remember, this is your **practice arena**. The more you experiment here, the easier your graded lab will be!

### Start Right Now

1. **Make sure your setup works**: Run the Quick Start command above
2. **Begin Phase 1**: Start with the [Basic Exercises](exercises/basic/README.md)
3. **Don't skip around**: Each section builds on the previous one
4. **Have fun**: APIs are powerful and exciting once you get the hang of them!

### After This Module

You'll be ready to:

- Automate network configurations using REST APIs
- Integrate different network management tools
- Build custom monitoring and alerting systems
- Work with modern SDN controllers and cloud platforms
- Understand how network automation tools like Ansible work under the hood

### Get Help When You Need It

- **[Troubleshooting Guide](documentation/troubleshooting.md)** - Fix common issues yourself
- **Course Discussion Board** - Ask questions and help classmates  
- **Office Hours** - Get one-on-one help from your instructor
- **Study Groups** - Practice together with fellow students

## 📜 License

This educational content is provided under the terms specified in the LICENSE file.

**🚀 Ready? Let's make your first API call and start this journey!**
