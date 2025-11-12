# LangChain Official Agent Chat UI + x402 MCP

Uses LangChain's official Agent Chat UI (Next.js) with our x402-enabled MCP backend.

## Setup

```bash
# 1. Install dependencies
pnpm install

# 2. Create the official UI
pnpm setup

# 3. Set environment variables
cp .env.example .env
# Edit .env with your values

# 4. Run everything
pnpm dev
```

## Architecture

```
LangChain Official UI (Next.js - Port 3000)
    ↓ Connect via UI
Express Backend (Port 3001)
    ↓ x402 + LangChain
MCP Server (x402 enabled)
```

## Features from Official UI

- ✅ Time-travel debugging
- ✅ State inspection  
- ✅ Human-in-the-loop
- ✅ Tool visualization
- ✅ LangSmith integration

## Configuration

In the UI, connect to:
- **Deployment URL**: `http://localhost:3001`
- **Graph ID**: Your agent name

The backend automatically handles x402 payments via NaiveTreasurer.

