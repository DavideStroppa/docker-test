FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build

WORKDIR /src

COPY ["HelloWorld/HelloWorld.csproj", "HelloWorld/"]

RUN dotnet restore "HelloWorld/HelloWorld.csproj"

COPY . .

WORKDIR /src/HelloWorld

RUN dotnet publish "HelloWorld.csproj" -c Release -o /app/publish /p:UseAppHost=false

FROM mcr.microsoft.com/dotnet/runtime:8.0

WORKDIR /app

COPY --from=build /app/publish .

ENTRYPOINT ["dotnet", "HelloWorld.dll"]
