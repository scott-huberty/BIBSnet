FROM nvcr.io/nvidia/pytorch:21.11-py3

# Manually update the BIBSnet version when building
ENV BIBSNET_VERSION="3.2.0"

# Prepare environment
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
                    apt-utils \
                    autoconf \
                    build-essential \
                    bzip2 \
                    ca-certificates \
                    curl \
                    gcc \
                    git \
                    gnupg \
                    libtool \
                    lsb-release \
                    pkg-config \
                    unzip \
                    wget \
                    xvfb \
		    zlib1g && \
    apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/

# FSL 6.0.5.1
RUN apt-get update -qq \
    && apt-get install -y -q --no-install-recommends \
           bc \
           dc \
           file \
           libfontconfig1 \
           libfreetype6 \
           libgl1-mesa-dev \
           libgl1-mesa-dri \
           libglu1-mesa-dev \
           libgomp1 \
           libice6 \
           libxcursor1 \
           libxft2 \
           libxinerama1 \
           libxrandr2 \
           libxrender1 \
           libxt6 \
           sudo \
           wget \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* \
    && echo "Downloading FSL ..." \
    && mkdir -p /opt/fsl-6.0.5.1 \
    && curl -sSL "https://s3.msi.umn.edu/bibsnet-data/bibsnet-v3.2.0.tar.gz" \
    | tar -xzf - fsl-6.0.5.1-centos7_64.tar.gz -O | tar -xzC /opt/fsl-6.0.5.1 --no-same-owner --strip-components 1 \
    --exclude "fsl/config" \
    --exclude "fsl/data/first" \
    --exclude "fsl/data/mist" \
    --exclude "fsl/data/possum" \
    --exclude "fsl/data/standard/bianca" \
    --exclude "fsl/data/standard/tissuepriors" \
    --exclude "fsl/doc" \
    --exclude "fsl/etc/default_flobs.flobs" \
    --exclude "fsl/etc/js" \
    --exclude "fsl/etc/luts" \
    --exclude "fsl/etc/matlab" \
    --exclude "fsl/extras" \
    --exclude "fsl/include" \
    --exclude "fsl/refdoc" \
    --exclude "fsl/src" \
    --exclude "fsl/tcl" \
    --exclude "fsl/bin/asl_file" \
    --exclude "fsl/bin/asl_mfree" \
    --exclude "fsl/bin/avscale" \
    --exclude "fsl/bin/b0calc" \
    --exclude "fsl/bin/bet2" \
    --exclude "fsl/bin/betsurf" \
    --exclude "fsl/bin/calc_grad_perc_dev" \
    --exclude "fsl/bin/ccops" \
    --exclude "fsl/bin/cluster" \
    --exclude "fsl/bin/contrast_mgr" \
    --exclude "fsl/bin/distancemap" \
    --exclude "fsl/bin/drawmesh" \
    --exclude "fsl/bin/dtifit" \
    --exclude "fsl/bin/dtigen" \
    --exclude "fsl/bin/eddy_cuda10.2" \
    --exclude "fsl/bin/eddy_cuda8.0" \
    --exclude "fsl/bin/eddy_cuda9.1" \
    --exclude "fsl/bin/eddy_openmp" \
    --exclude "fsl/bin/estimate_metric_distortion" \
    --exclude "fsl/bin/fabber_asl" \
    --exclude "fsl/bin/fabber_cest" \
    --exclude "fsl/bin/fabber_dce" \
    --exclude "fsl/bin/fabber_dsc" \
    --exclude "fsl/bin/fabber_dualecho" \
    --exclude "fsl/bin/fabber_dwi" \
    --exclude "fsl/bin/fabber_pet" \
    --exclude "fsl/bin/fabber_qbold" \
    --exclude "fsl/bin/fabber_t1" \
    --exclude "fsl/bin/fabber" \
    --exclude "fsl/bin/fast" \
    --exclude "fsl/bin/fdr" \
    --exclude "fsl/bin/fdt_matrix_merge" \
    --exclude "fsl/bin/feat_model" \
    --exclude "fsl/bin/film_gls" \
    --exclude "fsl/bin/filmbabe" \
    --exclude "fsl/bin/find_the_biggest" \
    --exclude "fsl/bin/first_mult_bcorr" \
    --exclude "fsl/bin/first_utils" \
    --exclude "fsl/bin/first" \
    --exclude "fsl/bin/flameo" \
    --exclude "fsl/bin/fsl_glm" \
    --exclude "fsl/bin/fsl_histogram" \
    --exclude "fsl/bin/fsl_mvlm" \
    --exclude "fsl/bin/fsl_regfilt" \
    --exclude "fsl/bin/fsl_sbca" \
    --exclude "fsl/bin/fsl_schurprod" \
    --exclude "fsl/bin/fslcc" \
    --exclude "fsl/bin/FSLeyes" \
    --exclude "fsl/bin/fslfft" \
    --exclude "fsl/bin/fslpspec" \
    --exclude "fsl/bin/fslsmoothfill" \
    --exclude "fsl/bin/fslsurfacemaths" \
    --exclude "fsl/bin/ftoz" \
    --exclude "fsl/bin/fugue" \
    --exclude "fsl/bin/lesion_filling" \
    --exclude "fsl/bin/make_dyadic_vectors" \
    --exclude "fsl/bin/makerot" \
    --exclude "fsl/bin/melodic" \
    --exclude "fsl/bin/merge_parts_gpu" \
    --exclude "fsl/bin/midtrans" \
    --exclude "fsl/bin/mist" \
    --exclude "fsl/bin/mm" \
    --exclude "fsl/bin/mvntool" \
    --exclude "fsl/bin/new_invwarp" \
    --exclude "fsl/bin/overlay" \
    --exclude "fsl/bin/pnm_evs" \
    --exclude "fsl/bin/pointflirt" \
    --exclude "fsl/bin/possum" \
    --exclude "fsl/bin/prelude" \
    --exclude "fsl/bin/prewhiten" \
    --exclude "fsl/bin/probtrackx" \
    --exclude "fsl/bin/probtrackx2_gpu" \
    --exclude "fsl/bin/probtrackx2" \
    --exclude "fsl/bin/proj_thresh" \
    --exclude "fsl/bin/pulse" \
    --exclude "fsl/bin/pvmfit" \
    --exclude "fsl/bin/qboot" \
    --exclude "fsl/bin/rmsdiff" \
    --exclude "fsl/bin/run_mesh_utils" \
    --exclude "fsl/bin/sigloss" \
    --exclude "fsl/bin/signal2image" \
    --exclude "fsl/bin/slicer" \
    --exclude "fsl/bin/slicetimer" \
    --exclude "fsl/bin/smoothest" \
    --exclude "fsl/bin/spharm_rm" \
    --exclude "fsl/bin/surf_proj" \
    --exclude "fsl/bin/surf2surf" \
    --exclude "fsl/bin/surf2volume" \
    --exclude "fsl/bin/Susan" \
    --exclude "fsl/bin/swap_subjectwise" \
    --exclude "fsl/bin/swap_voxelwise" \
    --exclude "fsl/bin/swe" \
    --exclude "fsl/bin/tbss_skeleton" \
    --exclude "fsl/bin/tsplot" \
    --exclude "fsl/bin/ttologp" \
    --exclude "fsl/bin/ttoz" \
    --exclude "fsl/bin/unconfound" \
    --exclude "fsl/bin/vecreg" \
    --exclude "fsl/bin/xfibres_gpu" \
    --exclude "fsl/bin/xfibres" \
    && find /opt/fsl-6.0.5.1/data/standard -type f -not -name "MNI152_T1_2mm_brain.nii.gz" -delete
