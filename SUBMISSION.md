# ServerBuddy — Hackathon Submission

**Code repository:** https://github.com/vim719/ServerBuddy
**Live app:** https://serverbuddy.serverpod.space (API: https://serverbuddy.api.serverpod.space)
**Demo video:** <paste YouTube/Loom link, max 2 min>

## Project description

ServerBuddy is a voice companion named **Anna** that talks with you in real time, researches the live web, and gives cited stock and crypto "market pulse" outlooks. What makes Anna feel like a buddy rather than a chatbot is **long-term memory**: she remembers what you tell her between conversations.

**How it uses Serverpod:** Anna's memory runs on a Serverpod 4 backend. A `Memory` model defined in `memory.spy.yaml` (`table: memories`) becomes a shared, type-safe Dart class plus a generated ORM (`Memory.db`) backed by Postgres. A `MemoryEndpoint` exposes `remember`, `getMemories` and `forget`, which insert, query (newest first), and delete rows with `Memory.db.insertRow / find / deleteRow`. Schema changes ship as versioned Serverpod migrations. The server, its managed Postgres database, and the Flutter web build are all deployed with `serverpod cloud launch` on **Serverpod Cloud**.

**How it uses Flutter:** The `serverbuddy_flutter` app calls the backend through the generated client (`client.memory.remember(...)`, `client.memory.getMemories()`), with no REST code or JSON handling written by hand. It shows your saved memories in a list, lets you add new ones or forget old ones, and adapts its layout for phone and desktop. The same codebase targets web, iOS, Android and desktop.

The stack is Dart from database to UI: the endpoint signatures on the server are the API contract, and if they change, the Flutter app gets a compile-time error rather than a runtime bug.

## 2-minute demo script

1. (0:00–0:15) Landing page: Serverpod branding top-left and bottom-right, "Built with Flutter" footnote. "This is ServerBuddy, Anna, a voice companion with memory."
2. (0:15–0:45) Talk to Anna briefly; show the Market Pulse page.
3. (0:45–1:20) Open the Flutter app at the serverpod.space URL. Type "I prefer morning market briefings" and click Remember. It appears in the list. Reload the page: it is still there, loaded from Postgres.
4. (1:20–1:45) Show `memory.spy.yaml` and `memory_endpoint.dart`, then the `client.memory.remember` call in Flutter.
5. (1:45–2:00) Show the Serverpod Cloud Console Logs/Sessions tab and the deploy command.
