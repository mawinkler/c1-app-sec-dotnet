# https://hub.docker.com/_/microsoft-dotnet
FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build
WORKDIR /source

# copy csproj and restore as distinct layers
COPY *.sln .
COPY aspnetapp/*.csproj ./aspnetapp/
RUN dotnet restore

# copy everything else and build app
COPY aspnetapp/. ./aspnetapp/
WORKDIR /source/aspnetapp
RUN dotnet publish -c release -o /app --no-restore

# final stage/image
FROM mcr.microsoft.com/dotnet/aspnet:6.0
WORKDIR /app
COPY --from=build /app ./

# Application Security
RUN mkdir -p /usr/local/trend_app_protect_netcore/bin
COPY bin /usr/local/trend_app_protect_netcore/bin
COPY TrendAppProtect.config /usr/local/

ENV CORECLR_ENABLE_PROFILING=1
ENV CORECLR_PROFILER={a51743a9-9e05-4a9f-adcd-d39aa322615a}
ENV CORECLR_PROFILER_PATH=/usr/local/trend_app_protect_netcore/bin/libTrendAppProtectProfiler-x64-Linux.so
ENV TREND_AP_CONFIG_FILE=/usr/local/TrendAppProtect.config
ENV TREND_AP_LOG_FILE=/trend_app_protect.log
ENV TREND_AP_LOG_LEVEL=debug
ENV TREND_AP_HELLO_URL=https://agents.trend-us-1.application.cloudone.trendmicro.com/
# /Application Security

ENTRYPOINT ["dotnet", "aspnetapp.dll", "-v", "d"]