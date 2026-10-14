# ServerBuddy — Hackathon Submission

**Code repository:** https://github.com/vim719/ServerBuddy
**Live app (talk to Anna):** https://serverbuddy.serverpod.space
**Showcase page:** https://vim719.github.io/ServerBuddy/
**Demo video:** <paste YouTube/Loom link, max 2 min>

## Project description

ServerBuddy is a real-time voice companion named **Anna**. You talk to her out loud in the browser; she answers in about a second, searches the live web when she needs fresh facts, and remembers you between calls. Tell her your name and your next call picks up where the last one left off.

**How it uses Serverpod:** The whole backend is a Serverpod 4 server written in Dart, hosted on **Serverpod Cloud**.
- An `AgentEndpoint` replaces the original Python service. `getConfig` mints Agora AccessToken2 voice tokens in pure Dart; a unit test checks them byte-for-byte against Agora's official SDK. `startAgent` launches Anna's voice pipeline (speech-to-text → LLM → text-to-speech) through Agora's Conversational AI REST API. `stopAgent` saves the conversation and ends the call.
- Anna's memory uses Serverpod models: `ConversationMemory` (a table with a `List<MemoryTurn>` field) is read with `ConversationMemory.db` and re-injected into her prompt on the next call. Updates run inside a database transaction. Running agents are tracked in an `AgentSession` table, so a call can still be ended and remembered after a server restart.
- API keys are Serverpod passwords (`passwords.yaml` locally, `scloud password set` in the cloud), so they never reach the client. Schema changes ship as Serverpod migrations.

**How it uses Flutter:** The app is a Flutter web app served by Serverpod.
- It calls the server through the generated, type-safe client: `client.agent.getConfig()`, `client.agent.startAgent(...)`, `client.agent.stopAgent(...)`. There is no hand-written REST code.
- The "Meet Anna" screen, the voice orb that reacts to Anna's and your voice levels, the live transcript, and the mute and end-call controls are all Flutter widgets.
- Audio streaming uses Agora's browser SDK through a small `dart:js_interop` bridge.

Dart runs end to end, from the Postgres tables to the call screen. One `serverpod start` runs the full stack locally, and one `serverpod cloud launch` deploys it.

## 2-minute demo script

1. (0:00–0:15) The showcase page: "Meet Anna", Serverpod top-left and bottom-right, Flutter in the footer. Click "Talk to Anna live".
2. (0:15–1:00) Enter your name and start the conversation. Anna greets you; tell her something about yourself and ask a current-events question (she searches the web). Point out the live transcript and voice orb.
3. (1:00–1:25) End the call, start a new one with the same name. Anna remembers you.
4. (1:25–1:50) Show `agent_endpoint.dart`, `conversation_memory.spy.yaml`, and `client.agent.startAgent` in the Flutter code.
5. (1:50–2:00) Show the Serverpod Cloud Console logs: `agent.startAgent` and `agent.stopAgent`.
