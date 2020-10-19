# Copyright (c) Jupyter Development Team.
# Distributed under the terms of the Modified BSD License.

#FROM ucsb/ling-111:v20200116.6
FROM dddlab/python-notebook:v20200331-df7ed42-94fdd01b492f

LABEL maintainer="Patrick Windmiller <sysadmin@pstat.ucsb.edu>"

USER $NB_UID

#--- Upgrade Python and install Xeus Python for Visual Debugger
RUN conda update python && \
    conda install --quiet -y xeus-python -c conda-forge

#--- Install nbgitpuller
RUN pip install nbgitpuller && \
    jupyter serverextension enable --py nbgitpuller --sys-prefix

#--- ling-194 Required Packages
RUN pip install mlconjug3 && \
    pip install ipdb && \
    pip install pytest-custom-report && \
    pip install nlpcube && \
    pip install praat-parselmouth && \
    pip install jsonschema && \
    pip install -i https://test.pypi.org/simple/ karel-robot==0.0.2

RUN conda install -c conda-forge nodejs && \
    conda install -c conda-forge spacy && \
    conda install -c conda-forge ipympl  && \
    conda install --quiet -y nltk && \   
    conda install --quiet -y mplcursors && \
#    conda install --quiet -y ipdb && \
#    conda install --quiet -y beautifulsoup4 && \
    conda install --quiet -y pytest && \
    conda install --quiet -y tweepy && \
    fix-permissions $CONDA_DIR && \
    fix-permissions /home/$NB_USER

# Adding language model to Spacy
RUN python -m spacy download en && \
    python -m spacy download en_core_web_md

#--- Upgrade Python and install Xeus Python for Visual Debugger
#RUN conda update python && \
#    conda install --quiet -y xeus-python -c conda-forge

#RUN jupyter labextension install @jupyter-widgets/jupyterlab-manager && \
RUN jupyter labextension install @jupyterlab/debugger && \
    jupyter labextension install jupyter-matplotlib@0.7.3 && \
    jupyter labextension update jupyterlab_bokeh && \
    jupyter lab build

RUN fix-permissions $CONDA_DIR && \
    fix-permissions /home/$NB_USER

RUN pip install PTable && \
    pip install pytest-custom-report

RUN fix-permissions $CONDA_DIR && \
    fix-permissions /home/$NB_USER
