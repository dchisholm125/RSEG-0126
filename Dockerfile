# ORIGINAL DOCKERFILE

# # syntax=docker/dockerfile:1.4

# # build the docker container
# FROM ubuntu:latest AS build

# # install Java compiler
# RUN apt-get update && apt-get install -y openjdk-17-jdk

# # create root working directory
# WORKDIR /app

# # bind mount the source code and compile it inside the container
# RUN --mount=type=bind,source=./sieve,target=/sieve \
# 	javac /sieve/Sieve.java -d /app

# # test run inside build container by providing an input)
# RUN echo 100 | java -cp /app Sieve


# # run the program
# FROM ubuntu:latest AS run

# # install only the Java runtime
# RUN apt-get update && apt-get install -y openjdk-17-jre

# WORKDIR /app

# # copy compiled class files from build stage
# COPY --from=build /app /app

# ENTRYPOINT ["java", "-cp", "/app", "Sieve"]



##### MINIMAL IMPLEMENTATION BELOW #####

# eclipse-temurin is a "slim" OpenJDK distribution.
FROM eclipse-temurin:17-jdk-focal AS build

# create root working directory
WORKDIR /app

# copy just the source file
COPY ./sieve/Sieve.java .

# Compile the Java code. No need for a bind mount.
RUN javac Sieve.java


# use a "distroless" image that only contains the Java runtime.
FROM gcr.io/distroless/java17-debian11 AS run

# create root working directory
WORKDIR /app

# copy ONLY the compiled .class file from the build stage.
COPY --from=build /app/Sieve.class .

# set the entrypoint to run the application.
ENTRYPOINT ["java", "Sieve"]
