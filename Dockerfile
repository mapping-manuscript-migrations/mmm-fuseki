FROM secoresearch/fuseki:spatial-legacy

COPY fuseki-config.ttl $FUSEKI_BASE/config.ttl
COPY assembler.ttl $FUSEKI_BASE/configuration/assembler.ttl

RUN wget -q -O /tmp/mmm_data.zip https://zenodo.org/record/4440464/files/mmm_data_v2.2.0.zip?download=1 \
 && unzip /tmp/mmm_data.zip -d /tmp

RUN $TDBLOADER --graph=http://ldf.fi/mmm/ /tmp/mmm_bibale.ttl \
 && $TDBLOADER --graph=http://ldf.fi/mmm/ /tmp/mmm_bodley.ttl \
 && $TDBLOADER --graph=http://ldf.fi/mmm/ /tmp/mmm_sdbm.ttl \
 && $TDBLOADER --graph=http://ldf.fi/mmm/places/ /tmp/mmm_places.ttl \
 && $TDBLOADER --graph=http://ldf.fi/schema/mmm/ /tmp/mmm-schema.ttl \
 && $TDBLOADER --graph=http://ldf.fi/schema/mmm/ /tmp/cidoc-crm.rdf \
 && $TDBLOADER --graph=http://ldf.fi/schema/mmm/ /tmp/frbroo.rdf \
 && $TDBLOADER --graph=http://ldf.fi/mmm/void/ /tmp/mmm-void.ttl \
 && $TEXTINDEXER \
 && $SPATIALINDEXER \
 && $TDBSTATS --graph urn:x-arq:UnionGraph > /tmp/stats.opt \
 && mv /tmp/stats.opt /fuseki-base/databases/tdb/

USER root

RUN rm -r /tmp/*

# Set permissions to allow fuseki to run as an arbitrary user
RUN chgrp -R 0 $FUSEKI_BASE \
 && chmod -R g+rwX $FUSEKI_BASE
 
USER 9008
