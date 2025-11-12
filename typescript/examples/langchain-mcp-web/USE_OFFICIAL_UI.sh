#!/bin/bash
# Script to replace custom UI with LangChain's official Agent Chat UI

set -e

echo "🔄 Setting up LangChain's official Agent Chat UI..."

# Create the official UI in a temp location
cd "$(dirname "$0")"
TEMP_DIR=$(mktemp -d)

echo "📦 Creating official Agent Chat UI..."
cd "$TEMP_DIR"
echo "pnpm" | npx -y create-agent-chat-app --project-name agent-ui

# Move it to our location
echo "📁 Replacing frontend..."
cd "$(dirname "$0")"

# Backup old files
mkdir -p .backup
mv src/App.tsx src/App.css src/main.tsx index.html vite.config.ts .backup/ 2>/dev/null || true

# Copy new UI
cp -r "$TEMP_DIR/agent-ui/"* ./

# Update package.json to combine both
echo "📝 Updating package.json..."
cat > package.json << 'EOF'
{
  "name": "@edgeandnode/langchain-mcp-official-ui",
  "description": "LangChain's Official Agent Chat UI with x402 MCP backend",
  "version": "0.1.0",
  "private": true,
  "type": "module",
  "scripts": {
    "dev": "concurrently \"npm run dev:server\" \"npm run dev:client\"",
    "dev:server": "tsx watch .backup/server.ts",
    "dev:client": "next dev",
    "build": "npm run build:server && npm run build:client",
    "build:server": "tsc .backup/server.ts --outDir dist/server",
    "build:client": "next build",
    "start": "concurrently \"node dist/server/server.js\" \"next start\"",
    "lint": "next lint"
  },
  "dependencies": {
    "@edgeandnode/ampersend-sdk": "workspace:^",
    "@langchain/core": "^0.3.29",
    "@langchain/langgraph": "^0.2.30",
    "@langchain/mcp-adapters": "^1.0.0",
    "@langchain/openai": "^1.0.0",
    "@modelcontextprotocol/sdk": "github:edgeandnode/mcp-typescript-sdk#2de06543904483073d8cc13db1d0e08e16601081",
    "cors": "^2.8.5",
    "dotenv": "^16.6.1",
    "express": "^4.18.2",
    "langchain": "^0.3.9",
    "next": "latest",
    "react": "^18.2.0",
    "react-dom": "^18.2.0"
  },
  "devDependencies": {
    "@types/cors": "^2.8.17",
    "@types/express": "^4.17.21",
    "@types/node": "^20",
    "@types/react": "^18",
    "@types/react-dom": "^18",
    "concurrently": "^8.2.2",
    "tsx": "^4.20.5",
    "typescript": "^5"
  }
}
EOF

# Cleanup
rm -rf "$TEMP_DIR"

echo "✅ Done! Your backend is in .backup/server.ts"
echo "   The frontend is now LangChain's official Agent Chat UI"
echo ""
echo "Next steps:"
echo "  1. pnpm install"
echo "  2. pnpm dev"
echo "  3. Configure the UI to connect to http://localhost:3001"

