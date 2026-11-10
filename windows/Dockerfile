FROM ubuntu:26.10

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y \
    git \
    build-essential \
    mingw-w64 \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /workspace

# Verify cross-compilers
RUN i686-w64-mingw32-gcc --version && \
    x86_64-w64-mingw32-gcc --version

# Verify required compiler options and CRT libraries
RUN printf 'int main(void) { return 0; }\n' | \
    i686-w64-mingw32-gcc \
    -x c -std=gnu23 -mcrtdll=msvcrt-os \
    -o /tmp/test32.exe - && \
    printf 'int main(void) { return 0; }\n' | \
    x86_64-w64-mingw32-gcc \
    -x c -std=gnu23 -mcrtdll=msvcrt-os \
    -o /tmp/test64.exe -

CMD ["/bin/bash"]
