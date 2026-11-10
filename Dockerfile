FROM ubuntu:24.04

ENV DEBIAN_FRONTEND=noninteractive

# Install system dependencies
RUN apt-get update && apt-get install -y \
    software-properties-common \
    build-essential \
    cmake \
    ninja-build \
    git \
    pkg-config \
    ca-certificates \
    libasound2-dev \
    libpulse-dev \
    libx11-dev \
    libxext-dev \
    libxrandr-dev \
    libxcursor-dev \
    libxfixes-dev \
    libxi-dev \
    libxinerama-dev \
    libxss-dev \
    libxtst-dev \
    libxkbcommon-dev \
    libdrm-dev \
    libgbm-dev \
    libgl1-mesa-dev \
    libgles2-mesa-dev \
    libegl1-mesa-dev \
    libdbus-1-dev \
    libibus-1.0-dev \
    libudev-dev \
    libwayland-dev \
    libdecor-0-dev \
    && rm -rf /var/lib/apt/lists/*

# Install GCC 15
RUN add-apt-repository -y ppa:ubuntu-toolchain-r/test \
    && apt-get update \
    && apt-get install -y gcc-15 g++-15 \
    && rm -rf /var/lib/apt/lists/*

# Make gcc default to GCC 15 with C23
RUN printf '#!/bin/sh\nexec /usr/bin/gcc-15 -std=c23 "$@"\n' \
    > /usr/local/bin/gcc \
    && chmod +x /usr/local/bin/gcc

# Build and install SDL3
RUN git clone --depth 1 \
    https://github.com/libsdl-org/SDL.git /tmp/SDL \
    && cmake -S /tmp/SDL -B /tmp/SDL/build \
        -DCMAKE_BUILD_TYPE=Release \
        -DSDL_SHARED=ON \
        -DSDL_STATIC=OFF \
    && cmake --build /tmp/SDL/build --parallel 2 \
    && cmake --install /tmp/SDL/build \
    && rm -rf /tmp/SDL \
    && ldconfig

ENV PKG_CONFIG_PATH=/usr/local/lib/pkgconfig:/usr/local/lib/x86_64-linux-gnu/pkgconfig
ENV LD_LIBRARY_PATH=/usr/local/lib:${LD_LIBRARY_PATH}

WORKDIR /workspace

CMD ["sleep", "infinity"]
