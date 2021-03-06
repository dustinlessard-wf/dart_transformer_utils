# Dart 1.24.2
FROM drydock-prod.workiva.net/workiva/smithy-runner-generator:179735 as build

# Build Environment Vars
ARG BUILD_ID
ARG BUILD_NUMBER
ARG BUILD_URL
ARG GIT_COMMIT
ARG GIT_BRANCH
ARG GIT_TAG
ARG GIT_COMMIT_RANGE
ARG GIT_HEAD_URL
ARG GIT_MERGE_HEAD
ARG GIT_MERGE_BRANCH
WORKDIR /build/
ADD . /build/
RUN echo "Starting the script sections" && \
		dart --version && \
		timeout 5m pub get && \
		pub run dependency_validator -i coverage,dart_style && \
		echo "Script sections completed"
ARG BUILD_ARTIFACTS_DART-DEPENDENCIES=/build/pubspec.lock
FROM scratch
