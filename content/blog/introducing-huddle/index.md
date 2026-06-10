---
title: "Introducing Huddle: A Family Trip Planner I Vibe Coded on My Phone"
date: 2026-06-09
draft: false
tags: ["Side Project", "Next.js", "SQLite", "Raspberry Pi", "Self-Hosting", "Vibe Coding", "Claude"]
categories: ["Development", "Side Projects", "Self-Hosting"]
---

I've been quietly building something on my phone over the past few months. Not in dedicated engineering sessions at a proper desk, but in stolen moments — commuting, or when I'm out somewhere and can't get my laptop out. The result is **Huddle**, a family trip planning app that I'm using right now to organise our holiday to the Isle of Wight this summer.

The whole thing was largely vibe coded with the Claude mobile app. That's not a humble brag or a disclaimer — it's genuinely how it happened. I'd have an idea, describe it conversationally, and the code would materialise. I'd test it on my phone, point out what was wrong, and we'd iterate. It felt less like engineering and more like a long, productive conversation with a capable collaborator who happened to be very good at Next.js.

## What Is Huddle?

Huddle is a collaborative trip planner built around a shared **activity bank**. Everyone in your group can suggest activities, RSVP, schedule things, track costs, and export their personal itinerary as a PDF.

Right now I'm using it to plan a trip to the Isle of Wight for late June with my sister Katie — we're staying at The Lakes Rookley and I've been adding activities as I find them.

{{< figure src="trip-view.png" alt="Huddle trip view showing Isle of Wight 2026 with the activity bank" >}}

The trip view shows:
- A cover photo and destination pulled from Google Maps
- Trip dates and a short description
- Everyone in your huddle (my sister Katie is on this one)
- A tabbed interface: Activities, Schedule, My plans, Costs, Travel, Map

## The Activity Bank

The activity bank is where the real work happens. Each activity can have:

- A title and rich-text description
- A location with autocomplete (powered by Geoapify)
- A website URL with a live OG link preview — so you can drop in a booking page and it pulls the title, image, and site name automatically
- A scheduling status: **Proposed** or **Scheduled**
- RSVP responses (yes / no / maybe) per member, with avatar stacks
- Pricing tiers with age bands (adult, child, senior, with min/max ages)
- Flags for "carers go free", "requires booking", and "free entry"
- A "I've booked this" confirmation per person, again with avatar stacks
- Comments from any huddle member

There's also a **place search** that lets you search for things to do near the trip destination — restaurants, beaches, attractions, parks — and add them straight to the bank with the location pre-filled. It pulls from Geoapify's places API and surfaces results as category pills you can browse.

The **Schedule tab** groups confirmed activities by calendar day with a date picker constrained to the trip window. The **My plans tab** shows only activities you've RSVPed yes to, which you can export as a PDF — useful for the day itself when you're offline or just want a clean view.

**Costs** tracks the per-member breakdown across all priced activities in the trip, accounting for party member ages and carer flags.

## The Tech Stack

The stack is deliberately boring and self-contained:

| Layer | Technology |
|---|---|
| Framework | Next.js 16 (App Router, Server Actions) |
| Database | SQLite via Prisma 7 + better-sqlite3 |
| Auth | Email + bcrypt + iron-session |
| UI | shadcn/ui + Tailwind CSS v4 |
| Rich text | Tiptap |
| Maps | Leaflet.js |
| Geolocation & places | Geoapify (free tier, 3,000 req/day) |
| PDF export | @react-pdf/renderer |
| Drag & drop | @dnd-kit |

**No third-party auth**. No NextAuth, no Clerk, no OAuth. Just an email, a hashed password, and a session cookie. It felt right to keep everything under one roof, and it made the whole auth flow something I could reason about entirely.

**SQLite** was a deliberate choice. I didn't want to manage a separate database server for a personal app. A single file on disk, Prisma keeping the schema in check, and a nightly backup — that's the entire persistence story. For the scale I'm running (a handful of trips, a few dozen activities, a couple of users), SQLite is more than capable and it's trivially simple to back up or move.

The geo API responses are cached in a SQLite table too, keyed by a SHA-256 hash with a 7-day TTL, so repeated place lookups don't burn through the free tier allowance.

## It Lives on a Raspberry Pi

Huddle is hosted on my Raspberry Pi at home, running behind a **Cloudflare Tunnel**. The Pi runs the app as a `systemd` service, Next.js serves it directly, and the SQLite database lives on the Pi's SD card.

The Cloudflare Tunnel means I don't need to open any ports on my router. Traffic goes Cloudflare edge → Tunnel daemon → local Next.js process. SSL, DDoS protection, and a proper domain come for free with no configuration on my end.

It's genuinely pleasant to self-host something this simple. Cold starts are fast, there's no cloud bill, and I have full control over the data. The trip invite link system means I can share a trip with family without them needing an account on the system — they click the link, register, and they're in. The link shows a branded preview with the trip name and cover photo when shared in iMessage or WhatsApp.

## If You Wanted to Productionise It

Running this on a Pi at home is fine for personal use. If you wanted to open it up to more users, here's how I'd approach it:

### 1. Swap SQLite for a hosted database

SQLite is single-writer by design, which is fine for a household app but becomes a bottleneck under concurrent load. The Prisma schema is clean — migrating to Postgres would largely be changing `provider = "postgresql"` in the Prisma config, adding a connection string, and running migrations.

Reasonable options:
- **Neon** — serverless Postgres with a generous free tier and pooling built in
- **Supabase** — Postgres plus storage and auth if you want to swap those out too
- **Railway** — very clean deploy experience for Postgres alongside a Next.js app

### 2. Move file storage off local disk

Cover photos currently land on the Pi's filesystem. At scale you'd point the upload route at object storage instead:

- **Cloudflare R2** — S3-compatible, no egress fees, pairs naturally if you're already in the Cloudflare ecosystem
- **AWS S3 + CloudFront** — the battle-tested option

The upload API route would swap from writing to disk to putting objects into a bucket, and the image URLs would point to the CDN.

### 3. Containerise it

The app currently runs as a bare Node process. Dockerising it makes deployment reproducible:

```dockerfile
FROM node:22-alpine
WORKDIR /app
COPY . .
RUN npm ci && npm run build
CMD ["node", "server.js"]
```

Add a `docker-compose.yml` with a volume mount for the SQLite file and you can spin the whole thing up anywhere, including a cheap VPS.

### 4. Add backup automation

Right now it's a manual task. A cron job that runs:

```bash
sqlite3 huddle.db ".backup /backups/huddle-$(date +%Y%m%d).db"
```

and rsyncs the backup directory to cloud storage (Backblaze B2, a private S3 bucket, wherever) is the minimum. If you switch to Postgres, the managed providers handle point-in-time recovery for you.

### 5. Rate limiting and abuse protection

The invite link system is deliberately open — anyone with a link can register. In a personal setup that's fine (you control who gets the link). For a public-facing deployment you'd want rate limiting on registration and some kind of abuse reporting. Cloudflare's WAF rules or a small middleware layer would handle this.

## What's Next

I'll be sharing more screenshots as the Isle of Wight trip comes together — the schedule view once we've pinned down timings, the costs breakdown across the party, and the PDF export Katie and I will each pull down on the day.

The code is in a private repo for now. If there's interest in it as a properly self-hostable project — a Docker image, a clean setup guide, maybe eventually a hosted option — I'd be happy to open it up.

---

*Built largely on my phone with Claude. Runs on a Pi in my living room. Vibe coding at its finest.*
