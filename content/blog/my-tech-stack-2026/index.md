---
title: "My Tech Stack in 2026: Evolution of a C# Developer"
date: 2026-01-16
draft: false
tags: ["Tech Stack", "Development Tools", "C#", "React", "Golang", "AI", "Hugo"]
categories: ["Development", "Tools"]
ShowReadingTime: true
ShowBreadCrumbs: true
ShowPostNavLinks: true
ShowWordCount: true
---

The tools we use define how we work. As we step into 2026, I thought it would be interesting to document the technologies and tools that power my day-to-day development work. This is my current tech stack—a mix of familiar friends and exciting new additions.

## Programming Languages

### C# - My Reliable Companion

C# remains my primary programming language and has been for years. There's something incredibly satisfying about the robustness of the .NET ecosystem and the elegance of modern C#. Whether I'm building APIs, working with Entity Framework, or leveraging LINQ for data manipulation, C# continues to be my go-to language for getting things done.

The language has evolved beautifully over the years. Features like records, pattern matching, and nullable reference types have made the codebase I work with more expressive and safer. The performance improvements in recent .NET versions are nothing short of impressive, and the cross-platform story with .NET is now genuinely solid.

### JavaScript & React

On the frontend, JavaScript paired with React is my framework of choice. React's component-based architecture just makes sense to me—it's predictable, maintainable, and the ecosystem is incredibly rich. The combination of hooks, context, and modern state management solutions has made building complex UIs surprisingly straightforward.

I appreciate how React has matured. The community is strong, the tooling is excellent, and there's almost always a library or pattern that can help solve whatever problem you're facing. Server components and the advancements in the React ecosystem keep things interesting.

### Golang - The New Adventure

2026 is the year I'm actively learning Go. This feels significant because it's a conscious move away from my beloved C#. Why Go? A few reasons:

- **Simplicity**: Go's philosophy of simplicity and explicit code is refreshing. There's usually one obvious way to do something.
- **Performance**: Go's performance characteristics are excellent, especially for network services and concurrent operations.
- **Industry Adoption**: More and more infrastructure tools are written in Go, and understanding the language helps me understand these tools better.
- **Career Growth**: Diversifying my skill set feels important. While C# will always be valuable, understanding different paradigms makes me a better engineer.

The learning curve has been interesting. Go's approach to error handling, its lack of traditional OOP features, and its emphasis on interfaces have forced me to think differently about problem-solving. It's uncomfortable in the best way possible.

## Development Environments

### JetBrains Rider - The Powerhouse

Rider has been my primary IDE for C# development, and it's an absolute beast. The combination of ReSharper's intelligent code analysis with a fast, modern IDE is unbeatable. Features like code inspections, refactoring tools, and the integrated debugging experience make working with large codebases manageable.

Rider's database tools, built-in terminal, and Git integration mean I rarely need to leave the IDE. It just works, and it works fast.

### Cursor IDE & CLI - The AI Revolution

But here's where things get interesting: in the age of AI agents, my workflow is shifting. I've been transitioning to a mixture of Cursor CLI and the Cursor IDE to tackle larger tasks using AI agents.

The traditional IDE experience is being augmented—and in some cases replaced—by AI-assisted development. When I have a big refactoring task, a complex feature to implement, or even when I'm exploring unfamiliar codebases, Cursor's AI capabilities significantly accelerate my work.

The Cursor CLI allows me to leverage AI agents from the command line, automating repetitive tasks and generating boilerplate code. The IDE itself integrates AI assistance directly into the editing experience, offering intelligent completions and code generation that goes beyond simple autocomplete.

This shift represents a fundamental change in how I work. I'm not just writing code anymore—I'm collaborating with AI to solve problems faster and more efficiently. It's powerful, occasionally humbling, and undeniably the future of software development.

## Hosting & Deployment

### Cloudflare Pages

I host my personal website on Cloudflare Pages, and it's been a fantastic experience. The integration with Git repositories means deployments are automatic—push to main, and the site updates. The global CDN ensures fast load times regardless of where visitors are located.

Cloudflare's free tier is incredibly generous, and the developer experience is smooth. Preview deployments for pull requests, custom domains, and SSL certificates all work seamlessly out of the box.

### Hugo - Static Site Generation

