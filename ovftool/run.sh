#ovftool/ovftool --targetType=OVA --eula@=eula.txt "vcloud://ta:vmware@alp-vcd100.eng.vmware.com?org=ACME&vdc=Detroit&vapp=test-vapp-with-eula"  target/a.ova
#ovftool/ovftool --targetType=OVF --eula@=eula.txt "vcloud://ta:vmware@alp-vcd100.eng.vmware.com?org=ACME&vdc=Detroit&vapp=two-disk"  target/two-disk.ovf
ovftool/ovftool --targetType=OVA --eula@=eula.txt "vcloud://ta:vmware@oss-vcd.eng.vmware.com?org=ACME&vdc=vdc3&vapp=test-vapp-with-eula"  target/test-vapp-with-eula.ova
