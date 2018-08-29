#!/bin/bash

if [ ! -f /app-code/requirements.txt ]; then
  # Esto vacia app-code pero no borra el directorio.
  # El directorio app-code va a estar "busy" para Docker asi que cumple el objetivo
  rm -rf /app-code/

  # Tratamiendo de directorio del codigo
  git clone --depth 1 https://github.com/ciudadanointeligente/votainteligente-portal-electoral /app-code
  mv /local_settings.py /app-code/
  KEY=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 32 | head -n 1)
  sed -i "s/^SECRET_KEY$/SECRET_KEY = '$KEY'/g" /app-code/local_settings.py
  mkdir /app-code/cache

  # Permisos de directorio del codigo
  find /app-code -type d -exec chmod 777 {} \;
  find /app-code -type f -exec chmod 666 {} \;

  # Django manage
  cd /app-code && python manage.py migrate
  cd /app-code && python manage.py compilescss
  cd /app-code && python manage.py collectstatic
  cd /app-code && python manage.py loaddata /example_data.yaml

  # No conocemos el password del admin en example_data.yaml asi que tenemos que cambiarlo
  #cd /app-code && echo "from django.contrib.auth import get_user_model; User = get_user_model(); usr = User.objects.get(username='admin'); usr.set_password('admin'); usr.save()" | python manage.py shell
fi

cd /app-code && gunicorn --bind=0.0.0.0:80 --workers=1 votainteligente.wsgi:application
