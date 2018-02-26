FROM resin/rpi-raspbian

RUN apt-get update
RUN apt-get install -y \
    python3-pip \
    cython3 \
    git \
    wget \
    libsm6 \
    libxrender-dev \
    python3-opencv \
    python3-numpy \
    portaudio19-dev

RUN pip3 install --upgrade pip

RUN python3 --version

ADD requirements.txt requirements.txt
RUN pip3 install -r requirements.txt

# RUN pip3 install tensorflow

RUN cd "/" && \
    git clone https://github.com/thtrieu/darkflow.git && \
    cd darkflow && \
    pip3 install -e .

WORKDIR /darkflow

RUN mkdir weights
RUN wget https://pjreddie.com/media/files/yolo.weights -P weights

ADD image_predict.py image_predict.py

CMD python3 image_predict.py cfg/yolo.cfg weights/yolo.weights 0.1