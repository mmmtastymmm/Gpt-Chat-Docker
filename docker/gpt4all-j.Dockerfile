FROM ubuntu:22.10

# Apt get packages
RUN apt-get update
RUN apt-get install -y \
    build-essential \
    cmake \
    git \
    wget

# Grab a model
RUN mkdir models
WORKDIR models
RUN wget https://gpt4all.io/models/ggml-gpt4all-j.bin
# grab the text interface now and build it
WORKDIR /
RUN git clone --recurse-submodules https://github.com/kuvaus/LlamaGPTJ-chat && \
    cd LlamaGPTJ-chat && \
    mkdir build && \
    cd build && \
    cmake .. && \
    cmake --build . --parallel && \
    mv bin/chat /usr/local/bin && \
    cd ../.. && \
    rm -rf LlamaGPTJ-chat

ENTRYPOINT ["chat", "-m", "/models/ggml-gpt4all-j.bin", "-n", "500"]