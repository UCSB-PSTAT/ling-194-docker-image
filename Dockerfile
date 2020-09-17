# Copyright (c) Jupyter Development Team.
# Distributed under the terms of the Modified BSD License.

FROM ucsb/ling-194:v20200902.1

LABEL maintainer="Patrick Windmiller <sysadmin@pstat.ucsb.edu>"

USER $NB_UID

RUN pip install PTable && \
    pip install pytest-custom-report

RUN fix-permissions $CONDA_DIR && \
    fix-permissions /home/$NB_USER
