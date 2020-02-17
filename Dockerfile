FROM rocker/shiny:3.6.1

RUN apt-get update -y && apt-get upgrade -y

# MetaShARK proper setup
# RUN apt-get install -y r-base
RUN apt-get install -y libcurl4-openssl-dev 
RUN apt-get install -y libraptor2-dev 
RUN apt-get install -y librasqal3-dev 
RUN apt-get install -y libxml2-dev 
RUN apt-get install -y libssl-dev 
RUN apt-get install -y libjq-dev 
RUN apt-get install -y libv8-dev 
RUN apt-get install -y librdf0-dev 
RUN apt-get install -y libpoppler-cpp-dev 
RUN apt-get install -y libjpeg-dev

# Download and install library
RUN R -e 'install.packages("remotes")'
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
RUN R -e 'remotes::install_github("EDIorg/EMLassemblyline", ref="fix41")'
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
RUN R -e 'remotes::install_github("ThinkRstat/tagsinput")'

# Setup
RUN mkdir -p /srv/shiny-server/apps/metashark
COPY MetaShARK_*.tar.gz /srv/shiny-server/apps/metashark.tar.gz
RUN R -e 'remotes::install_local("/srv/shiny-server/apps/metashark.tar.gz")'
COPY Rprofile.site /usr/local/lib/R/etc

RUN chmod -R 755 /srv/shiny-server/
EXPOSE 3838

CMD ["R","-e MetaShARK::runMetashark(server=TRUE)"]
