FROM python:2.7.15-stretch

# Dependencias para Debian
RUN apt-get update && apt-get install -y zlib1g-dev libjpeg-dev graphicsmagick libboost-dev python-dev && apt-get clean && rm -rf /var/cache/apt

# Arreglos temporales en requirements.txt, esperando https://github.com/ciudadanointeligente/votainteligente-portal-electoral/pull/1085
RUN wget https://raw.githubusercontent.com/ciudadanointeligente/votainteligente-portal-electoral/master/requirements.txt && \
    sed -i 's#git://#git+https://#g' requirements.txt && \
    echo "\nurllib3==1.21.1" >> requirements.txt && \
    echo "chardet==3.0.2" >> requirements.txt && \
    echo "gunicorn" >> requirements.txt && \
    pip install --no-cache-dir -r requirements.txt

COPY entrypoint.sh /
COPY local_settings.py /
COPY example_data.yaml /
ENTRYPOINT [ "/entrypoint.sh" ]
