FROM rocker/shiny:3.6.1

RUN apt-get update &&\
  apt-get install libcurl4-openssl-dev libxml2-dev libssl-dev libjq-dev libv8-dev librdf0-dev libpoppler-cpp-dev

# Download and install library
RUN R -e 'install.packages("remotes")'
RUN R -e 'remotes::install_github("r-lib/remotes", ref = "97bbf81")'
RUN R -e 'remotes::install_cran("shiny")'
RUN R -e 'remotes::install_cran("golem")'
RUN R -e 'remotes::install_cran("processx")'
RUN R -e 'remotes::install_cran("attempt")'
RUN R -e 'remotes::install_cran("DT")'
RUN R -e 'remotes::install_cran("glue")'
RUN R -e 'remotes::install_cran("htmltools")'
RUN R -e 'remotes::install_cran("EML")'
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

mkdir -p /srv/shiny-server
COPY MetaShARK_*.tar.gz /srv/shiny-server/app.tar.gz
RUN chmod -R 755 /srv/shiny-server/
RUN R -e 'remotes::install_local("/srv/shiny-server/app.tar.gz")'

EXPOSE 3838

CMD R -e "options('shiny.port'=3838,shiny.host='0.0.0.0'); MetaShARK::runMetaShARK()"
