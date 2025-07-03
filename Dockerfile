# Base image for runtime
FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS base
WORKDIR /app
EXPOSE 80

# Build stage
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /src

# Copy solution and project files
COPY TaskManagerApi.sln ./
COPY TaskManagerApi/TaskManagerApi.csproj TaskManagerApi/

# Restore dependencies (cached if no .csproj changes)
RUN dotnet restore TaskManagerApi.sln

# Copy the rest of the source code
COPY . .

# Publish the application
RUN dotnet publish TaskManagerApi.sln -c Release -o /app/publish

# Final stage
FROM base AS final
WORKDIR /app
COPY --from=build /app/publish .

ENTRYPOINT ["dotnet", "TaskManagerApi.dll"]
