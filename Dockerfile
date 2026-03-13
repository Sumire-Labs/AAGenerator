# Stage 1: Build Flutter web app
FROM ghcr.io/cirruslabs/flutter:stable AS build

WORKDIR /app
COPY pubspec.yaml pubspec.lock ./
RUN flutter pub get

COPY . .
RUN flutter build web --release

# Stage 2: Serve with Apache httpd
FROM httpd:alpine

COPY --from=build /app/build/web/ /usr/local/apache2/htdocs/

EXPOSE 80
