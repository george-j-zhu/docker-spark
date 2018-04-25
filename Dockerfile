FROM jupyter/pyspark-notebook
LABEL MAINTAINER "Jiajun Zhu <george.choo@outlook.com>"

USER root
ENV PYJ_LIB_VERSION py4j-0.10.1-src.zip

RUN mkdir /opt/pythonlibs
ENV PYTHONPATH /opt/pythonlibs:$SPARK_HOME/python/lib/$PYJ_LIB_VERSION:$PYTHONPATH

# install tig, emacs25
RUN apt-get update && \
    apt-get install --yes software-properties-common tig && \
    add-apt-repository ppa:kelleyk/emacs && \
    apt-get update && \
    apt-get remove --yes emacs && \
    apt-get autoremove --yes && \
    apt-get install --yes emacs25 graphviz

# install ispell and markdown
RUN apt-get install --yes ispell markdown

USER $NB_USER

RUN pip install --upgrade pip

RUN pip install -q py4j spark-sklearn findspark
# Install Keras
RUN conda install --yes tensorflow-gpu keras
# Use the latest version of hyperopts (python 3.5 compatibility)
RUN pip install https://github.com/hyperopt/hyperopt/archive/master.zip
# Elephas for distributed keras
RUN pip install elephas
# opencv
RUN conda install -c conda-forge --yes opencv

RUN mkdir ~/workspace

# install dependent packages for personal usage
RUN pip install chainer && \
    pip install --upgrade --no-deps statsmodels && \
    pip install git+https://github.com/s4w3d0ff/python-poloniex.git

# install python checkers
RUN pip install -q jedi importmagic autopep8
