# -*- mode: ruby -*-
# vi: set ft=ruby :

# VB specific configurations go here

def config_vb(config, i, total, name)
  puts "starting " + Addr[i - 1]
  config.vm.synced_folder "../../", "/tachyon"
  config.vm.synced_folder "./", "/vagrant"
  config.vm.box = "chef/centos-6.6"
  config.vm.provider "virtualbox" do |vb|
    if Memory != ''
      vb.memory = Memory
    end
    vb.cpus = 2
    vb.gui = true

    disk = @cmd['Disk']
    if disk != nil and disk.length > 0
      (0..disk.length).each do |j|    
        if disk[j].is_a? Integer      
          disk_file = "files/#{name}_disk_#{j}_#{disk[j]}GB.vdi"
          unless File.exist?(disk_file)
            vb.customize ['createhd', '--filename', disk_file, '--size', disk[j] * 1024]
          end
          if j == 0
            vb.customize ['storagectl', :id, '--name', "SCSI Controller", '--add', 'scsi']
          end
          vb.customize ['storageattach', :id, '--storagectl', "SCSI Controller", '--port', j + 1, '--device', 0, '--type', 'hdd', '--medium', disk_file]
        end
      end
    end
  end
  config.vm.network "private_network", ip: Addr[i - 1]
  config.vm.host_name =  "#{name}"
  if i == total # last VM starts tachyon
    config.vm.provision "shell", path: Post
    config.vm.provision "shell", path: "core/start_tachyon_cluster.sh"
  end
end
