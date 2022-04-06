uuid=`lsblk -o mountpoint,uuid | grep $1 | head -n 1 | awk '{print $2}'`

echo "\"Boot with standard options\"  \"root=UUID=$uuid rw\"" > /boot/refind_linux.conf
echo "\"Boot to single-user mode\"  \"root=UUID=$uuid single\"" >> /boot/refind_linux.conf
echo "\"Boot with minimal options\"  \"ro root=UUID=$uuid\"" >> /boot/refind_linux.conf

# a good file config should look like
#"Boot with standard options"  "root=UUID=5761ba4a-a3e1-4232-92b7-ad5e1b7df874 rw"
#"Boot to single-user mode"    "root=UUID=5761ba4a-a3e1-4232-92b7-ad5e1b7df874 single"
#"Boot with minimal options"   "ro root=UUID=5761ba4a-a3e1-4232-92b7-ad5e1b7df874"
