FROM centos:8

RUN yum update -y
RUN yum install -y wget

RUN wget https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh

# install in batch (silent) mode, does not edit PATH or .bashrc or .bash_profile
# -p path
# -f force
# RUN bash Miniconda3-latest-Linux-x86_64.sh -b

RUN bash /tmp/miniconda.sh -bfp /usr/local/ 

RUN rm -rf /tmp/miniconda.sh 

ENV PATH=/root/miniconda3/bin:${PATH} 

#RUN source /root/.bashrc
#RUN source /root/.bash_profile

RUN conda update -y conda
RUN conda list
RUN conda install -y numpy \
                     matplotlib \
                     pandas

RUN conda install -y python=3 

# cleanup
RUN rm Miniconda3-latest-Linux-x86_64.sh

RUN conda clean --all --yes

RUN rpm -e --nodeps curl bzip2 
RUN yum clean all

RUN mkdir /root/my_model
VOLUME /root/my_model
COPY ./Code/. ./root/my_model/
WORKDIR /root/my_model
CMD ["python3","code_file2.py"]
