FROM alpine
LABEL maintainer="Soflane <dev@ayoute.be>"
RUN apk add --update --no-cache git \
            py3-pip go make musl-dev \
            nano bash curl libcurl ncurses \
            ruby ruby-dev libffi-dev gcc zlib-dev procps sqlite-dev
# Add go modules to PATH 
ENV PATH="${PATH}:/root/go/bin"

# Install Mosint
RUN go install -v github.com/alpkeskin/mosint@latest
  
# Install Nexfil 
RUN git clone https://github.com/thewhiteh4t/nexfil.git /tools/nexfil 
RUN pip install --upgrade setuptools wheel aiohttp frozenlist multidict yarl
RUN chmod -R 751 /tools ;\
    mkdir /output  
RUN sed -i 's#loc_data =.*#loc_data = '\'/output/\''#' /tools/nexfil/nexfil.py
RUN mkdir -p /root/.local/share/nexfil/
RUN pip3 install -r /tools/nexfil/requirements.txt 
ENV PATH="${PATH}:/tools/nexfil"

# Install wpscan 
RUN gem install wpscan


VOLUME [ "/output" ]
#Copy bash script
COPY main.sh /tools/main.sh  
WORKDIR /tools
CMD [ "/tools/main.sh" ]