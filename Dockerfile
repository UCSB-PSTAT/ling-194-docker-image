# Copyright (c) Jupyter Development Team.
# Distributed under the terms of the Modified BSD License.

# changed to mikebirdgeneau/jupyterlab:latest
FROM jupyter/scipy-notebook

LABEL maintainer="Patrick Windmiller <sysadmin@pstat.ucsb.edu>"

USER $NB_UID

RUN pip install mlconjug3 && \
    pip install nlpcube && \
    pip install praat-parselmouth && \
#    pip install -i https://test.pypi.org/simple/ karel-robot && \
#    jupyter labextension install @jupyterlab/debugger && \
    jupyter labextension install jupyter-matplotlib && \
    jupyter labextension update --all

RUN conda install -c conda-forge spacy && \
    conda install -c conda-forge ipympl && \
    conda install --quiet -y nltk && \   
    conda install --quiet -y mplcursors && \
    conda install --quiet -y ipdb && \
    conda install --quiet -y pytest && \
    conda install --quiet -y tweepy && \
    conda install --quiet -y requests && \
    conda install --quiet -y beautifulsoup4 && \
    conda install --quiet -y xeus-python -c conda-forge
#    conda clean -tipsy && \
#    fix-permissions $CONDA_DIR && \
#    fix-permissions /home/$NB_USER
    
# Adding language model to Spacy
RUN python -m spacy download en

RUN python -m spacy download en_core_web_md

# RUN rm /opt/conda/share/jupyter/lab/extensions/jupyter-matplotlib-0.4.*

RUN pip install --upgrade jupyterlab && \
#    jupyter labextension update jupyterlab_bokeh && \
#    jupyter labextension update @jupyterlab/debugger && \
    jupyter labextension update @jupyter-widgets/jupyterlab-manager && \
    jupyter-lab build
