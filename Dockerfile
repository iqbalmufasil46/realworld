FROM node:18
WORKDIR /app

# Install pnpm globally
RUN npm install -g pnpm

# Copy only the workspace configuration and dependency files
COPY package.json pnpm-lock.yaml pnpm-workspace.yaml ./

# Copy workspace-specific package.json for apps/documentation
COPY apps/documentation/package.json ./apps/documentation/

# Install all dependencies, ensuring workspace dependencies are resolved
RUN pnpm install --frozen-lockfile

# Copy the entire project
COPY . .

# Build all workspaces
RUN pnpm build

# Set the default command to run the dev environment
CMD ["pnpm", "dev", "--", "--host", "0.0.0.0"]

EXPOSE 4321

