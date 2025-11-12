# Switch to LangChain's Official Agent Chat UI

## Quick Setup

```bash
./USE_OFFICIAL_UI.sh
```

This will:
1. Replace the custom React UI with LangChain's official Next.js Agent Chat UI
2. Keep your x402 backend server
3. Backup your old files to `.backup/`

## Manual Setup

If you prefer to set it up manually:

```bash
# Create new official UI
npx create-agent-chat-app --project-name ../langchain-mcp-official-ui

# Or install in this directory
pnpm install next react react-dom
```

## What You Get

- Time-travel debugging
- State inspection
- Human-in-the-loop UI
- Tool visualization
- LangSmith integration

## Backend Compatibility

Your existing Express backend (`src/server.ts`) works but needs modification to match LangGraph's API format. 

Consider using `@langchain/langgraph` server instead for full compatibility.

