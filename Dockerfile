FROM rocker/shiny:3.6.1

RUN apt-get update -y && apt-get upgrade -y
RUN apt-get install apt-utils

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
RUN apt-get install -y libjpeg-dev
RUN apt-get install -y xdg-utils

# Download and install library
RUN R -e 'install.packages("remotes")'
RUN R -e 'remotes::install_cran("shiny")'
RUN R -e 'remotes::install_cran("golem")'
RUN R -e 'remotes::install_cran("processx")'
RUN R -e 'remotes::install_cran("attempt")'
RUN R -e 'remotes::install_cran("DT")'
RUN R -e 'remotes::install_cran("glue")'
RUN R -e 'remotes::install_cran("htmltools")'
RUN R -e 'remotes::install_cran("EML")'
RUN R -e 'install.packages("lubridate")'
RUN R -e 'install.packages("readr")'
RUN R -e 'install.packages("reader")'
RUN R -e 'install.packages("XML")'
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
RUN R -e 'remotes::install_github("ThinkRstat/tagsinput")'
RUN R -e 'remotes::install_cran("config")'
RUN R -e 'remotes::install_github("ropenscilabs/emldown")'
RUN R -e 'remotes::install_cran("gdata")'
RUN R -e 'remotes::install_cran("ArgumentCheck")'
RUN R -e 'remotes::install_github("earnaud/cedarr")'

# Setup
RUN mkdir -p /srv/shiny-server/apps/metashark
COPY MetaShARK_*.tar.gz /srv/shiny-server/apps/metashark.tar.gz
RUN R -e 'remotes::install_local("/srv/shiny-server/apps/metashark.tar.gz", dependencies=TRUE)'
COPY Rprofile.site /usr/local/lib/R/etc

RUN chmod -R 755 /srv/shiny-server/
EXPOSE 3838

CMD ["R","-e MetaShARK::runMetashark()"]
