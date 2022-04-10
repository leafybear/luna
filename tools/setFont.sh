#:::::::::::::::::::::::::::::::::::::::::::
# Set the virtual console font
#
#!/bin/sh

echo "echo FONT=ter-v32n > /etc/vconsole.conf"
echo FONT=ter-v32n > /etc/vconsole.conf
echo "setfont ter-v32n"
setfont ter-v32n
