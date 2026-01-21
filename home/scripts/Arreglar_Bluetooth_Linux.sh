#!/bin/bash

# Paso 1: Downgrade a bluez y bluez-utils versión 5.58
sudo downgrade bluez bluez-utils

# Seleccionar la versión 5.58, es la más estable, no tiene estos problemas.

# Paso 2: Borrar el caché
sudo systemctl stop bluetooth
sudo rm -rf /var/lib/bluetooth

# Paso 3: Reiniciar y difrutar

sudo reboot now


