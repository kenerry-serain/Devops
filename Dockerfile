FROM microsoft/dotnet:2.1-sdk-alpine AS build-env
WORKDIR /app
EXPOSE 80
COPY . ./
RUN dotnet restore Devops.API/Devops.API.csproj
WORKDIR /app/Devops.API/ 
RUN dotnet publish -c Release -o out

FROM microsoft/dotnet:2.1-aspnetcore-runtime-alpine
WORKDIR /app
COPY --from=build-env /app/Devops.API/out . 
ENTRYPOINT ["dotnet", "Devops.API.dll"]