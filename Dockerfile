# This file describes the standard way to setup and run the sfcrime scripts
#
# Usage:
#
# # Assemble the full dev environment. This is slow the first time.
# docker build -t sfcrime .
#
# # Mount your source in an interactive container for quick testing:
# docker run -v `pwd`/src:/src/sfcrime `pwd`/data:/data/sfcrime-v -i -t docker bash
#
# # Run the unit tests
# docker run sfcrime tests.sh
#

FROM debian:jessie

# add zfs ppa
RUN apt-get update && apt-get install -y \
   octave \
   python \
   --no-install-recommends

# Upload sfcrime source
COPY src /src/sfcrime