ENV FSLDIR="/opt/fsl-6.0.5.1" \
    PATH="/opt/fsl-6.0.5.1/bin:$PATH" \
    FSLOUTPUTTYPE="NIFTI_GZ" \
    FSLMULTIFILEQUIT="TRUE" \
    FSLLOCKDIR="" \
    FSLMACHINELIST="" \
    FSLREMOTECALL="" \
    FSLGECUDAQ="cuda.q" \
    LD_LIBRARY_PATH="/opt/fsl-6.0.5.1/lib:$LD_LIBRARY_PATH"

ENV PATH="/opt/afni-latest:$PATH" \
    AFNI_IMSAVE_WARNINGS="NO" \
    AFNI_PLUGINPATH="/opt/afni-latest"

# Installing ANTs 2.3.3 (NeuroDocker build)
# Note: the URL says 2.3.4 but it is actually 2.3.3
ENV ANTSPATH="/opt/ants" \
    PATH="/opt/ants:$PATH"
WORKDIR $ANTSPATH
RUN curl -sSL --retry 5 "https://dl.dropbox.com/s/gwf51ykkk5bifyj/ants-Linux-centos6_x86_64-v2.3.4.tar.gz" \
    | tar -xzC $ANTSPATH --strip-components 1

# Create a shared $HOME directory
RUN useradd -m -s /bin/bash -G users -u 1000 bibsnet
WORKDIR /home/bibsnet
ENV HOME="/home/bibsnet" \
    LD_LIBRARY_PATH="/usr/lib/x86_64-linux-gnu:$LD_LIBRARY_PATH"

