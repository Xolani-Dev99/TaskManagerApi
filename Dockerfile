# Stage 1: Build
FROM mcr.microsoft.com/dotnet/sdk:9.0-preview AS build
WORKDIR /app

# Copy only main project and solution files
COPY *.sln ./
COPY TaskManagerApi.csproj ./

RUN dotnet restore TaskManagerApi.csproj

# Copy everything else
COPY . ./

# Publish only the main API project
RUN dotnet publish TaskManagerApi.csproj -c Release -o /app/out

# Stage 2: Runtime
FROM mcr.microsoft.com/dotnet/aspnet:9.0-preview AS runtime
WORKDIR /app

COPY --from=build /app/out .

ENTRYPOINT ["dotnet", "TaskManagerApi.dll"]