Speaking of my website, Hugo is the static site generator I use to build it. Hugo is written in Go (notice a pattern here?) and it's blazingly fast. The build times are measured in milliseconds, not seconds, which makes the development loop incredibly tight.

Hugo's templating system is powerful, the documentation is solid, and the ecosystem of themes and plugins is mature. For a blog or documentation site, Hugo hits the sweet spot between simplicity and capability.

The fact that I can write posts in Markdown, commit them to Git, and have them deployed to a global CDN within seconds is still impressive to me. It's simple, fast, and reliable—everything a personal site should be.

## Data Storage

### AWS DynamoDB

For data storage, I work with AWS DynamoDB every day. Moving from traditional relational databases to DynamoDB was a mindset shift—single-table design, partition keys, sort keys, and GSIs require thinking about data access patterns upfront rather than relying on flexible SQL queries.

DynamoDB's serverless nature means I don't worry about scaling, provisioning, or maintaining database servers. The performance is consistent, and the pay-per-use model aligns well with modern cloud economics. The learning curve was steep, but understanding NoSQL design patterns has made me a better architect.

## Testing Philosophy

### Custom Given-When-Then Frameworks with xUnit

Testing is where I've gotten opinionated. As a C# developer, xUnit is my testing framework of choice, but I've gone a step further—I've been writing my own Given-When-Then frameworks for my tests.

Inspired by [Andrew Poole's approach](https://forkinthecode.net/2023/07/18/given-when-then-helper-classes-for-component-tests.html) who I used to work with, I've built custom chaining frameworks that make component tests readable and maintainable. The pattern looks something like this:

```csharp
Given.UsingThe(Fixture).AUserExists()
    .And.AProductInTheDatabase();

When.UsingThe(Fixture).TheUserPurchasesTheProduct();

Then.UsingThe(Fixture).TheOrderIsCreated()
    .And.TheInventoryIsUpdated();
```

There's something incredibly satisfying about tests that read like specifications. The Given-When-Then pattern forces you to think clearly about test setup, action, and assertion. Building custom helpers for this pattern means tests become self-documenting—new team members can understand what's being tested without diving deep into implementation details.

It's more work upfront, but the payoff in test maintainability and readability is substantial. When tests are easy to read, they're easier to trust, and when they fail, they communicate exactly what went wrong.

## Version Control & CI/CD

### GitHub & GitHub Actions

Version control is Git, hosted on GitHub. No surprises there—GitHub has become the de facto standard for code hosting, and for good reason. The platform is stable, the integrations are extensive, and the social aspects (PRs, code reviews, discussions) are well-designed.

For CI/CD, GitHub Actions has become my automation tool of choice. The YAML-based workflow definitions live right next to the code, and the marketplace of pre-built actions means I can compose complex pipelines without reinventing the wheel. Whether it's running tests, building Docker images, or deploying to cloud providers, GitHub Actions handles it elegantly.

The fact that I can trigger workflows on any GitHub event—push, PR, release, schedule, or even manual dispatch—gives incredible flexibility. Combined with matrix builds for testing across multiple configurations, it's a powerful platform.

## What This Stack Says About Me

Looking at this list, a few themes emerge:

- **Pragmatism**: I choose tools that work and get out of my way. I'm not chasing trends—I'm using what's proven.
- **Performance**: Whether it's Hugo's build speed, Go's runtime performance, or Cloudflare's CDN, I value tools that are fast.
- **Evolution**: I'm not stuck in my ways. I'm learning Go, adopting AI-assisted development, and exploring new paradigms.
- **Full-Stack**: From backend C# APIs to React frontends, from Hugo static sites to AI-powered development—I'm comfortable across the stack.
- **Quality Obsessed**: Building custom testing frameworks shows I care deeply about code quality and maintainability.

## Looking Forward

Technology never stands still. By this time next year, this list will undoubtedly look different. Maybe Go will have become as natural to me as C#. Maybe Cursor and AI-assisted development will have completely replaced traditional IDEs. Maybe I'll have added a new language or framework to my toolkit.

That's what makes this industry exciting—there's always something new to learn, always a better way to solve old problems, always evolution.

What's your tech stack in 2026? Are you exploring new languages? Have you embraced AI-assisted development? I'd love to hear about your journey.

Until next time, happy coding!