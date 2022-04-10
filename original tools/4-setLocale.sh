#:::::::::::::::::::::::::::::::::::::::::::
# Set the locale (languages)
#

cp configs/locale.gen /etc/locale.gen
export LANG=en_GB.UTF-8
locale-gen
