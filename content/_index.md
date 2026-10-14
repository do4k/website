---
title: Home
type: landing
design:
  spacing: "4rem"
sections:
  - block: hero
    content:
      eyebrow: "Software Engineer · Bristol, UK"
      title: "Dan Oak"
      text: "Notes on AI coding agents, .NET, event-driven systems, and what it actually
        takes to ship software — straight from the production trenches."
      primary_action:
        text: "Read the blog"
        url: "/blog/"
        icon: "article"
      secondary_action:
        text: "GitHub"
        url: "https://github.com/do4k"
        icon: "brands/github"
    design:
      css_class: "hb-hero"
      spacing:
        padding: ["6rem", 0, "4rem", 0]
  - block: collection
    id: latest
    content:
      title: "Latest Posts"
      text: "Long-form write-ups, conference notes, and engineering deep dives."
      count: 6
      filters:
        folders:
          - blog
    design:
      view: article-grid
      columns: 2
      spacing:
        padding: ["2rem", 0, "4rem", 0]
---
