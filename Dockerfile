FROM rocker/shiny:3.6.1

RUN echo "force-unsafe-io" > /etc/dpkg/dpkg.cfg.d/02apt-speedup && \
    echo "Acquire::http {No-Cache=True;};" > /etc/apt/apt.conf.d/no-cache 


RUN apt-get update
# RUN apt-get build-dep -y libcurl4-openssl-dev
# RUN apt-get build-dep -y libraptor2-dev 
# RUN apt-get build-dep -y librasqal3-dev
# RUN apt-get build-dep -y libxml2-dev 
# RUN apt-get build-dep -y libssl-dev 
# RUN apt-get build-dep -y libjq-dev 
# RUN apt-get build-dep -y libv8-dev 
# RUN apt-get build-dep -y librdf0-dev 
# RUN apt-get build-dep -y libpoppler-cpp-dev 

# Inspired from https://github.com/ValentinChCloud/wallaceEcoMod-docker/blob/master/Dockerfile
RUN apt-get install -y libgdal-dev
RUN apt-get install -y libproj-dev 
RUN apt-get install -y net-tools 
RUN apt-get install -y procps 
RUN apt-get install -y openjdk-8-jdk 
RUN apt-get install -y libgeos-dev  
RUN apt-get install -y texlive-xetex   
RUN apt-get install -y texlive-fonts-recommended  
RUN apt-get install -y texlive-latex-recommended  
RUN apt-get install -y lmodern
# MetaShARK proper setup
RUN apt-get install -y libcurl4-openssl-dev 
RUN apt-get install -y libraptor2-dev 
RUN apt-get install -y librasqal3-dev 
RUN apt-get install -y libxml2-dev 
RUN apt-get install -y libssl-dev 
RUN apt-get install -y libjq-dev 
RUN apt-get install -y libv8-dev 
RUN apt-get install -y librdf0-dev 
RUN apt-get install -y libpoppler-cpp-dev 
RUN apt-get install -y r-base-core

# Download and install library
RUN R -e 'install.packages("remotes")'
RUN R -e 'remotes::install_github("r-lib/remotes", ref = "97bbf81")'
RUN R -e 'remotes::install_cran("shiny")'
RUN R -e 'remotes::install_cran("golem")'
# Have been skipped ----
RUN R -e 'remotes::install_cran("processx")'
RUN R -e 'remotes::install_cran("attempt")'
RUN R -e 'remotes::install_cran("DT")'
RUN R -e 'remotes::install_cran("glue")'
RUN R -e 'remotes::install_cran("htmltools")'
# /----
RUN R -e 'remotes::install_cran("EML")'
RUN R -e 'remotes::install_cran("lattice", force=TRUE)'
RUN R -e 'remotes::install_cran("ape", force=TRUE)'
RUN R -e 'remotes::install_github("EDIorg/EMLassemblyline")'
RUN R -e 'remotes::install_cran("RefManageR")'
RUN R -e 'remotes::install_cran("data.table")'
RUN R -e 'remotes::install_cran("dataone")'
RUN R -e 'remotes::install_cran("datapack")'
RUN R -e 'remotes::install_cran("dplyr")'
RUN R -e 'remotes::install_cran("shinyTree")'
RUN R -e 'remotes::install_cran("fs")'
RUN R -e 'remotes::install_cran("mime")'
RUN R -e 'remotes::install_cran("shinyFiles")'
RUN R -e 'remotes::install_cran("shinydashboard")'
RUN R -e 'remotes::install_cran("shinyjs")'
RUN R -e 'remotes::install_cran("shinyBS")'
RUN R -e 'remotes::install_cran("shinycssloaders")'
RUN R -e 'remotes::install_cran("readtext")'

RUN mkdir -p /srv/shiny-server
COPY MetaShARK_*.tar.gz /srv/shiny-server/app.tar.gz
RUN chmod -R 755 /srv/shiny-server/
RUN R -e 'remotes::install_local("/srv/shiny-server/app.tar.gz")'

EXPOSE 3838

CMD R -e "options('shiny.port'=3838,shiny.host='0.0.0.0'); MetaShARK::runMetaShARK()"
