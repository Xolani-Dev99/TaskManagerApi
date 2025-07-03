FROM mcr.microsoft.com/dotnet/sdk:9.0-preview AS build
WORKDIR /app

# Copy csproj and solution files
COPY *.sln ./
COPY TaskManagerApi.csproj ./

RUN dotnet restore TaskManagerApi.csproj

# Copy app source only (exclude tests)
COPY . ./

RUN dotnet publish TaskManagerApi.csproj -c Release -o /app/out

FROM mcr.microsoft.com/dotnet/aspnet:9.0-preview AS runtime
WORKDIR /app

COPY --from=build /app/out .

ENTRYPOINT ["dotnet", "TaskManagerApi.dll"]
