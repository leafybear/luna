#:::::::::::::::::::::::::::::::::::::::::::
# Set the locale (languages)
#
echo "cp configs/locale.gen /etc/locale.gen"
cp configs/locale.gen /etc/locale.gen
echo "export LANG=en_GB.UTF-8"
export LANG=en_GB.UTF-8
echo "locale-gen"
locale-gen
