FROM nvcr.io/nvidia/l4t-ml:r32.6.1-py3

ENV DEBIAN_FRONTEND=noninteractive
ENV SHELL /bin/bash

#
# install development packages
#
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
            cmake \
		  nano \
    && rm -rf /var/lib/apt/lists/*
    
# pip dependencies for pytorch-ssd
RUN pip3 install --verbose --upgrade Cython && \
    pip3 install --verbose boto3 pandas

# alias python3 -> python
RUN rm /usr/bin/python && \
    ln -s /usr/bin/python3 /usr/bin/python && \
    ln -s /usr/bin/pip3 /usr/bin/pip

#
# jupyter lab
#
RUN python -c "from notebook.auth.security import set_password; set_password('jetson', '/root/.jupyter/jupyter_notebook_config.json')"
# CMD /bin/bash echo "allow 10 sec for JupyterLab to start @ http://$(hostname -I | cut -d' ' -f1):8888 (password jetson)" && \
#	echo "JupyterLab loggin location: /var/log/jupyter.log (inside the container)" && \
#	/bin/bash

#
# jupyter clickable image widget
#
RUN git clone https://github.com/jaybdub/jupyter_clickable_image_widget
RUN cd jupyter_clickable_image_widget && pip3 install -e . && jupyter labextension install js

#
# jetcam interface
#
RUN git clone https://github.com/harleylara/jetcam.git
RUN cd /jetcam && python setup.py install

#
# jetson inference
#
RUN git clone https://github.com/dusty-nv/jetson-inference.git
WORKDIR jetson-inference
RUN git submodule update --init 

#
# build source
#
RUN sed -i 's/nvcaffe_parser/nvparsers/g' CMakeLists.txt && \
    mkdir build && \
    cd build && \
    cmake ../ && \
    make -j$(nproc) && \
    make install && \
    /bin/bash -O extglob -c "cd /jetson-inference/build; rm -rf -v !(aarch64|download-models.*)" && \
    rm -rf /var/lib/apt/lists/*