# install nnUNet git repo
RUN cd /home/bibsnet && \
    mkdir SW && \
    git clone https://github.com/MIC-DKFZ/nnUNet.git && \
    cd nnUNet && \
    git checkout -b v1.7.1 v1.7.1 && \
    pip install -e .

#ENV nnUNet_raw_data_base="/output"
ENV nnUNet_preprocessed="/opt/nnUNet/nnUNet_raw_data_base/nnUNet_preprocessed"
ENV RESULTS_FOLDER="/opt/nnUNet/nnUNet_raw_data_base/nnUNet_trained_models"

RUN mkdir -p /opt/nnUNet/nnUNet_raw_data_base/ /opt/nnUNet/nnUNet_raw_data_base/nnUNet_preprocessed /opt/nnUNet/nnUNet_raw_data_base/nnUNet_trained_models/nnUNet /home/bibsnet/data
#COPY trained_models/Task512_BCP_ABCD_Neonates_SynthSegDownsample.zip /opt/nnUNet/nnUNet_raw_data_base/nnUNet_trained_models/nnUNet
RUN curl -sSL "https://s3.msi.umn.edu/bibsnet-data/bibsnet-v3.2.0.tar.gz" | tar -xzf - Task552_uniform_distribution_synthseg.tar.gz -O | tar -xzC /opt/nnUNet/nnUNet_raw_data_base/nnUNet_trained_models/nnUNet --no-same-owner --strip-components 1 && \
    curl -sSL "https://s3.msi.umn.edu/bibsnet-data/bibsnet-v3.2.0.tar.gz" | tar -xzf - Task514_BCP_ABCD_Neonates_SynthSeg_T1Only.tar.gz -O | tar -xzC /opt/nnUNet/nnUNet_raw_data_base/nnUNet_trained_models/nnUNet --no-same-owner --strip-components 1 &&\
    curl -sSL "https://s3.msi.umn.edu/bibsnet-data/bibsnet-v3.2.0.tar.gz" | tar -xzf - Task515_BCP_ABCD_Neonates_SynthSeg_T2Only.tar.gz -O | tar -xzC /opt/nnUNet/nnUNet_raw_data_base/nnUNet_trained_models/nnUNet --no-same-owner --strip-components 1 && \
    curl -sSL "https://s3.msi.umn.edu/bibsnet-data/bibsnet-v3.2.0.tar.gz" | tar -xzf - Task526_BIBSNet_Production_Model.tar.gz -O | tar -xzC /opt/nnUNet/nnUNet_raw_data_base/nnUNet_trained_models/nnUNet --no-same-owner --strip-components 1

RUN curl -sSL "https://dl.dropbox.com/s/gwf51ykkk5bifyj/ants-Linux-centos6_x86_64-v2.3.4.tar.gz" \
    | tar -xzC $ANTSPATH --strip-components 1

COPY run.py /home/bibsnet/run.py
COPY src /home/bibsnet/src
COPY bin /home/bibsnet/bin
RUN chmod 777 -R /opt/fsl-6.0.5.1
RUN bash /home/bibsnet/bin/fixpy.sh /opt/fsl-6.0.5.1
RUN curl -sSL "https://s3.msi.umn.edu/bibsnet-data/bibsnet-v3.2.0.tar.gz" | tar -xzf - data.tar.gz -O | tar -xzC /home/bibsnet/data --no-same-owner --strip-components 1

COPY requirements.txt  /home/bibsnet/requirements.txt

#Add bibsnet dir to path
ENV PATH="${PATH}:/home/bibsnet/"
RUN cp /home/bibsnet/run.py /home/bibsnet/bibsnet

RUN cd /home/bibsnet/ && pip install -r requirements.txt
RUN cd /home/bibsnet/ && chmod 555 -R run.py bin src bibsnet data
RUN chmod -R a+r /opt/nnUNet/nnUNet_raw_data_base/nnUNet_trained_models/nnUNet/3d_fullres
RUN find /opt/nnUNet/nnUNet_raw_data_base/nnUNet_trained_models/nnUNet/3d_fullres -type f -name 'postprocessing.json' -exec chmod 666 {} \;

ENTRYPOINT ["bibsnet"]
