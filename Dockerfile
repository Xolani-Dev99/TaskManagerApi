# Stage 1: Restore and build
FROM mcr.microsoft.com/dotnet/sdk:9.0-preview AS build
WORKDIR /app

# Copy only project files and restore
COPY *.sln ./
COPY TaskManagerApi/*.csproj ./TaskManagerApi/
RUN dotnet restore TaskManagerApi/TaskManagerApi.csproj

# Copy everything else and publish
COPY . .
WORKDIR /app/TaskManagerApi
RUN dotnet publish -c Release -o /app/out

# Stage 2: Runtime
FROM mcr.microsoft.com/dotnet/aspnet:9.0-preview AS runtime
WORKDIR /app
COPY --from=build /app/out .

ENTRYPOINT ["dotnet", "TaskManagerApi.dll"]
